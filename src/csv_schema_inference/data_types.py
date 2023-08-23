class DataTypes:

    ALLOWED_DATE_FORMATS = [
        ("%Y-%m-%d", "YYYY-mm-dd"),
        ("%d-%m-%Y", "dd-mm-YYYY"),
        ("%m/%d/%Y", "mm/dd/YYYY"),
        ("%d/%m/%Y", "dd/mm/YYYY")
        # Add more date-only formats as needed
    ]

    ALLOWED_TIMESTAMP_FORMATS = [
        ("%Y-%m-%d %H:%M:%S", "YYYY-mm-dd HH:MI:SS"),
        ("%Y-%m-%d %I:%M:%S %p", "YYYY-mm-dd HH12:MI:SS AM")
        # Add more timestamp formats as needed
    ]

    ALLOWED_TIME_FORMATS = [
        ("%H:%M:%S", "HH:MI:SS"),
        ("%I:%M:%S %p", "HH12:MI:SS AM")
        # Add more timestamp formats as needed
    ]

    ALLOWED_BOOLEAN_VALUES = ["true", "false", "TRUE", "FALSE", "True", "False"]

    ALLOWED_NULL_VALUES = ["", "na", "NA", "null", "NULL"]

    DATA_TYPE_STRING = 'STRING'
    DATA_TYPE_FLOAT = 'FLOAT'
    DATA_TYPE_INTEGER = 'INTEGER'
    DATA_TYPE_DATE = 'DATE'
    DATA_TYPE_TIMESTAMP = 'TIMESTAMP'
    DATA_TYPE_TIME = 'TIME'
    DATA_TYPE_UNKNOWN = 'UNKNOWN'
    DATA_TYPE_BOOLEAN = 'BOOLEAN'
    DATA_TYPE_NONE = 'NONE'

    MINIMUM_STR_LENGTH = 32
    MINIMUM_PRECISION = 12
    MINIMUM_SCALE = 2