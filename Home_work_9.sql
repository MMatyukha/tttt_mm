---Практическое задание по теме “Транзакции, переменные, представления”----
--1.В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
  INSERT INTO sample.users (SELECT * FROM shop.users WHERE id=1);
  DELETE FROM shop.users WHERE id=1;
COMMIT;

--2.Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

DROP VIEW IF EXISTS v_products;

CREATE VIEW v_products (catalog_name, products_name) AS 
  (SELECT products.name, catalogs.name 
    FROM products
      JOIN catalogs ON products.catalog_id=catalogs.id
   );
   
--3.по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.


SELECT a.Date, NOT isnull(created_at) AS created_at 
from (
    select curdate() - INTERVAL (a.a + (10 * b.a) + (100 * c.a) + (1000 * d.a) ) DAY as Date
    from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as d
) a
LEFT JOIN test ON a.date=test.created_at
WHERE a.Date between '2018-08-01' and '2018-08-31'
ORDER BY a.date
;
-------------Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)----
--1.Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

DROP USER IF EXISTS 'shop'@'localhost'; 
DROP USER IF EXISTS 'shop_read'@'localhost'; 

CREATE USER IF NOT EXISTS 'shop'@'localhost' IDENTIFIED WITH sha256_password BY 'qwerty';
GRANT ALL ON shop.* TO 'shop'@'localhost';

CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY 'qwerty';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';




--------------Практическое задание по теме “Хранимые процедуры и функции, триггеры"-----
--1.Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello() RETURNS text CHARSET utf8mb4 NOT DETERMINISTIC
BEGIN
	DECLARE return_text text;
	if hour(now())>=6 AND hour(now())<=12 then
	  set return_text='Доброе утро';
	elseif hour(now())>12 AND hour(now())<=18 then
	  set return_text='Доброе день';
	elseif hour(now())>18 AND hour(now())<=23 then 
	  set return_text='Добрый вечер';
	else 
	  set return_text='Доброй ночи'; 
	end if;
RETURN return_text;
END//
DELIMITER ;

SELECT hello();

--2.В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //

CREATE TRIGGER trg_products_insert_check BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF ISNULL(NEW.name) && ISNULL(NEW.desription) THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Name and desription can`t be null';
  END IF; 
END//

CREATE TRIGGER trg_products_update_check BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF ISNULL(NEW.name) && ISNULL(NEW.desription) THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Name and desription can`t be null';
  END IF; 
END//

DELIMITER ;


