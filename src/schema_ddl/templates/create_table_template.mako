% for table in tables:
CREATE OR REPLACE TABLE ${table['name']} (
%   for column in table['columns']:
    ${column['name']} ${column['data_type']} \
    % if 'nullable' in column:
        ${'NOT NULL' if not column['nullable'] else ''} \
    % endif
    ${',' if not loop.last else ''}
%   endfor
);
% endfor
