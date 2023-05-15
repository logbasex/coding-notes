## Tutorial
- https://www.practical-mongodb-aggregations.com/

## Syntax

### Lookup & pipeline

(ChatGPT mongodb match inside lookup syntax)

You can use the `$match` stage inside a `$lookup` pipeline to filter the documents from the joined collection based on a condition. The syntax for using `$match` inside a `$lookup` pipeline is as follows:

```json5
{
  $lookup: {
    from: "joined_collection",
    let: { localField: "$localField" },
    pipeline: [
      { $match:
        { $expr:
          { $and:
            [
              { $eq: [ "$joinedField", "$$localField" ] },
              { $gte: [ "$someField", 10 ] }
            ]
          }
        }
      }
    ],
    as: "joined_docs"
  }
}
```

In this example, the `$lookup` stage is used to join the current collection with the `joined_collection`. The `let` variable `localField` is defined with the value of the local field that is used for the join. The `$match` stage is used inside the `pipeline` option of the `$lookup` stage to filter the documents from the `joined_collection`. In this case, the documents are filtered based on two conditions: `joinedField` must match the value of `localField`, and `someField` must be greater than or equal to 10. Finally, the resulting documents are stored in the `joined_docs` field.

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

### [Project first element in an array](https://stackoverflow.com/questions/39196537/project-first-item-in-an-array-to-new-field-mongodb-aggregation)

