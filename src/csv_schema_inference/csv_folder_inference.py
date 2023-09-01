import json
import os

from csv_delimiter_detector import CsvDelimiterDetector
from csv_schema_inference import CsvSchemaInference

MAX_ROWS_TO_CONSIDER_FOR_DATATYPE = 5000
MAX_ROWS_TO_CONSIDER_FOR_DELIM = 100


class CsvFolderInference:
    def __init__(self, folder_path, output_file_path, max_rows=MAX_ROWS_TO_CONSIDER_FOR_DATATYPE):
        self.folder_path = folder_path
        self.output_file_path = output_file_path
        self.max_rows = max_rows

    def perform_inference(self):
        print(f'PerformInference: Inferring all the files from folder: {self.folder_path}')

        metadata_all = {
            "entity_group": os.path.basename(self.folder_path),
            "entities": []
        }

        # Loop through all files in the folder
        for filename in os.listdir(self.folder_path):

            # Check if the file has a .csv extension
            if filename.endswith((".csv", ".txt")):
                # Construct the full path to the CSV file
                csv_file_path = os.path.join(self.folder_path, filename)
                print(f"PerformInference: Found CSV file: {csv_file_path}")

                # Detect the CSV delimiter for this file.
                delim_detector = CsvDelimiterDetector(csv_file_path, MAX_ROWS_TO_CONSIDER_FOR_DELIM)
                delimiter = delim_detector.detect_delimiter()

                type_detector = CsvSchemaInference(delimiter, csv_file_path, self.max_rows)
                type_detector.infer_schema()
                metadata = type_detector.build_metadata()

                metadata_all["entities"].append(metadata["entities"][0])

        os.makedirs(os.path.dirname(self.output_file_path), exist_ok=True)
        with open(self.output_file_path, 'w') as json_file:
            json.dump(metadata_all, json_file, indent=4)

        print(f'PerformInference: Output File: {self.output_file_path}')
        print(f'PerformInference: Metadata: \n {json.dumps(metadata_all, indent=4)}')
