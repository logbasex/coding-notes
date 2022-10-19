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
  ```
  {results: {$gt: {$size: 1}}}
  ```

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
  
- Distinct by condition
  ```shell
   db.event.distinct("results.name", {leagueName: 'LMB'})
  ```
  
## Delete

- [Delete by date greater than equal](https://stackoverflow.com/questions/22422178/mongodb-remove-all-dates-less-than-specified)
  ```shell
  db.user.deleteMany({createdDate: {$gte: new Date("2022-08-01")}})
  ```

## Add a field to collection

- https://stackoverflow.com/questions/7714216/add-new-field-to-every-document-in-a-mongodb-collection
  ```shell
  db.yourCollection.updateMany({}, {$set:{"someField": "someValue", "someField": "someValue"}})
  ```
  
  ```shell
  db.crawl_api_config.update(query,{$set: {"pageIndex":""}},false,true)
  ```

## Remove field from document
- https://stackoverflow.com/questions/6851933/how-to-remove-a-field-completely-from-a-mongodb-document
  ```shell
  db.crawl_item.updateMany({sportName: "Tennis"},{"$unset":{"title": 1, "rawTitle": 1}})
  ```

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
- [Size](https://stackoverflow.com/questions/6082748/does-the-mongodb-stats-function-return-bits-or-bytes)
  ```shell
  db.stats()                in Bytes
  db.stats(1024)            in KB
  db.stats(1024*1024)       in MB
  db.stats(1024*1024*1024)  in GB
  ```
  ```shell
  # https://gist.github.com/joeyAghion/6511184
  var stats = [];

  db.getCollectionNames().forEach(function (n) {
  stats.push(db[n].stats());
  });
  
  stats = stats.sort(function (a, b) {
  return b['size'] - a['size']
  });
  
  for (var c in stats) {
  // skip views
  if (!stats[c]["ns"]) continue;
  print(stats[c]["ns"] + ": " + stats[c]["size"] + " (" + (stats[c]["storageSize"] / 1073741824).toFixed(3) + "GB)");
  }
  ```

## Full-text search
- [MongoDB diacriticInSensitive search not showing all accented (words with diacritic mark) rows as expected and vice-versa](https://stackoverflow.com/questions/43138189/mongodb-diacriticinsensitive-search-not-showing-all-accented-words-with-diacrit)
  - Tìm kiếm dựa vào base character (bỏ dấu)
- [mongoDB prefix wildcard: fulltext-search ($text) find part with search-string](https://stackoverflow.com/questions/24343156/mongodb-prefix-wildcard-fulltext-search-text-find-part-with-search-string)
- [Language stemming](https://stackoverflow.com/questions/21018738/mongodb-fulltext-search-workaround-for-partial-word-match)
  - Stemming is the process of reducing words to their root, base or .. well .. stem.
- [Mongodb match accented characters as underlying character](https://stackoverflow.com/questions/7707671/mongodb-match-accented-characters-as-underlying-character?noredirect=1&lq=1)
- [MongoDB text search partial words](https://sqlserverguides.com/mongodb-text-search-partial-words/)