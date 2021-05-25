-
CREATE DATABASE shop
-- ---
-- Table 'goods'
-- товары
-- ---

DROP TABLE IF EXISTS `goods`;
		
CREATE TABLE `goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название',
  `description` text NOT NULL COMMENT 'Описание',
  `price` int NOT NULL COMMENT 'Стоимость',
  `manufactured_id` int NOT NULL COMMENT 'Производитель',
  `catalog_id` int NOT NULL,
  `unit` varchar(50) DEFAULT NULL COMMENT 'ед измерения',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Товары';


INSERT INTO `goods` VALUES 
(1,'vel','Eligendi voluptas provident placeat qui assumenda numquam. Ad nobis at veritatis nobis. Suscipit ea fugit nihil aperiam sunt blanditiis. Quisquam quia aut ut alias fugit.',2931,1,1,NULL),
(2,'eum','Ducimus ipsum cum at voluptatem similique magnam laborum ratione. Nulla quidem eos placeat voluptate aut. Qui ab eius omnis est quia id quisquam.',209,2,2,NULL),
(3,'laudantium','Temporibus cum pariatur eos laboriosam quae nostrum et. Voluptate et non quas eveniet earum. Et ut dolor occaecati et sequi. Ut rem consequatur molestiae.',63156,3,3,NULL),
(4,'iure','Sed voluptatem qui eos aspernatur dolorum fuga. Rerum possimus quas ex optio vero dolorum et aspernatur. Cum quia nisi temporibus dolor voluptatem sed. Voluptatem corrupti atque exercitationem tempora aut recusandae.',0,4,4,NULL),
(5,'ratione','Qui aut sed suscipit praesentium sunt. Odio iusto dolores rerum excepturi. Sunt voluptas inventore explicabo voluptas repudiandae cupiditate.',20273633,5,5,NULL),
(6,'officia','Tenetur dicta facere accusamus dignissimos earum laudantium rerum. Numquam ea ullam fuga qui voluptas magnam minima.',5609,6,6,NULL),
(7,'repellendus','Aut quibusdam sunt saepe inventore sed. Exercitationem aliquid enim nam. Dolores aliquam fugit incidunt quae iusto quia.',9367,7,7,NULL),
(8,'dignissimos','Quos nihil at eaque. Quo sint itaque totam laudantium et corporis. Impedit qui id impedit quidem. Quia fuga saepe praesentium et necessitatibus aliquid. Quia odit id totam et dolores minus.',102,8,8,NULL),
(9,'doloremque','Reiciendis aut voluptatem sed doloribus quia dolorem molestiae. Omnis labore aut qui explicabo ut autem. Corrupti omnis et culpa. Veniam velit quia qui fuga quidem.',109,9,9,NULL),
(10,'necessitatibus','Et repellendus odit reprehenderit qui officia ab rem. Quibusdam placeat ullam commodi et labore. Dolor qui dicta ut voluptatem qui. Sint eligendi vero enim tempora est.',2,10,10,NULL);
-- ---
-- Table 'manufactured'
-- производитель
-- ---

DROP TABLE IF EXISTS `manufactured`;
		
CREATE TABLE `manufactured` (
  `id` int NOT NULL AUTO_INCREMENT ,
  `ID_COUNTRY` int NOT NULL,
  `NAME` varchar(100) NOT NULL COMMENT 'Название',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='производитель';

INSERT INTO manufactured (id,ID_COUNTRY,NAME)
	VALUES (1,2,'FRA'),
	 (2,8,'Австралия Органик'),
	 (3,5,'Вайет Вайтхолл Экспорт ГмбХ'),
	 (4,7,'Себастиан Штро'),
	 (5,6,'Леонард Ланг Гмбх'),
	 (6,3,'Гюнель'),
	 (7,1,'Гадор'),
	 (8,4,'Агенас'),
	 (9,9,'Ликвор'),
	 (10,10,'Инкрас');

-- ---
-- Table 'orders'
-- заказы
-- ---

DROP TABLE IF EXISTS `orders`;
		
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `delivery_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='заказы';

