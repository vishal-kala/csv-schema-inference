-- Begin --
-- Script to rollback table creations --

use role DATA_ENGINEER;
use warehouse COMPUTE_DEV_CORE;
use database RAW_WIP;
use schema HEALTH_DATA;

DROP TABLE RAW_WIP.HEALTH_DATA.industry_data;


DROP TABLE RAW_WIP.HEALTH_DATA.debt_data;


DROP TABLE RAW_WIP.HEALTH_DATA.invoice;

-- End --
