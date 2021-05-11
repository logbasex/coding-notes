## DBMS (Database Management System)

## RDBMS (Relational Database Management System)
An RDBMS is a Relational Database Management System. **It is the database software itself**, which manages storage, querying, updating, and, well, everything. Specifically, an **RDBMS uses a [relational model](https://www.digitalocean.com/community/tutorials/what-is-the-relational-model) of data**, as the name suggests. If you want to work on an RDBMS, you’ll need to learn its implementation language (often C), relational model theory, and a lot of nitty-gritty stuff about filesystem access, transactional logging, scalability, synchronisation, and so on.

SQL, the Structured Query Language, is a language (or a family of closely related languages or dialects) which is typically used to query the RDBMS. If you want to work with SQL, you just learn SQL and maybe a tiny bit of relational model theory for background.

So: the RDBMS is the system, and SQL is the language used to interact with the system. In principle you could have an RDBMS that uses some other language for access, and in principle you could use SQL to interact with some other kind of database system, though in practice the two are closely coupled.

SQLite, MySQL, MariaDB, Postgres, et al are all RDBMSes, and the language you’ll use to interact with all of them is SQL. (Note, however, that the ‘dialect’ of SQL is not identical, so while all the basic CRUD functionality should be the same across all SQL-based DBs, there will be some differences between them. It would be nice if there were only one SQL, but in practice there’s the MySQL ‘dialect’ of SQL, and so on.)

## Relational Model

------
https://www.digitalocean.com/community/tutorials/what-is-the-relational-model

The relational model is an abstract model used to organize data within a database. In order to control access to a database, write data, run queries, or perform any other tasks related to database management, a database management system must have some kind of underlying model that defines how the data within it are organized.

**Databases that implement the relational model are often referred to as** ***relational databases***. The relational model was for a long time the most sophisticated model for organizing data, and its widespread use has only recently been curbed by the rise of nonrelational — or, NoSQL — data models.

The most fundamental elements in the relational model are **relations**, which users and modern RDBMSs recognize as tables. A relation is a set of tuples, or rows in a table, with each tuple sharing a set of attributes, or columns:

![](https://assets.digitalocean.com/articles/understanding_relational_dbs/tuples_chart_final.png)


A column is the smallest organizational structure of a relational database, and represents the various facets that define the records in the table. Hence their more formal name, attributes. It can be helpful to think of each tuple as a unique instance of whatever type of people, objects, events, or associations the table holds.

-------


## SQL (Structure Query Language)
- **SQL is used to communicate with a database**. According to ANSI (American National Standards Institute), it is the standard language for relational database management systems