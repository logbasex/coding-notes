## References
- [Elasticsearch Routing](https://opster.com/guides/elasticsearch/glossary/elasticsearch-routing/)
- [Improving query performance in ElasticSearch at scale](https://blogs.halodoc.io/improving-query-performance-in-elasticsearch-at-scale/)
- [Elasticsearch Architecture VI: Routing](https://blog.devgenius.io/elasticsearch-architecture-vi-routing-f88e7fb390d7)
- [Understanding Sharding in Elasticsearch](https://codingexplained.com/coding/elasticsearch/understanding-sharding-in-elasticsearch)
- [Customizing Your Document Routing](https://www.elastic.co/blog/customizing-your-document-routing)

---
---

## Custom Routing

> In order to improve search speed, you can create custom routing. For example, you can enable custom routing that will ensure that only a single shard will be queried (the shard that contains your data).

---
---

## What is Routing?

All of your data lives in a primary shard, somewhere in the cluster. You may have five shards or five hundred, but any particular document is only located in one of them. Routing is the process of determining _which_ shard that document will reside in.

Because Elasticsearch tries hard to make defaults work for 90% of users, routing is handled automatically. For most users, it doesn’t matter where a document is stored.

The default routing scheme hashes the ID of a document and uses that to find a shard. This includes both user-provided IDs and randomly generated IDs picked by Elasticsearch. Default routing gives an even distribution of documents across the entire set of shards – you won’t have any “hotspots” where documents tend to cluster on one shard or another.

## The need for custom routing

Random routing works well most of the time, but there are scenarios where domain knowledge of your data can lead to better performance with a custom routing solution. Imagine a single index with 20 shards (overallocated to support future growth).

What happens when a search request is executed on the cluster?

1.  Search request hits a node
2.  The node broadcasts this request to every shard in the index (either a primary or replica shard)
3.  Each shard performs the search query and responds with results
4.  Results are merged on the gateway node, sorted and returned to the user

Elasticsearch has no idea where to look for your document. All the docs were randomly distributed around your cluster…so Elasticsearch has no choice but to broadcasts the request to all 20 shards. This is a non-negligible overhead and can potentially impact performance.

Wouldn’t it be nice if we could tell Elasticsearch which shard the document lived in? Then you would only have to search one shard to find the document(s) that you need.

This is exactly what custom routing does.

Instead of blindly broadcasting to all shards, you tell Elasticsearch _“**Hey! Search for the data on this shard! It’s all there, I promise!**”_. For example, you could route documents based on their user\_id. Or their zip or postcode. Or whatever is commonly searched/filtered in your application.

Routing ensures that all documents with the same routing value will locate to the same shard, eliminating the need to broadcast searches. This design pattern is often called the “User Data Flow”, popularized from [Shay’s talk at Berlin Buzzwords](http://vimeo.com/44716955#t=825).

## Custom Routing is Fast

This point is so important, so central to custom routing, that it deserves its own section. Custom routing ensures that **only one shard** is queried.

This has the potentially to increase performance noticeably, if your problem fits into the niche that custom routing serves.

It doesn’t matter if you have 20 or 100 shards in your index, custom routing ensures that only the shards holding your data are queried. Under the right data organization, this can be the difference between a cluster that is struggling and one that doesn’t break a sweat.

----
----

## Implement custom routing

Custom routing in Elasticsearch can significantly improve search performance and efficiency, especially in scenarios involving large datasets and distributed environments. By default, Elasticsearch uses a hash of the document ID to determine the shard where a document is stored. However, custom routing allows you to control the placement of documents based on a custom value, ensuring that related documents are stored in the same shard and can be queried more efficiently.

Here's a basic example of how to use custom routing in Elasticsearch, from indexing documents with a custom routing value to searching for those documents using the same routing value.

### 1. Creating an Index with Custom Routing

First, you need to create an index that supports custom routing. While creating the index, you specify which field you'll use for custom routing.

```json
PUT /my_index
{
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 1
  },
  "mappings": {
    "properties": {
      "my_routing_field": { "type": "keyword" }
    }
  }
}
```

### 2. Indexing Documents with Custom Routing

When indexing documents, you specify the custom routing value. This example uses `my_routing_field` as the routing parameter.

```json
PUT /my_index/_doc/1?routing=user123
{
  "name": "John Doe",
  "my_routing_field": "user123"
}
```

In this case, `user123` is the custom routing value, and Elasticsearch will use it to determine the shard instead of the document ID's hash.

### 3. Searching Documents with Custom Routing

To search for documents, you use the same routing value used for indexing to ensure that the search is efficient and scoped to the relevant shard.

```json
GET /my_index/_search?routing=user123
{
  "query": {
    "match": {
      "my_routing_field": "user123"
    }
  }
}
```

This search query will only target the shard where documents with `routing=user123` are stored, making the search operation faster and more efficient.

### Benefits and Considerations

- **Performance**: By ensuring related documents are stored on the same shard, search queries can be executed more efficiently.
- **Scalability**: Custom routing helps in scaling your Elasticsearch cluster by reducing the number of shards that need to be searched.
- **Use Cases**: Custom routing is particularly useful for multi-tenant applications where each tenant's data can be routed to specific shards.

However, it's essential to use custom routing judiciously, as improper use can lead to uneven data distribution across shards (shard hotspots), which can negatively impact performance.

This example provides a basic understanding of custom routing in Elasticsearch. Depending on your specific use case, you might need to adjust your index settings, mappings, and queries accordingly.