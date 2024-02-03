## References
- [Analysis of Lucene — Basic Concepts](https://alibaba-cloud.medium.com/analysis-of-lucene-basic-concepts-5ff5d8b90a53)
- [Managing Relations Inside Elasticsearch](https://www.elastic.co/blog/managing-relations-inside-elasticsearch)

---
---

![](insertion.png)

## [Refresh vs Flush](https://stackoverflow.com/questions/19963406/refresh-vs-flush)

> **refresh**: transform in-memory buffer to in-memory segment which can be searched.

![](insertion-refresh.png)

> **flush**: (a) merge small segments to be a big segment (b) fsync the big segment to disk (c) empty translog.

![](insertion-flush.png)

## How insertion works with lucene segment in elasticsearch

In Elasticsearch, which is built on top of Lucene, the process of inserting (indexing) documents into segments is a critical part of how it manages and searches data efficiently. Here's a step-by-step overview of how insertion works within the context of Lucene segments in Elasticsearch:

### 1. Document Indexing Request
- When a document is indexed in Elasticsearch, it's first processed by the relevant index's mapping to determine how the fields within the document should be stored and indexed. This includes analyzing text fields, converting data types, and applying any configured indexing strategies.

### 2. Buffering Documents
- The newly indexed document is initially stored in an in-memory buffer. Elasticsearch uses this buffer to collect and batch documents together to improve the efficiency of the indexing process. This buffer is part of the Indexing Buffer, which is shared among all shards on a node.

### 3. Creating a New Segment
- Once the in-memory buffer reaches a certain size or after a specific interval of time, Elasticsearch flushes its contents to disk. This flushing process involves creating a new Lucene segment. Each segment is a self-contained index, and the document is written to this new segment. This process includes creating the inverted index for the document, which enables efficient text searches.

### 4. Segment Immutability
- Once a segment is written to disk, it becomes immutable, meaning it cannot be changed. Any updates or deletions to documents within that segment are handled by marking the original document as deleted and, if updating, indexing a new version of the document in a subsequent segment flush. The document marked as deleted will still exist in the segment until a merge operation occurs.

### 5. Segment Merging
- Over time, as more documents are indexed and more segments are created, Elasticsearch periodically merges smaller segments into larger ones. This merge process is managed in the background and helps optimize the index by reducing the number of segments that must be searched for each query and by permanently removing deleted documents from the filesystem. Merging segments also helps in reclaiming disk space and ensuring that the search performance remains efficient.

### 6. Refresh and Commit Operations
- Elasticsearch performs periodic "refresh" operations (by default, every second) to make the newly indexed documents available for search. A refresh operation creates a new searcher on the index, which includes any newly created segments since the last refresh.
- A "commit" operation, on the other hand, is a more durable operation that updates the index metadata on disk to reflect the latest changes, including new segment creation. This ensures that changes are persisted and recoverable after a restart.

### 7. Translog for Durability
- Alongside segment creation, each indexing operation is also written to a transaction log (translog) before it's even added to the in-memory buffer. The translog ensures that any changes not yet flushed to a segment can be recovered in case of a crash. After a commit operation, the translog is trimmed since the data it contains has been safely written to segments and persisted on disk.

This process showcases how Elasticsearch, leveraging Lucene's capabilities, manages to efficiently index, update, and search vast amounts of data with high performance and reliability. The use of segments and the strategies around them are central to achieving this efficiency.
