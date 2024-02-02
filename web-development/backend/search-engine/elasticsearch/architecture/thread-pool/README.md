## References
- [Scaling Elasticsearch](https://medium.com/hipages-engineering/scaling-elasticsearch-b63fa400ee9e)
- [ElasticSearch Thread Pools](https://sauravomar01.medium.com/elasticsearch-thread-pools-56a988dff1b7)
- [Elasticsearch Threadpool](https://opster.com/guides/elasticsearch/glossary/elasticsearch-threadpool/)
---
---

## Thread Pool

When dealing with a large number of parallel operations in elastic search, such as search requests or bulk indexing operations, Elasticsearch uses Threadpools to manage the processing of incoming requests and to optimize the use of resources on each node in the cluster.

## What is Thread pools:

-   Thread pools are a collection of threads that are available to perform tasks.
-   It helps us to manage memory management in the case. of executing a large number of requests.
-   Elastic Search has different thread pools for different purposes like Searching, Indexing.
-   It also has Queue, when all the threads busy. executing then-incoming requests gets queued for execution.

you can check different types thread pool using below command

> curl -XGET "localhost:9200/_cat/thread_pool?v&h=node_name,name,active,rejected,completed"

There are many thread pools are present in Elastic Search, we mainly look some of them.

## Search ActiveThread pools:

-   In elasticsearch it has a dedicated search pool and an associated queue for each node.
-   There are a number of workers which are equal to no of cores present in those machines.
-   By default Search thread pool size is based on [Littles’law](https://en.wikipedia.org/wiki/Little%27s_law).

    > ((available_processors * 3) / 2) + 1

-   We can also update thread pool size using property in **elasticsearch.yml**

    > threadpool.search.size

-   Default queue\_size of `1000`.

## Write or Index ActiveThread pools:

-   In elasticsearch it has a dedicated index the pool and an associated queue for each node.
-   By default Index thread pool size is based on [Littles’law](https://en.wikipedia.org/wiki/Little%27s_law).

    > (1 + available processors)

-   We can also update thread pool size using property in **elasticsearch.yml**

    > threadpool.index.size:

-   Default queue\_size of 200.

----
----

## Detail about search thread pool in distributed search

In the context of distributed search within Elasticsearch, the search thread pool plays a critical role in handling search requests across multiple nodes in a cluster. Distributed search allows Elasticsearch to leverage data stored across different nodes, ensuring high availability and scalability for search operations. The search thread pool is specifically designed to manage and execute these search requests efficiently.

### How Distributed Search Works

When a search request is made in a distributed Elasticsearch cluster, the request is initially received by a coordinating node. The coordinating node then forwards the search request to the appropriate shards that hold the relevant data across various nodes in the cluster. Each node that receives the shard-level search request uses its search thread pool to execute the search on its local data.

### Search Thread Pool Characteristics

- **Type**: The search thread pool is typically a fixed thread pool. This means it has a predetermined number of threads dedicated to handling search requests. **The size of the search thread pool is usually determined by the number of CPU cores available on the node**, with Elasticsearch automatically allocating one thread per core specifically for search operations.

- **Queue Size**: Each search thread pool has a queue for holding search requests that cannot be immediately processed due to all threads being busy. The size of this queue is configurable and plays a crucial role in how the system behaves under heavy search load. A queue that's too small may result in rejected search requests during peak times, while a too-large queue can lead to high memory pressure and increased response times.

- **Rejection Policy**: When the search thread pool queue is full, and new search requests cannot be queued, Elasticsearch's rejection policy kicks in. Typically, this results in search requests being rejected with an exception, signaling to the client application that the cluster is under heavy load. Monitoring rejected search requests is crucial for capacity planning and performance tuning.

### Importance in Distributed Search

The efficiency of the search thread pool is vital for the overall performance of distributed searches. Since each node processes a portion of the search in parallel, the search thread pool must be optimized to handle the local execution of searches efficiently. This involves tuning the size of the thread pool and its queue based on the node's hardware capabilities and the cluster's search workload.

### Tuning and Monitoring

- **Tuning**: Adjusting the size of the search thread pool and its queue can help accommodate different search workloads. For instance, a cluster primarily serving complex search queries may benefit from a larger thread pool size, while a cluster with high query volumes might require adjustments to the queue size to prevent request rejections.

- **Monitoring**: Elasticsearch provides various metrics to monitor the health and performance of the search thread pool, such as the number of active threads, the size of the thread pool queue, and the number of rejected search requests. These metrics are essential for identifying bottlenecks and tuning the thread pool settings.

### Conclusion

The search thread pool is a cornerstone of distributed search in Elasticsearch, ensuring that search requests are processed efficiently across the cluster. Proper configuration and monitoring of the search thread pool are essential for maintaining high performance and ensuring that the Elasticsearch cluster can handle the intended search workload effectively.

---
---

## Why we need Thread Pool

Let's consider an example scenario where Elasticsearch uses thread pools to manage search requests efficiently.

### Scenario: Handling Search Requests

Imagine an Elasticsearch cluster with several nodes, each configured with a search thread pool. This thread pool is configured to have a fixed number of threads, say 10 threads per node, dedicated to handling search requests.

#### Incoming Search Requests

When multiple search requests arrive at the cluster, they are distributed across the nodes responsible for the relevant shards of data. Each node uses its search thread pool to process these requests.

1. **Efficient Resource Management**: The node receives the search requests and assigns them to available threads in the search thread pool. Since threads are reused, there's minimal overhead from thread creation or destruction.

2. **Concurrency Control**: If all 10 threads in the search thread pool are busy, new search requests are queued. This limits the number of concurrent search operations, preventing the system from becoming overloaded and ensuring that the node remains responsive.

3. **Task Prioritization**: Since search requests are handled by a dedicated search thread pool, they are prioritized over other non-search operations, ensuring timely processing of user queries.

4. **Overload Protection**: Suppose the queue for the search thread pool reaches its capacity due to a surge in search requests. In this case, the node's rejection policy kicks in—additional search requests might be rejected or rerouted, protecting the system from being overwhelmed and maintaining stable operation.

#### Example Configuration

In `elasticsearch.yml`, the configuration for a search thread pool might look something like this (hypothetical example for illustration purposes):

```yaml
thread_pool.search.size: 10
thread_pool.search.queue_size: 100
```

This configuration sets the search thread pool to have 10 threads and a queue size of 100 for each node in the cluster.

#### Monitoring and Adjusting

Administrators can monitor the performance and utilization of the search thread pool using Elasticsearch's monitoring tools. If they notice that search requests are frequently queued or rejected, indicating that the thread pool is under high load, they might decide to adjust the thread pool size or queue size to better accommodate the workload.

### Conclusion

This example illustrates how Elasticsearch's search thread pool efficiently manages search requests, balancing resource utilization, system stability, and performance optimization. By adjusting thread pool configurations and monitoring their performance, administrators can ensure that the cluster handles search operations effectively, even under varying loads.
