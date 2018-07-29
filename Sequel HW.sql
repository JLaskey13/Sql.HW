-- 1a
SELECT a.first_name, a.last_name
	FROM  actor a;

-- 1b    
SELECT upper(concat(a.first_name," ", a.last_name)) as full_name
	FROM actor a;

-- 2a    
SELECT a.actor_id, a.first_name, a.last_name 
	FROM actor a
    WHERE a.first_name = "JOE";
    
-- 2b    
SELECT * FROM actor a
	WHERE a.last_name LIKE '%GEN%';
    
-- 2c    
SELECT a.first_name, a.last_name 
	FROM actor a 
	WHERE a.last_name LIKE '%LI%'
	ORDER BY a.last_name, a.first_name;

-- 2d
SELECT country_id, country
	FROM country
    WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
-- 3a
ALTER TABLE actor
	ADD COLUMN middle_name VARCHAR(20) AFTER first_name;
    
-- 3b

ALTER TABLE actor
	MODIFY COLUMN middle_name blob;

-- 3c
ALTER TABLE actor
	DROP COLUMN middle_name;
    
-- 4a
SELECT last_name, COUNT(last_name) as number_of_last_names
	FROM actor
    GROUP BY 1;
    
-- 4b
SELECT last_name, COUNT(last_name) as number_of_last_names
	FROM actor
    GROUP BY 1
    HAVING number_of_last_names >= 2;

-- 4c
UPDATE actor 
	SET first_name = 'HARPO'
    WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
    
-- 4d
UPDATE actor
	SET first_name = 
    CASE WHEN first_name = 'HARPO'
    THEN 'GROUCHO'
    ELSE 'MUCHO GROUCHO'
    END
    WHERE actor_id=172;
    
-- 5a
 SHOW CREATE TABLE address;
 
 -- 6a
 SELECT s.first_name, s.last_name, a.address
	FROM staff s 
    JOIN address a ON a.address_id = s.address_id;

 -- 6a
SELECT s.first_name, s.last_name, a.address
	FROM staff s
	JOIN address a ON a.address_id = s.address_id;
    
-- 6b
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount)
	FROM staff s
	JOIN payment p ON p.staff_id = s.staff_id 
	AND p.payment_date LIKE '2005-08';    

-- 6c
SELECT f.title, SUM(a. actor_id) AS number_actors
	FROM film_actor a
    JOIN film f ON f.film_id = a.film_id
    GROUP BY f.title;

-- 6d
SELECT f.title, SUM(i.inventory_id) AS total_copies
	FROM inventory i
	JOIN film f ON f.film_id = i.film_id
	WHERE title = 'Hunchback Impossible';

-- 6e
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount)
	FROM customer c
    JOIN payment p on p.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY 3;

-- 7a
SELECT title
	FROM film
	WHERE title LIKE 'K%' OR title LIKE 'Q%'
	AND title IN ( 
SELECT title
	FROM film 
	WHERE language_id = 'English'); 

-- 7b
SELECT f.film_id, f.title, fa.actor_id, a.first_name, a.last_name
	FROM film f
	JOIN film_actor fa ON fa.film_id = f.film_id
    JOIN actor a ON a.actor_id = fa.actor_id
    WHERE f.title = 'Alone Trip';

-- 7c
SELECT c.first_name, c.last_name, c.email
	FROM customer c
	JOIN address a ON a.address_id = c.address_id
	JOIN city ct ON ct.city_id = a.city_id
	JOIN country cnt ON cnt.country_id = ct.country_id
	WHERE cnt.country = 'Canada';

-- 7d
SELECT f.film_id, fc.category_id, cat.name
	FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category cat ON cat.category_id = fc.category_id
    WHERE cat.name = 'Family';

-- 7e
SELECT f.title, COUNT(rental_id) as number_rentals
	FROM rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id
    JOIN film f ON f.film_id = i.film_id
    GROUP BY f.title
    ORDER BY 2 DESC;
    
-- 7f
SELECT s.store_id, SUM(amount) as gross_revenue
	FROM payment p
	JOIN rental r ON p.rental_id = r.rental_id
	JOIN inventory i ON i.inventory_id = r.inventory_id
	JOIN store s ON s.store_id = i.store_id
	GROUP BY s.store_id;
    
-- 7g
SELECT s.store_id, ct.city, co.country
	FROM store s
	JOIN address a ON s.address_id = a.address_id
	JOIN city ct ON ct.city_id = a.city_id
	JOIN country co ON co.country_id = ct.country_id;
    
-- 7h
SELECT c.name AS 'Genre', SUM(p.amount) AS gross_revenue
	FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN inventory i ON fc.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY c.name
    ORDER BY 2 DESC
    LIMIT 5;
    
-- 8a
CREATE VIEW top_five_genres AS
SELECT c.name, SUM(p.amount) AS gross_revenue
	FROM payment p
    JOIN rental r ON r.rental_id = p.rental_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON fc.film_id = i.film_id
    JOIN category c ON c.category_id = fc.category_id
    GROUP BY c.name
    ORDER BY 2 
    LIMIT 5;
    
-- 8b
SELECT * FROM top_five_genres;
    
-- 8c
DROP VIEW top_five_genres;    
    
    