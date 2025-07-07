/* CREATE DATABASE AND SCHEMA*/

USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;
/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

-- Create a JSON File format

CREATE OR REPLACE FILE FORMAT myjsonformat TYPE = 'JSON'
STRIP_OUTER_ARRAY = TRUE;

-- Creat a stage

CREATE OR REPLACE STAGE my_jsonfile file_format = myjsonformat;

-- Create table with Variant option

CREATE OR REPLACE TABLE raw_source (SRC VARIANT);

-- Upload Json file from SNOWSQL

put file ://C: \ data \ JSON_NEW.json @my_jsonfile AUTO_COMPRESS = FALSE;

-- Copy table into Variant table

COPY INTO raw_source
FROM @my_jsonfile FILE_FORMAT = myjsonformat;
    
-- Check JSON data in table

SELECT * FROM raw_source;



-- Check and see a column at a time

SELECT src, src:Department
FROM   raw_source;


-- Remove the Quotes
SELECT  src, src:Department::string AS Dept
FROM    raw_source;

-- Traverse the file

SELECT src,src:Zone[0].SubZone
FROM    raw_source;



SELECT src, src:Zone [0].Division [0].Store
FROM   raw_source;


SELECT src:Department::string, 
Zone_f.*
FROM  raw_source,
    LATERAL FLATTEN(INPUT => SRC:Zone) as Zone_f;


create or replace table dump_json as
SELECT src:Department::string as dep, 
Zone.value:SubZone :: string as subzone_col,
div.value:Store :: string as store_col, 
ord.value:SR :: string as sr_col,
ord.value:Sales :: string as sales_col

FROM  raw_source,
    LATERAL FLATTEN(INPUT => SRC:Zone) as Zone,
    LATERAL FLATTEN(INPUT => zone.value:Division) as div,
    LATERAL FLATTEN(INPUT => div.value:Orders) as ord;

--create or replace table dump_json as    
SELECT
    src:Department::string as dept_col,
    zone.value:SubZone :: string as subzone_col,
    div.value:Store :: string  as ord,
    ord.value:SR :: string as sr_col,
    ord.value:Sales :: string as sales_col
    
FROM
    raw_source,
    LATERAL FLATTEN(INPUT => SRC:Zone) as Zone,
    LATERAL FLATTEN(INPUT => zone.value:Division) as div,
    LATERAL FLATTEN(INPUT => div.value:Orders) as ord;


select * from  dump_json;









