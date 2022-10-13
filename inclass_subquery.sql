-- MULTIJOIN
-- connect information from
-- film => film_actor => actor tables
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
ORDER BY first_name;


-- Sub Query
-- You can make sub queries in 3 spots
-- SELECT, FROM, and WHERE statements

-- SELECT headers_you_want_to_see
-- FROM table_you_want_to_pull_from
-- WHERE conditions_go_here

-- WHERE IS THE MOST COMMON
-- turn 2 queries into 1
-- query 1: find all payments over $175 and locate that customer id
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC
LIMIT 5;

-- query 2: get customer info
SELECT first_name, last_name, email
FROM customer;

-- FINALLY, lets put these 2 queries together
SELECT first_name, last_name, email
FROM customer
WHERE customer_id in (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
    ORDER BY SUM(amount) DESC
    LIMIT 5
);

-- ANOTHER QUERY IN THE WHERE CLAUSE (using JOINS)
SELECT first_name, last_name
FROM actor
WHERE actor_id in (
    SELECT actor_id
    FROM film_actor
    INNER JOIN film
    ON film.film_id = film_actor.film_id
    WHERE  title = 'Mulan Moon'
);


-- FROM CLAUSE SUB QUERY
SELECT first_name, last_name
FROM (
    SELECT first_name, last_name, title
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film
    ON film.film_id = film_actor.film_id
) AS actors_and_movie_titles
WHERE title = 'Mulan Moon';


-- SELECT STATEMENT SUB QUERY
-- THIS IS THE MOST UNCOMMON
SELECT first_name, last_name, (
    SELECT COUNT(rental_id)
    FROM rental
)
FROM customer;


-- STORED PROCEDURE AND STORED FUNCTION
SELECT *
FROM payment;

CREATE OR REPLACE PROCEDURE late_fee_shohat (
    customer INTEGER,
    lateFeeAmount NUMERIC(5,2)
)
LANGUAGE plpgsql
AS
$$
BEGIN
    -- add late fee to customer
    UPDATE payment
    SET amount = amount + lateFeeAmount
    WHERE customer_id = customer;
    -- commit the above ststaement inside of a transaction
    COMMIT;
END
$$
;

-- call a stored procedure
CALL late_fee_shohat(341,0.20)


SELECT *
FROM payment
WHERE customer_id = 341 LIMIT 1;


-- Stored functions
SELECT * FROM actor ORDER BY actor_id DESC;

CREATE OR REPLACE FUNCTION add_an_actor_shoha(
    actor INTEGER,
    f_name VARCHAR(45),
    l_name VARCHAR(45),
    updated TIMESTAMP WITHOUT TIME ZONE
)
RETURNS VOID
LANGUAGE plpgsql
AS 
$MAIN$
BEGIN
    -- insert into our actor table
    INSERT INTO actor(actor_id, first_name, last_name, last_update)
    VALUES (actor, f_name, l_name, updated);

END
$MAIN$
;

-- calling a function is diff from a procedure
-- do not use the keyword CALL
-- instead use SELECT

SELECT add_an_actor_shoha(902, 'Michael', 'Cera', NOW()::TIMESTAMP)