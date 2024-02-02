## Pagination & Sort

When executing a search query with pagination and sorting in an Elasticsearch cluster, the process involves several steps across all relevant shards to ensure that the final results are accurate and in the correct order. Here's an overview of how this process typically works:

### 1. Query Distribution
- The search query, including conditions, pagination parameters (`from` and `size`), and sorting instructions, is distributed to all shards holding parts of the index.

### 2. Local Processing on Each Shard
- **Matching Documents:** Each shard executes the search query against its local data. This involves finding all documents that match the search conditions.
- **Local Sorting:** The shard then sorts these matching documents according to the specified sort criteria. This is necessary because the final sorting of results must consider documents across all shards.
- **Local Pagination:** Although each shard does not apply the `from` and `size` pagination directly in the sense of only returning the specified slice of documents, **it does need to determine which documents could potentially be included in the final paginated result**. To do this efficiently and ensure that the final global result set is accurate, **`each shard typically returns more documents than requested by the size parameter`**.
  > **This is because the shard cannot know in advance which of its documents will make it into the top results after global sorting**.

### 3. Gathering and Global Sorting
- **Gathering Results:** The coordinating node gathers the documents from all shards. Since each shard returns documents sorted according to the query's sort criteria, the coordinating node has to merge these sorted lists into a global sorted list.
- **Global Pagination:** Once the global sorting is complete, the coordinating node applies the pagination parameters (`from` and `size`) to select the final set of documents to return. This ensures that the documents in the final response are indeed the top N documents as per the global sort order and pagination parameters.

### 4. Final Fetch Phase (Optional)
- In some cases, after determining the final set of document IDs to be returned, the coordinating node may perform an additional fetch phase to retrieve the full document content for these IDs from the relevant shards. This step is optimized to only fetch the necessary documents.

### Summary
To answer your question directly: Yes, all relevant shards need to query all data matching the search conditions, sort these documents locally, and then provide a sufficiently large set of top documents to the coordinating node. The coordinating node is responsible for the final global sorting, applying pagination, and potentially fetching the complete documents. This ensures that the search results are accurate according to the query parameters and sorting criteria, even in a distributed environment where data is partitioned across many shards.


----
----

## How local pagination works

When dealing with a search query that requests a specific page of results far into the dataset (e.g., `from=100, size=20`), the process within each shard and the coordinating node in an Elasticsearch cluster involves several nuanced steps to ensure efficient retrieval and accuracy of the requested slice of data. Here's how it works in detail:

### Handling Deep Pagination Requests

For a query asking for results starting from a high offset (`from=100`) with a given size (`size=20`), Elasticsearch employs strategies to manage both performance and relevance. The local processing on each shard and the subsequent global aggregation step are key to understanding this.

### Local Shard Processing

1. **Local Relevance Ranking:** Each shard independently evaluates the query against its documents, ranking them by relevance according to the search criteria.

2. **Local Pre-selection:** Instead of applying the `from` and `size` directly at the shard level, each shard pre-selects a larger set of top candidates. The number of documents to pre-select is influenced by the `from` and `size` parameters but adjusted to ensure that the global ranking process can accurately identify the top documents that match the global `from` and `size` requirements.

3. **Overfetching:** To accommodate deep pagination requests efficiently, shards may overfetch. This means that each shard returns more documents than what the final `size` parameter specifies, to account for the distribution of relevant documents across shards. For a request like `from=100, size=20`, each shard might return its top `from + size` documents (e.g., top 120 documents), knowing that not all will be included in the final result set but ensuring that the most relevant ones have a chance to be.

### Global Aggregation and Final Sorting

4. **Global Sorting and Ranking:** The coordinating node collects the pre-selected documents from all shards. It then performs a global sorting to rank these documents across the entire dataset.

5. **Applying Pagination Globally:** After global ranking, the coordinating node applies the `from` and `size` parameters to this globally sorted list to extract the specific subset of documents requested (documents 101-120 in this case).

6. **Fetching Full Documents:** Once the final set of document IDs is determined, Elasticsearch may perform an additional fetch phase to retrieve the full content of these documents from the respective shards, if the full document data wasn't included in the initial response from each shard.

### Why Not Local Pagination for Deep Pages?

