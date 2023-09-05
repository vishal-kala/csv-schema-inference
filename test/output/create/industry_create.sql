-- Begin --
-- Script to create all the necessary entities --

use role DATA_ENGINEER;
use warehouse COMPUTE_DEV_CORE;
use database RAW_WIP;
use schema HEALTH_DATA;


CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.industry_data (
    year NUMBER(16, 0),
    industry_aggregation_nzsioc VARCHAR(64),
    industry_code_nzsioc VARCHAR(64),
    industry_name_nzsioc VARCHAR(128),
    units VARCHAR(64),
    variable_code VARCHAR(64),
    variable_name VARCHAR(64),
    variable_category VARCHAR(64),
    value VARCHAR(64),
    industry_code_anzsic06 VARCHAR(128),
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);

CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.debt_data (
    id NUMBER(16, 0),
    ranking NUMBER(16, 0),
    debt_taken BOOLEAN,
    amount NUMBER(16, 8),
    date_y DATE,
    date_m DATE,
    date_d DATE,
    ts_1 TIMESTAMP,
    ts_2 TIMESTAMP,
    ts_3 TIMESTAMP,
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);

CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.invoice (
    invoice_id NUMBER(16, 0),
    invoice_date DATE,
    payment_date DATE,
    amount NUMBER(32, 20),
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);
