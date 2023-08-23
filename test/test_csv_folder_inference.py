from csv_folder_inference import CsvFolderInference

if __name__ == "__main__":
    folder_path = './data/industry'
    output_file_path = './output/industry.json'

    folder_inferer = CsvFolderInference(folder_path, output_file_path)
    folder_inferer.perform_inference()
