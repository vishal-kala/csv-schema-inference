from csv_folder_inference import CsvFolderInference

if __name__ == "__main__":
    folder_path = 'data/healthcorum'
    output_file_path = './output/healthcorum.json'

    folder_inferer = CsvFolderInference(folder_path, output_file_path, max_rows=100000)
    folder_inferer.perform_inference()


