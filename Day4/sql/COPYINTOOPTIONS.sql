/* 

    Copy INTO TABLE Options 

     ON_ERROR = { CONTINUE | SKIP_FILE (DEFAULT IN SNOWPIPE) | SKIP_FILE_<num> | 'SKIP_FILE_<num>%' | ABORT_STATEMENT (DEFAULT IN BULK LOADING) }
     SIZE_LIMIT = <num>
     RETURN_FAILED_ONLY = TRUE | FALSE (DEFAULT)
     MATCH_BY_COLUMN_NAME = CASE_SENSITIVE | CASE_INSENSITIVE | NONE (DEFAULT)  ---
     ENFORCE_LENGTH = TRUE (DEFAULT) | FALSE
     
     TRUNCATECOLUMNS = TRUE | FALSE
     FORCE = TRUE | FALSE
     PURGE = TRUE | FALSE

*/


/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

RM @internal_named_stage/MOCK1.CSV;

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
  
CREATE OR REPLACE TABLE LA_DB.LA_SCHEMA.CUSTOMERS_NAMED (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(255) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);

--ON_ERROR = { CONTINUE | SKIP_FILE (DEFAULT IN SNOWPIPE) | SKIP_FILE_<num> | 'SKIP_FILE_<num>%' | ABORT_STATEMENT (DEFAULT IN BULK LOADING) }
-- Use defaut Copy

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff;

SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;

-- ABORT STATEMENT IS BY DEFAULT

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = ABORT_STATEMENT;

SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;

-- Use of CONTINUE to ignore error records

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = CONTINUE;

SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;


-- SKIP the file if erroneous record

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = SKIP_FILE;

SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;

-- Ignore first 2 error

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = SKIP_FILE_2;

SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;

-- Ignore first 2% error

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = 'SKIP_FILE_2%';


SELECT COUNT(*) FROM customers_named;
TRUNCATE customers_named;

-- Size Limit Option, First file will always go through

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
SIZE_LIMIT = 640;

TRUNCATE customers_named;

-- RETURN_FAILED_ONLY = TRUE | FALSE (DEFAULT)
-- Return Failed file

COPY INTO customers_named
FROM @internal_named_stage
FILE_FORMAT = my_csv_ff
ON_ERROR = CONTINUE
RETURN_FAILED_ONLY  = TRUE;

TRUNCATE customers_named;

--MATCH_BY_COLUMN_NAME = CASE_SENSITIVE | CASE_INSENSITIVE | NONE (DEFAULT)
-- Case sensitive options checks Columns

COPY INTO customers_named
FROM @internal_named_stage/MOCK.CSV
FILE_FORMAT = my_csv_ff2
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

select * from customers_named;

TRUNCATE customers_named;

CREATE OR REPLACE FILE FORMAT my_csv_ff2
  TYPE = CSV
  FIELD_DELIMITER = ','
  --SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true
  PARSE_HEADER = TRUE
  COMPRESSION = NONE;

TRUNCATE customers_named;

  CREATE OR REPLACE TABLE LA_DB.LA_SCHEMA.CUSTOMERS_NAMED2 (
	CUSTOMER NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(5) NOT NULL,
	LAST_NAME VARCHAR(255) NOT NULL,
	REGION VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	GENDER VARCHAR(255) NOT NULL,
	"order" NUMBER(38,0) NOT NULL
);

-- ENFORCE_LENGTH = TRUE (DEFAULT) | FALSE
-- Reverse of TRUNCATECOLUMN

COPY INTO customers_named2
FROM @internal_named_stage/MOCK.CSV
FILE_FORMAT = my_csv_ff
ENFORCE_LENGTH =  FALSE;