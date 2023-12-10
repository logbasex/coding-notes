> Về cơ bản Stream<Entity> là một long-lived process và @Transactional(readOnly = true) để đảm bảo trong quá read data thì chỉ read data đã được commit bởi transaction khác, nếu chưa commit thì không read.
> 
> Mặc dù read database luôn có **Implicit Transactions** nhưng khi **Streaming Results** thì luôn cần **Explicit Transactions**.
> 
>> Streaming operations might take longer to complete compared to typical queries. During this time, the underlying data in the database might change due to other transactions.
> 
>> An explicit transaction ensures a consistent view of the data for the duration of the streaming process. The isolation level of the transaction determines how changes made by other concurrent transactions affect the data being streamed.
> 
## Why read data need to use @Transactional

Using the `@Transactional` annotation for read operations in a Spring application, even though it might seem unnecessary at first, has several important benefits:

1. **Consistent Data State:** When you read data within a transaction, you ensure that all the data read during the transaction is consistent with respect to a particular point in time. This is particularly important in scenarios where multiple related data entities are read in a single operation. Without a transaction, you might end up reading data that is partially updated by another concurrent transaction, leading to inconsistent or incorrect results.

2. **Unit of Work:** `@Transactional` wraps a series of read operations into a single unit of work. This means that either all the read operations within this boundary succeed, or if an error occurs, none of them take effect (which, in the case of reads, generally means retrying the read). It brings a level of atomicity to the operations.

3. **Database Session Management:** The annotation abstracts away the low-level handling of database sessions and connections. When a method is annotated with `@Transactional`, Spring ensures that a database session is opened and closed properly, which is a good practice for managing database resources efficiently.

4. **Leveraging Database Transaction Isolation Levels:** Even for read operations, the isolation level of a transaction can be important. Different isolation levels (like Read Committed, Repeatable Read, or Serializable) control how the transaction is isolated from the operations of other transactions, which can prevent issues like dirty reads, non-repeatable reads, and phantom reads.

5. **Read-Only Optimization:** When you use `@Transactional(readonly = true)`, you inform the transaction manager and the underlying database that the transaction will not modify any data. This can lead to performance optimizations, as the database can avoid locking data, which can improve throughput and reduce contention.

6. **Declarative Transaction Management:** Using `@Transactional` is part of a declarative approach to transaction management. It keeps transaction management code out of the business logic, making the code cleaner, more readable, and easier to maintain.

7. **Proxy-Based AOP:** In Spring, `@Transactional` works using AOP (Aspect-Oriented Programming) proxies. This means that the transactional behavior is applied around the method call transparently, without the need for explicit transaction code within the method. This makes your code cleaner and focused on its primary responsibility.

8. **Exception Handling:** Spring's transaction management converts checked exceptions to unchecked, runtime exceptions, simplifying error handling and rollback rules in transactional contexts.

In summary, using `@Transactional` for read operations ensures data consistency, optimizes performance, and improves code clarity and maintainability. It's a good practice to use it even for read-only scenarios in a Spring application.

## But usually we don't use @Transactional when query from DB except Stream<Entity>. Why?

In Spring applications, the use of `@Transactional` for database queries often depends on specific requirements and scenarios. While it's true that `@Transactional` is not always necessary for every read operation, there are certain situations where its use is particularly important or beneficial. Let's explore why it might not be commonly used for typical queries but is recommended for scenarios like streaming results:

1. **Simple Queries and Transaction Overhead:** For simple and straightforward database read operations, especially those that are atomic (like fetching a single row by ID), the benefits of wrapping these queries in a transaction may not be significant. Transactions add a certain overhead, and for operations that are inherently atomic or isolated by the database itself, this overhead might not be justified.

2. **Database Transaction Handling:** Modern databases and ORM frameworks like Hibernate often handle transactions efficiently at a lower level. For simple queries, these default transactional behaviors are usually sufficient, ensuring consistency and isolation without explicit transaction demarcation in the application code.

3. **Implicit Transactions:** Even when you don't explicitly use `@Transactional`, each database operation typically runs in its own implicit transaction, provided by the database management system. This is often sufficient for simple, quick read operations.

4. **Streaming Results (`Stream<Entity>`):** When you're streaming results from a database (like with `Stream<Entity>` in Spring Data), the situation is different. Streaming results involves keeping a cursor open in the database for the duration of the stream processing. This can be a long-lived operation, and without a transaction, the cursor might become invalid or the data may change during the streaming, leading to inconsistent results. Therefore, in this case, it is crucial to use `@Transactional` to ensure that the entire stream processing occurs within a consistent, managed transactional context.

5. **Avoiding Lazy Initialization Exceptions:** In cases where you're dealing with lazy-loaded entities (common in ORM frameworks like Hibernate), accessing certain properties of these entities outside of an active transaction can result in LazyInitializationException. Wrapping such operations in `@Transactional` ensures that the necessary data is fetched while the session is still open.

6. **Complex Queries and Reports:** In more complex scenarios, like generating reports or executing complex queries that involve multiple tables and entities, using `@Transactional` ensures consistency and coherence of the data throughout the execution of these operations.