![image](https://user-images.githubusercontent.com/22516811/200485136-a07bb777-e284-4b4a-9006-8228adfbbbbe.png)

```shell
{
  _id: 0,
  location: { $first: "$eventObj.location" }
}
```
### [$replaceRoot vs $unwind](https://stackoverflow.com/questions/64968829/mongodb-aggregation-project-the-specific-fields-from-lookup)

- https://mongoplayground.net/p/_3mNnNtsFet

```spring-mongodb-json
db={
  "orders": [
    {
      "_id": 1,
      "itemId": "111",
      "price": 12,
      "quantity": 2
    },
    {
      "_id": 2,
      "itemId": "222",
      "price": 20,
      "quantity": 1
    }
  ],
  "items": [
    {
      "_id": 111,
      "item": "almonds",
      "description": "almond clusters",
      "instock": 120
    },
    {
      "_id": 155,
      "item": "bread",
      "description": "raisin and nut bread",
      "instock": 80
    },
    {
      "_id": 222,
      "item": "pecans",
      "description": "candied pecans",
      "instock": 60
    }
  ]
}
```

**$replaceRoot**

```spring-mongodb-json
db.orders.aggregate([
  {
    $lookup: {
      from: "items",
      let: {
        itemId: {
          $convert: {
            input: "$itemId",
            to: "int"
          }
        }
      },
      pipeline: [
        {
          $match: {
            $expr: {
              $eq: [
                "$_id",
                "$$itemId"
              ]
            }
          }
        }
      ],
      // field in the items collection
      as: "fromItems"
    }
  },
  {
    $replaceRoot: {
      newRoot: {
        $mergeObjects: [
          {
            $arrayElemAt: [
              "$fromItems",
              0
            ]
          },
          "$$ROOT"
        ]
      }
    }
  },
  {
    $project: {
      _id: 1,
      description: 1,
      price: 1,
      quantity: 1
    }
  }
])
```

-------

https://mongoplayground.net/p/wK0hKVrwmIK

![image](https://user-images.githubusercontent.com/22516811/206153622-01ac17a8-8ec7-44ff-b6e9-94e74dc85b22.png)

-------
https://mongoplayground.net/p/8__hXTjL2hf

![https://stackoverflow.com/questions/66625887/using-replaceroot-in-mongodb](https://user-images.githubusercontent.com/22516811/206216071-df092e22-eb4f-491e-a6a7-61e3b6c6da32.png)

-------
https://mongoplayground.net/p/4bO7_UCte42

https://stackoverflow.com/questions/71211274/mongodb-aggregate-unwind-and-keep-roots-as-seperate-documents

![image](https://user-images.githubusercontent.com/22516811/206218772-1e8fbdec-874c-4b3d-a3e0-733f4aaed724.png)


### Match, Join by _id and Project field

Document **crawl_item**:

```shell
{
  "_id": {
    "$oid": "6369caa91a58967d79289e4f"
  },
  "contentType": "Event",
  "eventType": "Sport",
  "leagueName": "LMB",
  "sportName": "Baseball",
  "externalId": "http://api.stats.com-2446195",
  "processed": true,
  "season": 2022,
  "seasonPeriod": "Regular Season",
  "country": "Mexico",
  "city": "Tijuana",
  "statusString": "Final",
  "source": "http://api.stats.com",
  "version": "1.0",
}
```

Document **event**:
```shell
{
  "_id": {
    "$oid": "6369cab81a58967d7928a294"
  },
  "rawTitle": "torostijuanadiablosrojosmexicocity",
  "eventMode": 0,
  "eventType": "Sport",
  "resultType": 1,
  "crawlEventStatus": "Final",
  "sportName": "Baseball",
  "seasonPeriod": "Regular Season",
  "leagueName": "LMB",
  "location": "Mexico, Tijuana, Estadio Chevron",
  "title": "Toros Tijuana - Diablos Rojos Mexico City",
  "crawlItemId": "6369caa91a58967d79289e4f",
  "contentType": "Result",
  "status": 1,
}
```

Bài toán ở đây là dựa vào **eventId** từ hệ thống bên ngoài (**externalId** trong collection **crawl_item**) để lấy ra trường **location** bên trong collection **event**.

![image](https://user-images.githubusercontent.com/22516811/200486367-4b632a08-afdc-4ff0-b7d6-484173c59139.png)

![image](https://user-images.githubusercontent.com/22516811/200486550-7a37921c-4c90-4fd9-b7bf-0d235540a679.png)

![image](https://user-images.githubusercontent.com/22516811/200486636-3f931ee4-4de1-4d0a-8899-24c873830b5c.png)

```json5
[
    {
    $match: {
        $expr: {
            $and: [
                    {
                $regexMatch: {
                    input: '$externalId',
                    regex: '2446195'
                        }
                    }
                ]
            }
        }
    },
    {
    $lookup: {
        let: {
            crawlItemObjId: {
                $toString: '$_id'
                }
            },
        from: 'event',
        pipeline: [
                {
                $match: {
                    $expr: {
                        $eq: [
                            '$crawlItemId',
                            '$$crawlItemObjId'
                            ]
                        }
                    }
                },
                {
                $project: {
                    _id: 0,
                    location: 1
                    }
                }
            ],
        as: 'eventObj'
        }
    },
    {
    $project: {
        _id: 0,
        location: {
            $first: '$eventObj.location'
            }
        }
    }
]
```

## Spring mongodb

### Example 1
Given document `user_setting` with list of subscriptions (talents), let query active subscriptions only and order by position, and return more data about each subscription (`defaultLogoId` field store in collection `user_setting`, `name` field in collection `talent`).

Document `user_setting`

```json
{
  "_id": {
    "$oid": "63888b964366ba202995d897"
  },
  "userId": "63888b964366ba202995d896",
  "subscriptions": [
    {
      "userId": "6040b93008dcaa1aef2d6cfe",
      "active": true,
      "position": 0
    },
    {
      "userId": "6040b92f08dcaa1aef2d6cfa",
      "active": true,
      "position": 1
    },
    {
      "userId": "62c826f19c02eb53b726e8af",
      "active": false
    }
  ],
  "_class": "social.eko.entities.entity.UserSetting"
}
```

```spring-mongodb-json
db.user_setting.aggregate([
    {
        $unwind:"$subscriptions"
    },
    {
        $match: {
            "userId": "63888b964366ba202995d896",
            "subscriptions.active": true
        }
    },
    {
        $lookup: {
            from: "talent",
            localField: "subscriptions.userId",
            foreignField: "userId",
            as: "t"
        }
    },
    {
        $unwind:"$t"
    },
    {
        $project: {
            name: "$t.name",

            userId: "$t.userId",
            position: "$subscriptions.position"
        }
    },
    {
        $lookup: {
            from: "user_setting",
            localField: "userId",
            foreignField: "userId",
            as: "u"
        }
    },
    {
        $unwind:"$u"
    },
    {
        $project: {
            defaultLogoId: "$u.defaultLogoId",
            name: 1,
            userId: 1,
            position: 1
        }
    }
])
```

Code

```java
public class SpringMongodb {
	
  UnwindOperation unwindSubscriptions = Aggregation.unwind(FieldConst.SUBSCRIPTIONS);
  MatchOperation subscriptionMatch = Aggregation.match(
          Criteria
                  .where(FieldConst.USER_ID)
                  .is(userId)
                  .and(FieldConst.SUBSCRIPTION_ACTIVE)
                  .is(true)
  );

  AggregationOperation subscriptionTalentLookup = Aggregation.lookup(
          CollectionConst.TALENT,
          FieldConst.SUBSCRIPTION_USER_ID,
          FieldConst.USER_ID,
          "subscription_talent"
  );
  UnwindOperation unwindSubscriptionTalent = Aggregation.unwind("subscription_talent");

  ProjectionOperation talentNameProjection = Aggregation
          .project()
          .and("$subscription_talent.name")
          .as(FieldConst.NAME)
          .and("$subscription_talent.userId")
          .as(FieldConst.USER_ID)
          .and("$subscriptions.position")
          .as(FieldConst.POSITION);

  AggregationOperation subscriptionUserSettingLookup = Aggregation.lookup(
          CollectionConst.USER_SETTING,
          FieldConst.USER_ID,
          FieldConst.USER_ID,
          "subscription_user_setting"
  );
  UnwindOperation unwindSubscriptionUserSetting = Aggregation.unwind("subscription_user_setting");

  ProjectionOperation defaultLogoIdProjection = Aggregation
          .project(FieldConst.NAME, FieldConst.USER_ID, FieldConst.POSITION)
          .and("$subscription_user_setting.defaultLogoId")
          .as(FieldConst.DEFAULT_LOGO_ID);

  SortOperation sortByPosition = Aggregation.sort(Sort.Direction.ASC, FieldConst.POSITION);

  Aggregation agr = Aggregation.newAggregation(
          unwindSubscriptions,
          subscriptionMatch,
          subscriptionTalentLookup,
          unwindSubscriptionTalent,
          talentNameProjection,
          subscriptionUserSettingLookup,
          unwindSubscriptionUserSetting,
          defaultLogoIdProjection,
          sortByPosition,
          Aggregation.skip((long) pageable.getPageNumber() * pageable.getPageSize()),
          Aggregation.limit(pageable.getPageSize())
  );
}
```

### Example 2

- https://stackoverflow.com/questions/62479752/spring-data-mongodb-aggregation-rename-id-in-projection