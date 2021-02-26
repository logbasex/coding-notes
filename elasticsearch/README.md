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

## install

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
