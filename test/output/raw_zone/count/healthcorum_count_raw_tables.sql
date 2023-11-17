-- Begin --
-- Script to count rows for all the necessary entities --

use role MGSSFCOREDATAENGDEV;
use warehouse COMPUTE_DEVCORE;
use database RAW_${mdp_suffix};
use schema HEALTHCORUM;


SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_metrics
GROUP BY table_name, task_run_id, raw_load_time ;

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_metric_dim
GROUP BY table_name, task_run_id, raw_load_time ;

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_provider_dim
GROUP BY table_name, task_run_id, raw_load_time ;

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_metrics
GROUP BY table_name, task_run_id, raw_load_time ;

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_metric_dim
GROUP BY table_name, task_run_id, raw_load_time ;

SELECT table_name, task_run_id, raw_load_time, COUNT(1) as record_count
FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_provider_dim
GROUP BY table_name, task_run_id, raw_load_time ;
