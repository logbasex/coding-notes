## [Elasticsearch: The Definitive Guide](https://feliperohdee.gitbooks.io/elastic-search-definitive-guide/content/010_Intro/25_Tutorial_Indexing.html)

- apache lucene
  https://kipalog.kaopiz.com/posts/Lucene
  
- There is no efficient way to perform infix searches in SQL Server, neither using LIKE on an indexed column, or with a fulltext index.

You have to understand how index is working. Index is the very same like the dead-wood edition of encyclopedia.

If you use:

    SELECT * from customer where name like username%

The index, in fulltext or no fulltext should work. but

    SELECT * from customer where name like %username%

will never work with index. and it will be time-consuming query.

https://stackoverflow.com/questions/4194485/full-text-search-vs-like


# concept
https://www.quora.com/What-are-nodes-shards-and-clusters-in-elastic-search

https://logz.io/blog/10-elasticsearch-concepts/

https://logz.io/blog/managing-elasticsearch-indices/

- [static data and time series data](https://blog.softwaremill.com/6-not-so-obvious-things-about-elasticsearch-422491494aa4)

## install
https://www.elastic.co/guide/en/elasticsearch/reference/7.5/docker.html


## config
1. Heap size

  - Create new file in /etc/elasticsearch/jvm.options.d (E.g: user.options, note that don't edit file jvm.options), add heap size config
    > -Xms1G
    > 
    > -Xmx1G
    
  - case-sensitive matter if elasticsearch service throw `invalid heap size` error.
  - Check log `elasticsearch.service`: `journalctl -u elasticsearch.service`
## exercises

- [Load sample dataset](https://viblo.asia/p/thong-ke-voi-aggregation-query-trong-elasticsearch-phan-1-cong-cu-truy-van-va-tong-quat-ve-aggregation-query-07LKXAdpZV4)
    > curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/account/_bulk?pretty&refresh" --data-binary "@accounts.json"
- [Aggregations](https://www.tutorialspoint.com/elasticsearch/elasticsearch_aggregations.htm)

- [Get array size for each document](https://discuss.elastic.co/t/how-to-get-array-size-for-each-document/226599)

### ELASTICSEARCH FULL TEXT QUERIES VS TERM LEVEL QUERIES
- https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html
- https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-dsl-query-string-query
- https://cloudmaterials.com/en/blog-entry/elasticsearch-full-text-queries-vs-term-level-queries

### Inverted Index
- https://dammayxanh.wordpress.com/2017/11/22/full-text-search-bap-be-hoc-interted-index/

### Synonym search
- https://stackoverflow.com/questions/34333486/one-way-synonym-search-in-elasticsearch
- https://medium.com/@purbon/handling-similar-words-in-elasticsearch-9c80aba88627

### https://coralogix.com/blog/42-elasticsearch-query-examples-hands-on-tutorial/


### Init data
- https://www.elastic.co/guide/en/elasticsearch/reference/current/array.html
- [Test analyzer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-custom-analyzer.html)

### Use cases
- [Autocomplete search](https://medium.com/@milosbiljanovic/springboot-autocomplete-with-elasticsearch-11ea95d58854#cdf7)

### SDK
- https://www.elastic.co/guide/en/elasticsearch/client/java-rest/current/java-rest-high-create-index.html

## Tools
- [elasticsearch-dump](https://github.com/elasticsearch-dump/elasticsearch-dump)
    ```spring-mongodb-json
    elasticdump \
  --input=http://192.168.5.21:9200/news_index \
  --output=http://localhost:9200/news_index \
  --type=mapping

    elasticdump \
    --input=http://192.168.5.21:9200/news_index \
    --output=http://localhost:9200/news_index \
    --type=data
    ```