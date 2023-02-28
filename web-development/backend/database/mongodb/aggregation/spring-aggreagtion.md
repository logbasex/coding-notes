## @Aggregation annotation and debug
```java
// aggregation addFields $toString '$_id' auto convert to _id.
// logging.level.org.springframework.data.mongodb.core.MongoTemplate=DEBUG
@Aggregation(pipeline = {
        "{ '$addFields': { '_id': { $toString: '$_id' }}}",
        "{ '$lookup': { from: 'talent', localField: '_id', foreignField: 'userId', as: 't'} }",
        "{ '$match': {\"t.status\": 1, \"t.spotifyId\": {'$exists': true}, userId: {$in: ?0} } }"
})
```