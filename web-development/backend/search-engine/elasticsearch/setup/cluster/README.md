## References
- [Boosting Elasticsearch Cluster Performance: 3 Proven Tips](https://betterprogramming.pub/boosting-elasticsearch-cluster-performance-3-proven-tips-9b718a9114bc)

----
----

## Clustering

> http://localhost:9200/_cluster/health

```json
{
    "cluster_name": "es_cluster",
    "status": "green",
    "timed_out": false,
    "number_of_nodes": 3,
    "number_of_data_nodes": 3,
    "active_primary_shards": 3,
    "active_shards": 6,
    "relocating_shards": 0,
    "initializing_shards": 0,
    "unassigned_shards": 0,
    "delayed_unassigned_shards": 0,
    "number_of_pending_tasks": 0,
    "number_of_in_flight_fetch": 0,
    "task_max_waiting_in_queue_millis": 0,
    "active_shards_percent_as_number": 100.0
}
```