 Практическое задание по теме “Управление БД”
-- 1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
сd~
nano .my.cnf
[Client]
user=root
password=my8sql



-- 2. Сздайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
mysql -u root -p    
CREATE DATABASE example;
CREATE DATABASE sample;
USE example;
CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(255) COMMENT 'Имя пользователя');
exit

-- 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
mysqldump -u root -p example > sample.sql
mysql -u root -p sample < sample.sql  
mysql -u root -p
SHOW DATABASES;
DESCRIBE sample.users;


-- 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword 
    базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > first_100_rows_help_keyword.sql
