## References
- [Stop using offset for pagination - Why it's grossly inefficient](https://www.reddit.com/r/programming/comments/knlp8a/stop_using_offset_for_pagination_why_its_grossly/)

----
----

## How JPA pageIndex, pageSize works under the hood

Java Persistence API (JPA) provides a way to interact with relational databases in a Java-centric way, abstracting many of the complexities of direct SQL interactions. When it comes to pagination, JPA's `pageIndex` and `pageSize` are commonly used to handle large datasets efficiently by retrieving a subset of the data at a time. Here's an overview of how they work under the hood:

### 1. Understanding `pageIndex` and `pageSize`

- **`pageSize`** specifies the number of records to return in a single page.
- **`pageIndex`** represents the index of the page to retrieve. Typically, pageIndex starts from 0 or 1, depending on the implementation or framework.

### 2. Conversion to SQL Queries

JPA translates these pagination parameters into SQL queries using `LIMIT` and `OFFSET` clauses (or their equivalents, depending on the database).

- The `LIMIT` clause is used to limit the number of rows returned.
- The `OFFSET` clause skips a number of rows before starting to return rows from the query.

### 3. Calculating OFFSET and LIMIT

Here's the general formula used:

- **OFFSET** = `pageIndex` * `pageSize`
- **LIMIT** = `pageSize`

So, if `pageIndex` is 2 and `pageSize` is 10, the SQL query would have `OFFSET 20 LIMIT 10`, which means skipping the first 20 rows and then fetching the next 10 rows.

### 4. Execution Process

1. **Query Translation**: JPA translates the method call with `pageIndex` and `pageSize` into an SQL query with `LIMIT` and `OFFSET`.

2. **Database Interaction**: The database executes the SQL query, returning only the set of results defined by `OFFSET` and `LIMIT`.

3. **Object Mapping**: JPA maps the returned rows to the corresponding entity objects, which are then returned to the application.

### 5. Use in JPA Repositories

In Spring Data JPA, for instance, you often use `Pageable` interface which encapsulates `pageIndex` and `pageSize`. Methods in repository interfaces can accept a `Pageable` object, and Spring Data JPA handles the pagination logic automatically.

### 6. Efficiency and Caveats

- Pagination is efficient for handling large datasets.
- However, using a high `OFFSET` can be inefficient in some databases, as the database still has to read through all the rows up to the offset.
- The efficiency also depends on the database's indexing and the complexity of the query.

### Conclusion

JPA's pagination using `pageIndex` and `pageSize` is a powerful feature for handling large datasets in an efficient and manageable way. Under the hood, it translates into SQL queries with `LIMIT` and `OFFSET`, with some nuances depending on the database and the specific JPA implementation.


----
----

## However, using a high OFFSET can be inefficient in some databases

Yes, using a high `OFFSET` value in pagination can indeed be inefficient in certain databases, and understanding why requires a deeper look into how databases execute queries with `OFFSET` and `LIMIT` clauses.

### Why High OFFSETs are Inefficient:

1. **Full Table Scan or Index Scan:** When a query with a high `OFFSET` is executed, the database typically performs a full table or index scan. This means it reads through all the rows up to the point of the `OFFSET` value, even though these rows are not returned in the query result. For example, if you have an `OFFSET` of 1000, the database has to read through the first 1000 rows to get to the 1001st row, which is inefficient, especially for large datasets.

2. **Increased IO and CPU Usage:** Reading through a large number of rows increases the Input/Output (IO) operations and CPU usage. This is particularly problematic in large tables with millions of rows.

3. **Non-Linear Performance Degradation:** The performance degradation is not linear with the increase in `OFFSET` value. The larger the `OFFSET`, the more pronounced the performance hit, as the database has to skip over more rows.

### Alternatives and Optimizations:

1. **Seek Method:** Instead of using `OFFSET`, consider using a "seek method" (or keyset pagination). This approach involves querying based on a column value (often a primary key or a unique indexed column) from where the last page ended. For example, instead of `OFFSET 1000 LIMIT 10`, use a query like `WHERE id > last_seen_id LIMIT 10`. This is usually more efficient as it avoids scanning rows that aren't needed.

2. **Indexing:** Ensure that the columns used in the `ORDER BY` clause of your pagination query are indexed. This can significantly reduce the cost of scanning to the `OFFSET` point.

3. **Caching:** For frequently accessed data, consider caching the results of paginated queries to reduce database load.

4. **Limit the Total Number of Pages:** Implementing a maximum cap on the `OFFSET` or the total number of pages can help in reducing the load on the database for extremely large datasets.

5. **Adjusting Page Size:** Sometimes adjusting the page size can also be an effective way to optimize performance, balancing between the number of queries and the size of each result set.

### Conclusion:

While pagination is essential for handling large datasets, the method of implementation can greatly impact performance. Using high `OFFSET` values can lead to inefficiencies, especially for large datasets. Alternatives like the seek method, proper indexing, and caching strategies can help in optimizing pagination performance in databases.
