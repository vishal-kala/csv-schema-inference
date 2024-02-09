from src.schema_ddl.ddl_generator import DDLGenerator


def main():
    ddl_generator = DDLGenerator(
        metadata_file_path='./output/healthcorum.json',
        config_file_path='./config.json'
    )
    ddl_generator.generate_ddl()


if __name__ == '__main__':
    main()
