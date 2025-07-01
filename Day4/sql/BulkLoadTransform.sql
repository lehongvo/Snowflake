--Reference https://docs.snowflake.com/en/user-guide/data-load-transform


list @internal_named_stage;

select t.$1,t.$2,t.$4 from @internal_named_stage/data_0_0_0.csv t;

select t.$1, CONCAT(t.$2 ,' ', t.$3 ),t.$4, t.$7 from @internal_named_stage/data_0_0_0.csv t;




-- Create new table
CREATE or replace TABLE new_table2 (
  customer VARCHAR,
  full_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" INTEGER
);



---load only for selected column and reorder

COPY INTO new_table2 (customer,full_name,region,gender,email)
FROM  (select t.$1, CONCAT(t.$2 ,' ', t.$3 ),t.$4, t.$6, t.$5 from @internal_named_stage/data_0_0_0.csv t)
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 )
FORCE = TRUE;  

truncate new_table2;

select * from new_table2;




-- Create new table
CREATE or replace TABLE new_table2 (
  customer VARCHAR,
  full_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" DECIMAL (15,3),
  extra_col BINARY
);

---load only for column casting to Decimal

COPY INTO new_table2 (customer, full_name, region,email,gender,"ORDER", extra_col)
FROM  (select t.$1, CONCAT(t.$2 ,' ', t.$3 ),  t.$4,t.$5, t.$6, cast( t.$7 AS INTEGER),to_binary(t.$4,'utf-8') from @internal_named_stage/data_0_0_0.csv t)
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 )
;
FORCE = TRUE;  

select * from new_table2;

truncate new_table2;



---load only for auto increment

-- Create new table
CREATE or replace TABLE new_table2 (

  index number autoincrement start 2 increment 10,
  customer VARCHAR,
  full_name VARCHAR,
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" DECIMAL (15,3),
  extra_col BINARY
);

COPY INTO new_table2 (customer, full_name, region,email,gender,"ORDER", extra_col)
FROM  (select t.$1, CONCAT(t.$2 ,' ', t.$3 ),  t.$4,t.$5, t.$6, cast( t.$7 AS INTEGER),to_binary(t.$4,'utf-8') from @internal_named_stage/data_0_0_0.csv t)
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 );
FORCE = TRUE;  

select * from new_table2;

truncate new_table2;


CREATE or replace TABLE new_table2 (

  index number autoincrement start 1 increment 1,
  customer VARCHAR,
  full_name VARCHAR (8),
  region VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  "ORDER" DECIMAL (15,3),
  extra_col BINARY
);


--Truncating text strings that exceed the target column length

COPY INTO new_table2 (customer, full_name, region,email,gender,"ORDER", extra_col)
FROM  (select t.$1, CONCAT(t.$2 ,' ', t.$3 ),  t.$4,t.$5, t.$6, cast( t.$7 AS INTEGER),to_binary(t.$4,'utf-8') from @internal_named_stage/data_0_0_0.csv t)
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 )
TRUNCATECOLUMNS = TRUE;
FORCE = TRUE;  

select * from new_table2;

truncate new_table2;
   

