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

### [Project first element in an array](https://stackoverflow.com/questions/39196537/project-first-item-in-an-array-to-new-field-mongodb-aggregation)

![image](https://user-images.githubusercontent.com/22516811/200485136-a07bb777-e284-4b4a-9006-8228adfbbbbe.png)

```shell
{
  _id: 0,
  location: { $first: "$eventObj.location" }
}
```

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