## [Filter](https://gist.github.com/ipbastola/2c955d8bf2e96f9b1077b15f995bdae3)

JQ to filter JSON by value
Syntax: <strong>`cat <filename> | jq -c '.[] | select( .<key> | contains("<value>"))'`</strong>

Example: To get json record having _id equal 611
```bash
cat my.json | jq -c '.[] | select( ._id | contains(611))'
```
Remember: if JSON value has no double quotes (eg. for numeric) to do not supply in filter i.e. in `contains(611)`

## Get first, last element
- https://stackoverflow.com/a/45911762/10393067
```shell script
curl https://selenium-release.storage.googleapis.com | xq | jq 'last(.ListBucketResult|.Contents|.[]|.Key| select(test(".*selenium-server-standalone.*.jar")))
```

## [How to iterate through keys of different names](https://stackoverflow.com/questions/35086391/jq-how-to-iterate-through-keys-of-different-names)

- https://jqplay.org/s/dhVVmNrq0h2

```json
{
  "leaderBoard": {
    "people": {
      "person": {
        "41": {
          "id": "f27fl5vv05p9259gz2oonuoyx",
          "matchName": "Si Woo Kim",
          "firstName": "Si Woo",
          "lastName": "Kim",
          "gender": "Male",
          "nationalityId": "4vzpxtqkiwx0puygnmayr74di",
          "nationality": "Korea Republic",
          "madeCut": "Yes",
          "position": 1,
          "score": -18,
          "holesPlayed": 72,
          "strokes": 262
        },
        "42": {
          "id": "f27fl5vv05p9259gz2oonuoyx",
          "matchName": "Si Woo Kimm",
          "firstName": "Si Woo",
          "lastName": "Kim",
          "gender": "Male",
          "nationalityId": "4vzpxtqkiwx0puygnmayr74di",
          "nationality": "Korea Republic",
          "madeCut": "Yes",
          "position": 1,
          "score": -18,
          "holesPlayed": 72,
          "strokes": 262
        }
      }
    }
  }
}
```

> .leaderBoard.people.person | to_entries | .[].value.matchName

## Remove double quote
```shell script
--raw-ouput
jq -r '.[].name'
```

## Cheatsheet

- https://gist.github.com/olih/f7437fb6962fb3ee9fe95bda8d2c8fa4
- https://stedolan.github.io/jq/manual/
- https://hyperpolyglot.org/json