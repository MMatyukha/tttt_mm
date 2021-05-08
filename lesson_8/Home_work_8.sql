

----------3.Определить кто больше поставил лайков (всего) - мужчины или женщины?	
	select COUNT(*) as likes
    FROM vk.Like_users lu 
    inner join  vk.profiles p  on p.user_id = lu.USER_ID 
    GROUP BY p.gender ;
	
------4.Вывести для каждого пользователя количество созданных сообщений, постов, загруженных медиафайлов и поставленных лайков.	

SELECT 
  u.first_name,
  u.last_name,
  count(p.From_USER_ID),
  count(lu.USER_ID)
  from vk.users u 
  inner join vk.posts p  on p.From_USER_ID = u.id 
  inner join vk.Like_users lu  on lu.USER_ID =u.id 
  GROUP by u.id;
  
-------------(по желанию) Подсчитать количество лайков которые получили 10 самых молодых пользователей.   
SELECT 
  u.first_name,
  u.last_name,
  count(p.From_USER_ID),
  count(lu.USER_ID)
  from vk.users u 
  inner join vk.posts p  on p.From_USER_ID = u.id 
  inner join vk.Like_users lu  on lu.USER_ID =u.id 
  inner join vk.profiles p2 on p2.user_id =u.id 
  GROUP by u.id 
  ORDER BY p2.birthday DESC limit 10;