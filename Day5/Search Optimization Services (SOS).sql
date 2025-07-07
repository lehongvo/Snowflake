/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;


-- Lets find approx distinct count for any column

SELECT APPROX_COUNT_DISTINCT(C_CUSTOMER_ID) from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.customer;

-- Copy data to sample table

CREATE OR REPLACE TABLE SOS_CUSTOMER
AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER;

-- CHeck the data

SELECT COUNT(*) FROM SOS_CUSTOMER;


-- Check the property of the table

SHOW TABLES LIKE '%sos%';

-- Disable the cache

ALTER SESSION SET  USE_CACHED_RESULT = FALSE;

-- Check on table

SELECT * FROM SOS_CUSTOMER where C_CUSTOMER_ID = 'AAAAAAAAEAJMKCEA';

-- Set the serach optimization

ALTER TABLE SOS_CUSTOMER add search optimization;


-- Check the credit used details


SELECT * FROM TABLE(information_schema.search_optimization_history());

-- You can also add column wise SOS on Equality column

ALTER TABLE t1 ADD SEARCH OPTIMIZATION ON EQUALITY(c1, c2, c3);





  