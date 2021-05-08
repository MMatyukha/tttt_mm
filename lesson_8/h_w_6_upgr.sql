-- 2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей. */

SELECT SUM(likes)
  FROM (SELECT profiles.user_id, profiles.birthday, COUNT(likes.to_subject_id) AS likes
	  FROM profiles
	       JOIN likes
		 ON likes.to_subject_id = profiles.user_id
	 GROUP BY profiles.user_id, profiles.birthday
	 ORDER BY profiles.birthday DESC
	 LIMIT 10) AS countlikes;
	 
---4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети. */

SELECT users.id AS id, COUNT(media.user_id) + COUNT(likes.from_user_id) + COUNT(messages.from_user_id) AS acts
  FROM users
       LEFT JOIN media
              ON users.id = media.user_id
       LEFT JOIN likes
              ON users.id = likes.from_user_id
       LEFT JOIN messages
              ON users.id = messages.from_user_id
 GROUP BY id
 ORDER BY acts
 LIMIT 10;