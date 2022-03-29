## Performance

- [Check RAM limit](https://developerslogblog.wordpress.com/2019/11/27/mongodb-sort-how-to-fix-maximum-ram-exceeded-error/)
  ```shell
  db.adminCommand( { getParameter : 1, "internalQueryExecMaxBlockingSortBytes" : 1 } )
  ``` 

- [Sort and Indexes](https://pavneetkaur27.medium.com/mongodb-best-practices-for-performing-sorting-e7001f1f503f)
  ```shell
  /* Creating compound index on fields 
    a: ascending order, 
    b: descending order,
    c: ascending order
  */
  
  db.getCollection('people').createIndex({a: 1, b: -1, c: 1})
  This index works for below queries:-
  
  // forward direction sort with prefix
  
  db.getCollection('people').find({}).sort({a: 1})
  db.getCollection('people').find({}).sort({a: 1, b: -1})
  db.getCollection('people').find({}).sort({a: 1, b: -1, c: 1})
  
  // backward direction sort
  
  db.getCollection('people').find({}).sort({a: -1})
  db.getCollection('people').find({}).sort({a: -1, b: 1})
  db.getCollection('people').find({}).sort({a: -1, b: 1, c: -1})
  
  Doesn't work for below queries:-
  
  db.getCollection('people').find({}).sort({b: -1})
  db.getCollection('people').find({}).sort({b: 1})
  db.getCollection('people').find({}).sort({c: 1})
  db.getCollection('people').find({}).sort({b: -1, a: 1})
  db.getCollection('people').find({}).sort({b: -1, c: 1}) db.getCollection('people').find({}).sort({c: -1, b: 1, a: -1})
  ```
- https://tuyendoan.medium.com/mongodb-best-practice-10c35ce71210
- [How to Speed-Up MongoDB Regex Queries by a Factor of up-to 10](https://medium0.com/statuscode/how-to-speed-up-mongodb-regex-queries-by-a-factor-of-up-to-10-73995435c606)
    - Regex and text index

## Sorting and Ordering

[Ordering vs Sorting with Hibernate – What should you use?](https://thorben-janssen.com/ordering-vs-sorting-hibernate-use/#Ordering)

- **Sorting** happens within your Java application using a Comparable or Comparator implementation.

- **Ordering** adds an ORDER BY clause to the database query so that the database performs the tasks. **That is the preferable approach because databases are highly optimized for these kinds of operations and handle them more efficiently than your Java code**.

[Sort hibernate collection when retrieving from database](https://stackoverflow.com/questions/5081349/sort-hibernate-collection-when-retrieving-from-database)

[What's the difference between ordering and sorting?](https://stackoverflow.com/a/17247525/10393067)