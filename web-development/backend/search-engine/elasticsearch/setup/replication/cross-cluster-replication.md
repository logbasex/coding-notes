## References
- [High Availability in Elasticsearch – Cross Cluster Replication and Alternatives](https://opster.com/blogs/elasticsearch-cross-cluster-replication-overview/)
- [Follow the Leader: An Introduction to Cross-Cluster Replication in Elasticsearch](https://www.elastic.co/blog/follow-the-leader-an-introduction-to-cross-cluster-replication-in-elasticsearch)

----
----

## The Needs of the Many

The ability to natively replicate data to an Elasticsearch cluster from another Elasticsearch cluster is our most heavily requested feature, and one that our users have [long been asking](https://discuss.elastic.co/t/cross-data-center-replication/11670) for. After years of engineering effort [laying the necessary foundations](https://www.elastic.co/blog/elasticsearch-sequence-ids-6-0), [building new fundamental technology into Lucene](https://issues.apache.org/jira/browse/LUCENE-8198), and [iterating and refining our initial design](https://github.com/elastic/elasticsearch/issues/30086), we are excited to announce that cross-cluster replication (CCR) is now available and production-ready in Elasticsearch 6.7.0. In this post, the first in a series, we will provide some brief introduction to what we have implemented, and some technical background on CCR. In future posts we will deep-dive into specific CCR use cases.

Cross-cluster replication in Elasticsearch enables a variety of mission-critical use cases within Elasticsearch and the Elastic Stack:

-   **Disaster Recovery (DR) / High Availability (HA)**: Tolerance to withstand a datacenter or region outage is a requirement for many mission-critical applications. This requirement was previously solved in Elasticsearch with additional technologies, which added additional complexity and management overhead. Satisfying cross-datacenter DR / HA requirements can now be solved natively in Elasticsearch, utilizing CCR, with no additional technologies.
-   **Data Locality**: Replicate data in Elasticsearch to get closer to the user or application server, reducing latencies that [cost you money](https://developers.google.com/web/fundamentals/performance/why-performance-matters/). For example, a product catalog or reference dataset may be replicated to twenty or more data centers around the world, to minimize the distance between the data and the application server. Another use case may be a stock trading firm with offices in London and New York. All trades in the London office are written locally and replicated to the New York office, and all trades in the New York office are written locally and replicated to London. Both offices have a global view for all trades.
-   **Centralized Reporting**: Replicate data from a large number of smaller clusters back to a centralized reporting cluster. This is useful when it may not be efficient to query across a large network. For example, a large global bank may have 100 Elasticsearch clusters around the world, each within a different bank branch. We can use CCR to replicate events from all 100 banks around the world back to a central cluster where we can analyze and aggregate events locally.

Prior to Elasticsearch 6.7.0, these use cases could be partially addressed with third-party technologies, which is cumbersome, carries a lot of administration overhead, and has significant drawbacks. With cross-cluster replication natively integrated into Elasticsearch, we free our users of the burden and drawbacks of managing complicated solutions, can offer advantages above what existing solutions can provide (e.g., comprehensive error handling), and provide APIs within Elasticsearch and UIs in Kibana for managing and monitoring CCR.

Stay tuned for our follow-up posts to dive into each of these use-cases in greater detail.