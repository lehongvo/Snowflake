USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

create or replace TABLE LA_DB.LA_SCHEMA.CUSTOMERS_TABLE (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(255) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);


-- List down the stage
list @%CUSTOMERS_TABLE;


-- load file via snowsql
put file://C:\data\MOCK.CSV @%customers_table/staged AUTO_COMPRESS = FALSE;
put file://C:\data\MOCK1.CSV @%customers_table/staged AUTO_COMPRESS = FALSE;

put file://C:\data\MOCK1.CSV @%customers_table/staged AUTO_COMPRESS = FALSE OVERWRITE = TRUE;

-- Copy file from stage to table
COPY INTO customers_table
FROM @%customers_table/staged
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)  PURGE = TRUE;

