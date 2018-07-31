--111111111111111111111111111111111111111111111111111111111111111

--1A
select first_name, last_name
 from sakila.actor;
 
 --1B
 SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS ActorName
 FROM actor;

 --22222222222222222222222222222222222222222222222222222222222222
 
 --2A
  select actor_id, first_name, last_name
 from actor where first_name ='joe';
 
 --2B
  select * from actor where last_name like '%GEN%';
 
 --2C
   select * from actor where last_name like '%LI%'
 order by last_name, first_name;
 
 --2D
SELECT country_id, country FROM country WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');

--33333333333333333333333333333333333333333333333333333333333333

--3A
ALTER TABLE actor ADD COLUMN discription BLOB NULL AFTER first_name;

--3B
ALTER TABLE actor DROP COLUMN discription;

--44444444444444444444444444444444444444444444444444444444444444

--4A
SELECT DISTINCT last_name, COUNT(last_name) AS 'name_count' FROM actor GROUP BY last_name;

--4B
SELECT DISTINCT last_name, COUNT(last_name) AS 'name_count' FROM actor GROUP BY last_name HAVING name_count >= 2;

--4C
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

--4D
UPDATE actor
 SET first_name = 
 CASE 
 WHEN first_name = 'HARPO' 
 THEN 'GROUCHO'
 ELSE 'MUCHO GROUCHO'
 END
 WHERE actor_id = 172;

--55555555555555555555555555555555555555555555555555555555555555

#5
 SHOW CREATE TABLE sakila.address;

 CREATE TABLE `address` (
   `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
   `address` varchar(50) NOT NULL,
   `address2` varchar(50) DEFAULT NULL,
   `district` varchar(20) NOT NULL,
   `city_id` smallint(5) unsigned NOT NULL,
   `postal_code` varchar(10) DEFAULT NULL,
   `phone` varchar(20) NOT NULL,
   `location` geometry NOT NULL,
   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`address_id`),
   KEY `idx_fk_city_id` (`city_id`),
   SPATIAL KEY `idx_location` (`location`),
   CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8

--66666666666666666666666666666666666666666666666666666666666666

--6A
SELECT first_name, last_name, address
FROM staff s
INNER JOIN address a
ON s.address_id = a.address_id;

--6B
SELECT first_name, last_name, SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id
ORDER BY last_name ASC;

--6C
SELECT title, COUNT(actor_id)
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY title;

--6D
SELECT title, COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

--6E
SELECT last_name, first_name, SUM(amount)
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;

--77777777777777777777777777777777777777777777777777777777777777

--7A
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");

--7B
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
--7C
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

--7D
SELECT film.film_id, film.title
FROM film 
JOIN film_category ON (film.film_id = film_category.film_id)
JOIN category ON (film_category.category_id = category.category_id)
WHERE category.name = ‘Family’;

--7E
SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

--7F
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

--7G
SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;
WHERE country = 'CANADA' AND country = 'AUSTRAILA';

--7H
SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

--888888888888888888888888888888888888888888888888888888888888888

--8A
CREATE VIEW top_five_grossing_genres AS

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

--8B
SELECT * FROM top_five_grossing_genres;

--8C
DROP VIEW top_five_grossing_genres;

--------------------------------------------------------
--   Thank you :)
