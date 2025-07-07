/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

-- Create a stage with encryption

CREATE
OR REPLACE STAGE internal_UN_stage 
 ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

 -- check the listing

LS @internal_UN_stage;

-- Test all the functions

-- Scoped File URL : Generates a scoped Snowflake-hosted URL to a staged file
--                   using the stage name and relative file path as inputs.

PUT file:///Users/user/Desktop/NewOPP/images.avif @internal_UN_stage AUTO_COMPRESS = FALSE;

SELECT BUILD_SCOPED_FILE_URL (@internal_UN_stage, 'images.jpg');

-- Stage File URL : Generates a Snowflake-hosted file URL to a staged file 
--                  using the stage name and relative file path as inputs.

SELECT BUILD_STAGE_FILE_URL (@internal_UN_stage, 'images.jpg');

-- Presigned URL : Generates the pre-signed URL to a staged file using the stage name and 
--                 relative file path as inputs. Access files in an external stage using the function.


SELECT GET_PRESIGNED_URL (@internal_UN_stage, 'images.jpg', 60);


-- Stage Location : Returns the URL for an external or internal named stage using the stage name as the input.

SELECT GET_STAGE_LOCATION(@internal_UN_stage);


SELECT GET_ABSOLUTE_PATH (@internal_UN_stage, 'images.jpg');



SELECT GET_RELATIVE_PATH (@internal_UN_stage, 's3://sfc-sg-ds1-52-customer-stage/heka0000-s/stages/c7f70975-579a-45e5-92b8-9cc28e8b6137/images.jpg');


-- Create a view on top of Scoped URL 

CREATE OR REPLACE SECURE VIEW sample_image AS
SELECT BUILD_SCOPED_FILE_URL (@internal_UN_stage, 'images.jpg') AS scoped_file_url;

-- View can be used to access the file

SELECT * from sample_image;




 
