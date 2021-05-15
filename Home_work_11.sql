#NoSQL
# 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов. */

HSET counters '192.168.0.1' 3
HSET counters '192.168.0.2' 2
HSET counters '192.168.0.3' 5
HGETALL counters


# 2. При помощи базы данных Redis решите задачу поиска имени пользователя 
по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.*/

HSET email 'Test_1' 'test_1@gmail.com'
HSET name 'test_1@gmail.com' 'Test_1'

HSET email 'Test' 'test@gmail.com'
HSET name 'test@gmail.com' 'Test'



# 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB. */

use shop
db.shop.insert({catalog: 'Процессоры', products:[
				{id: 1, name: 'Intel Core i7-8100', description: '', price: 3200}]})
db.shop.update({catalog: 'Процессоры'}, {$push: 
 				{ products: {id: 2, name:'Intel Core i7-7400', description: '',price: 17700 } }})
db.shop.insert({catalog: 'Материнские платы', products:[
 				{id: 3, name: 'Intel Core i5-3317U', description: '', price: 7000}]} )
db.shop.update({catalog: 'Материнские платы'}, {$set: 
				{ products:[{id: 3, name: 'Gigabyte H310M S2H', description: '', price: 3790}]}} )
db.shop.find()

#Оптимизация

#1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name

CREATE TABLE logs (
  table_name VARCHAR(20) NOT NULL,
  pk_id INT UNSIGNED NOT NULL,
  name VARCHAR(255),
  created_at DATETIME DEFAULT NOW()
) ENGINE=ARCHIVE;

CREATE TRIGGER users_log AFTER INSERT ON users FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'users',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'catalogs',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'products',
      pk_id = NEW.id,
      name = NEW.name;

#2.  Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER $$

DROP PROCEDURE IF EXISTS test$$
CREATE PROCEDURE test()
BEGIN
   DECLARE count INT DEFAULT 0;
   WHILE count < 1000 DO
      INSERT INTO users (name, birthday_at) VALUES
        (LEFT(UUID(), RAND()*(10-5)+5), DATE(CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 365) DAY)),
      SET count = count + 1;
   END WHILE;
END$$
DELIMITER;

test();
