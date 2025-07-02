/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

-- Create TASK with User Managed Warehouse

CREATE OR REPLACE TASK TASK_DEMO_U
  WAREHOUSE = WAREHOUSE_SMARTOSC
  SCHEDULE = '2 SECONDS'
AS
INSERT INTO my_table (id, name, email) VALUES
  (100, 'User Managed', 'john@example.com');

-- Create TASK for Serverless

CREATE OR REPLACE TASK TASK_DEMO_S
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'   --By Default Medium
  SCHEDULE = '1 MINUTE'
AS
INSERT INTO my_table (id, name, email) VALUES
  (100, 'Serverless', 'john@example.com');
  
-- Check the default values

SHOW PARAMETERS IN DATABASE;
  
-- Show all Tasks

SHOW TASKS;

-- Need to Resume the tasks

ALTER TASK TASK_DEMO_U RESUME;
ALTER TASK TASK_DEMO_S RESUME;

--Check history of all tasks

SELECT * FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY());

-- Check data update

SELECT * FROM MY_TABLE;

-- You can alter the initial warehouse

ALTER TASK TASK_DEMO_S SET USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'SMALL';

-- Suspend the Tasks

ALTER TASK TASK_DEMO_S SUSPEND;
ALTER TASK TASK_DEMO_U SUSPEND;

DESC TASK TASK_DEMO_S;


EXECUTE TASK TASK_DEMO_S;


DROP TASK IF EXISTS TASK_DEMO_S;

-- Depndednt Tasks

CREATE OR REPLACE TASK TASK_DEMO_2
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
  --SCHEDULE = '1 MINUTE'
  AFTER TASK_DEMO_U
AS
INSERT INTO my_table (id, name, email) VALUES
  (100, 'Dependent', 'john@example.com');

ALTER TASK TASK_DEMO_2 RESUME;

SHOW TASKS;


-- Combining Stream and Tasks

-- Inserting new record in source tablle

INSERT INTO raw_data (id, name, age)
VALUES (10, 'Learn', 45);

SELECT * FROM raw_data_stream;

CREATE OR REPLACE TASK TASK_STREAM
  USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
  SCHEDULE = '1 MINUTE'
WHEN  SYSTEM$STREAM_HAS_DATA('raw_data_stream')
AS INSERT INTO processed_data(id,name,age) SELECT id, name, age FROM raw_data_stream;

ALTER TASK TASK_STREAM RESUME;

--Check history of all tasks

SELECT * FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY());

SHOW TASKS;

SELECT *  FROM processed_data;


ALTER TASK TASK_DEMO_2 SUSPEND;

--Drop All Tasks

DROP TASK TASK_DEMO_2;
DROP TASK TASK_STREAM;
DROP TASK TASK_DEMO_U;

  






  


