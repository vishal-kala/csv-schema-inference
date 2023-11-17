CREATE OR REPLACE TABLE TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_metric_dim (
    metric_id NUMBER(16, 0),
    metric_name VARCHAR(64),
    metric_description VARCHAR(1024),
    metric_domain VARCHAR(64),
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    load_timestamp TIMESTAMP
);

USE DATABASE DL_CHANGE_MGMT_${mdp_suffix};
