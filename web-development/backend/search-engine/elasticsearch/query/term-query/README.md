## Overview

| Query Name | Chức năng                                                             | Query mẫu | Matching Text                                                                     | Not Matching Text            |
| --- |-----------------------------------------------------------------------| --- |-----------------------------------------------------------------------------------|------------------------------|
| term | \- Query trên truy vấn mình truyền vào, analyzer sẽ không được apply | dog | \- this is a dog                                                                  | \- there are many dogs here<br> \- Dog is green                                                                 |

## Set up data

```bash
curl -X POST "localhost:9200/term_query/_doc/1" -H 'Content-Type: application/json' -d'
{
  "description": "this is a dog"
}'

curl -X POST "localhost:9200/term_query/_doc/2" -H 'Content-Type: application/json' -d'
{
  "description": "there are many dogs here"
}'

curl -X POST "localhost:9200/term_query/_doc/3" -H 'Content-Type: application/json' -d'
{
  "description": "Dog is green"
}'
```

## Query

```bash
curl --location --request POST 'http://localhost:9200/term_query/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
    "query": {
        "term": {
            "description": {
                "value": "dog"
            }
        }
    }
}'
```