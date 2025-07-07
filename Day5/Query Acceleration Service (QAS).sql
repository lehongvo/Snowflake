/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;


-- Find Eligible Queries

SELECT query_id, eligible_query_acceleration_time
  FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_ACCELERATION_ELIGIBLE
  ORDER BY eligible_query_acceleration_time DESC;

-- Check various QAS parameters

SELECT parse_json(system$estimate_query_acceleration('01ae2979-3200-d4c9-0005-3db60005f1be'));

{
  "estimatedQueryTimes": {
    "1": 473,
    "2": 319,
    "28": 44,
    "4": 196,
    "8": 114
  },
  "originalQueryTime": 927.589,
  "queryUUID": "01ae2979-3200-d4c9-0005-3db60005f1be",
  "status": "eligible",
  "upperLimitScaleFactor": 28
}

-- Find the query

SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
where Query_id = '01ae2979-3200-d4c9-0005-3db60005f1be';

-- Set the cache to false

ALTER SESSION SET  USE_CACHED_RESULT = FALSE;

-- Add the Query

SELECT ss_item_sk, ss_customer_sk, ss_ticket_number, ss_net_paid
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.store_sales
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.customer ON store_sales.ss_customer_sk = customer.c_customer_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
WHERE customer.c_current_cdemo_sk =  customer.c_current_hdemo_sk
AND date_dim.d_year = 2001;


-- Add the accelaration

-- Scaling factor cost you in multiple of scaling factor, example scale factor of 5 can cost 5X credit of normal use

ALTER WAREHOUSE COMPUTE_WH SET
  ENABLE_QUERY_ACCELERATION =  TRUE
  QUERY_ACCELERATION_MAX_SCALE_FACTOR = 0;

-- Check the warehouse

  SHOW WAREHOUSES LIKE '%COMPUTE_WH%'; 