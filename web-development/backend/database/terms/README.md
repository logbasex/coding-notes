## Database
A database is a collection of structured information organized in a way that it can be easily accessed, managed, and updated by computer programs.

Complex databases often use more formalized structures and design patterns, typically defined by a Database Management System (DBMS). There are many different types of common database management systems, some using design patterns like the Relational Model and NoSQL, with query languages like SQL.

## Database Ranking
https://db-engines.com/en/ranking

## DBMS (Database Management System)

## RDBMS (Relational Database Management System)

https://www.quora.com/What-is-the-difference-between-RDBMS-and-SQL

An RDBMS is a Relational Database Management System. **It is the database software itself**, which manages storage, querying, updating, and, well, everything. Specifically, an **RDBMS uses a [relational model](https://www.digitalocean.com/community/tutorials/what-is-the-relational-model) of data**, as the name suggests. If you want to work on an RDBMS, you’ll need to learn its implementation language (often C), relational model theory, and a lot of nitty-gritty stuff about filesystem access, transactional logging, scalability, synchronisation, and so on.

SQL, the Structured Query Language, is a language (or a family of closely related languages or dialects) which is typically used to query the **RDBMS**. **If you want to work with SQL, you just learn SQL and maybe a tiny bit of relational model theory for background**.

So: the RDBMS is the system, and SQL is the language used to interact with the system. In principle you could have an RDBMS that uses some other language for access, and in principle you could use SQL to interact with some other kind of database system, though in practice the two are closely coupled.

**SQLite, MySQL, MariaDB, Postgres, et al are all RDBMSes**, and the language you’ll use to interact with all of them is SQL. (Note, however, that the ‘dialect’ of SQL is not identical, so while all the basic CRUD functionality should be the same across all SQL-based DBs, there will be some differences between them. It would be nice if there were only one SQL, but in practice there’s the MySQL ‘dialect’ of SQL, and so on.)

## Relational Model

------
https://www.digitalocean.com/community/tutorials/what-is-the-relational-model

The relational model is an abstract model used to organize data within a database. In order to control access to a database, write data, run queries, or perform any other tasks related to database management, a database management system must have some kind of underlying model that defines how the data within it are organized.

**Databases that implement the relational model are often referred to as** ***relational databases***. The relational model was for a long time the most sophisticated model for organizing data, and its widespread use has only recently been curbed by the rise of nonrelational — or, NoSQL — data models.

The most fundamental elements in the relational model are **relations**, which users and modern RDBMSs recognize as tables. A relation is a set of tuples, or rows in a table, with each tuple sharing a set of attributes, or columns:

![](https://assets.digitalocean.com/articles/understanding_relational_dbs/tuples_chart_final.png)


A column is the smallest organizational structure of a relational database, and represents the various facets that define the records in the table. Hence their more formal name, attributes. It can be helpful to think of each tuple as a unique instance of whatever type of people, objects, events, or associations the table holds.

-------

## Relational Databases
https://www.digitalocean.com/community/tutorials/understanding-relational-databases

Disadvantage: Horizontal scale

![](https://hackernoon.com/hn-images/0*zQDy30a97Fwa0C_q.png)

## SQL (Structure Query Language)
- **SQL is used to communicate with a database**. According to ANSI (American National Standards Institute), it is the standard language for relational database management systems


## What is the difference between MySQL and SQL?

SQL is a computer language, whereas MySQL is a software or an application

-----

SQL, the Structured Query Language, is a language (or a family of closely related languages or dialects) which is typically used to query the **RDBMS**. If you want to work with SQL, you just learn SQL and maybe a tiny bit of relational model theory for background.

**SQLite, MySQL, MariaDB, Postgres, et al are all RDBMSes**.

--------

A RDBMS is a kind of database software, specifically one which keeps the data organised into a particular kind of table. Postgres, MySQL, Sqlite, Access and so on are RDBMSs.

SQL is a language used to access and control RDBMSs. Pretty much all RDBMSs accept instructions in SQL, although the SQL they accept differs in small details. You can use SQL to set up databases and modify them, as well as accessing them.

So: **an RDBMS is not a language but a kind of database software; SQL is not a kind of database software but a language**.

## What is the difference between the database and the table?
There is a major difference between a database and a table. The differences are as follows:

- Tables are a way to represent the division of data in a database while the database is a collection of tables and data.
- Tables are used to group the data in relation to each other and create a dataset. This dataset will be used in the database. The data stored in the table in any form is a part of the database, but the reverse is not true.
- A database is a collection of organized data and features used to access them, whereas the table is a collection of rows and columns used to store the data.

# Scale
 - ## [Database Scaling : Horizontal and Vertical Scaling](https://hackernoon.com/database-scaling-horizontal-and-vertical-scaling-85edd2fd9944)
    - Vertical Scaling - Scale Up
   
        ![](https://hackernoon.com/hn-images/0*eJhhXAdzxNqNHv_V.jpg)
     
    - Horizontal Scaling - Scale Out
   
        ![](https://hackernoon.com/hn-images/0*Z4Ib_tXhm7hXlHNB.jpg)