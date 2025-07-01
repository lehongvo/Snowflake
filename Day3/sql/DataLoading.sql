-- Use relavant DB, Schema, Role and Warehouse

USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

-- Create a new table

CREATE TABLE customers (
  customer INT NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  region VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  gender VARCHAR(255) NOT NULL,
  "order" INT NOT NULL
);



-- Force load, shall reload the data forcefully

COPY INTO "LA_DB"."LA_SCHEMA"."CUSTOMERS"
FROM '@"LA_DB"."LA_SCHEMA"."CUST_STAGE"/MOCK.csv'
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=FALSE,
    FIELD_OPTIONALLY_ENCLOSED_BY=NONE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT
FORCE = TRUE;