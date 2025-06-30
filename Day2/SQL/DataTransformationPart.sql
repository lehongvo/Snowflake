---Data Transformations 

-- Merge first and last name

SELECT CUSTOMER_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME, EMAIL, PHONE, JOIN_DATE
FROM CUSTOMER;

--01ad0adb-3200-c337-0000-0004ade6b1b1

-- Trim + sign from phone numbers

SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, LTRIM(PHONE, '+' ) AS CLEAN_PHONE, JOIN_DATE
FROM CUSTOMER;

--01ad0adb-3200-c336-0000-0004ade641b1

-- Use of I/LIKE function

SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, JOIN_DATE
FROM CUSTOMER
WHERE FIRST_NAME ILIKE '%JOHN%';

--01ad0adc-3200-c319-0000-0004ade681e1


-- Use of LEN() function

SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, LEN(ADDRESS) AS ADDRESS_LENGTH, JOIN_DATE
FROM CUSTOMER;

--01ad0add-3200-c332-0000-0004ade6c1bd

-- Use of last_query_id

SELECT CUSTOMER_ID FROM TABLE(RESULT_SCAN(last_query_id()));

--01ad0add-3200-c332-0000-0004ade6c1c1

-- How last_query_id works

SELECT LAST_QUERY_ID(2);

--01ad0ad8-3200-c336-0000-0004ade64191



-- Check more at https://docs.snowflake.com/en/user-guide/data-load-transform#supported-functions






