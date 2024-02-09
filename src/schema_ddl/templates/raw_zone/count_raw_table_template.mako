% if is_first:
-- Begin --
-- Script to count rows for all the necessary entities --

use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['raw_db']['database']};
use schema ${sf_details['raw_db']['schema']};

% endif

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${entity['name']}
GROUP BY table_name, task_run_id, raw_load_time ;
