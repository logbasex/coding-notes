## Replace media domain STAGING to PROD.

### 1. Find all STAGING domain
```shell
db.media.aggregate([
    {
        $match: {cdnOrigin: /staging/}
    },
    {
        $project: {
            domain: {$arrayElemAt: [{$split: ["$cdnOrigin", "/"]}, 2]}
        }
    },
    {
        $group: {
            _id: "$domain"
        }
    },
    {
        $project: {
            _id: 0,
            domain: "$_id"
        }
    }
])
```

```shell
db.media.bulkWrite([
    {
        updateMany: {
            filter: {cdnOrigin: {$regex: "staging.cdn.com"}},
            update: [{
                $set: {
                    cdnOrigin: {
                        $replaceOne: {
                            input: "$cdnOrigin",
                            find: "staging.cdn.com",
                            replacement: "prod.cdn.com"
                        }
                    }
                }
            }]
        }
    },
    {
        updateMany: {
            filter: {cdnLarge: {$regex: "s3.staging.cdn.com"}},
            update: [{
                $set: {
                    cdnLarge: {
                        $replaceOne: {
                            input: "$cdnLarge",
                            find: "s3.staging.cdn.com",
                            replacement: "prod.cdn.com"
                        }
                    }
                }
            }]
        }
    }
])
```

```shell
db.media.updateMany(
  { cdnOrigin: { $regex: "s3.staging.cdn.com" } },
  [{
    $set: { cdnOrigin: {
      $replaceOne: { input: "$cdnOrigin", find: "s3.staging.cdn.com", replacement: "prod.cdn.com" }
    }}
  }]
)
```