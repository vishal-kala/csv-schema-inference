CREATE OR REPLACE TABLE csv_data (
    yea_r NUMBER(16, 0) NOT NULL ,
    industry_aggregation_nzsioc VARCHAR(64) NOT NULL ,
    industry_code_nzsioc VARCHAR(64) NOT NULL ,
    industry_name_nzsioc VARCHAR(128) NOT NULL ,
    units VARCHAR(64) NOT NULL ,
    variable_code VARCHAR(64) NOT NULL ,
    variable_name VARCHAR(64) NOT NULL ,
    variable_category VARCHAR(64) NOT NULL ,
    value VARCHAR(64) NOT NULL ,
    industry_code_anzsic06 VARCHAR(128) NOT NULL 
);
