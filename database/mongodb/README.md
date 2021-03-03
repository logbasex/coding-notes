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
  
  
    {talents: {$size: 1}}           # mongodb compass 
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