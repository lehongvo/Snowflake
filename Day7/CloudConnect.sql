-- Create AWS Account
-- Load S3 File
-- Create Policy
-- Attach to the role
-- Create Storage Integration
-- Update connection between SF and AWS
-- Create File Format
-- Load stage
-- COPY INTO


/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;


-- Create Storage Integration for GCS
CREATE OR REPLACE STORAGE INTEGRATION sample_gcs_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'GCS'
  ENABLED = TRUE
  STORAGE_GCS_SERVICE_ACCOUNT = '<your-gcs-service-account-email>'
  STORAGE_ALLOWED_LOCATIONS = ('gcs://your-gcs-bucket/path/to/data/');
-- STORAGE_BLOCKED_LOCATIONS = ('<confidential data1>', '<confidential data2>');

-- Find details of the Integration and update relation between GCP
DESC INTEGRATION sample_gcs_int;

-- CSV format (reuse if needed)
CREATE OR REPLACE FILE FORMAT mycsvformat
   TYPE = 'CSV'
   FIELD_DELIMITER = ','
   SKIP_HEADER = 1;

-- Create Stage for GCS
CREATE OR REPLACE STAGE my_gcs_stage
  STORAGE_INTEGRATION = sample_gcs_int
  URL = 'gcs://your-gcs-bucket/path/to/data/'
  FILE_FORMAT = mycsvformat;

-- Describe stage
DESC STAGE my_gcs_stage;

-- Create Table (reuse if needed)
CREATE or replace TABLE new_table_cloud (
  customer VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" INTEGER
);

-- Copy INTO table from GCS
COPY INTO new_table_cloud
  FROM @my_gcs_stage
  PATTERN='.*MOCK.*.csv';

-- Check table
SELECT * FROM new_table_cloud;

-- Load directly from GCS Bucket (if needed, using storage integration)
-- Note: Direct credential usage is not supported for GCS like AWS; use storage integration and stage.
-- COPY INTO new_table_cloud
--   FROM 'gcs://your-gcs-bucket/path/to/data/MOCK.csv'
--   STORAGE_INTEGRATION = sample_gcs_int
--   FILE_FORMAT = (FORMAT_NAME = mycsvformat);