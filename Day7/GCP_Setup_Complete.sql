-- =====================================================
-- SNOWFLAKE GCP INTEGRATION SETUP - COMPLETE GUIDE
-- Project: snowflake-demo-2024
-- Bucket: gs://snowflake-demo-2024-data
-- =====================================================

-- STEP 1: PREREQUISITES (COMPLETED)
-- =====================================================
-- ✅ Project created: snowflake-demo-2024
-- ✅ Service Account created: snowflake-gcs-integration@snowflake-demo-2024.iam.gserviceaccount.com
-- ✅ GCS Bucket created: gs://snowflake-demo-2024-data
-- ✅ Files uploaded: MOCK.csv, JSON_ADV.json
-- ✅ Permissions granted: Storage Object Admin

-- =====================================================

-- STEP 2: SNOWFLAKE SETUP
-- =====================================================

-- 2.1. Use appropriate role and warehouse
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

-- 2.2. Create or use existing database and schema
CREATE DATABASE IF NOT EXISTS LA_DB;
USE DATABASE LA_DB;

CREATE SCHEMA IF NOT EXISTS LA_SCHEMA;
USE SCHEMA LA_SCHEMA;

-- =====================================================

-- STEP 3: CREATE STORAGE INTEGRATION
-- =====================================================

-- 3.1. Tạo Storage Integration cho Google Cloud Storage (KHÔNG dùng STORAGE_GCS_SERVICE_ACCOUNT)
CREATE OR REPLACE STORAGE INTEGRATION gcp_storage_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'GCS'
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('gcs://snowflake-demo-2024-data/')
  COMMENT = 'Integration for GCS bucket access';

-- 3.2. Lấy service account do Snowflake sinh ra để cấp quyền trên GCP:
DESC STORAGE INTEGRATION gcp_storage_integration;
-- => Copy giá trị ở cột STORAGE_GCP_SERVICE_ACCOUNT (hoặc STORAGE_GCS_SERVICE_ACCOUNT)
-- => Vào GCP, cấp quyền Storage Object Admin cho service account này trên bucket gs://snowflake-demo-2024-data

-- =====================================================

-- STEP 4: GCP SIDE CONFIGURATION (COMPLETED)
-- =====================================================
-- ✅ Service account has Storage Object Admin permission on bucket
-- ✅ Bucket contains test files: MOCK.csv, JSON_ADV.json

-- =====================================================

-- STEP 5: CREATE FILE FORMATS
-- =====================================================

-- 5.1. CSV Format
CREATE OR REPLACE FILE FORMAT gcp_csv_format
   TYPE = 'CSV'
   FIELD_DELIMITER = ','
   SKIP_HEADER = 1
   NULL_IF = ('NULL', 'null')
   EMPTY_FIELD_AS_NULL = TRUE
   TRIM_SPACE = TRUE;

-- 5.2. JSON Format
CREATE OR REPLACE FILE FORMAT gcp_json_format
   TYPE = 'JSON'
   STRIP_OUTER_ARRAY = TRUE
   ENABLE_OCTAL = FALSE
   ALLOW_DUPLICATE = FALSE;

-- 5.3. Parquet Format
CREATE OR REPLACE FILE FORMAT gcp_parquet_format
   TYPE = 'PARQUET'
   COMPRESSION = 'AUTO';

-- =====================================================

-- STEP 6: CREATE STAGES
-- =====================================================

-- 6.1. Create Stage for CSV files
CREATE OR REPLACE STAGE gcp_csv_stage
  STORAGE_INTEGRATION = gcp_storage_integration
  URL = 'gcs://snowflake-demo-2024-data/'
  FILE_FORMAT = gcp_csv_format;

-- 6.2. Create Stage for JSON files
CREATE OR REPLACE STAGE gcp_json_stage
  STORAGE_INTEGRATION = gcp_storage_integration
  URL = 'gcs://snowflake-demo-2024-data/'
  FILE_FORMAT = gcp_json_format;

-- 6.3. Create Stage for all data files
CREATE OR REPLACE STAGE gcp_data_stage
  STORAGE_INTEGRATION = gcp_storage_integration
  URL = 'gcs://snowflake-demo-2024-data/';

-- =====================================================

-- STEP 7: VERIFY STAGE CONFIGURATION
-- =====================================================

-- 7.1. Describe stages
DESC STAGE gcp_csv_stage;
DESC STAGE gcp_json_stage;
DESC STAGE gcp_data_stage;

