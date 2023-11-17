CREATE OR REPLACE TABLE RAW_${mdp_suffix}.HEALTHCORUM.facility_provider_dim (
    npi NUMBER(16, 0),
    name VARCHAR(128),
    facility_type VARCHAR(64),
    peer_group VARCHAR(64),
    overall_score NUMBER(16, 8),
    appropriateness_score NUMBER(16, 8),
    cost_score NUMBER(16, 8),
    effectiveness_score NUMBER(16, 8),
    patient_panel VARCHAR(64),
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    table_name VARCHAR(64)
);

USE DATABASE DL_CHANGE_MGMT_${mdp_suffix};
