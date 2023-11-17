CREATE OR REPLACE TABLE TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_provider_dim (
    npi NUMBER(16, 0),
    name VARCHAR(64),
    subspecialty VARCHAR(64),
    specialty_domain VARCHAR(64),
    avg_risk NUMBER(16, 8),
    peer_group VARCHAR(256),
    peer_avg_risk NUMBER(16, 8),
    overall_score NUMBER(16, 8),
    appropriateness_score NUMBER(16, 8),
    cost_score NUMBER(16, 8),
    effectiveness_score NUMBER(16, 8),
    patient_panel_prof VARCHAR(64),
    patient_panel_rx VARCHAR(64),
    raw_load_time TIMESTAMP,
    task_run_id VARCHAR(48),
    load_timestamp TIMESTAMP
);

USE DATABASE DL_CHANGE_MGMT_${mdp_suffix};
