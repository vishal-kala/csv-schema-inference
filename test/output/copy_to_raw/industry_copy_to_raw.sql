-- Begin --
-- Script to copy data from staging to raw --
use role DATA_ENGINEER;
use warehouse DATA_ENGINEER;
use database RAW_WIP;
use schema HEALTH_DATA;

-- Begin: Loading data for industry_data
put file:///home/reference_data/data_files/industry_data.csv @RAW_WIP.HEALTH_DATA.%industry_data;

COPY INTO RAW_WIP.HEALTH_DATA.industry_data (
        year ,
        industry_aggregation_nzsioc ,
        industry_code_nzsioc ,
        industry_name_nzsioc ,
        units ,
        variable_code ,
        variable_name ,
        variable_category ,
        value ,
        industry_code_anzsic06 ,
        raw_load_time ,
        task_run_id
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $5 ,
        $6 ,
        $7 ,
        $8 ,
        $9 ,
        $10 ,
        timestamp_ntz(current_timestamp) ,
        newid()
        FROM @RAW_WIP.HEALTH_DATA.%industry_data)
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for industry_data


-- Begin: Loading data for debt_data
put file:///home/reference_data/data_files/debt_data.csv @RAW_WIP.HEALTH_DATA.%debt_data;

COPY INTO RAW_WIP.HEALTH_DATA.debt_data (
        id ,
        ranking ,
        debt_taken ,
        amount ,
        date_y ,
        date_m ,
        date_d ,
        ts_1 ,
        ts_2 ,
        ts_3 ,
        raw_load_time ,
        task_run_id
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        $5 ,
        $6 ,
        $7 ,
        $8 ,
        $9 ,
        $10 ,
        timestamp_ntz(current_timestamp) ,
        newid()
        FROM @RAW_WIP.HEALTH_DATA.%debt_data)
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for debt_data


-- Begin: Loading data for invoice
put file:///home/reference_data/data_files/invoice.csv @RAW_WIP.HEALTH_DATA.%invoice;

COPY INTO RAW_WIP.HEALTH_DATA.invoice (
        invoice_id ,
        invoice_date ,
        payment_date ,
        amount ,
        raw_load_time ,
        task_run_id
    )
FROM (SELECT
        $1 ,
        $2 ,
        $3 ,
        $4 ,
        timestamp_ntz(current_timestamp) ,
        newid()
        FROM @RAW_WIP.HEALTH_DATA.%invoice)
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- End: Loading data for invoice

-- End --
