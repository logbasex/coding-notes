## Overview

| Query Name     | Functionality                                                                                                                                                            | Example Query   | Matching Text Examples                      | Not Matching Text Examples                                  |
|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------|---------------------------------------------|-------------------------------------------------------------|
                            |
| `match_phrase` | - Only matches if terms are in the same order and contiguous.                                                                                                             | `cat dog`       | - cat dog are green | - dog cat are green<br>- cat and dog are green<br>- green and cat dogs                |

Yes, that's correct. A `match_phrase` query in Elasticsearch will return nothing when you try to use it to match a partial word such as "ca" against a field value like "cat dog". The `match_phrase` query expects to find the exact sequence of words as provided in the query, considering whole words only after they have been analyzed.

### Why Match Phrase Fails in This Case
Here’s why a `match_phrase` query with "ca" would fail against "cat dog":

1. **Whole Words**: `match_phrase` queries do not perform partial matching. They look for exact, whole-word matches in the order specified.
2. **Analyzer Behavior**: Before performing the match, the field's analyzer processes both the input text ("ca") and the text in the field ("cat dog"). Most standard analyzers tokenize on whitespace and may apply transformations like lowercasing, stemming, etc. However, they will treat "ca" as a complete token and look for exactly that token in the indexed data.
3. **Partial Tokens**: Elasticsearch does not support partial token matching with `match_phrase`. If you want to match partial words, you would need to use a query type that supports that behavior, like a `wildcard` or `prefix` query.


## Set up data

```bash
curl -X POST "localhost:9200/match_phrase_query/_doc/1" -H 'Content-Type: application/json' -d'
{
  "description": "cat dog are green"
}'

curl -X POST "localhost:9200/match_phrase_query/_doc/2" -H 'Content-Type: application/json' -d'
{
  "description": "green and cat dogs"
}'

curl -X POST "localhost:9200/match_phrase_query/_doc/3" -H 'Content-Type: application/json' -d'
{
  "description": "dog cat are green"
}'

curl -X POST "localhost:9200/match_phrase_query/_doc/4" -H 'Content-Type: application/json' -d'
{
  "description": "cat and dog are green"
}'
```

## Query

```bash
curl --location --request POST 'http://localhost:9200/match_phrase_query/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
  "query": {
    "match_phrase": {
      "description": "cat dog"
    }
  }
}'
```

## [Slop parameter in Match Phrase query](https://opster.com/guides/elasticsearch/search-apis/elasticsearch-match-phrase-query/)

The Match Phrase Query also supports a `slop` parameter. The `slop` parameter specifies how far apart the terms can be while still considering the document a match. For example, if you set `slop` to 1, the terms can be one position apart.
