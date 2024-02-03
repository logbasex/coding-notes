## References
- [Elasticsearch Cluster Sizing and Performance Tuning](https://alikzlda.medium.com/elasticsearch-cluster-sizing-and-performance-tuning-42c7dd54de3c)

---
---

## Performance Optimization

### Monitor the Index Size

The size of your index may grow over time, potentially necessitating adjustments to the cluster or hardware.

Reindex Your Index Periodically
Especially in write-heavy indexes, the size tends to increase over time. This is primarily due to updated documents. 

> **In Elasticsearch, `documents are considered immutable`, meaning they are not updated directly. Instead, a new document is created with the updated data, and its version is incremented by one**. 

> **When you `reindex` your index, the `new index will contain the latest versions of documents`, potentially leading to a decrease in index size**.

Force Merge
In Elasticsearch, all shards are Lucene Indexes, which are composed of one or more files. The force merge operation enables the merging of these files, resulting in the creation of larger segments. Larger segments are more efficient for storing data.

### Disable Replicas For Initial Indexing

When you index a document, it’s initially written to the primary shards and then copied to the replicas. Copying to replicas is a resource-intensive operation and can slow down the initial indexing process. Therefore, it’s recommended to disable replicas until the initial indexing is complete.

