-- Week 5 - Wednesday
-- Questions

-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT customer.customer_id, address.district
FROM customer
JOIN address ON customer.address_id = address.address_id 
WHERE district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT *
FROM (
SELECT first_name, last_name, sum(amount)
FROM payment 
JOIN customer ON customer.customer_id = payment.customer_id 
GROUP BY customer.customer_id 
) AS "big ballers"
WHERE sum > 175;

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT first_name, last_name country_id
FROM customer
JOIN address ON customer.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id 
JOIN country ON city.country_id = country.country_id 
WHERE country LIKE 'Nepal';


-- 5. Which staff member had the most
-- transactions?

SELECT first_name, last_name, COUNT(payment.staff_id)
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id 
GROUP BY staff.first_name, staff.last_name, payment.staff_id 
ORDER BY COUNT DESC;
--Jon Stephens

-- 6. How many movies of each rating are
-- there?

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY rating;

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT *
FROM (
SELECT first_name, last_name, payment.amount 
FROM payment
JOIN customer ON customer.customer_id = payment.customer_id 
WHERE payment.amount > 6.99
GROUP BY customer.first_name, customer.last_name, payment.amount
) AS "ABOVE $6.99";

-- 8. How many free rentals did ourstores give away?

SELECT count(payment_id)
FROM payment
WHERE amount = 0;