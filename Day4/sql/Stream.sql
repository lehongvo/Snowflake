/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

-- Create Source table
CREATE or REPLACE TABLE raw_data (
  id INT,
  name VARCHAR(50),
  age INT
);



-- Create Target table

CREATE OR REPLACE TABLE processed_data (
  id INT,
  name VARCHAR(50),
  age VARCHAR(10)
);


SHOW TABLES LIKE '%raw%';

-- Insert data in source

INSERT INTO raw_data (id, name, age)
VALUES (1, 'John', 25),
       (2, 'Mary', 30),
       (3, 'Peter', 40),
       (4, 'Jane', 35);

       

-- Display source data

SELECT * FROM raw_data;

-- One time load to target table

INSERT INTO processed_data SELECT * FROM raw_data;

-- Display tagret table

SELECT * FROM processed_data;

-- Create Stream on source table

CREATE OR REPLACE STREAM raw_data_stream ON TABLE raw_data;

-- Show all streams 

SHOW STREAMS;

-- Show specific streams

DESC STREAM RAW_DATA_STREAM;

-- Display stream data

SELECT * FROM raw_data_stream;

-- Check databse parameters

SHOW PARAMETERS IN DATABASE;



-- Inserting new record in soucre tablle

INSERT INTO raw_data (id, name, age)
VALUES (5, 'Mike', 45);

-- Display stream data

SELECT * FROM raw_data_stream;

-- First example for insert stream

INSERT INTO processed_data(id,name,age) SELECT id, name, age FROM raw_data_stream;

-- After consuming stream

SELECT * FROM raw_data_stream;

-- Display tagret table

SELECT * FROM processed_data;






-- Update source table record
UPDATE raw_data SET age = 27 WHERE id = 1;



-- Delete a record
DELETE FROM raw_data WHERE id = 4;

-- Insert a new record
INSERT INTO raw_data (id, name, age)
VALUES (6, 'Mike', 65);


-- Merge to load data from stream to target 

 MERGE INTO processed_data p USING raw_data_stream s ON p.ID = s.ID
  WHEN MATCHED AND metadata$action = 'DELETE' AND metadata$isupdate = 'FALSE' -- Deletion
    THEN DELETE    
  WHEN MATCHED AND metadata$action = 'INSERT' AND metadata$isupdate = 'TRUE'  --Update
    THEN UPDATE SET p.NAME = s.NAME, p.AGE = s.AGE      
  WHEN NOT MATCHED AND metadata$action = 'INSERT' AND metadata$isupdate = 'FALSE' -- Insert
    THEN INSERT (ID, NAME, AGE) VALUES (s.ID, s.NAME, s.AGE)
;



SELECT * FROM processed_data;





-- After consuming stream

SELECT * FROM raw_data_stream;


-- Show specific streams

DESC STREAM RAW_DATA_STREAM;



--Append only Stream
CREATE OR REPLACE STREAM raw_data_stream2 ON TABLE raw_data append_only=true; -- For external table insert_only = true

SELECT * FROM raw_data_stream2;


-- Update source table record
UPDATE raw_data SET age = 28 WHERE id = 1;



-- Delete a record
DELETE FROM raw_data WHERE id = 1;

-- Insert a new record
INSERT INTO raw_data (id, name, age)
VALUES (6, 'Mike', 45);

