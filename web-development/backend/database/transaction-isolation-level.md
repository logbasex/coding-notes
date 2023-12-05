## Dirty Read, Non-Repeatable Read, Phantom Read

![image](https://gist.github.com/assets/22516811/7af5dcff-afef-43c2-8d5b-7ef0e38b64f4)

In the context of database systems and transactional processing, three common types of anomalies that can occur due to concurrent transactions are Dirty Read, Non-Repeatable Read, and Phantom Read. These are important concepts, particularly when considering transaction isolation levels.

### 1. **Dirty Read**:
- **Definition**: A dirty read occurs when a transaction reads data that has been written by another transaction that has not yet been committed. This data is called "dirty" because it might be rolled back (i.e., the changes might be undone), making the read potentially invalid.
- **Example**: Transaction 1 starts and updates a record. Transaction 2 reads the updated record before Transaction 1 commits or rolls back the change. If Transaction 1 then rolls back its changes, Transaction 2 will have read data that technically never existed in the database.
- **Prevention**: Most databases prevent dirty reads through their default isolation levels. Read Uncommitted is the only isolation level that allows dirty reads.

- ![image](https://gist.github.com/assets/22516811/0b5a8c65-891f-460e-9d04-5e39a4534bd6)
   
### 2. **Non-Repeatable Read**:
- **Definition**: This occurs when a transaction reads the same row of data more than once and gets different data each time because another transaction has modified the data in between the reads.
- **Example**: Transaction 1 reads a row. Transaction 2 then updates that row and commits the change. When Transaction 1 reads the row again, it gets different data.
- **Prevention**: Using the Repeatable Read or Serializable isolation levels in a database can prevent non-repeatable reads. These levels ensure that if a row is read once in a transaction, it cannot be changed by other transactions until the first transaction is completed.

### 3. **Phantom Read**:
- **Definition**: A phantom read occurs when a transaction re-executes a query returning a set of rows that satisfy a search condition and finds that the set of rows satisfying the condition has changed due to another recently-committed transaction.
- **Example**: Transaction 1 reads a set of rows that meet a certain condition. Transaction 2 inserts or deletes some rows that affect the same set. When Transaction 1 re-executes the same query, it finds a different set of rows.
- **Prevention**: The Serializable isolation level is typically used to prevent phantom reads. This level ensures a fully isolated transaction, preventing other transactions from inserting or deleting rows that would affect the query results in the ongoing transaction.

- ![image](https://gist.github.com/assets/22516811/99ba6b24-1e5d-4d1b-8518-599baa53f3c9)

Each of these anomalies represents a different challenge in maintaining the consistency and integrity of data in a database. The choice of isolation level in a database management system is often a balance between the need for data consistency and the need for performance and concurrency. Higher isolation levels provide greater data consistency but can lead to decreased performance due to increased locking and reduced concurrency.

---
---

Certainly! Let's go through examples of Dirty Read, Non-Repeatable Read, and Phantom Read in the context of MySQL, illustrating how these phenomena can occur. We'll assume the use of the InnoDB storage engine, which is the default in MySQL and supports transactional features.

### 1. Dirty Read
In MySQL, Dirty Reads are typically not observed under default settings because the default isolation level is REPEATABLE READ, which prevents them. However, they can occur under the READ UNCOMMITTED isolation level.

**Example:**

Suppose we have a table `accounts` with columns `id` and `balance`.

- **Transaction 1** (T1):
    - `SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;`
    - `START TRANSACTION;`
    - `UPDATE accounts SET balance = balance + 100 WHERE id = 1;`
    - (Do not commit yet)

- **Transaction 2** (T2):
    - `SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;`
    - `START TRANSACTION;`
    - `SELECT balance FROM accounts WHERE id = 1;` (Reads the uncommitted balance from T1)
    - `COMMIT;`

- **Transaction 1** continues:
    - `ROLLBACK;` (Reverts the balance change)

Here, T2 reads the uncommitted balance update made by T1, which is a Dirty Read.

### 2. Non-Repeatable Read
Occurs under READ COMMITTED isolation level in MySQL.

**Example:**

- **Transaction 1**:
    - `SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`
    - `START TRANSACTION;`
    - `SELECT balance FROM accounts WHERE id = 1;` (Reads the initial balance)

- **Transaction 2**:
    - `SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`
    - `START TRANSACTION;`
    - `UPDATE accounts SET balance = balance + 100 WHERE id = 1;`
    - `COMMIT;`

- **Transaction 1** continues:
    - `SELECT balance FROM accounts WHERE id = 1;` (Reads the updated balance, different from the first read)
    - `COMMIT;`

T1 experiences a Non-Repeatable Read because it reads different values for the same row during the same transaction.

### 3. Phantom Read
Occurs under READ COMMITTED but can be prevented with REPEATABLE READ or SERIALIZABLE in MySQL.

**Example:**

- **Transaction 1**:
    - `SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`
    - `START TRANSACTION;`
    - `SELECT * FROM accounts WHERE balance > 100;` (Returns a set of rows)

- **Transaction 2**:
    - `SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`
    - `START TRANSACTION;`
    - `INSERT INTO accounts (id, balance) VALUES (3, 150);` (Inserts a new row)
    - `COMMIT;`

- **Transaction 1** continues:
    - `SELECT * FROM accounts WHERE balance > 100;` (Returns a different set of rows, including the new row)
    - `COMMIT;`

T1 experiences a Phantom Read because the set of rows satisfying its query changes during its execution due to T2's insertion.

In practice, the impact and handling of these phenomena depend on the specific requirements of the application and the chosen transaction isolation level. Higher isolation levels (like REPEATABLE READ or SERIALIZABLE) reduce these anomalies but can impact the performance due to increased locking.