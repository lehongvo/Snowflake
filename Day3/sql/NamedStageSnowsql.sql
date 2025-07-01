USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

create or replace TABLE LA_DB.LA_SCHEMA.CUSTOMERS_NAMED (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(255) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);



show stages;


CREATE
OR REPLACE STAGE internal_named_stage1 file_format = (
    type = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1
);

-- All Command listed here (Except PUT command)  can be executed in snowsight as well

PUT file:///Users/user/Downloads/Code+and+Data+Files/data/MOCK.csv @internal_named_stage1 AUTO_COMPRESS = FALSE;
PUT file:///Users/user/Downloads/Code+and+Data+Files/data/MOCK1.csv @internal_named_stage1 AUTO_COMPRESS = FALSE OVERWRITE = TRUE;

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)  PURGE = TRUE;