INSERT INTO orders (id,customer_id,created_at,delivery_id)
	VALUES (2,5,'2015-02-19 12:42:02.0','2'),
	 (3,6,'2015-02-19 12:42:02.0','2'),
	 (4,6,'2015-02-19 12:42:02.0','3'),
	 (5,7,'2015-02-19 12:42:02.0','3'),
	 (6,8,'2015-02-19 12:42:02.0','3'),
	 (7,2,'2015-02-19 12:42:02.0','3'),
	 (9,4,'2015-02-19 12:42:02.0','4'),
	 (10,10,'2015-02-19 12:42:02.0','1');

-- ---
-- Table 'orders_products'
--  состав заказа
-- ---

DROP TABLE IF EXISTS `orders_products`;
		
CREATE TABLE `orders_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `goods_id` int NOT NULL,
  `total` int NOT NULL COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=' состав заказа';

INSERT INTO `orders_products` (`id`,`order_id`,`goods_id`,`total`,`created_at`,`updated_at`) 
 VALUES ('1','2','2','3.25','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('2','3','5','5','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('3','4','4','6.35','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('4','5','4','6.35','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('5','6','5','5','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('6','7','8','123','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('7','8','6','3','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('8','9','7','56','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('9','10','3','10','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0'),
 ('10','2','3','10','2015-02-19 12:42:02.0','2015-02-19 12:42:02.0');


-- Table 'warehouse_goods'
-- Запасы на складе
-- ---

DROP TABLE IF EXISTS `warehouse_goods`;
		
CREATE TABLE `warehouse_goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `goods_id` int NOT NULL,
  `value` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Запасы на складе';

