/* CREATE DATABASE AND SCHEMA*/
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

/* Use acccountadmin role and WH */

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

--Simple UDF with SQL

  CREATE OR REPLACE FUNCTION addition (n number)
  RETURNS number
  --LANGUAGE SQL
  AS 'n + 8';


select addition(1);
  
--Another way of writing the same UDF
CREATE OR REPLACE FUNCTION addition_new (n number)
  RETURNS number
--LANGUAGE SQL
  AS $$
  
  		n + 8

  $$;

select addition_new(1);

-- Using String

CREATE OR REPLACE FUNCTION addition (s string)
  RETURNS string
  AS 's || ''8''';


-- Fetching data from UDFs

  SELECT addition(1);

  SELECT addition('1');



--Using JAVASCRIPT

CREATE OR REPLACE FUNCTION addition_java(n FLOAT)
  RETURNS FLOAT
  LANGUAGE JAVASCRIPT
  AS 'return N + 5.0;';

  select addition_java(1.1);

CREATE OR REPLACE FUNCTION addition_java_new(n double)
  RETURNS double
  LANGUAGE JAVASCRIPT
  AS $$
   return N + 5

   $$;

SELECT addition_java_new(1);




--UDTF

CREATE OR REPLACE FUNCTION test()
    RETURNS TABLE(msg VARCHAR)
    AS
    $$
        SELECT 'Training'
        UNION
        SELECT 'Snowflake'
    $$;

SELECT msg 
    FROM TABLE(test())
    ORDER BY msg;


create or replace table sales (
    product_id varchar, 
    quantity_sold numeric(11, 2)
    );

insert into sales (product_id, quantity_sold) values 
    ('Jeans', 2000),
    ('Shirt',  1000);

    
create or replace function sales_udtf(PROD_ID varchar)
    returns table (Product_ID varchar, Quantity_Sold numeric(11, 2))
    as
    $$
        select product_ID, quantity_sold 
            from sales 
            where product_ID = PROD_ID
    $$
    ;


select *
    from table(sales_udtf('Jeans'))
    order by product_id;
    



    
--Stored Procedure

CREATE OR REPLACE SECURE PROCEDURE return_greater(number_1 INTEGER, number_2 INTEGER)
RETURNS INTEGER 
LANGUAGE SQL
AS
BEGIN
  IF (number_1 > number_2) THEN
    RETURN number_1;
  ELSE
    RETURN number_2;
  END IF;
END;


CALL return_greater(4, 3);
   

-- Check Attributes of UDF/SP

SHOW FUNCTIONS LIKE '%add%';

SHOW PROCEDURES LIKE '%return%';

-- Secure Function

CREATE OR REPLACE SECURE FUNCTION addition_new_S (n FLOAT)
  RETURNS FLOAT
--LANGUAGE SQL
  AS $$
  
  		n + 8.0

  $$;


-- Check DDL for Functions


USE ROLE ACCOUNTADMIN;

--Grant relevant access on DB

GRANT USAGE on DATABASE LA_DB to USERADMIN;
-- Grant usage access on a schema
GRANT USAGE on SCHEMA LA_SCHEMA to USERADMIN;

-- Grant select access on UDF

GRANT USAGE ON FUNCTION addition_new_S(FLOAT) TO USERADMIN;
GRANT USAGE ON FUNCTION addition_new(number) TO USERADMIN;

-- Grant usage on Procedure

GRANT USAGE ON PROCEDURE return_greater(INTEGER, INTEGER) TO USERADMIN;

-- Grant warehouse usage to the role

GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE USERADMIN;

-- Assume USERROLE

USE ROLE USERADMIN;

select get_ddl('FUNCTION','addition_new_S(FLOAT)');


select get_ddl('FUNCTION','addition_new(number)');


 -- External Functions


  select my_database.my_schema.my_external_function(col1) from table1;

