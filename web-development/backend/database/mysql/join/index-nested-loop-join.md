## Setup

```sql
CREATE TABLE customer
(
    id         INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    level      VARCHAR(20)
);

CREATE TABLE level
(
    level    VARCHAR(20) PRIMARY KEY,
    discount INT
);

INSERT INTO customer (ID, FIRST_NAME, LAST_NAME, LEVEL)
VALUES (123, 'Avery', 'Winston', 'Gold'),
       (456, 'Bob', 'Washington', 'Platinum'),
       (346, 'Anders', 'Fosse', 'Bronze'),
       (398, 'Markus', 'Herren', 'Silver'),
       (862, 'Alice', 'Smith', 'Gold'),
       (773, 'Berry', 'Henry', 'Platinum'),
       (640, 'Vihaan', 'Kangas', 'Gold');

INSERT INTO level (LEVEL, DISCOUNT)
VALUES ('Bronze', 5),
       ('Silver', 7),
       ('Gold', 10)

explain select * from customer c join level l on c.level = l.level where l.level = 'Bronze';
```

====
====

## Explain query

To understand the output of the `EXPLAIN` query for `SELECT * FROM customer c JOIN level l ON c.level = l.level WHERE l.level = 'Bronze';`, let's break down each part of the output step by step:

### Query Explanation
```sql
EXPLAIN SELECT * FROM customer c JOIN level l ON c.level = l.level WHERE l.level = 'Bronze';
```

### Output
| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra        |
|----|-------------|-------|------------|-------|----------------|----------|---------|-------|------|----------|--------------|
| 1  | SIMPLE      | l     | NULL       | const | PRIMARY        | PRIMARY  | 82      | const | 1    | 100.00   | NULL         |
| 1  | SIMPLE      | c     | NULL       | ALL   | NULL           | NULL     | NULL    | NULL  | 7    | 14.29    | Using where  |

### Explanation of Each Column
1. **id**: Indicates the sequential number of the query's execution step. Here, both steps are part of the same query (`id = 1`).

2. **select_type**: The type of SELECT query. In this case, both are `SIMPLE`, indicating simple SELECT queries without subqueries or unions.

3. **table**: The name of the table for the current step in the query execution plan. The first step involves the `level` (`l`) table, and the second step involves the `customer` (`c`) table.

4. **partitions**: Indicates the partitions involved. In this output, it’s NULL, meaning no specific partitions are used.

5. **type**: The join type or access method used for the table:
    - `const` for the `level` table means it is treated as a constant because of the specific WHERE condition (`l.level = 'Bronze'`).
    - `ALL` for the `customer` table means a full table scan is being used.

6. **possible_keys**: The indexes that MySQL could consider using. For `level`, it shows `PRIMARY`, and for `customer`, there are no possible keys listed.

7. **key**: The actual key (index) used by MySQL. For `level`, it is using the `PRIMARY` key.

8. **key_len**: The length of the key used. For `level`, the length is 82 bytes.

9. **ref**: The columns or constants that are compared to the index named in the key column to select rows from the table. For `level`, it is using `const` (the constant value 'Bronze').

10. **rows**: The estimated number of rows MySQL expects to examine:
    - 1 row for the `level` table (because it matches a specific constant value).
    - 7 rows for the `customer` table (since it performs a full table scan).

11. **filtered**: The estimated percentage of rows that will be filtered by the table condition:
    - 100% for the `level` table (all rows matching the constant value 'Bronze').
    - 14.29% for the `customer` table (only a portion of rows expected to match the condition).

12. **Extra**: Additional information about the query execution:
    - `NULL` for the `level` table, indicating no extra conditions.
    - `Using where` for the `customer` table, indicating that a WHERE clause is used to filter rows.

### Interpretation
1. The query first examines the `level` table to find the row where `level = 'Bronze'`. This is very efficient because it uses the `PRIMARY` key index and expects to find exactly one row (`type: const`).
2. Once the matching row in the `level` table is found, the query performs a full table scan on the `customer` table (`type: ALL`), filtering rows based on the join condition and the WHERE clause.

