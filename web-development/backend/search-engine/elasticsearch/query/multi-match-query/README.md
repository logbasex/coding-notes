## Overview

| Query Name | Chức năng                                                             | Query mẫu | Matching Text                                                                     | Not Matching Text            |
| --- |-----------------------------------------------------------------------| --- |-----------------------------------------------------------------------------------|------------------------------|
| multi\_match | \- apply match query trên nhiều field khác nhau | \- field1: dog \- field2: cat | match với field1 chứa dog hoặc field2 chứa cat | \- Nếu cả 2 fields không chứa bất cứ từ liên quan đến dog và cat |

## Set up data

```bash
curl -X POST "localhost:9200/multi_match_query/_doc/1" -H 'Content-Type: application/json' -d'
{
  "description": "The cat is blue. It loves to play with blue toys.",
  "tag": "FR VN2017"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/2" -H 'Content-Type: application/json' -d'
{
  "description": "A friendly dog. The dog is white and loves snow.",
  "tag": "FRVN2017"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/3" -H 'Content-Type: application/json' -d'
{
  "description": "cat and dog living together. They are green pets.",
  "tag": "FR VN-2017"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/4" -H 'Content-Type: application/json' -d'
{
  "description": "This is a big black cat. The cat loves to sleep on a soft pillow.",
  "tag": "US CA2018"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/5" -H 'Content-Type: application/json' -d'
{
  "description": "A tiny kitten playing with its dog friend. They love chasing each other.",
  "tag": "UK LD2019"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/6" -H 'Content-Type: application/json' -d'
{
  "description": "An old cat and a young dog are best friends. They share everything.",
  "tag": "US TX2020"
}'

curl -X POST "localhost:9200/multi_match_query/_doc/7" -H 'Content-Type: application/json' -d'
{
  "description": "The big old dog loves to guard the house and play with cats.",
  "tag": "US NY2021"
}'
```

## Query

```bash
curl --location --request POST 'http://localhost:9200/multi_match_query/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
  "query": {
    "multi_match": {
      "query": "2017",
      "fields": ["description", "tag"]
    }
  }
}'
```