/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;


-- Create a table
CREATE OR REPLACE TABLE mytable (
 id number(8) NOT NULL,
 first_name varchar(255) default NULL,
 last_name varchar(255) default NULL,
 city varchar(255),
 state varchar(255)
);

-- Populate the table with data
INSERT INTO mytable (id,first_name,last_name,city,state)
 VALUES
 (1,'Ryan','Dalton','Salt Lake City','UT'),
 (2,'Upton','Conway','Birmingham','AL'),
 (3,'Kibo','Horton','Columbus','GA');

-- Create a JSON File format

CREATE OR REPLACE FILE FORMAT myjsonformat TYPE = 'JSON' COMPRESSION='NONE';


-- Creat a stage

CREATE OR REPLACE STAGE my_jsonfile file_format = myjsonformat;


-- Unload the data to a file in a stage
COPY INTO @my_jsonfile
 FROM (SELECT OBJECT_CONSTRUCT('id', id, 'first_name', first_name, 'last_name', last_name, 'city', city, 'state', state) FROM mytable)
 FILE_FORMAT = myjsonformat;
 

ls @my_jsonfile;

 -- GET for SNOWSQL
--GET  @my_jsonfile/data_0_0_0.json file://C:\data\unload2;

-- Create a PARQUET File format

CREATE OR REPLACE FILE FORMAT myparformat TYPE = 'PARQUET'  COMPRESSION='NONE';


-- Creat a stage

CREATE OR REPLACE STAGE my_parfile file_format = myparformat;

COPY INTO @my_parfile 
FROM  (SELECT OBJECT_CONSTRUCT('id', id, 'first_name', first_name, 'last_name', last_name, 'city', city, 'state', state) FROM mytable)
 FILE_FORMAT = myparformat;

 ls @my_parfile; 

 -- GET for SNOWSQL
 --GET  @my_parfile/data_0_0_0.parquet file://C:\data\unload2;
 