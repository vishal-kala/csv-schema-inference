% if is_first:
-- Begin --
-- Script to create all the necessary tables --

use role ${sf_details['role']};
use warehouse ${sf_details['role']};
use database ${sf_details['raw_db']['database']};
use schema ${sf_details['raw_db']['schema']};

% endif

CREATE OR REPLACE TABLE ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${table['name']} (
%   for column in table['columns']:
    ${column['name']} ${column['data_type']} \
    % if 'nullable' in column:
        ${'NOT NULL' if not column['nullable'] else ''} \
    % endif
    ,
%   endfor
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);
