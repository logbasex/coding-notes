## Overview

| Query Name | Chức năng                                                                                                                                                                                                       | Query mẫu | Matching Text                                                                     | Not Matching Text            |
| --- |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| --- |-----------------------------------------------------------------------------------|------------------------------|
| match | \- Matches nếu 1 term trong query đó match<br> \- Càng nhiều term match thì score của document đó sẽ lớn<br> \- Query search sẽ được apply analyzer config cho field search đó hoặc để mặc định (nếu không set) | cat dog | \- cat and dog<br> \- The blue cat \- The cat is blue<br> \- The dog is white<br> | \- The blue<br> \- The white |

## Set up data

```bash
curl -X POST "localhost:9200/match_query/_doc/1" -H 'Content-Type: application/json' -d'
{
  "description": "cat and dog",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/match_query/_doc/2" -H 'Content-Type: application/json' -d'
{
  "description": "The blue cat",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/match_query/_doc/3" -H 'Content-Type: application/json' -d'
{
  "description": "The cat is blue",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/match_query/_doc/4" -H 'Content-Type: application/json' -d'
{
  "description": "The cat is white",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/match_query/_doc/5" -H 'Content-Type: application/json' -d'
{
  "description": "The blue",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/match_query/_doc/6" -H 'Content-Type: application/json' -d'
{
  "description": "The white"
}'
```

## Match Query

```bash
curl --location --request POST 'http://localhost:9200/match_query/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
  "query": {
    "match": {
      "description": "cat dog"
    }
  }
}'
```