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

- https://geekflare.com/mongodb-queries-examples/
- https://dzone.com/articles/why-mongodb

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
  
- Not like operator
  ```shell
  db.test.find({c: {$not: /ttt/}}
  ```  
  
- [Query String](https://stackoverflow.com/questions/20175122/how-can-i-use-not-like-operator-in-mongodb)


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

- [Update specific value in array](https://stackoverflow.com/questions/48545448/mongodb-replace-specific-array-values)  
    - Using positional paramenter
  ```shell
  db.movies.updateMany(
    { "languages": "French" },  
    { "$set": { "languages.2": "Francais" } }
  )
  ```
  
- [Find document with array that contains a specific value](https://stackoverflow.com/questions/18148166/find-document-with-array-that-contains-a-specific-value)
  ```shell
  db.user.find({"roles.name": {$all: ["ROLE_TALENT"]}}, {roles: 1, _id: 0})
  
  [{"_id": {"$oid": "5fb2518eaeddc725f84232a6"}, "name": "ROLE_TALENT", "version": "1.0", "deleted": false}]
  ```

- [How to select a single field for all documents in a MongoDB collection?](https://stackoverflow.com/questions/25589113/how-to-select-a-single-field-for-all-documents-in-a-mongodb-collection)

  ```shell
  db.user.find({}, {roles: 1, _id: 0}).pretty();
  
  ## data grip
  {}, {roles:1, _id:0}
  ```
## Add a field to collection

https://stackoverflow.com/questions/7714216/add-new-field-to-every-document-in-a-mongodb-collection
```shell
db.yourCollection.updateMany({}, {$set:{"someField": "someValue"}})
```

```shell
db.crawl_api_config.update(query,{$set: {"pageIndex":""}},false,true)
```

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
## System

- [Connection count](https://stackoverflow.com/questions/8975531/check-the-current-number-of-connections-to-mongodb)
  ```shell
  db.currentOp(true).inprog.reduce(
    (accumulator, connection) => {
      ipaddress = connection.client ? connection.client.split(":")[0] : "Internal";
      accumulator[ipaddress] = (accumulator[ipaddress] || 0) + 1;
      accumulator["TOTAL_CONNECTION_COUNT"]++;
      return accumulator;
    },
    { TOTAL_CONNECTION_COUNT: 0 }
  )
  ``` 


## Full-text search
- [MongoDB diacriticInSensitive search not showing all accented (words with diacritic mark) rows as expected and vice-versa](https://stackoverflow.com/questions/43138189/mongodb-diacriticinsensitive-search-not-showing-all-accented-words-with-diacrit)
  - Tìm kiếm dựa vào base character (bỏ dấu)
- [mongoDB prefix wildcard: fulltext-search ($text) find part with search-string](https://stackoverflow.com/questions/24343156/mongodb-prefix-wildcard-fulltext-search-text-find-part-with-search-string)
- [Language stemming](https://stackoverflow.com/questions/21018738/mongodb-fulltext-search-workaround-for-partial-word-match)
  - Stemming is the process of reducing words to their root, base or .. well .. stem.
- [Mongodb match accented characters as underlying character](https://stackoverflow.com/questions/7707671/mongodb-match-accented-characters-as-underlying-character?noredirect=1&lq=1)
- [MongoDB text search partial words](https://sqlserverguides.com/mongodb-text-search-partial-words/)