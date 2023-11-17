-- Begin --
-- Script to copy data from raw to trusted --
use role MGSSFCOREDATAENGDEV;
use warehouse COMPUTE_DEVCORE;
use database TRUSTED_${mdp_suffix};
use schema HEALTHCORUM;

-- Begin: Loading data for facility_metrics
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_metrics
 (
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        load_timestamp
 )
   SELECT
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_metrics;

-- End: Loading data for facility_metrics


-- Begin: Loading data for facility_metric_dim
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_metric_dim
 (
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        load_timestamp
 )
   SELECT
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_metric_dim;

-- End: Loading data for facility_metric_dim


-- Begin: Loading data for facility_provider_dim
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_provider_dim
 (
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
        load_timestamp
 )
   SELECT
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
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.facility_provider_dim;

-- End: Loading data for facility_provider_dim


-- Begin: Loading data for practice_metrics
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_metrics
 (
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        load_timestamp
 )
   SELECT
        npi,
        metric_id,
        metric_score,
        raw_load_time,
        task_run_id,
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_metrics;

-- End: Loading data for practice_metrics


-- Begin: Loading data for practice_metric_dim
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_metric_dim
 (
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        load_timestamp
 )
   SELECT
        metric_id,
        metric_name,
        metric_description,
        metric_domain,
        raw_load_time,
        task_run_id,
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_metric_dim;

-- End: Loading data for practice_metric_dim


-- Begin: Loading data for practice_provider_dim
INSERT INTO TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_provider_dim
 (
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
        load_timestamp
 )
   SELECT
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
        current_timestamp
   FROM RAW_${mdp_suffix}.HEALTHCORUM.practice_provider_dim;

-- End: Loading data for practice_provider_dim

-- End --
