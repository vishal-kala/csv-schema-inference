from csv_delimiter_detector import CsvDelimiterDetector
from csv_schema_inference import CsvSchemaInference

NUMBER_OF_ROWS_TO_CONSIDER = 100000

if __name__ == "__main__":
    csv_file_path = './data/industry_sample_data.csv'
    csv_file_path2 = './data/industry_data.csv'
    output_file_path = './output/table.json'

    delim_detector = CsvDelimiterDetector(csv_file_path2, NUMBER_OF_ROWS_TO_CONSIDER)
    delimiter = delim_detector.detect_delimiter()

    print(f"Detected delimiter: '{delimiter}'")

    type_detector = CsvSchemaInference(delimiter, csv_file_path2, output_file_path, 1000000)
    type_detector.infer_schema()
    type_detector.write_schema()
