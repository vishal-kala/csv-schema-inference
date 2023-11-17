CREATE OR REPLACE TABLE ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${entity['name']} (
%   for field in entity['fields']:
    ${field['name']} ${field['data_type']},
%   endfor
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    table_name VARCHAR(64)
);

USE DATABASE DL_CHANGE_MGMT_${'${mdp_suffix}'};
