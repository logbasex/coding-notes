## References
- [Database Buffer Pool - Part 1](https://samuel-sorial.hashnode.dev/database-buffer-pool-part-1)
- [Database Buffer Pool - Part 2](https://samuel-sorial.hashnode.dev/database-buffer-pool-part-2?source=more_series_bottom_blogs)

----
----
### 1. Multiple buffer pools

### 2. Pre-fetching

### 3. Scan sharing (Synchronized-scans)

### 4. Buffer pool bypass

----
----

## [Efficient Data Management with a Buffer Manager: Exploring the Heart of Database Systems](https://levelup.gitconnected.com/efficient-data-management-with-a-buffer-manager-exploring-the-heart-of-database-systems-a8944c24c33f)

> In the database, the **buffer** represents a temporary storage area in the main memory, which is used to cache database pages. Compare to the memory, the read and write speed of the disk is pretty slow, thus, when users want to get access to data from the disk, it might take a large amount of time. To improve performance, the **DBMS uses a buffer to temporarily hold frequently accessed data in memory**.

> It can also ensure data consistency. **Suppose one transaction adds certain values to the database, this update will first be written to the buffer before being written to disk**. When this transaction fails, the DBMS can still roll back the changes and return to a consistent state.

> The buffer pool is a collection of **pages** which is the data from the database. Memory is converted into a buffer pool by partitioning the space into frames that pages can be placed in. The main memory pages in the buffer pool are called **frames**, it is a unit of the buffer pool. A buffer frame can hold the same amount of data as a page can.

### What is the Buffer manager

> The buffer manager is one of the most important components of DBMS, **which shuffles data from main memory to disk**. It ensures the data requests and updates made by programs are satisfied by **copying data from disk to buffer pool or from buffer pool to disk**.

When a user requests data from the database, the buffer manager first checks if the data is already in the buffer pool. If it is, the buffer manager retrieves the data from memory and returns it to the user. If the data is not in the buffer pool, the buffer manager retrieves it from disk and loads it into memory.

The buffer manager also manages the write operations to the buffer pool. When a user modifies data in the database, the buffer manager writes the changes to the buffer pool instead of directly to the disk. The changes are then written to disk later when the buffer manager deems it necessary.

The buffer manager is a critical component of a DBMS as it can significantly impact the system’s performance. A well-designed buffer manager can help to reduce the number of disk accesses required, which can improve the overall performance of the system.

![](DBMS-buffer-pool.png)

Buffer pool in DBMS

### Buffer pool metadata

To track frames more efficiently, the buffer manager keeps some information for each frame in the pool. Here is an example:

| Frame ID | Page ID | dirty | pin_count |
|----------|---------|-------|-----------|
| 0        | 5       | 1     | 3         |
| 1        | 2       | 0     | 2         |
| 2        | 3       | 1     | 0         |

This table contains 4 pieces of information:

-   **Frame ID**: the id of each frame in the buffer pool
-   **Page ID**: for determining which page a frame currently contains
-   **dirty**: for determining whether the page has been modified since it was brought into the buffer pool from disk., if the page has been modified the Boolean variable; dirty is set as 1. otherwise 0
-   **pin\_count**: for tracking the number of requestors **currently using a page**, each time the page is requested, the “pin\_count” will increase, whenever it fulfills the request the “pin\_count” will decrease

### Replacement strategies

The buffer manager is responsible for caching data from disk in memory so that the user can access different pages faster. But the size of it is limited, so what would happen if the buffer pool becomes full? How does it decide which block should be evicted to make more room for new data?

There are multiple replacement strategies that are used by the current buffer manager, the goal of these strategies is to maximize the efficiency of the buffer pool by evicting blocks that are least likely to be accessed again in the near future.

**Least Recently Used (LRU) policy**

The best-known replacement policy is LRU. It works by maintaining a list of pages in memory and keeping track of the order in which each page was last accessed. When a page needs to be evicted from memory to make room for a new page, the page that was least recently used (i.e., the page that has not been accessed for the longest period of time) is chosen for eviction.

To implement the LRU page replacement algorithm, a queue of pointers is maintained. Each pointer in that queue point to a frame which `pin_count` is 0. Whenever the `pin_count` of that page goes to 0, it will be added to the end of that queue. And this algorithm will pick up the frame to replace at the head of the queue.

**Clock Replacement**

Sometimes the LRU policy can be costly, in order to make it more effective, the clock replacement was invented. In this policy, we don’t need to maintain a queue, but just a variable called `current`, and the page was chosen for replacement using the `current` variable. This variable ranges from 1 to X and X is the number of buffer frames. It is in a circular order so you can regard the whole frame being arranged in a circle like a clock's face, the `current` variable is the clock hand. Same as LRU, in this policy, each page will have a variable called `reference`, it will be turned on when `pin_count` goes to 0.

So, the whole process is: the algorithm will first choose the `current` frame for replacement. If that frame's `reference` bit is false, then the `current` clock hand will go to the next frame, and increase the current page's `pin_count`, until find a frame that has 0 `pin_count`.

**Most Recently Used (MRU) policy**

MRU follows the opposite strategy of LRU. The MRU selects the buffer page that has been accessed most recently and removes it from the buffer when a new page needs to be loaded.

Thanks for reading!


