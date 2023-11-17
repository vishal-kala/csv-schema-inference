CREATE OR REPLACE TABLE RAW_${mdp_suffix}.HEALTHCORUM.facility_metrics (
    npi NUMBER(16, 0),
    metric_id NUMBER(16, 0),
    metric_score NUMBER(16, 8),
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    table_name VARCHAR(64)
);

USE DATABASE DL_CHANGE_MGMT_${mdp_suffix};
