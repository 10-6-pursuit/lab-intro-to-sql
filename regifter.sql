-- Getting started, do not update
DROP TABLE IF EXISTS gifts;
DROP DATABASE IF EXISTS regifter;
CREATE DATABASE regifter;
\c regifter
-- End getting started code

--
-- Write your code below each prompt

--
\echo Create a table called gifts
-- with the following columns
-- id serial primary KEY
-- gift - string
-- giver - string
-- value - integer
-- previously_regifted boolean
regifter=# CREATE TABLE gifts ( id SERIAL PRIMARY KEY, gift TEXT, giver TEXT, value INTEGER, previously_regifted BOOLEAN);
CREATE TABLE
regifter=# \d gifts
                                   Table "public.gifts"
       Column        |  Type   | Collation | Nullable |              Default
---------------------+---------+-----------+----------+-----------------------------------
 id                  | integer |           | not null | nextval('gifts_id_seq'::regclass)
 gift                | text    |           |          |
 giver               | text    |           |          |
 value               | integer |           |          |
 previously_regifted | boolean |           |          |
Indexes:
    "gifts_pkey" PRIMARY KEY, btree (id)
                                               ^
regifter=# ALTER TABLE gifts ALTER COLUMN gift TYPE VARCHAR(255);
ALTER TABLE
regifter=# ALTER TABLE gifts ALTER COLUMN giver TYPE VARCHAR(255);
ALTER TABLE
-- 
\echo See details of the table you created
-- 

regifter=# \d gifts
                               Table "public.gifts"
       Column        |  Type   | Collation | Nullable |              Default