INSERT INTO `warehouse_goods` (`id`,`warehouse_id`,`goods_id`,`value`,`created_at`,`updated_at`) VALUES
('1','1','10','10','2013-05-07 16:46:13.630','2013-05-09 16:46:13.630'),
 ('2','2','9','5','2013-05-07 16:46:13.630','2013-05-17 16:46:13.630'),
 ('3','3','9','7','2013-05-07 16:46:13.630','2013-05-17 16:46:13.630'),
 ('4','4','7','8','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('5','6','7','0.25','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('6','10','8','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('7','2','3','7','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('8','7','2','3','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('9','8','4','4','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63'),
 ('10','9','10','2','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63');
-- ---
-- Table 'country'
-- Страна
-- ---

DROP TABLE IF EXISTS `country`;
		
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name_short` varchar(100) NOT NULL COMMENT 'Аббревиату́ра',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Страна';

INSERT INTO `country` (`id`,`name`,`created_at`,`updated_at`,`name_short`) 
 VALUES (1,'Австрия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Австрия'),
	(2,'Венгрия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Венгрия'),
	(3,'Германия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Германия'),
	(4,'Гонконг','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Гонконг'),
	(5,'Дания','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Дания'),
	(6,'Израиль','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Израиль'),
	(7,'Италия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Италия'),
	(8,'Латвия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Латвия'),
	(9,'Норвегия','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Норвегия'),
	(10,'Польша','2013-05-07 16:46:13.630','2013-05-07 16:46:13.630','Польша');
-- ---
-- Table 'catalogs'
-- Разделы интернет-магазина
-- ---

DROP TABLE IF EXISTS `catalogs`;
		
CREATE TABLE `catalogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'название раздела',
  `UNIQUE_NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Разделы интернет-магазина'

INSERT INTO `catalogs` VALUES 
(1,'ipsum','accusamus'),
(2,'omnis','dolorum'),
(3,'consequuntur','amet'),
(4,'rerum','voluptatem'),
(5,'hic','culpa'),
(6,'id','exercitationem'),
(7,'quia','voluptas'),
(8,'unde','eos'),
(9,'esse','officiis'),
(10,'sunt','dolorem');

-- ---
-- Table 'delivery'
-- доставка
-- ---

DROP TABLE IF EXISTS `delivery`;
		
CREATE TABLE `delivery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_delivery` varchar(30) NOT NULL COMMENT 'Способ  доставки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='доставка';

INSERT INTO delivery (id,type_delivery)
	VALUES (1,'CDEK'),
	 (2,'ПОЧТА РОССИИ'),
	 (3,'САМОВЫВОЗ'),
	 (4,'ДРУГОЕ');
-- ---
-- Table 'customers'
-- Пользователи
-- ---

DROP TABLE IF EXISTS `customers`;
		
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `address` varchar(100) NOT NULL,
  `login` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Пользователи';

INSERT INTO customers (id,name,email,address,login,password)
	VALUES (1,'Анна','treutel@example.net','169300, Республика Коми, г.Ухта, ул.Строительная, д.2а','test1','12345'),
	 (2,'Игорь','jaiden@example.net','420004,Татарстан Респ.Казань, Горьковское ш.,д 47','test2','test2'),
	 (3,'Алла','lavinia.roob@example.net','Республика Коми, г. Ухта, ул. Мира, д. 16','test3','test3'),
	 (4,'Генрих','jordyn98@example.org','169300 Республика Коми, г. Ухта, ул. Космонавтов, д.1','test4','test4'),
	 (5,'Лидия','marcos@example.org','169300,Республика Коми, г Ухта, ул. Транспортная,16б','test5','test5'),
	 (6,'Конкордия','rupert96@example.net','420004,Татарстан Респ.Казань,Сапровское ш.,д 47','5','5'),
	 (7,'Наталья','clark58@example.org','420004,Татарстан Респ.Казань,Ленинское ш.,д 47','test22','test22'),
	 (8,'Олег','ratke.jamal@example.net',' Магадан, Якутская улица, 53к2.','58','58'),
	 (9,'Георг','bcrist@example.org','Россия, Калининград, ул. Некрасова, 45','789','789'),
	 (10,'Марта','do''reilly@example.com','Комиссаровский переулок, 7, Псков ','test278','test278');


-- ---
-- Table 'discounts'
-- Скидки
-- ---

DROP TABLE IF EXISTS `discounts`;
		
CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `goods_id` int NOT NULL,
  `discount` decimal(10,0) NOT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime NOT NULL,
  `finished_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Скидки';

INSERT INTO `discounts` (`id`,`customer_id`,`goods_id`,`discount`,`started_at`,`finished_at`,`created_at`,`updated_at`) VALUES
 ('1','1','10','0.25','2013-05-07 16:46:13.630','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('2','2','9','0.25','2013-05-07 16:46:13.630','2013-05-17 16:46:13.630','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('3','3','9','0.25','2013-05-07 16:46:13.630','2013-05-17 16:46:13.630','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('4','4','7','0.25','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('5','6','7','0.25','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('6','10','8','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('7','2','3','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('8','7','2','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('9','8','4','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630'),
 ('10','9','10','0.5','2013-05-07 16:46:13.630','2013-05-09 16:46:13.63','2013-05-09 16:46:13.630','2013-05-09 16:46:13.630');
-- ---
-- Table 'warehouse'
-- Склады
-- ---

DROP TABLE IF EXISTS `warehouse`;
		
CREATE TABLE `warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Склады';

INSERT INTO `warehouse` (`id`,`name`,`created_at`,`updated_at`) VALUES
('1','Склад Оплеснина','2017-06-19 13:01:18.557','2017-06-19 13:01:18.557'),
('2','Склад Строителей','2017-06-19 13:01:18.557','2017-06-19 13:01:18.557'),
('3','Основной склад','2017-06-19 13:01:18.557','2017-06-19 13:01:18.557'),
('4','Склад УРМЗ','2017-06-19 13:01:18.557','2017-06-19 13:01:18.557');