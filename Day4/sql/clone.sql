/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;



CREATE or REPLACE TABLE sample_data (
  id INT,
  name VARCHAR(50),
  age INT
);


INSERT INTO sample_data (id, name, age)
VALUES (1, 'John', 25),
       (2, 'Mary', 30),
       (3, 'Peter', 40),
       (4, 'Jane', 35);


-- Create a clone

CREATE OR REPLACE TABLE clone_data CLONE sample_data;

-- Create clone from clone

CREATE OR REPLACE TABLE clone_data2 CLONE clone_data;

SELECT * FROM clone_data2;
SELECT * FROM sample_data;

-- Update the original table

INSERT INTO sample_data (id, name, age)
VALUES (5, 'John', 25);

SELECT * FROM clone_data;

-- Time Travel-----

-- Create the CUSTOMER table
ALTER SESSION SET TIMEZONE = 'UTC';

-- This command retrieves the current timestamp in the UTC timezone
SELECT SYSTIMESTAMP();

--2023-07-29 05:30:44.611 +0000

TRUNCATE TABLE sample_data;

CREATE OR REPLACE TABLE orders_clone_restore CLONE sample_data BEFORE (TIMESTAMP => '2023-07-29 05:30:44.611 +0000'::timestamp);

CREATE OR REPLACE TABLE orders_clone_restore CLONE sample_data BEFORE (STATEMENT => '01adebc5-3200-d22f-0005-3db60003005e');



SELECT * FROM orders_clone_restore; 


-- This command selects all rows from the CUSTOMER table as it existed 3 hours ago
CREATE OR REPLACE TABLE orders_clone_restore CLONE sample_data  AT(OFFSET => -60*3);









/* Similary we can CLONE DB, SCEHMA but if any of the child has time travel beyond the retention period
  Or If Time travel is set before the child was created */


  -- Create a sample view
  
CREATE OR REPLACE VIEW myview AS SELECT * FROM CUSTOMER;

SELECT * FROM LA_DB.LA_SCHEMA.myview;

-- Clone the Schema

CREATE OR REPLACE SCHEMA LA_SCHEMA2 CLONE LA_SCHEMA;

-- Check DDL

SELECT GET_DDL ('schema', 'LA_SCHEMA2', true);


-- DROP original table
DROP TABLE LA_DB.LA_SCHEMA.CUSTOMER;

-- Check the impact on new view

SELECT * FROM LA_DB.LA_SCHEMA2.myview;

UNDROP TABLE LA_DB.LA_SCHEMA.CUSTOMER;

SELECT * FROM LA_DB.LA_SCHEMA2.CUSTOMER;







-- Testing for CLONING of stream



-- Create Source table
CREATE or REPLACE TABLE raw_data (
  id INT,
  name VARCHAR(50),
  age INT
);

-- Create new Stream

CREATE OR REPLACE STREAM raw_data_stream ON TABLE raw_data;

SHOW STREAMS;

-- Inserting new record in soucre tablle

INSERT INTO raw_data (id, name, age)
VALUES (5, 'Mike', 45);

-- Check Stream data

SELECT * FROM raw_data_stream;

-- Create Copy Stream

CREATE OR REPLACE STREAM LA_DB.LA_SCHEMA.raw_data_stream2 CLONE raw_data_stream;

SELECT * FROM LA_DB.LA_SCHEMA.raw_data_stream;

DESC stream raw_data_stream2;


-- Clone the Schema

DROP SCHEMA LA_SCHEMA2;

CREATE OR REPLACE SCHEMA LA_SCHEMA2 CLONE LA_SCHEMA;


DESC stream LA_DB.LA_SCHEMA2.RAW_DATA_STREAM;

SELECT * FROM LA_DB.LA_SCHEMA2.RAW_DATA_STREAM;

LA_DB.LA_SCHEMA2.RAW_DATA_STREAM





