In summary, while `@Transactional` is not strictly necessary for every simple read operation, its use is essential in scenarios involving complex queries, streaming results, or operations requiring a guaranteed state of consistency and isolation. The decision to use `@Transactional` should be based on the specific requirements and characteristics of each use case.

## Does @Transactional meaning that I'm reading database at a specific point of time, right?

The `@Transactional` annotation in the context of Spring Framework and Java does not inherently guarantee that you are reading the database at a specific point in time, like a snapshot. Instead, its primary role is to define the boundaries of a transaction within which a consistent view of the database is maintained according to the transaction's isolation level. Here's a bit more detail:

1. **Transaction Isolation Levels:** The consistency of the data you read within a transaction is governed by the transaction's isolation level. Common isolation levels include Read Uncommitted, Read Committed, Repeatable Read, and Serializable. Each level offers different guarantees about how data is isolated from changes made by other concurrent transactions.

2. **Read Committed (Most Common Default):** Many databases and Spring's transaction management default to the Read Committed isolation level. This means that within a transaction, you'll only see data that has been committed (saved) by other transactions. However, if another transaction modifies the data after your current transaction starts, subsequent reads within your transaction might see these changes. This does not constitute a fixed point-in-time snapshot.

3. **Repeatable Read and Serializable:** To achieve a point-in-time snapshot-like behavior, higher isolation levels like Repeatable Read or Serializable are needed. With Repeatable Read, if you read a row within a transaction, subsequent reads of that row in the same transaction will see the same data, even if other transactions are modifying it. Serializable goes further, providing a strict point-in-time snapshot of the entire dataset, but at the cost of concurrency (as it can lead to significant locking).

4. **Performance Considerations:** Higher isolation levels, while providing more consistency, come with a performance cost due to increased locking and reduced concurrency. Therefore, they are used judiciously.

5. **Read-Only Transactions:** Using `@Transactional(readonly = true)` doesn't change the isolation level, but it can optimize performance for read operations because the database knows no data modification will occur.

6. **Database-Specific Behavior:** The actual behavior and guarantees of transaction isolation levels can vary between different database systems. It's important to understand how your particular database handles transactions.

In summary, `@Transactional` manages transaction boundaries and can, depending on the isolation level, offer a consistent view of the database for the duration of the transaction. However, it doesn't inherently provide a point-in-time snapshot unless you explicitly configure it to use a higher isolation level like Serializable. The choice of isolation level should balance the need for consistency against performance implications.

## why streaming results need explicit Transactions

Streaming results from a database in a Spring application often requires explicit transaction management, typically achieved using the `@Transactional` annotation. The primary reasons for this necessity revolve around the way database cursors and data consistency are handled during the streaming process. Let's break this down:

1. **Maintaining an Open Database Cursor**:
    - When you stream data from a database, especially large datasets, the application doesn't fetch all the data at once. Instead, it uses a cursor to fetch the data in smaller chunks to avoid memory overload.
    - This cursor needs to remain open for the duration of the stream. Without an active transaction, the database connection and thus the cursor could be closed before the stream has been fully processed, leading to errors or incomplete data retrieval.

2. **Data Consistency and Isolation**:
    - Streaming operations might take longer to complete compared to typical queries. During this time, the underlying data in the database might change due to other transactions.
    - An explicit transaction ensures a consistent view of the data for the duration of the streaming process. The isolation level of the transaction determines how changes made by other concurrent transactions affect the data being streamed.

3. **Avoiding LazyInitializationException in Hibernate**:
    - If you're using an ORM like Hibernate with lazy loading, accessing a lazily-loaded collection outside of an active transaction results in `LazyInitializationException`.
    - Streaming a dataset that includes lazily-loaded elements needs an open transaction to ensure that these elements can be loaded as they are accessed during the stream.

4. **Transactional Context for Business Logic**:
    - Streaming data often involves not just reading data but also applying some business logic as the data is processed (e.g., filtering, aggregating).
    - Having this process within a transactional context ensures that all operations - reading and processing - are part of a single unit of work, maintaining data integrity and consistency.

### Example Scenario

Consider an example where you are streaming a large set of records from a database for processing:

```java
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

@Service
public class DataProcessingService {

    private final DataRepository dataRepository;

    public DataProcessingService(DataRepository dataRepository) {
        this.dataRepository = dataRepository;
    }

    @Transactional(readOnly = true)
    public void processDataStream() {
        try (Stream<DataRecord> dataStream = dataRepository.streamAllData()) {
            dataStream.forEach(record -> {
                // Process each record
            });
        }
    }
}
```

In this example, `processDataStream` is annotated with `@Transactional(readOnly = true)`. This ensures that during the entire operation of streaming and processing the data:
- The database cursor remains open.
- A consistent view of the data is maintained.
- Any lazy-loaded elements within each `DataRecord` can be accessed without issues.

By using `@Transactional` in this way, you ensure that the streaming process is reliable, consistent, and free of common pitfalls associated with managing database resources and transactions.
