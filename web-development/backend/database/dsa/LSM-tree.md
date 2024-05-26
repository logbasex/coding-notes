## References
- [From Log-Structured Merge-Tree storage engine to a toy database](https://careers.coccoc.com/blogs/from-log-structured-merge-tree-storage-engine-to-a-toy-database)

====
====

> LSMTree is a data structure that allows append-only operations, that’s why it stands by its name, “Log-structured”. **The database is simply a very big log containing all the key-value pairs, and all the modifications such as create, update, and delete are treated the same — insert new records into the big log**. The design sounds very unintuitive at first look, but it brings to the table a remarkable benefit that no other engines can afford: being append-only means writes will always be sequential, maintaining high throughput, low latency, no disk seek, no write amplification (as in BTree)... Now you have a faint idea of why LSMTree is write-preferable. Let’s go on, a database is not that simple.

Yes, the initial idea behind an LSM (Log-Structured Merge) tree is quite simple and elegant. Let's break it down to its core components:

### Initial Idea of LSM Tree

1. **Log-Structured Writes**:
    - **Sequential Writes**: Instead of writing data in place (as with traditional B-trees), all writes are appended to a log. This means that every write operation (insert, update, delete) is simply added to the end of the log. This approach takes advantage of the efficiency of sequential writes, which are much faster than random writes.

2. **In-Memory Buffer**:
    - **Memtable**: Incoming writes are first written to an in-memory buffer called the memtable. This buffer is typically implemented as a sorted data structure (like a balanced tree or a skip list) to allow for fast inserts and lookups.

3. **Persistent Storage**:
    - **SSTables**: When the memtable reaches a certain size, it is flushed to disk as a Sorted String Table (SSTable). SSTables are immutable, sorted files on disk. Each SSTable contains a batch of writes that were in the memtable.

4. **Read Path**:
    - **Searching**: To read a value, the system first checks the memtable. If the value is not found in the memtable, it searches through the SSTables. Since SSTables are sorted and immutable, they can be searched efficiently.

5. **Compaction**:
    - **Merging**: Over time, multiple SSTables accumulate, which can slow down read operations. To address this, a process called compaction is used. Compaction merges multiple SSTables into a single SSTable, discarding any obsolete entries (like deleted records) and consolidating the data to maintain read performance.

### Simplified Diagram

```
Write Operation:
Client -> Memtable (In-Memory, Sorted Structure) -> SSTable (On Disk, Immutable)

Read Operation:
Client -> Memtable -> SSTables

Compaction:
Multiple SSTables -> Compaction Process -> Fewer, Larger SSTables
```

### Example

Imagine a simple key-value store using an LSM tree:

1. **Insert (key1, value1)**: Append to the memtable.
2. **Insert (key2, value2)**: Append to the memtable.
3. **Memtable Full**: Flush to disk as SSTable1.
4. **Insert (key3, value3)**: Append to the (now empty) memtable.
5. **Delete (key1)**: Append a delete marker (tombstone) to the memtable.
6. **Memtable Full Again**: Flush to disk as SSTable2.
7. **Read (key1)**: Check memtable (find tombstone, key1 deleted), then SSTables if necessary.
8. **Compaction**: Merge SSTable1 and SSTable2, removing the tombstone and any obsolete entries.

### Key Benefits

1. **High Write Throughput**: Sequential writes to the log and memtable ensure high write performance.
2. **Efficient Read Performance**: Even though multiple SSTables may need to be searched, the use of Bloom filters and sorted data structures keeps reads efficient.
3. **Compaction**: Periodic compaction ensures that the number of SSTables remains manageable, improving read performance and reclaiming storage space.

### Conclusion

The initial idea of the LSM tree is to use a log-structured approach to handle writes efficiently, leveraging an in-memory buffer (memtable) for fast writes and periodic flushing to disk as immutable, sorted tables (SSTables). This simple yet powerful concept allows for high write throughput and effective management of storage and read performance through compaction.

====
====

## Update/Delete operation

In an LSM (Log-Structured Merge) tree, updates and deletes are handled differently compared to traditional data structures due to its append-only nature. Let's go into detail about how these operations are managed.

### Update Operations

**Concept**:
- In an LSM tree, an update is treated as a new write operation rather than modifying an existing record in place.

**Process**:
1. **Write to Memtable**:
    - When an update for a key is received, it is written to the in-memory structure (memtable). The new value for the key overwrites the previous value in the memtable if it exists.
2. **Write-Ahead Log (WAL)**:
    - The update is also appended to the write-ahead log to ensure durability. This ensures that in case of a crash, the update can be recovered.
3. **Flushing to SSTable**:
    - When the memtable is flushed to disk (due to reaching its size limit), the updated key-value pair is written to a new SSTable file on disk.
4. **Compaction**:
    - During compaction, the old value of the key (if it exists in older SSTables) is discarded, and the new value is retained. This process ensures that there is only one version of the key in the resulting SSTable after compaction.

### Delete Operations

**Concept**:
- Deletes are handled by writing a special marker called a "tombstone" to indicate that the key has been deleted.

**Process**:
1. **Write to Memtable**:
    - A tombstone marker is written to the memtable for the key that needs to be deleted. This tombstone effectively marks the key as deleted.
2. **Write-Ahead Log (WAL)**:
    - The tombstone is also appended to the write-ahead log to ensure durability.
3. **Flushing to SSTable**:
    - When the memtable is flushed, the tombstone is written to a new SSTable.
4. **Read Handling**:
    - During a read operation, if a tombstone is encountered for a key, it indicates that the key has been deleted, and the key is ignored in the results.
5. **Compaction**:
    - During compaction, SSTables are merged, and any keys marked with tombstones are removed from the resulting SSTable. This process reclaims space and ensures that deleted keys do not persist indefinitely.

### Example Walkthrough

#### Update Operation Example

1. **Initial State**:
    - Key `key1` with value `value1` exists in the memtable.
    - Memtable is flushed to SSTable1: `(key1, value1)`.

2. **Update Operation**:
    - Update `key1` to `value2`.
    - Memtable now contains: `(key1, value2)`.

3. **Flushing**:
    - When the memtable is flushed, it creates SSTable2 with: `(key1, value2)`.

4. **Compaction**:
    - SSTable1: `(key1, value1)`
    - SSTable2: `(key1, value2)`
    - Compaction merges these, resulting in: `(key1, value2)` in the new SSTable.

#### Delete Operation Example

1. **Initial State**:
    - Key `key1` with value `value1` exists in the memtable.
    - Memtable is flushed to SSTable1: `(key1, value1)`.

2. **Delete Operation**:
    - Delete `key1`.
    - Memtable now contains: `Tombstone(key1)`.

3. **Flushing**:
    - When the memtable is flushed, it creates SSTable2 with: `Tombstone(key1)`.

4. **Read Operation**:
    - A read for `key1` checks the memtable first (if it's still there) and then SSTable2. The tombstone indicates `key1` is deleted, so no value is returned.

5. **Compaction**:
    - SSTable1: `(key1, value1)`
    - SSTable2: `Tombstone(key1)`
    - Compaction merges these, resulting in no entry for `key1` in the new SSTable (both the old value and the tombstone are discarded).

### Key Points

- **Updates** are new writes with the same key. The latest value is determined during reads or compaction.
- **Deletes** use tombstones to mark keys as deleted. These tombstones are processed and removed during compaction to free up space.

This approach ensures high write throughput and efficient management of updates and deletes, leveraging the strengths of the append-only and log-structured nature of LSM trees.

====
====

Yes, LSM Trees (Log-Structured Merge Trees) are indeed a fascinating and efficient way to handle high-throughput write operations in databases. They differ significantly from traditional B-trees, which makes them particularly suitable for modern workloads with heavy write demands. Here’s a deeper look into LSM Trees and how they function within a database context:

### Basic Concept of LSM Trees

**Append-Only Design**: As you've mentioned, LSM Trees employ an append-only design. Instead of updating records in place, they simply append new versions of records to a log. This means:

1. **Sequential Writes**: Since all writes are sequential, this eliminates the costly random disk I/O operations, leading to higher throughput and lower latency.
2. **No Write Amplification**: Unlike B-trees, where an update might necessitate multiple disk writes (to maintain tree balance), LSM Trees minimize this by appending data.

### Components of an LSM Tree

1. **Memtable**: This is an in-memory data structure (often a sorted tree or skip list) where incoming writes are initially stored. It ensures very fast write operations.
2. **SSTables (Sorted String Tables)**: Once the memtable reaches a certain size, it is flushed to disk as an immutable SSTable. SSTables are sorted and can be efficiently read.
3. **WAL (Write-Ahead Log)**: To ensure durability, writes are also logged to a WAL before being added to the memtable. This guarantees that data is not lost in case of a crash.

### Operations in LSM Trees

- **Write Operations**: New records are written to the WAL and memtable. When the memtable is full, it is flushed to disk as an SSTable.
- **Read Operations**: Reads first check the memtable, then any SSTables on disk. To optimize this, Bloom filters are often used to quickly check if an SSTable might contain the desired record.
- **Compaction**: Over time, multiple SSTables accumulate, which can slow down reads. Compaction is the process of merging and reorganizing SSTables to maintain read efficiency. This process consolidates SSTables and removes deleted or obsolete entries.

### Advantages of LSM Trees

1. **High Write Throughput**: Sequential writes ensure that the system can handle high write rates efficiently.
2. **Efficient Storage Management**: Compaction helps in reclaiming space by removing outdated records and merging smaller SSTables into larger ones.
3. **Scalability**: LSM Trees can handle very large datasets due to their efficient write and storage management.

### Challenges and Considerations

1. **Compaction Overhead**: While compaction improves read performance, it can introduce overhead and latency. Effective strategies and configurations are essential to balance this.
2. **Read Amplification**: While writes are efficient, reads might need to check multiple SSTables, which can introduce read amplification. Optimizations like Bloom filters and proper tuning of compaction can mitigate this.
3. **Tuning**: Proper tuning of memtable size, SSTable size, and compaction frequency is critical for optimal performance.

### Conclusion

LSM Trees provide a robust solution for databases that need to handle high write volumes efficiently. They offer unique advantages over traditional B-trees, particularly in write-heavy workloads, by leveraging sequential writes and minimizing write amplification. However, they require careful management of read operations and compaction processes to maintain overall system performance. This makes LSM Trees a powerful tool in the design of modern, high-performance databases.

====
====

## What is Sequential Writes in context of SSD?

In the context of SSDs (Solid State Drives), sequential writes refer to the process of writing data in a continuous, linear order to the storage medium. This is in contrast to random writes, where data is written to non-adjacent locations on the storage device. Sequential writes are particularly beneficial for SSDs due to their unique architecture and operational characteristics.

### Key Characteristics and Benefits of Sequential Writes on SSDs

1. **Performance**:
    - **Higher Throughput**: Sequential writes can be executed more quickly than random writes because they take advantage of the SSD’s ability to write large contiguous blocks of data efficiently.
    - **Lower Latency**: By minimizing the overhead associated with addressing multiple disparate locations on the drive, sequential writes can achieve lower latency compared to random writes.

2. **Wear-Leveling**:
    - **Prolonged Lifespan**: SSDs have a limited number of write/erase cycles per memory cell. Sequential writes can contribute to more even wear-leveling, which helps in extending the lifespan of the SSD by spreading the write/erase cycles more evenly across the storage cells.

3. **Reduced Write Amplification**:
    - **Efficiency**: Write amplification is a phenomenon where the actual amount of data written to the storage cells is greater than the amount of data intended to be written. Sequential writes reduce write amplification by minimizing the need for frequent erasure and rewriting of data blocks, thus improving the efficiency of the write process.

### How Sequential Writes Work in SSDs

- **NAND Flash Memory**: SSDs are built on NAND flash memory, which stores data in cells organized in pages and blocks. Writing data sequentially aligns well with the way NAND flash memory operates, allowing for efficient utilization of pages and blocks.
- **Garbage Collection**: SSDs periodically perform garbage collection to clean up and consolidate free space. Sequential writes can simplify garbage collection by reducing fragmentation, which in turn can enhance write performance and endurance.
- **Controller Optimization**: Modern SSD controllers are designed to optimize sequential write operations. They can buffer and write data in large chunks, further enhancing the performance of sequential writes.

### Comparison with Random Writes

- **Random Writes**:
    - Involve writing data to non-sequential addresses on the SSD.
    - Typically result in higher latency and lower throughput due to the need to manage non-contiguous data locations.
    - Increase write amplification and can lead to more frequent garbage collection cycles, thereby potentially reducing the SSD's lifespan.

### Practical Applications

- **Log-Structured Merge Trees (LSM Trees)**: As mentioned earlier, LSM Trees benefit from sequential writes because they append data in a continuous manner. This aligns well with SSDs’ strengths, leading to improved performance.
- **Database Systems**: Many modern databases optimize for sequential writes to take advantage of SSD characteristics, ensuring high write throughput and durability.
- **File Systems**: Some file systems are designed to optimize for sequential writes, especially in environments where large files are frequently written and modified.

### Conclusion

Sequential writes are a critical aspect of optimizing SSD performance and longevity. By writing data in a linear, contiguous fashion, sequential writes leverage the inherent strengths of SSD architecture, providing higher throughput, lower latency, and more efficient use of the storage medium. This makes them particularly suitable for applications and systems that require high write performance and durability.

====
