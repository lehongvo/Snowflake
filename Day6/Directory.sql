-- Create a stage with encryption

CREATE
OR REPLACE STAGE internal_UN_stage 
 ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
DIRECTORY=(ENABLE=TRUE);

-- Alter to enable Directory in existing

ALTER STAGE internal_UN_stage
SET DIRECTORY=(ENABLE=TRUE);

-- Check for data in DIRECTORY

SELECT * FROM  DIRECTORY(@internal_UN_stage);

-- Manual Refresh

ALTER STAGE internal_UN_stage REFRESH;


-- For External Stage Auto refresh

directoryTableParams (for Amazon S3) ::=
  [ DIRECTORY = ( ENABLE = { TRUE | FALSE }
                  [ REFRESH_ON_CREATE =  { TRUE | FALSE } ]
                  [ AUTO_REFRESH = { TRUE | FALSE } ] ) ]