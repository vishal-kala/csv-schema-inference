-- Begin --
-- Script to rollback table creations --

use role DATA_ENGINEER;
use warehouse COMPUTE_DEV_CORE;
use database TRUSTED_WIP;
use schema REFERENCE_DATA;

DROP TABLE TRUSTED_WIP.REFERENCE_DATA.industry_data;


DROP TABLE TRUSTED_WIP.REFERENCE_DATA.debt_data;


DROP TABLE TRUSTED_WIP.REFERENCE_DATA.invoice;

-- End --
