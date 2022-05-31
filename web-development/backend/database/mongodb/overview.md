[Is MongoDB disk based?](https://stackoverflow.com/questions/9442883/is-mongodb-disk-based)

[Redis vs. MongoDB: Comparing In-Memory Databases with Percona Memory Engine](https://scalegrid.io/blog/comparing-in-memory-databases-redis-vs-mongodb-percona-memory-engine/)

## The maximum BSON document size is 16 megabytes
![https://studio3t.com/wp-content/uploads/2020/09/mongodb-vs-sql-1.png](https://user-images.githubusercontent.com/22516811/171187337-f5cf9291-af24-412c-a3b9-449f8da037fb.png)

## Json vs Bson (Binary Json - Javascript object notation)
https://www.baeldung.com/mongodb-bson
https://dev.to/abetavarez/json-vs-bson-2f6b

Why mongodb using BSON instead of JSON?
Because Json has only six data types:
![image](https://user-images.githubusercontent.com/22516811/171200984-4434fcf7-809d-4991-982a-3f2033b71dcc.png)

That isn't enough for store data like date...
Manipulate, query using criteria is hard and slow. 

BSON provides several advantages over using regular JSON:
- **Compact**: In most cases, storing a BSON structure requires less space than its JSON equivalent
- **Data Types**: BSON provides additional data types not found in regular JSON, such as Date and BinData
- One of the main benefits of using BSON is that it's **easy to traverse**. BSON documents contain additional metadata that allow for easy manipulation of the fields of a document, without having to read the entire document itself.

![https://jahangir-devs.medium.com/mongodb-part-2-understanding-the-basics-crud-operations-ed4863846eff](https://user-images.githubusercontent.com/22516811/171202673-2d8e7c87-9d7a-4270-8a28-2cef0ba31bed.png)

https://www.mongodb.com/basics/bson

