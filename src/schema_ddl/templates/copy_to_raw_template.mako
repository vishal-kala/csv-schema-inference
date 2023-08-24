% if is_first:
-- Begin --
-- Script to copy data from staging to raw --
use role ${sf_details['role']};
use warehouse ${sf_details['role']};
use database ${sf_details['raw_db']['database']};
use schema ${sf_details['raw_db']['schema']};
% endif

-- Begin: Loading data for ${entity['name']}
put file://${sf_details['data_folder']}/${entity['name']}.csv \
    @${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.%${entity['name']};

COPY INTO ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${entity['name']} (
%   for field in entity['fields']:
        ${field['name']} ,
%   endfor
        raw_load_time ,
        task_run_id
    )
FROM (SELECT
%   for field in entity['fields']:
        $${loop.index+1} ,
%   endfor
        timestamp_ntz(current_timestamp) ,
        newid()
        FROM @${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.%${entity['name']})
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for ${entity['name']}

% if is_last:
-- End --
% endif
