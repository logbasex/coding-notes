## References
- [What is the difference between Lucene and Elasticsearch](https://stackoverflow.com/questions/27793721/what-is-the-difference-between-lucene-and-elasticsearch)

---
---
## [Apache Lucene - Index File Formats](https://lucene.apache.org/core/3_0_3/fileformats.html#Segments)

Lucene indexes may be composed of multiple sub-indexes, or segments. Each segment is a fully independent index, which could be searched separately. Indexes evolve by:

- Creating new segments for newly added documents.

- Merging existing segments.

Searches may involve multiple segments and/or multiple indexes, each index potentially composed of a set of segments.


----
----

## Elasticsearch index Vs Lucene index.

The **Elasticsearch index** is a chunk of documents just like databases consist of tables in relational world.  
In order to achieve scaling we spread the Elasticsearch Indices into multiple physical nodes / servers.

For that, we break the Elasticsearch Indices into smaller units which are called **shards**.

**Question: How it is related to Lucene index?**  
If we want to search for a specific term (for example: "_Cake_" or "_Cookie_") we'll have to go over each shard and look for it (lets put aside how shards are being located and replicated on each node).

This operation will take a lot of time - so we need to use an **efficient data structure for this search** - this is where **Lucene's index** comes into play.

Each **Elasticsearch shard is based on the Lucene index structure** and stores statistics about terms in order to make term-based search more efficient.

(!) This is quiet confusing because of the word "index" and the fact that an Elasticsearch shard is a portion of Elasticsearch index BUT is based on a data structure of Lucene index .

___

### Bonus - Lucene's index as a inverted index

As can be seen in the example below , Lucene's index stores the original document’s content plus additional information, such as term dictionary and term frequencies, which increase searching efficiency:

```
Term           Document                 Frequency
Cake           doc_id_1, doc_id_8       4 (2 in doc_id_1, 2 in doc_id_8)
Cookie         doc_id_1, doc_id_6       3 (2 in doc_id_1, 1 in doc_id_6)
Spaghetti      doc_id_12                1 (1 in doc_id_12)
```

Lucene's index falls into the family of indexes known as an inverted index. This is because it can list, for a term, the documents that contain it.  
This is the inverse of the natural relationship, in which documents list terms.

___

### (Reminder) How did we reached from a Shard to a term?

(1) Shard is a directory of files which contains documents.  
(2) A document is a sequence of fields.  
(3) A field is a named sequence of terms.  
(4) A term is a string.


----
----

