

-- Set Query Result cache to FALSE

ALTER SESSION SET  USE_CACHED_RESULT = FALSE;

SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER;


-- Dummy Query

SELECT ss_item_sk, ss_customer_sk, ss_ticket_number, ss_net_paid
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.store_sales
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.store_returns ON store_sales.ss_customer_sk = store_returns.sr_customer_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk limit 20000;
WHERE customer.c_current_cdemo_sk =  customer.c_current_hdemo_sk limit 20000;
--AND date_dim.d_year = 2001;

--01ae2990-3200-d4c9-0005-3db60005f2ea


EXPLAIN USING TEXT SELECT CC_CALL_CENTER_SK from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CALL_CENTER;

-- Query History Function

SELECT * FROM TABLE(information_schema.query_history())
ORDER BY START_TIME;

-- Query History View 45 Min to 3 hours latency, also available for readers account usage

SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY;




