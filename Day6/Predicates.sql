CREATE OR REPLACE TABLE new_vartab (id NUMBER(3), data VARIANT);

INSERT INTO new_vartab
  SELECT column1 AS id, PARSE_JSON(column2) AS data
    FROM VALUES 
                (1, '["apple", "banana", "cherry"]'),  -- A JSON array with strings
                (2, '{"name": "John", "age": 30, "is_active": true}'),  -- A JSON object
                (3, 'true'),  -- Boolean value
                (4, '3.14159'),  -- A string representing a floating-point number
                (5, '100'),  -- A string representing an integer
                (6, 'null'),  -- String "null" (not actual NULL)
                (7, '["1", "2", "3", "4", "5"]'),  -- A JSON array of strings
                (8, '[true, false, null, "string"]'),  -- A mixed JSON array
                (9, '{"address": {"street": "Main St", "city": "Snowflake"}}')  -- A nested JSON object
       AS vals;



SELECT * FROM new_vartab WHERE IS_NULL_VALUE(data);


SELECT * FROM new_vartab WHERE IS_DECIMAL(data);


SELECT * FROM new_vartab WHERE IS_ARRAY(data);

SELECT * FROM new_vartab WHERE IS_OBJECT(data);