This execution plan suggests that while the lookup in the `level` table is very efficient, the full table scan on the `customer` table could be optimized, perhaps by adding an index on the `level` column in the `customer` table to speed up the join condition.

====
====

## Why join not start with full table scan Customer first?

The order in which tables are joined and scanned can significantly impact the performance of a query. MySQL's query optimizer makes decisions based on several factors, including available indexes, the size of the tables, and the conditions in the query.

In your specific query:

```sql
EXPLAIN SELECT * FROM customer c JOIN level l ON c.level = l.level WHERE l.level = 'Bronze';
```

### Why the Join Starts with `level` Table

1. **Constant Condition on `level` Table**:
    - The condition `l.level = 'Bronze'` is a highly selective filter that reduces the number of rows immediately.
    - Since `level` is being filtered on a primary key (`PRIMARY`), which is very efficient, the optimizer chooses this table to start with.

2. **Efficiency**:
    - By starting with the `level` table, which has a very selective condition, the optimizer can immediately narrow down the number of rows to a small set (in this case, just one row with `level = 'Bronze'`).
    - This is a much faster operation compared to scanning the entire `customer` table first.

3. **Avoiding Full Table Scan Initially**:
    - If the `customer` table were scanned first, it would involve reading all rows (a full table scan) and then joining each row with the `level` table, which is less efficient.
    - Since there are fewer rows in `level` after applying the filter, starting with `level` reduces the number of operations needed when joining with the `customer` table.

### EXPLAIN Output Analysis

#### Step 1: Filtering `level` Table
- The first step involves scanning the `level` table where `level = 'Bronze'`.
- This is a very efficient operation (`const` type) because it uses the `PRIMARY` key and expects to find only one row (`rows = 1`).

#### Step 2: Joining with `customer` Table
- Once the matching row from the `level` table is identified, the next step is to join it with the `customer` table.
- A full table scan (`ALL` type) on the `customer` table is used because there is no suitable index on the `customer.level` column.
- The `customer` table has 7 rows in total, and the optimizer estimates that 14.29% of these rows (i.e., approximately one row) will match the join condition (`filtered = 14.29`).

### Optimization Suggestion

To optimize this query further, you could consider adding an index on the `level` column of the `customer` table. This index would allow MySQL to efficiently look up customers by their level, potentially avoiding a full table scan.

```sql
CREATE INDEX idx_customer_level ON customer(level);
```

### Expected Change in EXPLAIN Output

With the index in place, the query might use the index to quickly find the matching rows in the `customer` table, improving the overall performance. The updated EXPLAIN output could look something like this:

| id | select_type | table    | partitions | type  | possible_keys    | key               | key_len | ref   | rows | filtered | Extra        |
|----|-------------|----------|------------|-------|------------------|-------------------|---------|-------|------|----------|--------------|
| 1  | SIMPLE      | l        | NULL       | const | PRIMARY          | PRIMARY           | 82      | const | 1    | 100.00   | NULL         |
| 1  | SIMPLE      | c        | NULL       | ref   | idx_customer_level | idx_customer_level | 22      | const | 1    | 100.00   | Using index  |

In this case, the `type` for the `customer` table would change from `ALL` to `ref`, indicating that the query is using the new index to quickly find matching rows.

By starting with the `level` table and using a highly selective index scan, the optimizer reduces the workload and improves query performance.

=====
=====

## Explain Analyzer

```mysql
 explain analyzer select * from customer c join level_index l on c.level = l.level where l.level = 'Bronze';
```

```shell
-> Nested loop inner join  (cost=1 rows=1) (actual time=0.0386..0.0445 rows=1 loops=1)
    -> Filter: (l.`level` = 'Bronze')  (cost=0.65 rows=1) (actual time=0.0207..0.0244 rows=1 loops=1)
        -> Table scan on l  (cost=0.65 rows=4) (actual time=0.0188..0.0214 rows=4 loops=1)
    -> Index lookup on c using customer_level_index (level='Bronze'), with index condition: (c.`level` = l.`level`)  (cost=0.35 rows=1) (actual time=0.0153..0.017 rows=1 loops=1)

```