-- 7.2. List files in stage
LIST @gcp_csv_stage;
LIST @gcp_json_stage;
LIST @gcp_data_stage;

-- =====================================================

-- STEP 8: CREATE TABLES
-- =====================================================

-- 8.1. Create table for CSV data (based on MOCK.csv structure)
CREATE OR REPLACE TABLE customer_data (
  customer VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" INTEGER
);

-- 8.2. Create table for JSON data
CREATE OR REPLACE TABLE json_data (
  data VARIANT
);

SELECT * FROM  customer_data;
SELECT * FROM  json_data;

-- =====================================================

-- STEP 9: LOAD DATA FROM GCS
-- =====================================================

-- 9.1. Load CSV data using specific file
COPY INTO customer_data
  FROM @gcp_csv_stage
  FILES = ('MOCK.csv')
  ON_ERROR = 'CONTINUE'
  VALIDATION_MODE = RETURN_ERRORS;

-- 9.2. Load JSON data
COPY INTO json_data
  FROM @gcp_json_stage
  FILES = ('JSON_ADV.json')
  ON_ERROR = 'CONTINUE';

SELECT * FROM  customer_data;
SELECT * FROM  json_data;

-- 9.3. Load CSV data using pattern matching
-- COPY INTO customer_data
--   FROM @gcp_csv_stage
--   PATTERN = '.*\.csv'
--   ON_ERROR = 'CONTINUE';

-- =====================================================

-- STEP 10: VERIFY DATA LOADING
-- =====================================================

-- 10.1. Check loaded data
SELECT COUNT(*) as total_rows FROM customer_data;
SELECT * FROM customer_data LIMIT 10;

-- 10.2. Check JSON data
SELECT COUNT(*) as total_rows FROM json_data;
SELECT data FROM json_data LIMIT 5;

-- =====================================================

-- STEP 11: ADVANCED FEATURES
-- =====================================================

-- 11.1. Create external table (for read-only access)
CREATE OR REPLACE EXTERNAL TABLE external_customer_data (
    customer VARCHAR AS (value:c1::VARCHAR),
    first_name VARCHAR AS (value:c2::VARCHAR),
    last_name VARCHAR AS (value:c3::VARCHAR),
    region VARCHAR AS (value:c4::VARCHAR),
    email VARCHAR AS (value:c5::VARCHAR),
    gender VARCHAR AS (value:c6::VARCHAR),
    "ORDER" INTEGER AS (value:c7::INTEGER)
)
LOCATION = @gcp_csv_stage
FILE_FORMAT = gcp_csv_format
PATTERN = '.*\\.csv'
AUTO_REFRESH = FALSE;

-- 11.2. Query external table
SELECT * FROM external_customer_data LIMIT 10;

-- =====================================================

-- STEP 12: CLEANUP (if needed)
-- =====================================================

-- 12.1. Drop stages
-- DROP STAGE IF EXISTS gcp_csv_stage;
-- DROP STAGE IF EXISTS gcp_json_stage;
-- DROP STAGE IF EXISTS gcp_data_stage;

-- 12.2. Drop file formats
-- DROP FILE FORMAT IF EXISTS gcp_csv_format;
-- DROP FILE FORMAT IF EXISTS gcp_json_format;
-- DROP FILE FORMAT IF EXISTS gcp_parquet_format;

-- 12.3. Drop integration
-- DROP INTEGRATION IF EXISTS gcp_storage_integration;

-- =====================================================
-- TROUBLESHOOTING COMMANDS
-- =====================================================

-- Check integration status
SHOW INTEGRATIONS;

-- Check stage status
SHOW STAGES;

-- Check file format status
SHOW FILE FORMATS;

-- Test stage access
LIST @gcp_data_stage;

-- Check copy history
SELECT * FROM TABLE(INFORMATION_SCHEMA.COPY_HISTORY(
  TABLE_NAME => 'CUSTOMER_DATA',
  START_TIME => DATEADD('hours', -24, CURRENT_TIMESTAMP())
));

-- =====================================================
-- PROJECT INFORMATION:
-- =====================================================
-- Project ID: snowflake-demo-2024
-- GCS Bucket: gs://snowflake-demo-2024-data
-- Service Account: snowflake-gcs-integration@snowflake-demo-2024.iam.gserviceaccount.com
-- Test Files: MOCK.csv, JSON_ADV.json
-- Billing Account: 015CEC-3E1119-59CF0C 