/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

-- Create Sequence     

CREATE OR REPLACE SEQUENCE SEQUENCE_SAMPLE START = 1 INCREMENT = 1;

-- Check the details

SHOW SEQUENCES;

SHOW SEQUENCES like '%s%';

-- Check Sequence Value

SELECT SEQUENCE_SAMPLE.NEXTVAL;

--Create a New Table

CREATE OR REPLACE TABLE sequence_table (i INTEGER);

-- Keep doubling the number of rows:
INSERT INTO sequence_table (i) VALUES(SEQUENCE_SAMPLE.NEXTVAL);
INSERT INTO sequence_table (i) VALUES(SEQUENCE_SAMPLE.NEXTVAL);
INSERT INTO sequence_table (i) VALUES(SEQUENCE_SAMPLE.NEXTVAL);

-- Check the table value

SELECT i FROM sequence_table;

-- Important

-- SNowflake does not gurantee generating sequence without gaps

-- Also note Default value for the INCREMENT and START is 1.

-- Create a new sequence with increment of 5

CREATE OR REPLACE SEQUENCE SEQUENCE_SAMPLE2 START = 1 INCREMENT = 5;

-- Check multiple next value

SELECT SEQUENCE_SAMPLE2.nextval a, SEQUENCE_SAMPLE2.nextval b, SEQUENCE_SAMPLE2.nextval c, SEQUENCE_SAMPLE2.nextval d;


-- ALTER Sequence


ALTER SEQUENCE SEQUENCE_SAMPLE RENAME TO seq_name;


-- Drop Sequence

DROP SEQUENCE IF EXISTS SEQUENCE_SAMPLE;