---------------------+---------+-----------+----------+-----------------------------------
 id                  | integer |           | not null | nextval('gifts_id_seq'::regclass)
 gift                | character varying(25|          |          |
 giver               | character varying(25|          |          |
 value               | integer |           |          |
 previously_regifted | boolean |           |          |
Indexes:
    "gifts_pkey" PRIMARY KEY, btree (id)



-- 
\echo Alter the table so that the column price is changed to value 
-- 
regifter=# ALTER TABLE gifts RENAME COLUMN price TO VALUE;
ERROR:  column "price" does not exist
regifter=# \d gifts
regifter=# --Rename column (if it exists)
regifter=# ALTER TABLE gifts RENAME COLUMN price TO value;
ERROR:  column "price" does not exist

-- 
\echo Insert a peach candle, given by 'Santa' thats value is 9 and has been previously regifted
-- 
regifter=# INSERT INTO
regifter-# gifts (gift, giver, value, previously_regifted)
regifter-# VALUES
regifter-# ('Peach candle', 'Santa', 9, true);
INSERT 0 1

--
\echo Query for all the columns in your gifts table
-- 


--
\echo Uncomment below to insert 5 more gifts
-- 

INSERT INTO gifts (gift, giver, value, previously_regifted)
VALUES
('peach candle', 'Santa', '9', TRUE),
('cinnamon candle', 'Nick', '19', TRUE),
('soap on a rope', 'Rudolf', '29', FALSE),
('potpurri', 'Elf on the Shelf', '39', TRUE),
('mango candle', 'The Boss', '49', FALSE)
;

-- 
\echo Insert 5 more gifts of your own choosing,  include 1 more candle
--
regifter=# INSERT INTO gifts (gift, giver, value, previously_regifted)
regifter-# VALUES
regifter-# ('peach cobbler', 'Ant', '8', FALSE),
regifter-#  ('cinnamon candle', 'Nicole', '18', FALSE),
regifter-# (' scented soap', 'Rudy', '28', TRUE),
regifter-#  ('citrus potpurri', 'Elves', '38', FALSE),
regifter-#  ('mango chutney', 'Super', '48', TRUE)
regifter-#  ;
INSERT 0 5


--
\echo Query for gifts with a price greater than or equal to 20
--
regifter=# SELECT * FROM gifts WHERE value >= 20;
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  4 | soap on a rope  | Rudolf           |    29 | f
  5 | potpurri        | Elf on the Shelf |    39 | t
  6 | mango candle    | The Boss         |    49 | f
  9 |  scented soap   | Rudy             |    28 | t
 10 | citrus potpurri | Elves            |    38 | f
 11 | mango chutney   | Super            |    48 | t
(6 rows)


--
\echo Query for every gift that has the word candle in it, only show the gift column
--
regifter=# SELECT gift FROM gifts WHERE gift ILIKE '%candle%';
      gift
-----------------
 cinnamon candle
 mango candle
(2 rows)


--
\echo Query for every gift whose giver is Santa OR value is greater than 30
--
regifter=#  SELECT * FROM gifts WHERE giver = 'Santa' OR value > 30;
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  5 | potpurri        | Elf on the Shelf |    39 | t
  6 | mango candle    | The Boss         |    49 | f
 10 | citrus potpurri | Elves            |    38 | f
 11 | mango chutney   | Super            |    48 | t
(4 rows)

--
\echo Query for every gift whose giver is NOT Santa
--
regifter=# SELECT * FROM gifts WHERE giver != 'Santa';
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  3 | cinnamon candle | Nick             |    19 | t
  4 | soap on a rope  | Rudolf           |    29 | f
  5 | potpurri        | Elf on the Shelf |    39 | t
  6 | mango candle    | The Boss         |    49 | f
  7 | peach cobbler   | Ant              |     8 | f
  8 | cinnamon bun    | Nicole           |    18 | f
  9 |  scented soap   | Rudy             |    28 | t
 10 | citrus potpurri | Elves            |    38 | f
 11 | mango chutney   | Super            |    48 | t
(9 rows)

--
\echo Update the second gift to have a value of 2999
-- 
regifter=# UPDATE gifts SET value = 2999 WHERE id = 2;
UPDATE 1
regifter=# SELECT * FROM gifts;
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  1 | Peach candle    | Santa            |     9 | t
  3 | cinnamon candle | Nick             |    19 | t
  4 | soap on a rope  | Rudolf           |    29 | f
  5 | potpurri        | Elf on the Shelf |    39 | t
  6 | mango candle    | The Boss         |    49 | f
  7 | peach cobbler   | Ant              |     8 | f
  8 | cinnamon bun    | Nicole           |    18 | f
  9 |  scented soap   | Rudy             |    28 | t
 10 | citrus potpurri | Elves            |    38 | f
 11 | mango chutney   | Super            |    48 | t
  2 | peach candle    | Santa            |  2999 | t
(11 rows)


--
\echo Query for the updated item
--
regifter=# UPDATE gifts SET value = 2999 WHERE id = 2 RETURNING*;
 id |     gift     | giver | value | previously_regifted
----+--------------+-------+-------+---------------------
  2 | peach candle | Santa |  2999 | t
(1 row)

--
\echo Delete all the gifts from Santa and return the 'value' and 'gift' of the gift you have deleted
--
regifter=# DELETE FROM gifts WHERE giver = 'Santa' RETURNING value, gift;
 value |     gift
-------+--------------
     9 | Peach candle
  2999 | peach candle
(2 rows)


--
\echo Query for all the columns in your gifts table one more time
--
regifter=# SELECT * FROM gifts;
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  3 | cinnamon candle | Nick             |    19 | t
  4 | soap on a rope  | Rudolf           |    29 | f
  5 | potpurri        | Elf on the Shelf |    39 | t
  6 | mango candle    | The Boss         |    49 | f
  7 | peach cobbler   | Ant              |     8 | f
  8 | cinnamon bun    | Nicole           |    18 | f
  9 |  scented soap   | Rudy             |    28 | t
 10 | citrus potpurri | Elves            |    38 | f
 11 | mango chutney   | Super            |    48 | t
(9 rows)



-- BONUSES

--
 \echo Count the total number of gifts that have the word candle in it
-- 
Count the total number of gifts that have the word candle in it
regifter=# SELECT COUNT(*) FROM gifts WHERE gift ILIKE '%candle%';
 count
-------
     2
(1 row)

--
\echo Get the AVEREAGE value from all the gifts
--
regifter=# SELECT AVG(value) FROM gifts;
         avg
---------------------
 30.6666666666666667
(1 row)


-- 
 \echo Limit to 3 gifts, offset by 2 and order by price descending
--
regifter=# SELECT * FROM gifts ORDER BY value DESC OFFSET 2 LIMIT 3;
 id |      gift       |      giver       | value | previously_regifted
----+-----------------+------------------+-------+---------------------
  5 | potpurri        | Elf on the Shelf |    39 | t
 10 | citrus potpurri | Elves            |    38 | f
  4 | soap on a rope  | Rudolf           |    29 | f
(3 rows)


--
-- finish
--
