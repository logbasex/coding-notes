## Overview

| Query Name | Chức năng                                                             | Query mẫu | Matching Text                                                                     | Not Matching Text            |
| --- |-----------------------------------------------------------------------| --- |-----------------------------------------------------------------------------------|------------------------------|
| prefix | Nó tương tự như `match_phrase` query nhưng nó sẽ match chính xác term | FR VN | \- FR VN2017<br> \- FR VN-2017<br>                                                | \- FRVN2017<br> \- FRVN-2017                                                                                    |

## Set up data

```bash
curl -X POST "localhost:9200/prefix_query/_doc/1" -H 'Content-Type: application/json' -d'
{
  "description": "FR VN2017"
}'

curl -X POST "localhost:9200/prefix_query/_doc/2" -H 'Content-Type: application/json' -d'
{
  "description": "FR VN-2017"
}'

curl -X POST "localhost:9200/prefix_query/_doc/3" -H 'Content-Type: application/json' -d'
{
  "description": "FRVN2017"
}'

curl -X POST "localhost:9200/prefix_query/_doc/4" -H 'Content-Type: application/json' -d'
{
  "description": "FRVN-2017"
}'
```

## Query

```bash
curl --location --request POST 'http://localhost:9200/prefix_query/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
    "query": {
        "prefix": {
            "description.keyword": {
                "value": "FR VN"
            }
        }
    }
}'
```