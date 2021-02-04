# MySQL

## INSTALL

**[Access mysql from docker container](https://stackoverflow.com/questions/28389458/execute-mysql-command-from-the-host-to-container-running-mysql-server)**

`docker exec -t -i {docker_container_id/name} mysql -uroot -proot`

`docker exec -it mysql56 /bin/bash`

## TERMS

**[MySQL terminology: processes, threads & connections](http://code.openark.org/blog/mysql/mysql-terminology-processes-threads-connections)**

## Tools
- [TablePlus](https://tableplus.io/)
- [DataGrip](https://www.jetbrains.com/datagrip/)
- [Sequel Pro](http://www.sequelpro.com/) (abandoned)

## Backup and restore

**[Reference](https://gist.github.com/spalladino/6d981f7b33f6e0afe6bb)**

Backup from remote Database

- `sudo docker exec MySQL_CONTAINER_NAME /usr/bin/mysqldump --host=192.168.1.1 -u username --password=password --routines(optional) db_name > dump.sql`

Restore
- `cat dump.sql | docker exec -i MySQL_CONTAINER_NAME /usr/bin/mysql -u root --password=123456 db_name`

Export

- `mysqldump -u username -p database_name > data-dump.sql`

Import

- `mysql -u username -p new_database < data-dump.sql`
## Data types




## Commands

### DDL commands

**Change column**

  - **Both name and definition**
    
    `ALTER TABLE [table] CHANGE [column] ...`
    
  - **Only definition**
  
    `ALTER TABLE [table] MODIFY ...`

  - **Ony name**
    
    `ALTER TABLE [table] RENAME ...`
    
  - **Position**
  
    `ALTER TABLE [table] CHANGE COLUMN [column] [column] [column definition] AFTER [column]`  
    
    `ALTER TABLE [table] MODIFY COLUMN [column] [column definition] AFTER [column]`  

**Access monitor:** 

`mysql -u [username] -p;` (will prompt for password)

**Show all databases:**

`show databases;`

**Access database:**

`mysql -u [username] -p [database]` (will prompt for password)

**Create new database:** 

`create database [database];`

**Select database:** 

`use [database];`

**Determine what database is in use:** 

`select database();`

**Show all tables:** 

`show tables;`

**Show table structure:** 

`describe [table];`

**List all indexes on a table:** 

`show index from [table];`

**Create new table with columns:** 

`CREATE TABLE [table] ([column] VARCHAR(120), [another-column] DATETIME);`

**Adding a column:** 

`ALTER TABLE [table] ADD COLUMN [column] VARCHAR(120);`

**Adding a column with an unique, auto-incrementing ID:** 

`ALTER TABLE [table] ADD COLUMN [column] int NOT NULL AUTO_INCREMENT PRIMARY KEY;`

**Inserting a record:** 

`INSERT INTO [table] ([column], [column]) VALUES ('[value]', '[value]');`

**MySQL function for datetime input:** 

`NOW()`

**Selecting records:**

`SELECT * FROM [table];`

**Explain records:**

`EXPLAIN SELECT * FROM [table];`

**Selecting parts of records:**

`SELECT [column], [another-column] FROM [table];`

**Counting records:**

`SELECT COUNT([column]) FROM [table];`

**Counting and selecting grouped records:**

`SELECT *, (SELECT COUNT([column]) FROM [table]) AS count FROM [table] GROUP BY [column];`

**Selecting specific records:**

`SELECT * FROM [table] WHERE [column] = [value];` (Selectors: `<`, `>`, `!=`; combine multiple selectors with `AND`, `OR`)

**Select records containing `[value]`:**

`SELECT * FROM [table] WHERE [column] LIKE '%[value]%';`

**Select records starting with `[value]`:**

`SELECT * FROM [table] WHERE [column] LIKE '[value]%';`

**Select records starting with `val` and ending with `ue`:**

`SELECT * FROM [table] WHERE [column] LIKE '[val_ue]';`

**Select a range:**

`SELECT * FROM [table] WHERE [column] BETWEEN [value1] and [value2];`

**Select with custom order and only limit:**

`SELECT * FROM [table] WHERE [column] ORDER BY [column] ASC LIMIT [value];` (Order: `DESC`, `ASC`)

**Updating records:**

`UPDATE [table] SET [column] = '[updated-value]' WHERE [column] = [value];`

**Deleting records:**

`DELETE FROM [table] WHERE [column] = [value];`

**Delete *all records* from a table (without dropping the table itself):** 

`DELETE FROM [table];`
(This also resets the incrementing counter for auto generated columns like an id column.)

**Delete all records in a table:**
`truncate table [table];`

**Removing table columns:**

`ALTER TABLE [table] DROP COLUMN [column];`

**Deleting tables:**

`DROP TABLE [table];`

**Deleting databases:**

`DROP DATABASE [database];`

**Custom column output names:**

`SELECT [column] AS [custom-column] FROM [table];`

**Export a database dump (more info [here](http://stackoverflow.com/a/21091197/1815847)):**

`mysqldump -u [username] -p [database] > db_backup.sql`

Use `--lock-tables=false` option for locked tables (more info [here](http://stackoverflow.com/a/104628/1815847)).

**Import a database dump (more info [here](http://stackoverflow.com/a/21091197/1815847)):**

`mysql -u [username] -p -h localhost [database] < db_backup.sql`

**Logout:**

`exit;`

### DML Commands

---



---
## Aggregate functions
**Select but without duplicates:**

`SELECT distinct name, email, acception FROM owners WHERE acception = 1 AND date >= 2015-01-01 00:00:00`

**Calculate total number of records:**

`SELECT SUM([column]) FROM [table];`

**Count total number of `[column]` and group by `[category-column]`:**

`SELECT [category-column], SUM([column]) FROM [table] GROUP BY [category-column];`

**Get largest value in `[column]`:**

`SELECT MAX([column]) FROM [table];`

**Get smallest value:**

`SELECT MIN([column]) FROM [table];`

**Get average value:**

`SELECT AVG([column]) FROM [table];`

**Get rounded average value and group by `[category-column]`:**

`SELECT [category-column], ROUND(AVG([column]), 2) FROM [table] GROUP BY [category-column];`

## Multiple tables

**Select from multiple tables:**

`SELECT [table1].[column], [table1].[another-column], [table2].[column] FROM [table1], [table2];`

**Combine rows from different tables:**

`SELECT * FROM [table1] INNER JOIN [table2] ON [table1].[column] = [table2].[column];`

**Combine rows from different tables but do not require the join condition:**

`SELECT * FROM [table1] LEFT OUTER JOIN [table2] ON [table1].[column] = [table2].[column];` (The left table is the first table that appears in the statement.)

**Rename column or table using an _alias_:** 

`SELECT [table1].[column] AS '[value]', [table2].[column] AS '[value]' FROM [table1], [table2];`

## Users functions
**List all users:** 

`SELECT User,Host FROM mysql.user;`

**Create new user:** 

`CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';`

**Grant `ALL` access to user for `*` tables:**

`GRANT ALL ON database.* TO 'user'@'localhost';`

## Find out the IP Address of the Mysql Host
`SHOW VARIABLES WHERE Variable_name = 'hostname';` ([source](http://serverfault.com/a/129646))

## MySQL function
Like concat: `SELECT url FROM media where url like concat('%','youtube','%');`

Find mysql version: `SELECT @@version;`

Convert milisecond to datetime: `select from_unixtime(1591711200000/1000);`

## Another

SET FOREIGN_KEY_CHECKS=0; -- to disable foreign check

SET FOREIGN_KEY_CHECKS=1; -- to re-enable them

# Problems

## Format date 
`SELECT DATE_FORMAT(column_name, '%m/%d/%Y %H:%i') FROM table_reference;` (Default date format of MySQL is: `YYYY-MM-dd`)

## Check AUTO_INCREMENT value

SHOW TABLE STATUS FROM `database_name` WHERE `name` LIKE 'table_name';
#### LAST_INSERT_ID()
-- --------------NOT WORK IF INSERT ID------------------

`insert into table_name (id, name) values (1, value);`

`select LAST_INSERT_ID();`

-- --------------RUN TWO QUERIES AT ONCE-----------------

`insert into table_name (name) values (value);`

`select LAST_INSERT_ID();`

## How to reset AUTO_INCREMENT

ALTER TABLE tablename AUTO_INCREMENT = value;

