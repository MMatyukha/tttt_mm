# 1. Создаем ключи для нашей базы ВК

# Таблицы, которым не нужны дополнительные ключи
# communities
# communities_statuses 
# communities_users
# friendship
# friendship_statuses
---1.Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.

----profiles
-- предполагаю, что ищут по дате рождения, и возможно полу

CREATE INDEX idx_profiles_birthday_sex ON profiles(birthday,sex);

------ users
CREATE INDEX idx_users_last_name_first_name ON users(last_name,first_name);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);


----2.Задание на оконные функции
------Построить запрос, который будет выводить следующие столбцы:
------имя группы
------среднее количество пользователей в группах (сумма количестива пользователей во всех группах делённая на количество групп)
------самый молодой пользователь в группе (желательно вывести имя и фамилию)
------самый старший пользователь в группе (желательно вывести имя и фамилию)
-------количество пользователей в группе
--------всего пользователей в системе (количество пользователей в таблице users)
----------отношение в процентах для последних двух значений (общее количество пользователей в группе / всего пользователей в системе) * 100-

SELECT DISTINCT communities.id, communities.name,
  (SELECT 
COUNT(cu.user_id) 
from communities_users cu)  as averag_users,
  FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities_users.community_id ORDER BY profiles.birthday DESC) as min_old,
  FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities_users.community_id ORDER BY profiles.birthday) as max_old,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) as in_communities,
  (SELECT count(*) FROM users) as users_total,
  (COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) / (SELECT count(*) FROM users)*100) as '%%'
FROM communities_users
	JOIN communities ON (communities.id = communities_users.community_id)
	JOIN users ON (users.id = communities_users.user_id)
	JOIN profiles ON (communities_users.user_id=profiles.user_id)
	#GROUP  by communities_users.users_id
ORDER by id
	;