import csv
import json
import os

from csv_delimiter_detector import read_first_n_rows
from data_types import DataTypes
from value_type_detector import ValueTypeDetector

MAX_LENGTH_OF_DATA = 1000
MAX_ROWS_TO_CONSIDER = 5000


class CsvSchemaInference:
    def __init__(self, delimiter, csv_file_path, max_rows=MAX_ROWS_TO_CONSIDER, max_length=MAX_LENGTH_OF_DATA):

        self.max_length = max_length
        self.max_rows = max_rows

        self.delimiter = delimiter
        self.csv_file_path = csv_file_path

        self.rows = None
        self.value_type_cache = {}

    def _set_header(self, header):
        self.header = header
        self.field_names = [name.replace('"', '') for name in
                            list(csv.reader([self.header.rstrip()], delimiter=self.delimiter))[0]]
        self.field_count = len(self.field_names)

    def _init_schema(self):
        self.schema = {}

        for i in range(0, self.field_count):
            self.schema[i] = {
                "name": self.field_names[i],
                "types_found": {
                }
            }

    def _infer_value_type(self, value, index):

        if value not in self.value_type_cache.keys():
            self.value_type_cache[value] = ValueTypeDetector().infer_value_type(value)

        value_type = self.value_type_cache[value]

        data_type = value_type["data_type"]
        str_length = value_type["str_length"]
        date_format = value_type["date_format"]
        number_precision = value_type["number_precision"]
        number_scale = value_type["number_scale"]

        if data_type not in self.schema[index]["types_found"].keys():
            self.schema[index]["types_found"][data_type] = {"count": 1,
                                                            "max_length": str_length,
                                                            "max_precision": number_precision,
                                                            "max_scale": number_scale,
                                                            "sample_data": [value],
                                                            "date_format": {}}

        else:
            self.schema[index]["types_found"][data_type]["count"] += 1
            if len(self.schema[index]["types_found"][data_type]["sample_data"]) < 10:
                if value not in self.schema[index]["types_found"][data_type]["sample_data"]:
                    self.schema[index]["types_found"][data_type]["sample_data"].append(value)

            # Store the max length of string
            if data_type == DataTypes.DATA_TYPE_STRING:
                current_max_length = self.schema[index]["types_found"][data_type]["max_length"]
                self.schema[index]["types_found"][data_type]["max_length"] = max(current_max_length, str_length)

            # Store the date format for data/time/timestamp type
            if data_type == DataTypes.DATA_TYPE_DATE \
                    or data_type == DataTypes.DATA_TYPE_TIME \
                    or data_type == DataTypes.DATA_TYPE_TIMESTAMP:
                if not date_format in self.schema[index]["types_found"][data_type]["date_format"].keys():
                    self.schema[index]["types_found"][data_type]["date_format"][date_format] = 1
                else:
                    self.schema[index]["types_found"][data_type]["date_format"][date_format] += 1

            # Store the precision and scale for float and integer
            if data_type in (DataTypes.DATA_TYPE_FLOAT, DataTypes.DATA_TYPE_INTEGER):
                current_max_precision = self.schema[index]["types_found"][data_type]["max_precision"]
                self.schema[index]["types_found"][data_type]["max_precision"] = max(current_max_precision,
                                                                                    number_precision)

                current_max_scale = self.schema[index]["types_found"][data_type]["max_scale"]
                self.schema[index]["types_found"][data_type]["max_scale"] = max(current_max_scale,
                                                                                number_scale)

    def _infer_row_type(self):
        print(f'DetectTypes: Total records to consider: {len(self.rows)}')

        for rowid, row in enumerate(self.rows):
            values = list(csv.reader([row.rstrip()], delimiter=self.delimiter))[0]

            # Ignore blank row
            if len(values) == 0:
                continue

            if len(values) < self.field_count:
                print(f'Not enough columns in the row # {rowid + 2}, cannot infer schema')
                print(f'Expected number of columns: {self.field_count}, found {len(values)}')

                raise Exception(f'Not enough columns in the row # {rowid + 2}, cannot infer schema. '
                                f'Expected number of columns: {self.field_count}, found {len(values)}')

            if len(values) > self.field_count:
                print(f'Extra columns found in the row # {rowid + 2}, record will be ignored during inference')
                continue

            # For each column value in the row.
            for index, value in enumerate(values):
                self._infer_value_type(value[0:self.max_length], index)

        print(f'DetectTypes: Detected Schema: \n {json.dumps(self.schema, indent=4)}')

    def infer_schema(self):
        # Read file
        rows = read_first_n_rows(self.csv_file_path, self.max_rows)

        self._set_header(rows[0])
        self.rows = rows[1:]

        self._init_schema()
        self._infer_row_type()

        for c in self.schema:
            types = self.schema[c]['types_found']

            # If there is None Type then it is a nullable field.
            if DataTypes.DATA_TYPE_NONE in types.keys():
                self.schema[c]["nullable"] = True

                # Remove the None Type as this information is no longer needed
                del self.schema[c]['types_found'][DataTypes.DATA_TYPE_NONE]
            else:
                self.schema[c]["nullable"] = False

            # If there are more than 2 data types then the final data type should be set to String.
            if len(types.keys()) > 2:
                self.schema[c]["data_type"] = DataTypes.DATA_TYPE_STRING

                if DataTypes.DATA_TYPE_STRING in types.keys():
                    self.schema[c]["max_length"] = max(DataTypes.MINIMUM_STR_LENGTH,
                                                       self.schema[c]['types_found'][DataTypes.DATA_TYPE_STRING][
                                                           "max_length"])
                else:
                    self.schema[c]["max_length"] = DataTypes.MINIMUM_STR_LENGTH

            # If there are exactly 2 data types then check if they are integer and float. If so use float, else string
            if len(types.keys()) == 2:
                if DataTypes.DATA_TYPE_INTEGER in types.keys() and DataTypes.DATA_TYPE_FLOAT in types.keys():
                    self.schema[c]["data_type"] = DataTypes.DATA_TYPE_FLOAT

                    max_scale = self.schema[c]['types_found'][DataTypes.DATA_TYPE_FLOAT]["max_scale"]
                    self.schema[c]["max_scale"] = max_scale

                    max_precision_float = self.schema[c]['types_found'][DataTypes.DATA_TYPE_FLOAT]["max_precision"]
                    max_precision_int = self.schema[c]['types_found'][DataTypes.DATA_TYPE_INTEGER]["max_precision"]

                    self.schema[c]["max_precision"] = max(max_precision_float, max_precision_int + max_scale)
                else:
                    self.schema[c]["data_type"] = DataTypes.DATA_TYPE_STRING

                    if DataTypes.DATA_TYPE_STRING in types.keys():
                        self.schema[c]["max_length"] = max(DataTypes.MINIMUM_STR_LENGTH,
                                                           self.schema[c]['types_found'][DataTypes.DATA_TYPE_STRING][
                                                               "max_length"])
                    else:
                        self.schema[c]["max_length"] = DataTypes.MINIMUM_STR_LENGTH

            if len(types.keys()) == 1:
                data_type = list(types.keys())[0]

                self.schema[c]["data_type"] = data_type
                self.schema[c]["max_length"] = self.schema[c]['types_found'][data_type]["max_length"]
                self.schema[c]["max_precision"] = self.schema[c]['types_found'][data_type]["max_precision"]
                self.schema[c]["max_scale"] = self.schema[c]['types_found'][data_type]["max_scale"]

                # If there are multiple date formats.
                if len(self.schema[c]['types_found'][data_type]["date_format"].keys()) > 1:
                    self.schema[c]["data_type"] = DataTypes.DATA_TYPE_STRING
                elif len(self.schema[c]['types_found'][data_type]["date_format"].keys()) == 1:
                    self.schema[c]["date_format"] = \
                        list(self.schema[c]['types_found'][data_type]["date_format"].keys())[0]
                else:
                    self.schema[c]["date_format"] = None

            del self.schema[c]["types_found"]

        print(f'InferSchema: Inferred Schema: \n {json.dumps(self.schema, indent=4)}')

        return self.schema

    def build_metadata(self):
        entity_name = os.path.splitext(os.path.basename(self.csv_file_path))[0]

        # Create a dictionary to store metadata
        metadata = {
            "entities": [
            ]
        }

        entity_info = {
            "name": entity_name,
            "delimiter": self.delimiter,
            "fields": []
        }

        for c in self.schema:
            data_type = self.schema[c]['data_type']

            column_info = {
                "name": self.schema[c]['name'],
                "type": data_type.lower(),
                "nullable": self.schema[c]['nullable'],
            }

            if data_type == DataTypes.DATA_TYPE_STRING:
                column_info["length"] = self.schema[c]["max_length"]

            if data_type in (DataTypes.DATA_TYPE_DATE, DataTypes.DATA_TYPE_TIME, DataTypes.DATA_TYPE_TIMESTAMP):
                column_info["format"] = self.schema[c]["date_format"]

            if data_type == DataTypes.DATA_TYPE_FLOAT:
                column_info["precision"] = self.schema[c]["max_precision"]
                column_info["scale"] = self.schema[c]["max_scale"]

            if data_type == DataTypes.DATA_TYPE_INTEGER:
                column_info["precision"] = self.schema[c]["max_precision"]

            entity_info["fields"].append(column_info)

        metadata["entities"].append(entity_info)

        print(f'BuildMetadata: Metadata: \n {json.dumps(metadata, indent=4)}')

        return metadata
