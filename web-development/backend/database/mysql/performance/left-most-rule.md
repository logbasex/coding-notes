## References
- https://medium.com/gitconnected/how-to-optimize-a-mysql-index-e357d3434ea9

----

## Leftmost Rule

The leftmost rule in MySQL indexing refers to how MySQL uses indexes, especially composite indexes (indexes on multiple columns). Understanding this rule is crucial for optimizing queries and designing effective indexes. Here's a detailed explanation:

### What is the Leftmost Rule?

1. **Composite Indexes**: A composite index is an index that includes two or more columns. For example, if you have an index on `(column1, column2, column3)`, it's a composite index.

2. **Leftmost Prefix**: MySQL can use the leftmost part of a composite index to optimize queries. This means that if a query uses `column1`, or `column1` and `column2`, or all three columns in the order they are indexed, MySQL can utilize the index.

3. **Partial Index Usage**: If a query doesn’t use the leftmost column of the index, MySQL cannot use that index efficiently. For example, if a query filters or sorts only on `column2` and `column3`, without involving `column1`, the composite index `(column1, column2, column3)` will not be used effectively.

### Why is the Leftmost Rule Important?

1. **Query Optimization**: Understanding this rule helps in designing queries that make the best use of indexes. For example, if you know you frequently filter data on `column1` and `column2`, a composite index on these columns would be beneficial.

2. **Index Design**: When designing composite indexes, you should consider the most common query patterns and arrange the columns in the index accordingly, keeping the most frequently used columns to the left.

3. **Performance Improvement**: Properly leveraging the leftmost rule can significantly improve query performance, as it enables the database to quickly locate rows using the index rather than performing full table scans.

### Practical Implications

- **Order of Columns in Index**: Always place the most frequently queried columns to the left in a composite index.
- **Order of Conditions in Query**: When writing queries, try to match the order of the WHERE clause conditions with the order of the columns in the composite index.
- **Partial Indexing**: Be aware that if your query does not use the leftmost columns of the index, the database might not use the composite index at all, leading to less optimal query performance.

### Conclusion

The leftmost rule is a fundamental concept in MySQL indexing, crucial for database performance tuning. By aligning your query patterns with the way MySQL uses indexes, you can achieve more efficient data retrieval and improve the overall performance of your database operations.

----

## B-tree index vs Leftmost Rule

To illustrate how data is stored and accessed using a B-tree index, let's consider a practical example. Suppose we have a database table named `Orders` with the following columns: **OrderID**, **CustomerID**, and **OrderDate**. We'll create a **composite B-tree index** on (CustomerID, OrderDate).

### Structure of the `Orders` Table

| OrderID | CustomerID | OrderDate  |
|---------|------------|------------|
| 1       | 100        | 2023-01-10 |
| 2       | 100        | 2023-01-15 |
| 3       | 101        | 2023-01-12 |
| 4       | 101        | 2023-01-22 |
| 5       | 102        | 2023-01-20 |
| 6       | 100        | 2023-01-18 |
| 7       | 102        | 2023-01-25 |
| 8       | 101        | 2023-01-30 |
| ...     | ...        | ...        |

### Visualizing the B-Tree Index on `(CustomerID, OrderDate)`

The B-tree index for `(CustomerID, OrderDate)` might be visualized as follows:

```
Root
|
+-- [CustomerID 100]
|      |
|      +-- [2023-01-10, OrderID 1]
|      +-- [2023-01-15, OrderID 2]
|      +-- [2023-01-18, OrderID 6]
|
+-- [CustomerID 101]
|      |
|      +-- [2023-01-12, OrderID 3]
|      +-- [2023-01-22, OrderID 4]
|      +-- [2023-01-30, OrderID 8]
|
+-- [CustomerID 102]
       |
       +-- [2023-01-20, OrderID 5]
       +-- [2023-01-25, OrderID 7]
```

### How Data is Accessed

1. **Query by `CustomerID` and `OrderDate`**:
    - Example: `SELECT * FROM Orders WHERE CustomerID = 100 AND OrderDate = '2023-01-15'`
    - The database uses the index to quickly find `CustomerID 100`, then within that branch, it looks for `OrderDate 2023-01-15`.

2. **Query by `CustomerID` only**:
    - Example: `SELECT * FROM Orders WHERE CustomerID = 101`
    - The database can efficiently use the index to find all orders for `CustomerID 101`.

3. **Inefficient Query (not using the leftmost column)**:
    - Example: `SELECT * FROM Orders WHERE OrderDate = '2023-01-20'`
    - This query doesn’t specify `CustomerID` and only filters by `OrderDate`. The B-tree index cannot be used effectively because it's sorted first by `CustomerID`.

### Conclusion

In this visualization, you can see that the index is organized first by `CustomerID` and then by `OrderDate` within each `CustomerID`. Queries that start with conditions on `CustomerID` will efficiently use this index. The leftmost rule comes from this ordering in the B-tree structure, where the leftmost column of the index defines the primary sorting and structuring of the index tree.
