-- Begin --
-- Script to copy data from staging to raw --
use role MGSSFCOREDATAENGDEV;
use warehouse COMPUTE_DEVCORE;
use database RAW_${mdp_suffix};
use schema HEALTHCORUM;

-- Begin: Loading data for facility_metrics
put file:///home/vishal.kala/healthcorum/data_files/facility_metrics.csv @RAW_${mdp_suffix}.HEALTHCORUM.%facility_metrics;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.facility_metrics (
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $current_ts,
        $generated_uuid,
        'facility_metrics'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%facility_metrics)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for facility_metrics


-- Begin: Loading data for facility_metric_dim
put file:///home/vishal.kala/healthcorum/data_files/facility_metric_dim.csv @RAW_${mdp_suffix}.HEALTHCORUM.%facility_metric_dim;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.facility_metric_dim (
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $current_ts,
        $generated_uuid,
        'facility_metric_dim'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%facility_metric_dim)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for facility_metric_dim


-- Begin: Loading data for facility_provider_dim
put file:///home/vishal.kala/healthcorum/data_files/facility_provider_dim.csv @RAW_${mdp_suffix}.HEALTHCORUM.%facility_provider_dim;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.facility_provider_dim (
        npi,
        name,
        facility_type,
        peer_group,
        overall_score,
        appropriateness_score,
        cost_score,
        effectiveness_score,
        patient_panel,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $5 ,
        $6 ,
        $7 ,
        $8 ,
        $9 ,
        $current_ts,
        $generated_uuid,
        'facility_provider_dim'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%facility_provider_dim)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for facility_provider_dim


-- Begin: Loading data for practice_metrics
put file:///home/vishal.kala/healthcorum/data_files/practice_metrics.csv @RAW_${mdp_suffix}.HEALTHCORUM.%practice_metrics;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.practice_metrics (
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $current_ts,
        $generated_uuid,
        'practice_metrics'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%practice_metrics)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for practice_metrics


-- Begin: Loading data for practice_metric_dim
put file:///home/vishal.kala/healthcorum/data_files/practice_metric_dim.csv @RAW_${mdp_suffix}.HEALTHCORUM.%practice_metric_dim;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.practice_metric_dim (
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $current_ts,
        $generated_uuid,
        'practice_metric_dim'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%practice_metric_dim)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for practice_metric_dim


-- Begin: Loading data for practice_provider_dim
put file:///home/vishal.kala/healthcorum/data_files/practice_provider_dim.csv @RAW_${mdp_suffix}.HEALTHCORUM.%practice_provider_dim;

SET generated_uuid = (SELECT UUID_STRING());

SET current_ts = (SELECT CURRENT_TIMESTAMP());

COPY INTO RAW_${mdp_suffix}.HEALTHCORUM.practice_provider_dim (
        npi,
        name,
        subspecialty,
        specialty_domain,
        avg_risk,
        peer_group,
        peer_avg_risk,
        overall_score,
        appropriateness_score,
        cost_score,
        effectiveness_score,
        patient_panel_prof,
        patient_panel_rx,
        raw_load_time,
        task_run_id,
        table_name
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $5 ,
        $6 ,
        $7 ,
        $8 ,
        $9 ,
        $10 ,
        $11 ,
        $12 ,
        $13 ,
        $current_ts,
        $generated_uuid,
        'practice_provider_dim'
        FROM @RAW_${mdp_suffix}.HEALTHCORUM.%practice_provider_dim)
        FILE_FORMAT = (TYPE = CSV
                SKIP_HEADER = 1
                FIELD_DELIMITER = ','
                FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for practice_provider_dim

-- End --
