-- Begin --
-- Script to create all the necessary entities --

use role DATA_ENGINEER;
use warehouse COMPUTE_DEV_CORE;
use database RAW_WIP;
use schema HEALTH_DATA;


CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.industry_data (
    year NUMBER(16, 0) NOT NULL ,
    industry_aggregation_nzsioc VARCHAR(64) NOT NULL ,
    industry_code_nzsioc VARCHAR(64) NOT NULL ,
    industry_name_nzsioc VARCHAR(128) NOT NULL ,
    units VARCHAR(64) NOT NULL ,
    variable_code VARCHAR(64) NOT NULL ,
    variable_name VARCHAR(64) NOT NULL ,
    variable_category VARCHAR(64) NOT NULL ,
    value VARCHAR(64) NOT NULL ,
    industry_code_anzsic06 VARCHAR(128) NOT NULL ,
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);

CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.debt_data (
    id NUMBER(16, 0) NOT NULL ,
    ranking NUMBER(16, 0) ,
    debt_taken BOOLEAN NOT NULL ,
    amount NUMBER(16, 4) ,
    date_y DATE ,
    date_m DATE ,
    date_d DATE ,
    ts_1 TIMESTAMP ,
    ts_2 TIMESTAMP ,
    ts_3 TIMESTAMP ,
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);

CREATE OR REPLACE TABLE RAW_WIP.HEALTH_DATA.invoice (
    invoice_id NUMBER(16, 0) NOT NULL ,
    invoice_date DATE NOT NULL ,
    payment_date DATE NOT NULL ,
    amount NUMBER(16, 10) NOT NULL ,
    raw_load_time TIMESTAMP ,
    task_run_id VARCHAR(32)
);
