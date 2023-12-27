## Overview
- https://medium.com/@Techiereads/unlocking-the-power-of-redis-8bee7bf36da7
- https://raphaeldelio.medium.com/10-things-you-didnt-know-about-redis-from-a-message-broker-to-a-graph-database-1fca6d0c28b3

----
----

## [Redis use cases](https://www.linkedin.com/posts/sahnlam_ive-used-redis-in-production-for-almost-activity-7119544967437418496-QmwG/?trk=public_profile_like_view)

![](https://media.licdn.com/dms/image/D5622AQH27tAmj9JMnA/feedshare-shrink_800/0/1697431794566?e=1706745600&v=beta&t=U749y8WCCXIJnQPvz96nqBX2GP9cS9-DgX8USqjc0us)

----
----

## [How does Redis persist data](https://www.linkedin.com/posts/alexxubyte_systemdesign-coding-interviewtips-activity-7143642585989804034-4n8t?utm_source=share&utm_medium=member_desktop)

![](https://media.licdn.com/dms/image/D4E22AQHOeEQmLiX-gg/feedshare-shrink_800/0/1703177120445?e=1706745600&v=beta&t=kpAjq8cNr10p9lmDHBqGo0QCV5282V6CfuyP3QaY30M)

----
----

## [Why is Redis fast](https://www.linkedin.com/posts/sahnlam_why-is-redis-fast-redis-is-fast-for-in-memory-activity-7140950344796200961-brGh?utm_source=share&utm_medium=member_desktop)

![](https://media.licdn.com/dms/image/C4E22AQEiNOn8Z3F2dQ/feedshare-shrink_800/0/1675788307343?e=1706745600&v=beta&t=W4b4u-ROxTx1tk5TyRc3H8XDF8ePPghWrzOBN0ZVBIw)

Sure, let's delve into more detail for each section of the image:

1. **RAM-based Access Times**:
    - This portion of the image illustrates the hierarchy of storage access times from fastest to slowest. Here are the specific components listed:
        - **Register**: The fastest form of memory access (0.3ns), registers are small storage areas in the CPU itself.
        - **L1 Cache**: Very fast CPU cache memory (0.9ns), but with limited storage capacity.
        - **L2 Cache**: Slightly slower than L1 (2.8ns), but larger.
        - **L3 Cache**: Shared among the CPU cores (12.9ns) and larger than L1 and L2, but slower.
        - **RAM**: General system memory used by Redis, slower than CPU caches (120ns) but much faster than persistent storage.
        - **SSD**: Solid-state drives are slower than RAM (50-150μs) but faster than HDDs.
        - **HDD**: Traditional hard disk drives are the slowest form of storage listed (1-10ms).
    - Redis's performance benefits significantly from operating in RAM, bypassing the slower read/write times associated with persistent storage.

2. **IO Multiplexing & Single-threaded read/write**:
    - **IO Multiplexing**: This technique allows Redis to monitor multiple sockets for IO events (like read or write readiness) using a single thread, which simplifies the architecture and reduces context switching overhead.
    - **Event Loop**: The core of the non-blocking IO model in Redis, where IO events are queued and processed in a loop.
    - **Event Queue**: A waiting area for events that are ready to be processed.
    - **Event Dispatcher**: This component delegates events from the queue to the appropriate event processors.
    - **Event Processors**: The handlers that perform the actual read or write operations when an event is dispatched to them.
    - **Multi-threaded vs. Single-threaded**: The diagram compares the complexity of multi-threaded models with the simplicity and efficiency of Redis's single-threaded event loop.

3. **Efficient Data Structures**:
    - **SDS (Simple Dynamic Strings)**: Redis strings are more complex than plain C strings, allowing for efficient storage and manipulation. They store metadata such as length and remaining free space to avoid the need to calculate the string length and to optimize memory allocations.
    - **LinkedList**: Used for Redis lists, which allows for constant time insertions and deletions, ideal for queues or stacks.
    - **HashTable**: The underlying structure for Redis hashes, providing efficient access to elements via a key.
    - **IntSet**: A specialized compact data structure used for sets that only contain integers.
    - **SkipList**: Part of the sorted set implementation, a skip list allows for O(logN) average time complexity for additions, removals, and searches, which is very efficient for a sorted collection.

The diagram also gives an example of an SDS with a buffer that contains the string "Redis," illustrating how Redis stores the length of the string, the amount of free space available, and the actual string data.

Lastly, the skip list example illustrates a multi-level index with forward pointers that allow for fast traversal over the sorted elements, significantly reducing the number of steps needed to find an element compared to a standard linked list.

### [Redis' Simple Dynamic String](https://chat.openai.com/c/d1da1a09-b236-4b4c-9eed-74f439442f53)

Alright! Since you have a year of development experience, let's dive into a more technical explanation of Redis' Simple Dynamic String (SDS).

Redis, known for its performance and flexibility, uses SDS to manage strings more efficiently compared to traditional C strings. Here's why SDS is beneficial:

1. **Length Awareness**: Unlike C strings, which rely on a null terminator to indicate the end, SDS strings store their length explicitly. This length metadata allows for constant-time (`O(1)`) operations to determine the string's length, avoiding the need to traverse the entire string as in C strings.

2. **Binary Safety**: SDS strings can contain any binary data, including null bytes (`'\0'`), which would normally signify the end of a string in C. This binary safety makes SDS suitable for storing non-text data, like images or serialized objects.

3. **Buffer Management**: Each SDS string maintains not just its length but also its allocated size. This distinction allows Redis to efficiently manage memory. When an SDS string needs to grow, it often has extra allocated but unused space (referred to as free space) that can be used, reducing the need for frequent memory reallocations.

4. **No Buffer Overflow**: Thanks to the explicit length and allocated size tracking, operations on SDS strings are less prone to buffer overflow vulnerabilities compared to standard C strings.

5. **Efficient Appending**: When appending data to an SDS string, Redis can often use the pre-allocated free space, making the operation faster. If the free space isn't sufficient, Redis reallocates the string with increased size. This process is more efficient than the typical C string concatenation, which often requires allocating a new string and copying data.

6. **Simplified String Manipulation**: Due to its structure and memory handling, SDS makes common string operations like concatenation, slicing, or modification simpler and more efficient than traditional C strings.

7. **Automatic Memory Management**: Redis handles the allocation and deallocation of SDS strings automatically, simplifying memory management for the developer.

In summary, SDS in Redis provides a more efficient, safe, and convenient way to handle strings, especially in the context of an in-memory database where performance and memory management are crucial.

## Redis Data Structure

- https://awstip.com/redis-and-its-data-structures-820a6dc3185f
- https://medium.com/analytics-vidhya/the-most-important-redis-data-structures-you-must-understand-2e95b5cf2bce