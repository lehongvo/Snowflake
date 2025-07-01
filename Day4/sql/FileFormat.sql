/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;


-- Copy CommandALL
COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)  PURGE = TRUE;



-- File Format definiation

CREATE OR REPLACE FILE FORMAT my_csv_ff
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true
  COMPRESSION = NONE;

  --Use file format
  
COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff  FORCE = TRUE;

select * from customers_named limit 10;

-- FF for JSON

CREATE OR REPLACE FILE FORMAT my_json_ff
  TYPE = JSON;

-- FF for PARQUET

CREATE OR REPLACE FILE FORMAT my_parquet_ff
  TYPE = PARQUET
  COMPRESSION = SNAPPY;



-- Alter FF

ALTER FILE FORMAT IF EXISTS my_csv_ff RENAME TO my_csv_ff_new;

ALTER FILE FORMAT my_csv_ff_new SET FIELD_DELIMITER='|';

--Describe FF

DESC FILE FORMAT my_csv_ff_new;


--  Show FF

SHOW FILE FORMATS;

--Drop FF

DROP FILE FORMAT my_csv_ff_new;




--Overriding Default File Format Options





COPY INTO mytable
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff;

CREATE STAGE my_int_stage
  FILE_FORMAT = my_csv_ff;
  

  CREATE TABLE mytable
  USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    WITHIN GROUP (ORDER BY ORDER_ID)
      FROM TABLE(
        INFER_SCHEMA(
          LOCATION=>'@mystage',
          FILE_FORMAT=>'my_csv_ff'
        )
      ));

      

1.COPY INTO TABLE statement.

2.Stage definition.

3.Table definition.