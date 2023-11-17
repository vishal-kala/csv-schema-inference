-- Begin --
-- Script to count rows for all the necessary entities --

use role MGSSFCOREDATAENGDEV;
use warehouse COMPUTE_DEVCORE;
use database TRUSTED_${mdp_suffix};
use schema HEALTHCORUM;


SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_metrics ;

SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_metric_dim ;

SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.facility_provider_dim ;

SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_metrics ;

SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_metric_dim ;

SELECT COUNT(1) FROM TRUSTED_${mdp_suffix}.HEALTHCORUM.practice_provider_dim ;
