% if is_first:
-- Begin --
-- Script to create all the necessary entities --

use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['raw_db']['database']};
use schema ${sf_details['raw_db']['schema']};

% endif

CREATE OR REPLACE TABLE ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${entity['name']} (
%   for field in entity['fields']:
    ${field['name']} ${field['data_type']},
%   endfor
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(32),
    table_name VARCHAR(64)
);