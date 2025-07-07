/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

ALTER SESSION SET  USE_CACHED_RESULT = FALSE;

-- Distinct Count , HLL error rate very low at : 1.62338%

SELECT COUNT(DISTINCT WR_ORDER_NUMBER) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_RETURNS;

-- 6m 25s 


SELECT APPROX_COUNT_DISTINCT (WR_ORDER_NUMBER) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_RETURNS;

-- 37s 


-- Similarity

CREATE OR REPLACE TABLE sample_table1 (
  id INT,
  name VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255)
);

INSERT INTO sample_table1 (id, name, city, state)
VALUES (1, 'John Doe', 'San Francisco', 'CA'),
       (2, 'Jane Doe', 'New York', 'NY'),
       (3, 'Peter Smith', 'Chicago', 'IL'),
       (4, 'Susan Jones', 'Los Angeles', 'CA'),
       (5, 'David Williams', 'Seattle', 'WA');


CREATE OR REPLACE TABLE sample_table2 (
  id INT,
  name VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255)
);

INSERT INTO sample_table2 (id, name, city, state)
VALUES (1, 'John Doe', 'San Francisco', 'CA'),
       (2, 'Jane Doe', 'New York', 'NY'),
       (3, 'Peter Smith', 'Chicago', 'IL'),
       (4, 'Susan Jones', 'Los Angeles', 'CA'),
       (5, 'David Williams', 'Seattle', 'WA'),
       (6, 'Mary Johnson', 'Dallas', 'TX'),
       (7, 'Michael Brown', 'Miami', 'FL');


select minhash(5, *) from sample_table1; -- Max K value is 1024, recommended is 100


select approximate_similarity(mh) 
from (
  select minhash(100, *) as mh from sample_table1
  union all
  select minhash(100, *) as mh from sample_table2
);

-- Frequency Estimation




SELECT TOP 5 HD_BUY_POTENTIAL, COUNT(HD_BUY_POTENTIAL) as Num FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.HOUSEHOLD_DEMOGRAPHICS
GROUP BY HD_BUY_POTENTIAL
ORDER BY Num DESC;

SELECT APPROX_TOP_K (HD_BUY_POTENTIAL,5,10000) 
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.HOUSEHOLD_DEMOGRAPHICS;




-- Percentile function

CREATE OR REPLACE TABLE testtable (c1 INTEGER);
INSERT INTO testtable (c1) VALUES 
    (0),
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10);

SELECT APPROX_PERCENTILE(c1, 0.1) FROM testtable;


