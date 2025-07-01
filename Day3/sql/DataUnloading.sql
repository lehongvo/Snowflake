USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

create or replace TABLE LA_DB.LA_SCHEMA.CUSTOMERS_USER (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(255) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);



list @~;

-- Recommended to USE 100-250 MB of compressed file

put file://C:\data\MOCK.CSV @~/customers_user/staged AUTO_COMPRESS = FALSE;
put file://C:\data\MOCK1.CSV @~/customers_user/staged AUTO_COMPRESS = FALSE;

put file://C:\data\MOCK1.CSV @~/customers_user/staged AUTO_COMPRESS = FALSE OVERWRITE = TRUE;

-- Upload files
PUT file:///Users/user/Downloads/Code+and+Data+Files/data/MOCK.csv @~/customers_user/staged AUTO_COMPRESS = FALSE;
PUT file:///Users/user/Downloads/Code+and+Data+Files/data/MOCK1.csv @~/customers_user/staged AUTO_COMPRESS = FALSE;
PUT file:///Users/user/Downloads/Code+and+Data+Files/data/MOCK1.csv @~/customers_user/staged AUTO_COMPRESS = FALSE OVERWRITE = TRUE;


COPY INTO customers_user
FROM @~/customers_user/staged
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)  PURGE = TRUE;

