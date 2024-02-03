## References
- [How Elasticsearch uses Lucene index time join to handle nested objects](https://medium.com/@at15/how-elasticsearch-uses-lucene-index-time-join-to-handle-nested-objects-854ad1085059)

---
---

## Nested and Parent-Child Documents

The performance difference between using nested documents and parent-child (child documents) relationships in Elasticsearch depends significantly on your specific use case, including the query patterns and the nature of your data. Both approaches have their strengths and trade-offs in terms of performance, and understanding these can help you make an informed decision.

### Nested Documents

- **Same Segment**: Nested documents are stored within the same document (and hence, the same segment), which means that operations on nested documents can be more cache-friendly and have lower latency because the data is co-located.
- **Performance**: Nested queries can be faster for certain types of searches, especially when the relationship between nested objects and the parent document needs to be tightly coupled. This co-location can lead to better query performance because there's no need to join data from different documents.
- **Use Case**: Ideal for documents that have lists of objects which do not frequently change. If the nested objects are updated often, each update reindexes the entire document, which can lead to increased indexing overhead.

### Parent-Child Documents

- **Separate Segments**: Parent and child documents are indexed as separate documents, which means they can reside in different segments. This separation can increase the complexity and overhead of join operations required to query parent-child relationships.
- **Performance**: Queries involving parent-child relationships can be more resource-intensive than nested queries, primarily due to the need to perform joins at query time. However, because child documents are indexed separately, updates to child documents can be more efficient than updates to nested documents, as they do not require reindexing the entire parent document.
- **Use Case**: Suited for relationships where the child documents are frequently updated or where the volume of child documents is very high. This model allows for more efficient updates since only the child documents need to be reindexed.

### Choosing Between Nested and Parent-Child Documents

- **Query Performance vs. Update Frequency**: If your use case involves complex queries that must maintain document hierarchies and you have relatively static data, nested documents might offer better performance. On the other hand, if you expect frequent updates to parts of the document structure or have very large document sets that need relational data models, parent-child relationships may be more suitable despite the potential query performance hit.
- **Resource Utilization**: Nested documents can lead to larger document sizes and potentially higher indexing times but offer faster query performance due to locality. Parent-child relationships offer more flexible data modeling and can be more efficient in terms of storage and updates, but querying can consume more resources due to the join operations required.

Ultimately, the choice between nested and parent-child documents should be guided by your specific requirements for query performance, update frequency, and how your data is structured. It's often beneficial to test both approaches with your actual datasets and queries to see which one aligns better with your performance and operational goals.