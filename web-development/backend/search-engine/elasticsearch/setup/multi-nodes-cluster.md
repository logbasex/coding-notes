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