> **Applying deep pagination (`from=100, size=20`) directly at each shard would imply that each shard could discard potentially relevant documents before the global ranking process, leading to inaccurate results.**
>
> **By overfetching and then globally ranking, Elasticsearch ensures that the documents presented to the user are indeed the most relevant across the entire index, not just the most relevant from each shard's narrow perspective**.

This approach, while efficient for moderate `from` and `size` values, can become resource-intensive for very deep pagination requests due to the overfetching strategy. To mitigate the performance impact of deep pagination, Elasticsearch recommends using the `search_after` parameter for efficiently retrieving large numbers of documents in a sequential manner, which avoids the need for overfetching and can provide a more scalable solution for deep pagination scenarios.

----
----

## Local Pagination

Let's illustrate this concept with a simplified example. Imagine an Elasticsearch cluster with an index split across 3 shards. We're searching this index with a query that requests results starting from the 100th result (`from=100`) and wants 20 results in total (`size=20`). For simplicity, we'll simulate the behavior of each shard returning documents based on relevance scores.

### Document Data Setup

Each shard has a collection of documents, each with a relevance score. Normally, these scores are computed based on how well each document matches the search criteria, but for this example, we'll assign scores arbitrarily to simulate the process.

- **Shard 1 Documents:** `[(1, 0.92), (2, 0.81), (3, 0.85), ...]`
- **Shard 2 Documents:** `[(1, 0.95), (2, 0.82), (3, 0.88), ...]`
- **Shard 3 Documents:** `[(1, 0.90), (2, 0.83), (3, 0.87), ...]`

### Local Processing at Each Shard

Each shard ranks its documents by score and prepares to return more documents than the final `size` to account for the `from` and `size` pagination parameters.

- **Assumption:** Each shard will pre-select a set of its top `N` documents, where `N` is larger than `size` but considers the `from` value. For this example, let's assume each shard decides to pre-select `from + size = 120` top documents to ensure coverage.

### Global Aggregation Step

- The coordinating node receives these pre-selected document sets from each shard.
- It then globally ranks these documents, considering documents from all shards, to identify the top documents according to the global pagination parameters (`from=100, size=20`).
- This process ensures that the final list of documents accurately reflects the top documents from across the entire index, not just the top documents from each shard.


----
----

## Why need to local pagination and local sorting while elasticsearch cluster does global pagination and global sorting eventually.

Your question touches on a fundamental aspect of distributed search systems like Elasticsearch, where both efficiency and accuracy are crucial. The process of local sorting and preliminary selection of documents on each shard before global aggregation and final sorting at the coordinating node level is designed to optimize both network usage and processing time. Here’s why local pagination and sorting are necessary even though global pagination and sorting are performed eventually:

### Efficiency in Data Transfer
- **Reducing Network Load:** If each shard were to send all documents that match the search criteria to the coordinating node, it would result in a significant amount of data transfer over the network. This could overwhelm the network bandwidth and increase the latency of search queries, especially for large indices or when the matching document set is vast.

### Optimizing Processing Time
- **Reducing Processing Overhead:** By performing local sorting and selecting a subset of top documents on each shard, Elasticsearch reduces the volume of data that the coordinating node must process. This localized reduction means the coordinating node has to merge and sort a smaller set of documents, significantly speeding up the query response time.

### Scalability and Performance
- **Scalable Architecture:** This approach allows Elasticsearch to scale horizontally. As the dataset grows and spreads across more shards, the system can maintain performance by ensuring that each shard only sends relevant top documents to the coordinating node, keeping the final sorting and merging phase manageable.

### Accuracy of Results
- **Maintaining Result Relevance:** Local sorting ensures that the documents sent from each shard to the coordinating node are the most relevant from that shard's subset of the data. This is crucial for maintaining the accuracy and relevance of the final, globally sorted results. Without local sorting, there’s no guarantee that the most relevant documents across the entire index would be included in the final result set.

### Practical Considerations
- **Balancing Load and Precision:** Elasticsearch uses practical heuristics to balance the load and precision of search results. For example, it initially requests a slightly larger set of top documents from each shard than what the final `size` parameter might suggest. This overfetching compensates for variations in document distribution and relevance across shards, ensuring that the final global sorting phase can accurately determine the top documents as per the query's requirements.

### Conclusion
The local pagination and sorting steps are not about finalizing which documents get returned but rather about efficiently determining a subset of documents that *could* be in the final result set. This design allows Elasticsearch to provide fast, scalable, and relevant search results across massive datasets distributed over many nodes, optimizing both computational and network resources.
