CREATE OR REPLACE TABLE TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_metrics (
    npi NUMBER(16, 0),
    metric_id NUMBER(16, 0),
    metric_score NUMBER(16, 0),
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    load_timestamp TIMESTAMP
);

USE DATABASE DL_CHANGE_MGMT_${mdp_suffix};
