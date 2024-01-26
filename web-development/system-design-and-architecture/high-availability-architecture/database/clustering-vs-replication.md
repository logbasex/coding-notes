## Show me clustering vs replication common pattern

Sure, I can describe common patterns of clustering and replication in the context of High Availability (HA) architectures:

### Clustering

Clustering refers to a group of servers (nodes) working together to operate as a single system. The primary goal of clustering is to ensure high availability and load balancing.

#### Common Clustering Patterns:

1. **Active-Passive Clustering**:
    - **Structure**: Includes primary (active) and secondary (passive) nodes. The active node handles all the workload under normal conditions.
    - **Function**: In case of failure of the active node, one of the passive nodes takes over, ensuring minimal service disruption.
    - **Use Case**: Ideal for services where uninterrupted availability is critical but the resource utilization is not constant.

2. **Active-Active Clustering**:
    - **Structure**: All nodes are active and share the workload.
    - **Function**: If one node fails, its workload is redistributed among the remaining active nodes.
    - **Use Case**: Suitable for systems with high traffic and constant load, as it allows for load balancing and redundancy.

3. **Load-Balanced Cluster**:
    - **Structure**: Multiple nodes are used to distribute the workload evenly.
    - **Function**: A load balancer distributes incoming requests to different nodes to prevent any single node from becoming a bottleneck.
    - **Use Case**: Commonly used in web server environments where traffic can be unpredictable and needs to be evenly distributed.

### Replication

Replication involves duplicating data from one database (or server) to another to ensure data availability and redundancy.

#### Common Replication Patterns:

1. **Master-Slave Replication**:
    - **Structure**: One primary (master) database and one or more secondary (slave) databases.
    - **Function**: The master database handles all write operations, while the slave databases replicate the data from the master and handle read operations.
    - **Use Case**: Useful when read operations are more frequent than write operations.

2. **Multi-Master Replication**:
    - **Structure**: Multiple master databases that can handle both read and write operations.
    - **Function**: Each master replicates its data to the other masters, providing redundancy and improving write availability.
    - **Use Case**: Ideal for distributed systems where write operations are needed at multiple geographical locations.

3. **Peer-to-Peer Replication**:
    - **Structure**: Each node (peer) acts both as a supplier and consumer of data.
    - **Function**: Data can be updated on any node, and changes are propagated to other nodes.
    - **Use Case**: Suitable for decentralized environments where data needs to be synchronized across multiple locations without hierarchical relationships.

### Conclusion

- **Clustering** is primarily about maintaining high availability and load balancing, with different nodes capable of taking over or sharing the workload.
- **Replication** focuses on data redundancy and consistency, ensuring that data is available and up-to-date across different servers or databases.

Both clustering and replication are critical in designing robust HA systems, and they often work in tandem. For instance, a database cluster might use replication to synchronize data across its nodes, combining both patterns for enhanced availability and reliability.