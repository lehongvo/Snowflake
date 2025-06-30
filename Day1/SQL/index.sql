/* Create Database and Schema*/

CREATE DATABASE LA_DB;

CREATE SCHEMA LA_SCHEMA;

/* Create table and insert record*/

CREATE OR REPLACE TABLE my_table (
  id INTEGER primary key,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) 
);


INSERT INTO my_table (id, name, email) VALUES
  (1, 'John Smith', 'john@example.com'),
  (1,'Amit', 'amit@example.com'),
  (3, 'Bob Johnson', 'bob@example.com');

/* Dispay data in the table */

SELECT * FROM my_table;

/* Check Meta-data of the table */

DESCRIBE TABLE MY_TABLE;

/* Check Meta-data of all the databases */

SHOW databases;

/* Check Meta-data of your database */

DESCRIBE database LA_DB;