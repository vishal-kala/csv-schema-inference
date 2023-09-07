% if is_first:
-- Begin --
-- Script to copy data from raw to trusted --
use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['trusted_db']['database']};
use schema ${sf_details['trusted_db']['schema']};
% endif

-- Begin: Loading data for ${entity['name']}
INSERT INTO ${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.${entity['name']}
 (
%   for field in entity['fields']:
        ${field['name']},
%   endfor
        raw_load_time,
        task_run_id,
        load_timestamp
 )
   SELECT
%   for field in entity['fields']:
        ${field['name']},
%   endfor
        raw_load_time,
        task_run_id,
        current_timestamp
   FROM ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${entity['name']};

-- End: Loading data for ${entity['name']}

% if is_last:
-- End --
% endif
