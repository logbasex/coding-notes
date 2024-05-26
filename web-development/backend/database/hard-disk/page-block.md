## References
- [On Disk IO, Part 5: Access Patterns in LSM Trees](https://medium.com/databasss/on-disk-io-access-patterns-in-lsm-trees-2ba8dffc05f9)

=====
=====

# Random Reads on SSDs

On _HDDs_, sequential access is preferred to random because of their physical organisation and the way they work. Read/write head is attached to the mechanical arm that has to travel across the disk in order to read the blocks of data; disk has to rotate in to position the track sector under read/write head. This all involves a non-trivial amount of movement. Operating System tries to amortise the costs by caching, buffering and scheduling operations optimally.

SSDs are made of electronics and do not have any moving components. In this regard, SSDs are inherently different from HDDs and there’s no performance degradation caused by where data is stored on disk physically. However, current SSD technology suffers from the performance degradation caused by _write amplification_. Lack of moving parts allows for several other characteristics, such as parallelism, but we won’t be discussing them in this article.

**Minimal read unit on SSD is _page_.** Reads and writes are performed in pages. Deleting a page worth of data does not immediately remove data physically. Instead, a page is marked as stale and will wait for Garbage Collection to reclaim free space.

> **Because writes are performed in pages, even if a single byte has to be updated, the whole page will be written anyway. At the same time, because of the specifics of NAND storage, pages can not be updated in place, so writes can be performed only into the empty pages. These two properties attribute for the _write amplification_ on SSDs.**

After an extensive amount of random writes, an FTL (Flash Transportation Layer) runs out of free pages and has to perform _Garbage Collection_: a process that reads, consolidates then and writes active pages in free blocks, freeing blocks, occupied by stale pages and reclaiming disk space.

Some SSDs implement background Garbage Collection, which takes advantage of idle time in order to consolidate blocks and reclaim stale pages before new data has to be written, which ensures that future foreground write processes have enough free pages available. But given enough write pressure, Garbage Collection process may not keep up with the amount of work, negatively impacting write performance.

A key goal of log-structured systems is sequentialising writes. However, if the FTL is shared by two log- structured applications (or even a single application with multiple append streams), the incoming data into the FTL is likely to look random or disjoint. You can read more about “stacking” log operations in [this paper](https://www.usenix.org/system/files/conference/inflow14/inflow14-yang.pdf).

We’ve discussed multiple things one has to take into consideration when working with SSDs. _Writing complete pages_ is better than writing data smaller than the page size, since the smallest SSD unit storage is a page. Because updating page will effectively allocate a new page and invalidate the previous one, updates may result into Garbage Collection. It’s better to _keep the write operations page-aligned_ in order to avoid additional write multiplication. And last, _keeping the data with similar lifecycle together_ (e.g. the data that would be both written and discarded at the same time) will be beneficial for performance. Most of these points are points speak favour of immutable LSM-like Storage, rather than systems that allows in-place updates: writes are batched and SSTables are written sequentially, files are immutable and, when deleted, the whole file is invalidated at once.

=====
=====

## why the SSD has to rewrite the entire page where that bit is located?

SSDs use flash memory for storage, which works differently from traditional hard drives. Here's why rewriting the entire page is necessary:

* **Limited write ability:** Flash memory cells can only be switched between states (set to 1 or 0) a limited number of times. Unlike a hard drive that can directly modify a bit, flash memory needs erasing the entire section before rewriting.

* **Page-based operations:** Flash memory works in pages, typically sized 512 bytes.  The SSD's controller can only erase or write to a whole page at once. Even if you only want to change a single bit, the entire page needs to be accessible.

Here's the process in simpler terms:

1. **Read the page:** The SSD controller first reads the entire page containing the bit you want to modify.
2. **Modify data in memory:** The controller creates a copy of the page in its internal memory and makes the desired change.
3. **Erase the page:** The original page in flash memory is erased.
4. **Write the modified page:** The updated page from memory, containing both the original data and your change, is written back to the now-empty space in flash memory.

This process ensures data integrity but adds some overhead compared to HDDs.  The SSD controller uses wear leveling techniques to spread write operations across different pages, maximizing the lifespan of the drive.

====
====

## why repeatedly erasing and writing to these cells weakens them over time, leading to potential data loss if exceeded?

Repeatedly erasing and writing to flash memory cells weakens them in a couple of ways, potentially leading to data loss if the endurance limit is exceeded:

1. **Dielectric breakdown:** Flash memory cells store data by trapping electrons in a floating gate.  The act of erasing involves applying a high voltage that forces electrons out of the gate.  Over time, this repeated high voltage stress can damage the insulating layer (dielectric) between the control gate and the floating gate. This weakens the cell's ability to hold a charge, making it harder to reliably distinguish between charged (1) and uncharged (0) states, potentially leading to data corruption or loss.

2. **Wear and tear:** The process of writing data also involves manipulating the charge state within the cell.  With each write cycle, some of the material within the cell can degrade or become trapped, reducing the overall capacity and reliability of the cell.  Imagine a tiny sponge used to represent the cell.  Repeatedly soaking and squeezing it can damage the sponge fibers, eventually limiting its ability to hold water (data).

These limitations define the endurance of a flash memory cell, which is typically specified as a number of program/erase (P/E) cycles.  Once a cell reaches its endurance limit, it becomes unreliable and may fail to retain data correctly.

Modern SSDs implement wear leveling techniques to mitigate this issue.  Wear leveling distributes write operations across different flash memory cells, ensuring no single cell experiences excessive wear. Additionally, they employ error correction codes (ECC) to detect and potentially correct errors that might occur during read/write operations.

Here's an analogy: Imagine writing on a piece of paper with a special pen.  Each write cycle weakens the paper slightly, and eventually, it becomes too fragile to write on reliably.  However, by carefully distributing your writing across different pages and using a special code to check for smudges, you can extend the lifespan of the paper (flash memory) significantly.

====
====

## Why SSD need concept of page, block?

SSDs rely on the concept of pages and blocks due to the limitations of flash memory technology compared to traditional hard drives. Here's the breakdown:

**Flash Memory Limitations:**

* **Limited Writes:** Flash memory cells can only be switched between states (0 or 1) a limited number of times. Unlike a hard drive that can directly modify a bit, flash memory requires erasing the entire section before rewriting.

* **Granularity:** Flash memory operates on groups of cells called pages, typically sized around 4 KB. The SSD controller can only access and modify data in these page-sized chunks.

**Why Pages and Blocks Matter:**

* **Efficiency:** Pages provide a balance between granularity and efficiency. They're small enough to avoid wasting flash memory by rewriting large chunks when you only need to change a tiny bit. Yet, they're large enough for efficient data transfer within the SSD.

* **Erase Operations:**  Since flash memory can only be erased in its entirety (pages), the concept of a block comes into play.  A block is a group of pages (often 64 to 128 pages) that the SSD controller can erase at once. This grouping allows for efficient use of erase operations, minimizing the number of times individual pages need to be subjected to the wear and tear of erasing.

**Analogy:**

Imagine a library with books made of fragile parchment.  Individual pages (paragraphs) can't be directly rewritten, and erasing a page (erasing a section) damages the parchment slightly.

* Pages: Represent manageable sections of information within a book. They're small enough to avoid wasting parchment when making small changes.

* Blocks: Represent groups of pages bundled together. The librarian can only erase an entire block (group of pages) at once. This minimizes the wear and tear on individual pages while allowing for efficient removal of outdated information.

**Benefits of Pages and Blocks:**

* **Optimizes Flash Memory Usage:** Pages and blocks prevent unnecessary rewrites and erases, prolonging the lifespan of the SSD.

* **Improves Write Performance:** By managing data in manageable chunks, the SSD controller can perform read/write operations more efficiently.

* **Enables Wear Leveling:**  SSDs use wear leveling techniques to distribute write operations across different blocks, ensuring no single block experiences excessive wear. This further extends the overall lifespan of the SSD.

In essence, pages and blocks are a compromise between efficient data access and managing the limitations of flash memory. They allow SSDs to function effectively while maximizing the endurance of the underlying storage technology.

====
====

## Why SSD need concept of page, block?

The concept of pages and blocks in SSDs (solid-state drives) arises from the underlying technology of NAND flash memory, which has specific characteristics and limitations. Here’s why these concepts are essential:

### NAND Flash Memory Structure

1. **Pages**:
    - **Definition**: A page is the smallest unit of data that can be written to or read from in a NAND flash memory.
    - **Typical Size**: Pages are typically 4KB to 16KB in size.
    - **Function**: Data is written to and read from NAND flash memory in pages.

2. **Blocks**:
    - **Definition**: A block is a collection of pages. It is the smallest unit that can be erased in NAND flash memory.
    - **Typical Size**: Blocks usually contain 64 to 256 pages.
    - **Function**: Blocks organize pages into larger units for efficient management of erasure and wear leveling.

### Why Pages and Blocks are Needed

1. **Efficient Data Management**:
    - **Read and Write Operations**: Reading and writing smaller units of data (pages) allow for efficient data access and manipulation. Pages provide a manageable size for these operations.
    - **Erasure Requirements**: NAND flash memory cells can only be reset (erased) at the block level. This allows for efficient management of the flash memory since erasing smaller units (pages) individually would be less efficient and could cause performance issues.

2. **Wear Leveling**:
    - **Longevity**: NAND flash cells wear out after a certain number of program/erase cycles. Managing data at the block level helps distribute wear evenly across the memory, extending the SSD’s lifespan.
    - **Wear Leveling Algorithms**: These algorithms work at the block level to ensure that no single block gets worn out prematurely.

3. **Garbage Collection**:
    - **Invalid Data Cleanup**: Over time, as data is updated, some pages within blocks become invalid (stale data). Garbage collection consolidates valid data and frees up entire blocks by erasing them.
    - **Space Reclamation**: By erasing blocks with invalid data, SSDs reclaim space for new writes, maintaining performance and storage efficiency.

4. **Write Amplification**:
    - **Minimization**: Managing writes and erasures at the page and block level helps minimize write amplification, where more data is written than the amount of data actually changed. This improves SSD performance and endurance.

### Practical Example

1. **Writing Data**:
    - When you write data, it’s written to pages. For example, writing a 10KB file may involve writing to several 4KB pages.

2. **Updating Data**:
    - If you update part of that file, the SSD cannot overwrite the existing pages directly. Instead, it writes the updated data to new pages and marks the old pages as invalid.

3. **Garbage Collection**:
    - Periodically, the SSD will perform garbage collection to consolidate valid data and erase blocks with a lot of invalid pages, freeing them up for future writes.

### Summary

- **Structural Necessity**: Pages and blocks are fundamental units in NAND flash memory that align with its physical characteristics and operational requirements.
- **Efficiency and Longevity**: These concepts enable efficient data management, wear leveling, and garbage collection, ensuring that the SSD operates effectively and has a long lifespan.
- **Performance Optimization**: By managing data at these levels, SSDs can optimize performance, reduce write amplification, and maintain high-speed data access.

In essence, pages and blocks are integral to how SSDs function, helping to manage the inherent limitations of NAND flash memory while optimizing performance and durability.

====
====

## Wear Leveling

### What is Wear Leveling?

Wear leveling is a technique used in SSDs (solid-state drives) to extend their lifespan. It ensures that all the memory cells in the SSD wear out evenly over time.

### Why is Wear Leveling Needed?

1. **Limited Write Cycles**:
    - NAND flash memory, which SSDs use, can only be written to and erased a limited number of times before it starts to wear out.
    - Some cells might get used more frequently than others, wearing out faster.

2. **Avoiding Early Failure**:
    - Without wear leveling, some parts of the SSD would wear out much sooner than others, leading to early failure of the drive.

### How Wear Leveling Works

1. **Even Distribution of Writes**:
    - Wear leveling spreads out the write and erase cycles evenly across all the memory cells in the SSD.
    - This prevents any single cell from being written to too frequently.

2. **Two Types of Wear Leveling**:
    - **Static Wear Leveling**: Moves rarely changed data to less used cells to ensure all cells are used evenly.
    - **Dynamic Wear Leveling**: Manages frequently changing data by spreading writes across all cells, not just the least used ones.

### Example

Imagine your SSD is like a chalkboard divided into sections, and each section can only be erased and rewritten a certain number of times.

- **Without Wear Leveling**:
    - You might end up writing and erasing the same section repeatedly, wearing it out quickly.
    - Other sections remain unused and fresh.

- **With Wear Leveling**:
    - The SSD makes sure to write and erase data in all sections more evenly.
    - When one section starts to wear out, it moves the data to a less used section, ensuring all sections get used over time.

### Visualizing Wear Leveling

- **Initial State**: All cells have similar wear levels.
  ```
  Cell 1: [ ] (unused)
  Cell 2: [ ] (unused)
  Cell 3: [ ] (unused)
  Cell 4: [ ] (unused)
  ```

- **Without Wear Leveling**: Repeatedly writing to Cell 1.
  ```
  Cell 1: [X][X][X][X] (wearing out quickly)
  Cell 2: [ ] (unused)
  Cell 3: [ ] (unused)
  Cell 4: [ ] (unused)
  ```

- **With Wear Leveling**: Writes are spread out.
  ```
  Cell 1: [X] (used a bit)
  Cell 2: [X] (used a bit)
  Cell 3: [X] (used a bit)
  Cell 4: [X] (used a bit)
  ```

### Benefits of Wear Leveling

- **Extended Lifespan**: By evenly distributing writes, wear leveling helps extend the overall lifespan of the SSD.
- **Reliability**: Prevents early failure by ensuring no single cell wears out too quickly.

In summary, wear leveling is like a smart system that ensures every part of your SSD is used evenly, making the drive last longer and work more reliably.