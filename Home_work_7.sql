----1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	u.id AS user_id, 
	u.name AS user_name,
	op.order_id AS order_id,
	op.product_id AS product_id,
	(SELECT name FROM products WHERE id = op.product_id) AS product_name,
	op.total
FROM users AS u
RIGHT JOIN 	orders AS o ON 	u.id = o.user_id
RIGHT JOIN 	orders_products AS op ON 	o.id = op.order_id
ORDER BY u.name, op.order_id;


---------2.Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT 
	p.id,
	p.name,
	p.price,
	c.id AS cat_id,
	c.name AS catalog
FROM 	products AS p
JOIN 	catalogs AS c ON p.catalog_id = c.id
order by c.id ; 

------3. (по желанию) Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов (flights) с русскими названиями городов.

SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights
ORDER BY flight_id;