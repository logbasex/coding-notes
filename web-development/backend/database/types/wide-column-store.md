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

## Column Family

> The concept of a **column family** in Cassandra (or other wide column stores) is somewhat analogous to a "document" in MongoDB (or other document stores) and a "table" in traditional relational databases, but there are important differences in how they are structured and used.

![https://thehonestcoder.com/choosing-the-right-database/](https://gist.github.com/assets/22516811/681ad20a-d0a7-4da2-a7a1-f9ee18639647)


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
