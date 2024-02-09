import csv
from collections import Counter

DEFAULT_ROWS_TO_CONSIDER = 100
MAX_ROWS_TO_CONSIDER = 5000

DELIMITER_COMMA = ','
DELIMITER_COLON = ':'
DELIMITER_PIPE = '|'
DELIMITER_SEMI_COLON = ';'
DELIMITER_TAB = '\t'

DEFAULT_DELIMITER = DELIMITER_COMMA

ALLOWED_DELIMITERS = [DELIMITER_COMMA, DELIMITER_COLON, DELIMITER_PIPE, DELIMITER_SEMI_COLON, DELIMITER_TAB]


# Read first N rows from a CSV file.
def read_first_n_rows(file_path, no_of_rows):
    print(f'ReadFirstNRows: Reading first {no_of_rows} rows from csv file {file_path}')

    with open(file_path, 'r', newline='', encoding='utf-8') as file:
        # Initialize a list to store the first n rows
        first_n_rows = []

        # Read and store the next n-1 rows
        for _ in range(no_of_rows):
            row = file.readline()
            if not row:
                print(f'ReadFirstNRows: Reached last line at row # {_}')
                break  # Stop if the end of file is reached

            first_n_rows.append(row)

    print(f'ReadFirstNRows: Finished reading first {len(first_n_rows)} rows from csv file {file_path}')

    return first_n_rows


class CsvDelimiterDetector:
    def __init__(self, file_path, no_of_rows=DEFAULT_ROWS_TO_CONSIDER):
        self.file_path = file_path
        self.no_of_rows = min(no_of_rows, MAX_ROWS_TO_CONSIDER)  # Will limit number of rows to MAX_ROWS_TO_CONSIDER

        self.header = None
        self.delimiter = None
        self.rows = None

    def _set_header(self):
        # Read the header row
        self.header = self.rows[0].rstrip()
        print(f'SetHeader: Header row: {self.header}')

    # Read the first row and determine the delimiter list based on the number of occurrences of the delimiter.
    def _detect_possible_delimiters(self):
        print(f'DetectPossibleDelimiters: Detecting all possible delimiters using the header row')

        # Initialize a Counter to count delimiter occurrences
        delimiter_counter = Counter()

        for delimiter in ALLOWED_DELIMITERS:
            # Count occurrence of the delimiter in the header row
            delimiter_count = self.header.count(delimiter)
            print(f'DetectPossibleDelimiters: Checking for occurrence of [{delimiter}], '
                  f'found {delimiter_count} occurrence')

            if delimiter_count > 0:
                delimiter_counter[delimiter] = delimiter_count

        # Sort delimiters by occurrence count in decreasing order
        sorted_delimiters = sorted(delimiter_counter.items(), key=lambda x: x[1], reverse=True)

        # Extract delimiters from sorted pairs
        possible_delimiters = [delimiter for delimiter, count in sorted_delimiters]

        print(f'DetectPossibleDelimiters: Possible delimiters are {possible_delimiters}')

        return possible_delimiters

    # Detect the delimiter based on the input rows and possible delimiters
    def _detect_delimiter_from_n_rows(self, possible_delimiters):
        print(f'DetectDelimiterFromNRows: Determining best matching delimiter')

        for delimiter in possible_delimiters:
            print(f'DetectDelimiterFromNRows: Checking if [{delimiter}] is the best matching delimiter')

            # Find the count of delimiter in the first row.
            delimiter_count = self._count_occurrence_of_delimiter(self.header, delimiter)

            print(f'DetectDelimiterFromNRows: Count of delimiter [{delimiter}] in header row is {delimiter_count}')

            if all([delimiter_count == self._count_occurrence_of_delimiter(self.rows[i], delimiter) for i in
                    range(1, len(self.rows))]):
                print(f'DetectDelimiterFromNRows: All {len(self.rows)} rows have same # of occurrence of [{delimiter}] '
                      f'hence this is the best matching delimiter')

                self.delimiter = delimiter
                break
            else:
                print(f'DetectDelimiterFromNRows: One or more rows have different # of occurrence of [{delimiter}] '
                      f'hence this may not be a right delimiter, will continue to check further')

        if self.delimiter is None:
            print(f'DetectDelimiterFromNRows: Could not find a delimiter that has same occurrence across all rows, '
                  f'hence returning the 1st one from the best possible delimiter list: {possible_delimiters}')

            self.delimiter = possible_delimiters[0] if len(possible_delimiters) > 0 else DEFAULT_DELIMITER

        return self.delimiter

    def _count_occurrence_of_delimiter(self, record, delimiter):
        values = list(csv.reader([record.rstrip()], delimiter=delimiter))[0]

        return len(list(values))

    # Read the file and detect the delimiter using first N rows.
    def detect_delimiter(self):
        self.rows = read_first_n_rows(self.file_path, self.no_of_rows)
        self._set_header()

        possible_delimiters = self._detect_possible_delimiters()
        delimiter = self._detect_delimiter_from_n_rows(possible_delimiters)

        print(f'DetectDelimiter: Detected delimiter for file: {self.file_path} as [{delimiter}] '
              f'using first {len(self.rows)} rows.')

        return delimiter
