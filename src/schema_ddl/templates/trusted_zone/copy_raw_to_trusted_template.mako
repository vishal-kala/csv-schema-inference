% if is_first:
-- Begin --
-- Script to copy data from raw to trusted --
use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['trusted_db']['database']};
use schema ${sf_details['trusted_db']['schema']};
% endif

-- Begin: Loading data for ${entity['name']}
put file://${sf_details['data_folder']}/${entity['name']}.csv \
    @${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.%${entity['name']};

COPY INTO ${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.${entity['name']} (
%   for field in entity['fields']:
        ${field['name']},
%   endfor
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
%   for field in entity['fields']:
        $${loop.index+1} ,
%   endfor
        timestamp_ntz(current_timestamp),
        newid(),
        '${entity['name']}'
        FROM @${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.%${entity['name']})
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = '${entity['delimiter']}'
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for ${entity['name']}

% if is_last:
-- End --
% endif
