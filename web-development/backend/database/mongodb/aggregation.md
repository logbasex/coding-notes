## Tutorial
- https://www.practical-mongodb-aggregations.com/
## Aggregation
- https://viblo.asia/p/tim-hieu-ve-aggregation-framework-trong-mongodb-Az45brRV5xY
- https://www.baeldung.com/java-mongodb-aggregations

- [Mongo group and push: pushing all fields](https://stackoverflow.com/questions/22150205/mongo-group-and-push-pushing-all-fields)
  ```shell
  { $group : {
            _id : "$author",
            books: { $push : "$$ROOT" }
        }}
  ```
- [Find duplicate records in MongoDB](https://stackoverflow.com/questions/26984799/find-duplicate-records-in-mongodb)
- ![image](https://user-images.githubusercontent.com/22516811/177312842-b7e2feaf-b51d-4f96-b94b-6ae8cf6058c5.png)
