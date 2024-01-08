## References
- [What is the problem with key-value databases and how wide column stores solve it.](https://medium.com/indexoutofrange/what-is-the-problem-with-key-value-databases-and-how-wide-column-stores-solve-it-5445efbae538)
- [NoSQL Database and its Types](https://medium.com/@cyberdrudge/nosql-database-and-its-types-494162f0305d)
- [Is Cassandra a Column-Oriented or Column-Family Database?](https://www.baeldung.com/cassandra-column-family-data-model)
- [Building Pinterest’s new wide column database using RocksDB](https://medium.com/pinterest-engineering/building-pinterests-new-wide-column-database-using-rocksdb-f5277ee4e3d2)
- [Why Discord Moved from MongoDB to Apache Cassandra, Let us Discuss](https://www.youtube.com/watch?v=86olupkuLlU)

## NoSQL Database and its Types
- Key-value store
- Document store
- Wide column store
- Graph database

---
---

## Column Family

> The concept of a **column family** in Cassandra (or other wide column stores) is somewhat analogous to a "document" in MongoDB (or other document stores) and a "table" in traditional relational databases, but there are important differences in how they are structured and used.

![https://thehonestcoder.com/choosing-the-right-database/](https://gist.github.com/assets/22516811/681ad20a-d0a7-4da2-a7a1-f9ee18639647)

---
---

## Advantage of Wide-Column Store over Document Store
Absolutely, let's delve into a more detailed example using a network of weather stations, expanding the dataset to illustrate the advantage of using a wide column store for time-series data.

### Expanded Scenario: Network of Weather Stations

Suppose we are monitoring 10 weather stations (WS1 to WS10). Each station collects data hourly on four parameters: temperature (°C), humidity (%), wind speed (km/h), and rainfall (mm).

#### Sample Data for a Day (24 hours)

- **Date**: 2023-07-15
- **Stations**: WS1 to WS10

For simplicity, I'll showcase a snippet of data for two stations over a 6-hour period.

#### Data Snippet:

| Time          | WS1 Temp | WS1 Hum | WS1 Wind | WS1 Rain | WS2 Temp | WS2 Hum | WS2 Wind | WS2 Rain | ... |
|---------------|----------|---------|----------|----------|----------|---------|----------|----------|-----|
| 00:00         | 22       | 78      | 10       | 0        | 20       | 80      | 8        | 1        | ... |
| 01:00         | 21       | 80      | 9        | 0        | 19       | 82      | 7        | 2        | ... |
| 02:00         | 21       | 79      | 11       | 0        | 18       | 81      | 9        | 1        | ... |
| 03:00         | 20       | 77      | 10       | 0        | 18       | 79      | 8        | 0        | ... |
| 04:00         | 19       | 75      | 12       | 0        | 17       | 78      | 7        | 0        | ... |
| 05:00         | 19       | 74      | 11       | 0        | 17       | 77      | 6        | 0        | ... |

### Wide Column Store (e.g., Cassandra)

**Data Layout in Cassandra**:

- Each row corresponds to a station and a date.
- Columns are dynamically created for each hour and parameter.

**Example Cassandra Table**:

| Station_Date   | 00:00 Temp | 00:00 Hum | 00:00 Wind | 00:00 Rain | 01:00 Temp | 01:00 Hum | ... |
|----------------|------------|-----------|------------|------------|------------|-----------|-----|
| WS1_2023-07-15 | 22         | 78        | 10         | 0          | 21         | 80        | ... |
| WS2_2023-07-15 | 20         | 80        | 8          | 1          | 19         | 82        | ... |
| ...            | ...        | ...       | ...        | ...        | ...        | ...       | ... |

**Advantages in this Layout**:

1. **Efficient Time-Range Queries**: Easy to run queries on a specific time range for a station or across stations.
2. **Scalability for High-Volume Writes**: Each hourly data entry is a new column, making the write process efficient even with massive data influx.
3. **Data Compression**: Similar data types across columns (like temperature) can be compressed effectively.

---
---

## Advantage of Wide-Column Store over Column/Row Store

To illustrate the advantages of a wide column store over a traditional column/row (relational) store, let's use a detailed example involving a retail chain's sales data.

### Scenario: Retail Chain Sales Data

Imagine a retail chain that operates multiple stores across the country. They need to track sales data, including product ID, store ID, sales amount, and date of sale.

#### Sample Data for a Single Day

Let's consider data for three stores (Store1, Store2, Store3) on a specific date (2023-07-15), selling various products.

#### Data Snippet:

| Store ID | Product ID | Sales Amount | Date       |
|----------|------------|--------------|------------|
| Store1   | Prod1      | $500         | 2023-07-15 |
| Store1   | Prod2      | $300         | 2023-07-15 |
| Store2   | Prod1      | $450         | 2023-07-15 |
| Store2   | Prod3      | $700         | 2023-07-15 |
| Store3   | Prod2      | $350         | 2023-07-15 |
| Store3   | Prod3      | $500         | 2023-07-15 |
| ...      | ...        | ...          | ...        |

### Wide Column Store (e.g., Cassandra)

In a wide column store, the data can be structured more efficiently:

- **Row Key**: Store ID and Date
- **Columns**: Each column represents a product, with the sales amount as its value.

**Example Data Layout in Cassandra**:

| Store_Date     | Prod1   | Prod2   | Prod3   | ... |
|----------------|---------|---------|---------|-----|
| Store1_2023-07-15 | $500    | $300    | NULL    | ... |
| Store2_2023-07-15 | $450    | NULL    | $700    | ... |
| Store3_2023-07-15 | NULL    | $350    | $500    | ... |
| ...            | ...     | ...     | ...     | ... |

**Advantages**:
1. **Efficient Storage**: Only stores the data that exists (sparse storage). If a product wasn't sold in a store on that day, the column simply doesn't exist for that row.
2. **Fast Queries for Specific Patterns**: Efficient for queries like "total sales per product for a given store on a particular day."
3. **Scalability**: Easily handles large datasets, adding more stores, products, or dates without significantly impacting performance.

### Traditional Column/Row Store (e.g., MySQL)

In a relational database, the data is stored in rows in a table:

**Example MySQL Table**:

| Store ID | Product ID | Sales Amount | Date       |
|----------|------------|--------------|------------|
| Store1   | Prod1      | $500         | 2023-07-15 |
| Store1   | Prod2      | $300         | 2023-07-15 |
| Store2   | Prod1      | $450         | 2023-07-15 |
| Store2   | Prod3      | $700         | 2023-07-15 |
| Store3   | Prod2      | $350         | 2023-07-15 |
| Store3   | Prod3      | $500         | 2023-07-15 |
| ...      | ...        | ...          | ...        |

**Challenges**:
1. **Storage Efficiency**: Each sale is a row, regardless of how many products a store sells. This can lead to large tables with many rows.
2. **Query Overhead**: Queries involving multiple joins (e.g., summing sales across stores) can be slower, especially as data grows.
3. **Scalability**: Handling very large datasets (millions of sales entries) may require more complex scaling solutions.

### Conclusion

In this retail sales scenario, a wide column store like Cassandra offers significant advantages:

- **Storage Efficiency**: Reduces storage space by not storing null values.
- **Query Performance**: Optimized for read/write operations on large-scale datasets, especially where the access pattern is predictable (like summing sales for specific products).
- **Scalability and Flexibility**: Easily scales to accommodate increasing data, and it's more flexible in handling a varying number of products per store.

While traditional relational databases are powerful for many applications, particularly those requiring complex joins and transactions, wide column stores demonstrate clear advantages in scenarios involving large-scale, sparse datasets where the access patterns are more straightforward and scalability is a key concern.

---
---

### Document Store (e.g., MongoDB)

**Data Layout in MongoDB**:

- Each document represents a single hourly reading for a station.

**Example MongoDB Document**:

```json
{
  "station_id": "WS1",
  "timestamp": "2023-07-15T00:00:00Z",
  "temperature": 22,
  "humidity": 78,
  "wind_speed": 10,
  "rainfall": 0
}
```

**Challenges in this Layout**:

1. **Querying Over Time Ranges**: To analyze data over a time range, each document must be retrieved and processed, which can be less efficient.
2. **Document Size**: As the data grows, the size of each document increases, potentially impacting performance.

### Conclusion

In the detailed weather station scenario, a wide column store like Cassandra offers significant advantages for time-series data:

- **Performance**: Efficient handling of large-scale, write-intensive operations.
- **Query Efficiency**: Faster and more efficient for time-range queries.
- **Scalability**: Better suited to handle massive and growing datasets typical in time-series scenarios.

While document stores provide flexibility and ease of use for certain data types, for high-volume, time-series data, wide column stores demonstrate clear performance and scalability benefits.

## Wide Columns Database

![image](https://gist.github.com/assets/22516811/a5fa6066-5472-40b2-9177-ebd762ad85c4)

---
---

![image](https://gist.github.com/assets/22516811/5e860bab-ae6c-4a21-a6af-7e3cb4d6f283)

---
---

![image](https://gist.github.com/assets/22516811/38826baa-8a08-4a6b-b2a5-9a6ac52c4181)

Figure 2: Logical view of a wide column database. The key point to observe here is that the database is schemaless, and each row need not contain all columns. All names, addresses, phone numbers are illustrative/not real.

---
---

![https://www.alibabacloud.com/blog/table-store-data-models---wide-column-and-time-series_594155](https://gist.github.com/assets/22516811/f4b2560a-ab26-4183-9be0-d8fbdb594321)
