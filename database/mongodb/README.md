## Shutdown

1. log in to mongo shell
2. use admin
3. db.shutdownServer()

## index
https://viblo.asia/p/tim-hieu-ve-index-trong-mongodb-924lJL4WKPM

## Docs
- https://mongodb.github.io/mongo-csharp-driver/2.9/reference/driver/expressions/#bitsanyset
```shell
Find(p => (p.PermissionFlags & 7) != 0);

{ PermissionFlags: { $bitsAnySet: 7 } }
```

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
- Query multi value
    ```shell script
    {_id: {$in: [ObjectId('604ee9e4473d470b0b044fcf'), ObjectId('604ae4683ab8ed7d865ccc3c')]}}
    ```
  
- Update field in document
    ```shell script
    db.user.update( { _id: ObjectId("5fbf730aec9b315423fd65c8")} , { $set: { city: "logbasex appp" } } );
    ```  
- Query unicode character with regex
    - https://docs.mongodb.com/manual/reference/operator/query/regex/
    - https://www.regular-expressions.info/unicode.html
    ```shell script
    {$and: [{displayName: /Madeline\x{00A0}K\x{00A0}Ramsbotham/}]}
    ```
- Query nested array and object
  ```json
  {
   "_id":"12345",
   "value": {
      "T":0,
      "v": [
             {
                "name":"JW",
                "cost":100
             }
         ]
      }
  }
  
  db.collection.find({ "value.v.name": "JW" })
  ```
  

- Delete multi documents
  ```shell
  db.users.deleteMany({name: {$in: ["viki", "vino", "naranyamoorthy"]}})
  ```
  
- Delete all documents in a collection
    ```shell script
      db.users.deleteMany({})
    ```  
- [Update many in mongodb](https://stackoverflow.com/questions/9038547/mongodb-update-every-document-on-one-field)
    ```shell
    db.foo.updateMany( {}, <update> )
    db.foo.updateMany( {}, {  $set: { lastLookedAt: Date.now() / 1000 }  })
    ```
  
## Add a field to collection

https://stackoverflow.com/questions/7714216/add-new-field-to-every-document-in-a-mongodb-collection

```shell
db.crawl_api_config.update(query,{$set: {"pageIndex":""}},false,true)
```