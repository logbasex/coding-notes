## Setup

```mysql
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
                           customer_id INT PRIMARY KEY,
                           customer_name VARCHAR(255)
);

CREATE TABLE orders (
                        order_id INT PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
                          product_id INT PRIMARY KEY,
                          product_name VARCHAR(255)
);

CREATE TABLE order_items (
                             order_item_id INT PRIMARY KEY,
                             order_id INT,
                             product_id INT,
                             quantity INT,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id),
                             FOREIGN KEY (product_id) REFERENCES products(product_id)
);



DELIMITER //

CREATE PROCEDURE generate_data()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE k INT DEFAULT 1;
    DECLARE l INT DEFAULT 1;
    DECLARE batch_size INT DEFAULT 1000;

    -- Temporary variables for batch inserts
    DECLARE customer_values TEXT DEFAULT '';
    DECLARE product_values TEXT DEFAULT '';
    DECLARE order_values TEXT DEFAULT '';
    DECLARE order_item_values TEXT DEFAULT '';

    -- Insert data into customers
    WHILE i <= 10000 DO
            SET customer_values = CONCAT(customer_values, '(', i, ', "Customer ', i, '")');
            IF MOD(i, batch_size) = 0 OR i = 10000 THEN
                SET @customer_sql = CONCAT('INSERT INTO customers (customer_id, customer_name) VALUES ', customer_values, ';');
                PREPARE stmt FROM @customer_sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET customer_values = '';
            ELSE
                SET customer_values = CONCAT(customer_values, ', ');
            END IF;
            SET i = i + 1;
        END WHILE;

    -- Insert data into products
    WHILE j <= 10000 DO
            SET product_values = CONCAT(product_values, '(', j, ', "Product ', j, '")');
            IF MOD(j, batch_size) = 0 OR j = 10000 THEN
                SET @product_sql = CONCAT('INSERT INTO products (product_id, product_name) VALUES ', product_values, ';');
                PREPARE stmt FROM @product_sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET product_values = '';
            ELSE
                SET product_values = CONCAT(product_values, ', ');
            END IF;
            SET j = j + 1;
        END WHILE;

    -- Insert data into orders
    WHILE k <= 500000 DO
            SET order_values = CONCAT(order_values, '(', k, ', ', FLOOR(1 + (RAND() * 10000)), ', "', DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY), '")');
            IF MOD(k, batch_size) = 0 OR k = 500000 THEN
                SET @order_sql = CONCAT('INSERT INTO orders (order_id, customer_id, order_date) VALUES ', order_values, ';');
                PREPARE stmt FROM @order_sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET order_values = '';
            ELSE
                SET order_values = CONCAT(order_values, ', ');
            END IF;
            SET k = k + 1;
        END WHILE;

    -- Insert data into order_items
    WHILE l <= 2000000 DO
            SET order_item_values = CONCAT(order_item_values, '(', l, ', ', FLOOR(1 + (RAND() * 500000)), ', ', FLOOR(1 + (RAND() * 10000)), ', ', FLOOR(1 + (RAND() * 10)), ')');
            IF MOD(l, batch_size) = 0 OR l = 2000000 THEN
                SET @order_item_sql = CONCAT('INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES ', order_item_values, ';');
                PREPARE stmt FROM @order_item_sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET order_item_values = '';
            ELSE
                SET order_item_values = CONCAT(order_item_values, ', ');
            END IF;
            SET l = l + 1;
        END WHILE;
END //

DELIMITER ;

-- Call the stored procedure to generate data
CALL generate_data();


EXPLAIN
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
             INNER JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = c.customer_id
      AND oi.product_id = 1 AND o.order_date > '2023-05-01'
);

-- Using IN()
EXPLAIN
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
             INNER JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = 1 AND o.order_date > '2023-05-01'
);
```

====
====

## Detailed Comparison of `WHERE IN` vs. `WHERE EXISTS` in MySQL

Understanding the performance differences between `WHERE IN` and `WHERE EXISTS` in MySQL requires a deeper look into how these clauses work and how MySQL optimizes queries involving them.

### `WHERE IN`

The `WHERE IN` clause checks if a value is present within a specified list or subquery result set.

#### Example with Constant List
```sql
SELECT *
FROM employees
WHERE department_id IN (1, 2, 3);
```

#### Example with Subquery
```sql
SELECT *
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 100);
```

**Performance Considerations:**

1. **Constant List:**
    - **Efficiency:** For small lists of constant values, `WHERE IN` is very efficient because it directly checks each value against the list.
    - **Execution Plan:** MySQL can optimize this by creating a set of constants to compare against the target column.

2. **Subquery:**
    - **Materialization:** When `IN` is used with a subquery, MySQL may need to materialize the subquery result set (i.e., temporarily store the results).
    - **Large Result Sets:** If the subquery returns a large number of rows, this can be inefficient because MySQL needs to hold all the results in memory and compare each row from the outer query against this large set.
    - **Indexed Columns:** Performance can be improved if the column in the subquery is indexed, but this does not always mitigate the overhead of materializing large result sets.

### `WHERE EXISTS`

The `WHERE EXISTS` clause checks for the existence of rows in a subquery. It returns true if the subquery returns at least one row.

#### Example
```sql
SELECT *
FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d WHERE e.department_id = d.department_id AND d.location_id = 100);
```

**Performance Considerations:**

1. **Short-Circuit Evaluation:**
    - **Efficiency:** `WHERE EXISTS` is generally more efficient for large datasets because it can stop processing the subquery as soon as a match is found. This is known as short-circuit evaluation.
    - **Correlated Subqueries:** `EXISTS` works well with correlated subqueries, which reference columns from the outer query.

2. **Index Usage:**
    - **Indexed Columns:** The efficiency of `EXISTS` can be greatly enhanced if the subquery involves indexed columns. MySQL can quickly look up the index and determine if a match exists.

### Summary

- **`WHERE IN`** is suitable for small, constant lists and can be efficient with indexed columns. However, it can be less efficient with large subquery result sets due to materialization overhead.
- **`WHERE EXISTS`** is generally more efficient for large datasets and correlated subqueries, benefiting from short-circuit evaluation and effective use of indexes.

By analyzing your specific use case, data distribution, and indexes, you can choose the most performant approach between `WHERE IN` and `WHERE EXISTS` for your MySQL queries.