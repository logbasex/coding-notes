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