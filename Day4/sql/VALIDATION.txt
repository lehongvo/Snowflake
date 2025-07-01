/* Validation Mode, to test the data before loading

VALIDATION_MODE = RETURN_n_ROWS | RETURN_ERRORS | RETURN_ALL_ERRORS

VALIDATE : Validates the files loaded in a past execution of the COPY INTO <table> command 

*/

/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

RM @internal_named_stage;

LS @internal_named_stage;

-- CSV File Format

CREATE OR REPLACE FILE FORMAT my_csv_ff
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true
  COMPRESSION = NONE;

  -- Create a sample table
  
CREATE OR REPLACE TABLE LA_DB.LA_SCHEMA.CUSTOMERS_NAMED3 (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(255) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);

-- Return all error by simulation

COPY INTO customers_named3
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
VALIDATION_MODE = 'RETURN_ERRORS';

-- Just check first N rows for error

COPY INTO customers_named3
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
VALIDATION_MODE = 'RETURN_10_ROWS';

-- Return all error by simulation, also include previous partialy loaded file

COPY INTO customers_named3
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
VALIDATION_MODE = 'RETURN_ALL_ERRORS';

-- Truncate table

TRUNCATE customers_named;


-- Using RETURN_FAILED_ONLY

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = CONTINUE
RETURN_FAILED_ONLY  = TRUE;

-- VALIDATE Option to check error in last COPY COmmand

SELECT * FROM TABLE(VALIDATE(customers_named, JOB_ID => '_last')); --01ade083-3200-d1bb-0005-3db60002918a

-- Save error in separate table

CREATE OR REPLACE TABLE copy_errors AS SELECT * FROM TABLE(VALIDATE(customers_named, JOB_ID => '01ade083-3200-d1bb-0005-3db60002918a'));

SELECT *  FROM copy_errors;





