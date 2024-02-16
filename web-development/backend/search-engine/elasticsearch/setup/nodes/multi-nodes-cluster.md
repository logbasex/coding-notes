## References
- [How To Install an Elasticsearch Cluster on Ubuntu 18.04](https://devconnected.com/how-to-install-an-elasticsearch-cluster-on-ubuntu-18-04/)
- [Elastic search multi node cluster with docker-compose](https://jndrbr7.hashnode.dev/elastic-search-multi-node-cluster-with-docker-compose2)
- [Setup a Multi-Node Elasticsearch Cluster](https://medium.com/avmconsulting-blog/how-to-deploy-and-configure-a-multi-node-elastic-search-cluster-c13990881ba0)

## Setup multi node cluster with docker

```yaml
version: '3.1'
services:
  es_service_1:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es_container_1
    environment:
      - cluster.name=es_cluster
      - node.name=es_container_1
      - discovery.seed_hosts=es_container_1,es_container_2,es_container_3
      - cluster.initial_master_nodes=es_container_1,es_container_2,es_container_3
      - node.max_local_storage_nodes=3
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - xpack.security.enabled=false
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./es_data_1:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    networks:
      - elastic_network

  es_service_2:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es_container_2
    environment:
      - cluster.name=es_cluster
      - node.max_local_storage_nodes=3
      - node.name=es_container_2
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - xpack.security.enabled=false
      - discovery.zen.ping.unicast.hosts=es_container_1
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./es_data_2:/usr/share/elasticsearch/data
    networks:
      - elastic_network

  es_service_3:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es_container_3
    environment:
      - cluster.name=es_cluster
      - node.max_local_storage_nodes=3
      - node.name=es_container_3
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - xpack.security.enabled=false
      - discovery.zen.ping.unicast.hosts=es_container_1
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./es_data_3:/usr/share/elasticsearch/data
    networks:
      - elastic_network

networks:
  elastic_network:
    driver: bridge
```

Check

> curl -X GET localhost:9200/_cat/nodes

![](cluster-master-node.png)

![](cluster-worker-node.png)

---
---

## How to reduce costs by optimize node roles? explain by example

Let's consider another example, focusing on a media streaming service that uses Elasticsearch for logging and analyzing user interaction data, content recommendations, and search functionalities. The service experiences fluctuating volumes of data and query loads depending on new content releases and promotional events.

### Initial Scenario

The media streaming service initially deployed a homogeneous Elasticsearch cluster configuration:

- **15 General-Purpose Nodes**: Each node was capable of handling master, data, and ingest roles. This configuration was chosen for its simplicity but led to inefficient resource utilization.
- **Challenges**:
    - High operational costs due to uniform use of high-specification hardware across all nodes, regardless of their actual workload.
    - Performance bottlenecks during peak event times due to inadequate resource allocation for different types of data and operations.

### Optimization Strategy

To optimize costs and improve performance, the service adopted a role-based optimization strategy for their Elasticsearch cluster.

#### Step 1: Role-Based Node Configuration

- **Action**: They reconfigured their cluster based on the specific roles required for their operations.
    - **3 Dedicated Master Nodes**: Chosen for their critical role in managing the cluster's state and not involved in heavy data processing, these nodes were set up on moderate-spec machines.
    - **Data Nodes Split into Hot and Cold Tiers**:
        - **Hot Nodes**: 4 high-performance nodes were designated for handling recent, frequently accessed data and real-time user interaction logs.
        - **Cold Nodes**: 6 nodes with larger storage and moderate computing power were used for older logs and data not frequently accessed.

#### Step 2: Dedicated Ingest Nodes for Log Data

- **Action**: To efficiently handle the high volume of incoming log data, 2 nodes were designated as ingest nodes, equipped with sufficient CPU and memory to preprocess and enrich log data before indexing.
- **Outcome**: This helped in managing the ingestion workload more effectively, ensuring that the data nodes were not overwhelmed by both search queries and data processing tasks.

#### Step 3: Fine-Tuning and Monitoring

- **Action**: The service implemented a monitoring system to track the performance and resource utilization of each node, adjusting their roles and resources as necessary to match the workload.
- **Outcome**: This dynamic approach allowed them to scale resources up or down for specific nodes, aligning operational costs more closely with actual needs.

### Results

- **Performance Improvement**: The role-based configuration and tiered data node strategy improved query performance and data processing speeds, particularly during peak times.
- **Cost Efficiency**: By tailoring the hardware specifications to the role of each node, the service significantly reduced their hardware and operational costs. Cold nodes, for example, used less expensive storage to hold less frequently accessed data, while dedicated master nodes operated on cost-effective hardware.
- **Enhanced Scalability**: The service was able to scale different parts of the cluster independently, adding hot nodes during promotional events for new content releases, and scaling back during off-peak periods, further optimizing costs.

### Conclusion

This example underscores the importance of a role-based node configuration in Elasticsearch clusters, especially for businesses with variable data and workload patterns. By strategically assigning node roles and adjusting resources based on real-time demands, organizations can achieve both operational efficiency and cost savings, ensuring their infrastructure can scale flexibly with their needs.

----
----

## Which specs should I use for each node type?

Selecting the appropriate specifications for each type of node in an Elasticsearch cluster depends on the role of the node and the specific workload it will handle. Here's a general guideline on what specs to consider for different node types, keeping in mind that these should be adjusted based on your actual use case, data volume, query complexity, and performance requirements:

### 1. Master Nodes

- **Purpose**: Managing the cluster state, including keeping track of nodes and shard allocation. They do not handle data directly or execute user queries.
- **Specs**:
    - **CPU**: Moderate CPU resources are sufficient since they are not heavily involved in query or data processing.
    - **RAM**: At least 8GB of RAM, but 16GB is recommended for larger clusters to manage the cluster state efficiently.
    - **Storage**: SSDs are preferred for faster access to cluster state data, although storage requirements are not high. A moderate-sized SSD (e.g., 250GB) should suffice.

### 2. Data Nodes

- **Purpose**: Storing data and executing data-related operations such as search and aggregation queries.
- **Specs**:
    - **CPU**: High CPU resources for processing queries and aggregations. The exact requirements depend on your query load.
    - **RAM**: The more, the better, since Elasticsearch relies heavily on memory for caching and faster data access. 32GB to 64GB of RAM is common, but for large datasets or heavy query loads, more may be necessary.
    - **Storage**: High-capacity SSDs are recommended for faster data access and improved I/O performance. The size depends on your data volume and growth projections.

### 3. Ingest Nodes

- **Purpose**: Preprocessing documents before indexing (e.g., applying transformations, enrichments).
- **Specs**:
    - **CPU**: Moderate to high CPU resources depending on the complexity of preprocessing tasks.
    - **RAM**: At least 16GB to accommodate the overhead of processing documents, with more required for complex transformations or high-volume ingestions.
    - **Storage**: Moderate-sized SSDs are typically sufficient since these nodes are not primarily used for long-term storage.

### 4. Coordinating Nodes

- **Purpose**: Coordinating client requests and aggregating results from data nodes, without storing data themselves.
- **Specs**:
    - **CPU**: High CPU resources to manage concurrent queries and compile results from data nodes.
    - **RAM**: High memory is beneficial for managing large aggregations and response data. 16GB to 32GB of RAM can be a good starting point, with adjustments based on the complexity and volume of queries.
    - **Storage**: Minimal storage requirements since they do not store data. SSDs are preferred for operating system and Elasticsearch software for better overall performance.

### 5. Hot/Warm/Cold Nodes (for tiered storage architectures)

- **Hot Nodes**: High-performance CPUs and RAM (similar to data nodes), with fast SSDs to handle active indexing and querying.
- **Warm Nodes**: Moderate CPU and RAM, with larger but slightly slower SSDs or high-performance HDDs, for less frequently accessed data.
- **Cold Nodes**: Lower CPU and RAM can be sufficient, with high-capacity HDDs for storing rarely accessed data.

### General Recommendations

- **Networking**: Fast networking is crucial for all node types to facilitate quick data transfer and communication within the cluster.
- **Overprovisioning**: Initially, it might be wise to slightly overprovision resources to accommodate unexpected spikes in load or data growth, with monitoring to adjust as needed.
- **Monitoring and Adjustment**: Regularly monitor the performance and resource utilization of your nodes to fine-tune their specifications over time based on actual usage patterns and requirements.

Choosing the right specs for each node type in your Elasticsearch cluster is critical for achieving optimal performance and cost-efficiency. It's important to start with a solid understanding of your workload and be prepared to adjust your configuration as your needs evolve.
