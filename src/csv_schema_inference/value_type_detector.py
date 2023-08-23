from datetime import datetime

from data_types import DataTypes

CHAR_DECIMAL = '.'


class ValueTypeDetector:
    def _get_float_or_integer_type(self, value):
        try:
            float_value = float(value)

            if float_value.is_integer() and CHAR_DECIMAL not in value:
                return DataTypes.DATA_TYPE_INTEGER, len(str(int(value))), 0
            else:
                return DataTypes.DATA_TYPE_FLOAT, len(str(value)) - 1, len(str(value).split('.')[1])
        except ValueError:
            return DataTypes.DATA_TYPE_UNKNOWN, None, None

    def _get_date_type(self, value):
        if 8 <= len(value) <= 10:  # Check if the input string length is 8, 9 or 10 characters
            for date_format, sql_format in DataTypes.ALLOWED_DATE_FORMATS:
                try:
                    datetime.strptime(value, date_format)
                    return DataTypes.DATA_TYPE_DATE, sql_format
                except ValueError:
                    pass

        if 16 <= len(value) <= 22:  # Check if the input string length is between 16 and 22 characters
            for timestamp_format, sql_format in DataTypes.ALLOWED_TIMESTAMP_FORMATS:
                try:
                    datetime.strptime(value, timestamp_format)
                    return DataTypes.DATA_TYPE_TIMESTAMP, sql_format
                except ValueError:
                    pass

        if 8 <= len(value) <= 12:  # Check if the input string length is between 8 and 12 characters
            for time_format, sql_format in DataTypes.ALLOWED_TIME_FORMATS:
                try:
                    datetime.strptime(value, time_format)
                    return DataTypes.DATA_TYPE_TIME, sql_format
                except ValueError:
                    pass

        return DataTypes.DATA_TYPE_UNKNOWN, None

    def _get_boolean_type(self, value):
        if value in DataTypes.ALLOWED_BOOLEAN_VALUES:
            return DataTypes.DATA_TYPE_BOOLEAN

        return DataTypes.DATA_TYPE_UNKNOWN

    def _get_none_type(self, value):
        if value in DataTypes.ALLOWED_NULL_VALUES:
            return DataTypes.DATA_TYPE_NONE

        return DataTypes.DATA_TYPE_UNKNOWN

    def _get_string_type(self, value):
        return DataTypes.DATA_TYPE_STRING, len(value)

    def infer_value_type(self, value):
        date_format = None
        number_precision = DataTypes.MINIMUM_PRECISION
        number_scale = DataTypes.MINIMUM_SCALE
        str_length = DataTypes.MINIMUM_STR_LENGTH

        data_type = self._get_none_type(value)

        # Consider the value is of type float or integer
        if data_type == DataTypes.DATA_TYPE_UNKNOWN:
            data_type, number_precision, number_scale = self._get_float_or_integer_type(value)

        # Consider the value is of type date, timestamp, time
        if data_type == DataTypes.DATA_TYPE_UNKNOWN:
            data_type, date_format = self._get_date_type(value)

        # Consider the value is of type boolean
        if data_type == DataTypes.DATA_TYPE_UNKNOWN:
            data_type = self._get_boolean_type(value)

        # Consider the value is of type string
        if data_type == DataTypes.DATA_TYPE_UNKNOWN:
            data_type, str_length = self._get_string_type(value)

        value_type = {
            "data_type": data_type,
            "str_length": str_length,
            "number_precision": number_precision,
            "number_scale": number_scale,
            "date_format": date_format
        }

        return value_type
