## Shutdown

1. log in to mongo shell
2. use admin
3. db.shutdownServer()

## index
https://viblo.asia/p/tim-hieu-ve-index-trong-mongodb-924lJL4WKPM


## query
https://docs.mongodb.com/guides/server/introduction/
https://docs.mongodb.com/manual/reference/method/db.collection.deleteMany/

- [Query based on sub-collection size](https://docs.mongodb.com/manual/reference/operator/query/size/)
    ```shell
    db.users.find({                   # mongo shell
      "talents" : {$size: 1}
    }).pretty();      
  
  
    {talents: {$size: 1}}             # mongodb compass 
    ```
- [Query specific field in array](https://stackoverflow.com/questions/3985214/retrieve-only-the-queried-element-in-an-object-array-in-mongodb-collection)  
    ```shell
    {"talents.name": /Logbasex/}      # wrap with quotes        
    ```
- Query date between
  ```shell
    {$and: [{contentType: "Event"}, {start:  {$gt: ISODate("2021-03-08T00:00:00.000Z"), $lt: ISODate("2021-03-09T00:00:00.000Z")}}]}
    ``` 
- [Query document where array size > 1](https://stackoverflow.com/questions/7811163/query-for-documents-where-array-size-is-greater-than-1)  

- Query null/non-null
  ```shell script
    {name: {$ne: null}}             # not equal
    {name: {$exits: true}}
    
    {name: {$eq: null}}             # equal
    {name: {$exits: false}}
  ```

- Delete multi documents
  ```shell
  db.users.deleteMany({name: {$in: ["viki", "vino", "naranyamoorthy"]}})
  ```

## Add a field to collection

https://stackoverflow.com/questions/7714216/add-new-field-to-every-document-in-a-mongodb-collection

```shell
db.crawl_api_config.update(query,{$set: {"pageIndex":""}},false,true)
```