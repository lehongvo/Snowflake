/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;
 
 -- Create new table
CREATE or replace TABLE new_pipe_table (
  customer VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" INTEGER
  -- "ORDER" INTEGER
);



list @INTERNAL_NAMED_STAGE;

-- Create a Pipe to Copy

CREATE OR REPLACE PIPE MYPIPE
AS
COPY INTO NEW_PIPE_TABLE FROM @INTERNAL_NAMED_STAGE;




-- Check data in the table

SELECT COUNT(*) from NEW_PIPE_TABLE;

-- Template for PIPE
CREATE [ OR REPLACE ] PIPE [ IF NOT EXISTS ] <name>
  [ AUTO_INGEST = [ TRUE | FALSE ] ]
  [ ERROR_INTEGRATION = <integration_name> ]
  [ AWS_SNS_TOPIC = '<string>' ]
  [ INTEGRATION = '<string>' ]
  [ COMMENT = '<string_literal>' ]
  AS <copy_statement>;

-- Show all PIPES

SHOW PIPES;

--Decribe MYPIPE

DESC PIPE MYPIPE;

-- Check data in the table

SELECT COUNT(*) from NEW_PIPE_TABLE;

-- Check Pipe Status
SELECT SYSTEM$PIPE_STATUS( 'MYPIPE' );

-- Refres to get it activate
ALTER PIPE MYPIPE REFRESH;










-- Create task to automate the snowpipe
CREATE or replace TASK TASK_SAMPLE
schedule = '1 MINUTE'
 --USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
 AS ALTER PIPE MYPIPE REFRESH;

 -- See the details of task
DESC TASK TASK_SAMPLE;

-- Start the task
ALTER TASK TASK_SAMPLE resume;

-- Drop the task
DROP TASK TASK_SAMPLE;
