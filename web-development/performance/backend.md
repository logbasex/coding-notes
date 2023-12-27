- https://www.alibabacloud.com/blog/a-handy-guide-to-optimizing-your-java-applications_595958?spm=a2c65.11461447.0.0.670714a72ryPud

## [How to improve API performance?](https://twitter.com/alexxubyte/status/1668998337205501952)

1. Pagination
- This is a common optimization when the size of the result is large. The results are streaming back to the client to improve the service responsiveness.

2. Asynchronous Logging
- Synchronous logging deals with the disk for every call and can slow down the system. Asynchronous logging sends logs to a lock-free buffer first and immediately returns. The logs will be flushed to the disk periodically. This significantly reduces the I/O overhead.

3. Caching
- We can cache frequently accessed data into a cache. The client can query the cache first instead of visiting the database directly. If there is a cache miss, the client can query from the database. Caches like Redis store data in memory, so the data access is much faster than the database.

4. Payload Compression
- The requests and responses can be compressed using gzip etc so that the transmitted data size is much smaller. This speeds up the upload and download.

5. Connection Pool
- When accessing resources, we often need to load data from the database. Opening the closing db connections add significant overhead. So we should connect to the db via a pool of open connections. The connection pool is responsible for managing the connection lifecycle.


![image](https://gist.github.com/assets/22516811/76d1db6b-f3c1-4499-9a5d-3398f4dcc028)

