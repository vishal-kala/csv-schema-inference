import json
import os
import re
from mako.template import Template

TEMPLATE_BASE_PATH = "./templates"
AVAILABLE_VARCHAR_LENGTHS = [32, 64, 128, 256, 1024, 4096]

DEFAULT_SNOWSQL_DATATYPE = "string"

JSON_DATATYPE_STRING = "string"
JSON_DATATYPE_DATE = "date"
JSON_DATATYPE_TIME = "time"
JSON_DATATYPE_TIMESTAMP = "timestamp"
JSON_DATATYPE_FLOAT = "float"
JSON_DATATYPE_INTEGER = "integer"
JSON_DATATYPE_BOOLEAN = "boolean"


class DDLGenerator:
    def __init__(self, metadata_file_path, config_file_path):
        self.metadata_file_path = metadata_file_path
        self.config_file_path = config_file_path

    def generate_ddl(self):
        # Load table metadata JSON data from the file
        with open(self.metadata_file_path, 'r') as json_file:
            schema_metadata = json.load(json_file)

        # Build Data Type for columns
        schema_metadata = self.build_data_type(schema_metadata)
        schema_metadata = self.formalize_names(schema_metadata)

        # Load configuration from the file
        with open(self.config_file_path, 'r') as config_file:
            config = json.load(config_file)
            base_output_path = config['base_output_path']
            template_mapping = config['template_mapping']
            additional_parameters = config['additional_parameters']

        # For each template, do transformation
        for template_name, template_info in template_mapping.items():
            output_pattern = template_info['output_pattern']
            output_subdir = template_info['output_subdir']
            output_path = os.path.join(base_output_path, output_subdir)

            current_dir = os.path.dirname(os.path.abspath(__file__))

            # Load the Mako template
            with open(f'{current_dir}/{TEMPLATE_BASE_PATH}/{template_name}.mako', 'r') as template_file:
                template_content = template_file.read()
                template = Template(template_content)

            # Apply the template on all tables
            for table in schema_metadata['tables']:
                table_name = table['name']
                output_filename = os.path.join(output_path, output_pattern.format(table_name=table_name.lower()))

                # Combine table metadata and additional parameters
                parameters = {
                    "tables": [table],
                    **additional_parameters
                }

                # Render the template
                rendered_ddl = template.render(**parameters)

                # Remove extra whitespaces
                rendered_ddl = re.sub(r'(?<=\S) +', ' ', rendered_ddl)

                # Write the generated DDL code to the output SQL file
                os.makedirs(output_path, exist_ok=True)
                with open(output_filename, 'w') as sql_file:
                    sql_file.write(rendered_ddl)

                print(
                    f"DDL code for table '{table_name}' using template '{template_name}' "
                    f"has been generated and written to '{output_filename}'.")

    def _handle_name(self, input):
        # Define a regular expression pattern to match one or more consecutive special characters
        pattern = r'[^a-zA-Z0-9_]+'

        output = re.sub(pattern, '_', input).lower()

        return output

    def formalize_names(self, schema_metadata):
        for table in schema_metadata['tables']:
            table["name"] = self._handle_name(table["name"])
            for column in table['columns']:
                column["name"] = self._handle_name(column["name"])

        return schema_metadata


    def build_data_type(self, schema_metadata):
        # Available length values in the desired pattern
        available_lengths = AVAILABLE_VARCHAR_LENGTHS

        # Iterate through the tables and columns, and update their data types
        for table in schema_metadata['tables']:
            for column in table['columns']:
                json_data_type = column['type']
                snowsql_data_type = None

                if json_data_type == JSON_DATATYPE_STRING:
                    length = column.get('length', 32)  # Default length is 32
                    length = max(available_lengths[0], length)  # Ensure length is at least 32
                    for available_length in available_lengths[1:]:
                        if length <= available_length:
                            length = available_length
                            break
                    snowsql_data_type = f"VARCHAR({length})"

                elif json_data_type == JSON_DATATYPE_INTEGER:
                    precision = max(column.get('length', 16), 16)  # Default precision is 16
                    scale = 0
                    snowsql_data_type = f"NUMBER({precision}, {scale})"

                elif json_data_type == JSON_DATATYPE_FLOAT:
                    precision = max(column.get('length', 16), 16)   # Default precision is 16
                    scale = max(column.get('precision', 4), 4)      # Default precision is 10
                    snowsql_data_type = f"NUMBER({precision}, {scale})"

                elif json_data_type == JSON_DATATYPE_BOOLEAN:
                    snowsql_data_type = f"BOOLEAN"

                elif json_data_type == JSON_DATATYPE_DATE:
                    snowsql_data_type = f"DATE"

                elif json_data_type == JSON_DATATYPE_TIMESTAMP:
                    snowsql_data_type = f"TIMESTAMP"

                elif json_data_type == JSON_DATATYPE_TIME:
                    snowsql_data_type = f"TIME"

                column['data_type'] = snowsql_data_type

        return schema_metadata
