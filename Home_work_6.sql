1.Создать и заполнить таблицы лайков и постов.

--Таблица Лайков-----------
DROP TABLE IF EXISTS vk.Like_users;

CREATE TABLE vk.Like_users (
	ID INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	USER_ID INT unsigned NOT NULL COMMENT 'Пользователь',
	media_id INT unsigned NOT NULL COMMENT 'Медиа',
	status enum('L','D','N')  NOT NULL COMMENT 'Статус:Like, Dislike, None - Просмотрено.',
	date_on DATETIME DEFAULT CURRENT_TIMESTAMP  COMMENT 'Дата  создания',
	date_off DATETIME DEFAULT CURRENT_TIMESTAMP  COMMENT 'Дата удаления');

--------------------Заполнение

INSERT  into vk.Like_users  VALUES
('2','99','50','L','2021-01-01','2021-01-01'),
('14','2','69','N','2021-01-01','2021-01-01'),
('22','56','78','N','2021-01-01','2021-01-01'),
('8','37','96','L','2021-01-01','2021-01-01'),
('97','38','63','L','2021-01-01','2021-01-01');

------------ПОСТЫ
CREATE TABLE vk.posts (
	ID INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	From_USER_ID INT unsigned NOT NULL COMMENT 'От  кого',
	media_type_id INT unsigned NOT NULL COMMENT 'ccылка  на тип медиа',
	text_TEXT varchar(200)  COMMENT 'КОМЕНТ',
	date_on DATETIME DEFAULT CURRENT_TIMESTAMP  COMMENT 'Дата  создания',
	date_off DATETIME DEFAULT CURRENT_TIMESTAMP  COMMENT 'Дата удаления');
	
	
--------------------Заполнение
INSERT  into vk.posts  VALUES
('2','99','50','О, сколько  нам  открытий  чудных','2021-01-01','2021-01-01'),
('14','2','69','Готовит   просвещения дух','2021-01-01','2021-01-01'),
('22','56','78','И опыт, сын ошибок трудных,','2021-01-01','2021-01-01'),
('8','37','96','И гений, парадоксов друг,','2021-01-01','2021-01-01'),
('97','38','63','И случай, бог изобретатель.','2021-01-01','2021-01-01');


------2.Создать все необходимые внешние ключи и диаграмму отношений.
-- Добавляем внешние ключи
ALTER TABLE vk.profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

-- Добавляем внешние ключи
ALTER TABLE vk.messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

----------3.Определить кто больше поставил лайков (всего) - мужчины или женщины?	
	select COUNT(*) as likes
    FROM vk.Like_users lu 
    inner join  vk.profiles p  on p.user_id = lu.USER_ID 
    GROUP BY p.gender ;
	
------4.Вывести для каждого пользователя количество созданных сообщений, постов, загруженных медиафайлов и поставленных лайков.	

SELECT 
  u.first_name,
  u.last_name,
  sum(p.From_USER_ID),
  sum(lu.USER_ID)
  from vk.users u 
  inner join vk.posts p  on p.From_USER_ID = u.id 
  inner join vk.Like_users lu  on lu.USER_ID =u.id 
  GROUP by u.id;
  
-------------(по желанию) Подсчитать количество лайков которые получили 10 самых молодых пользователей.   
SELECT 
  u.first_name,
  u.last_name,
  sum(p.From_USER_ID),
  sum(lu.USER_ID)
  from vk.users u 
  inner join vk.posts p  on p.From_USER_ID = u.id 
  inner join vk.Like_users lu  on lu.USER_ID =u.id 
  inner join vk.profiles p2 on p2.user_id =u.id 
  GROUP by u.id 
  ORDER BY p2.birthday DESC limit 10;