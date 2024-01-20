## References
- [Java NIO: Using Memory-mapped file to load big data into applications](https://medium.com/@trunghuynh/java-nio-using-memory-mapped-file-to-load-big-data-into-applications-5058b395cc9d)

----
----

> Somehow like Database Caching/ Direct Memory Access

----
----

## Why memory mapped file IO can avoid explicit read/write system calls 

Memory-mapped file I/O is a technique that can avoid explicit read/write system calls, which are commonly used in traditional file I/O operations. Here's how memory-mapped file I/O achieves this:

1. **Mapping File to Memory**: In memory-mapped I/O, a file is mapped directly into the virtual memory space of a process. This means that a portion of the virtual memory is dedicated to the contents of the file. The operating system (OS) sets up this mapping, creating a correspondence between a range of memory addresses and the contents of the file.

2. **Accessing File Data as Memory**: Once the file is mapped, reading from or writing to the file is done by accessing these memory addresses directly, just like accessing any other variable in memory. This is different from traditional file I/O, where you would use explicit system calls like `read()` or `write()` to interact with the file.

3. **OS Handles Synchronization**: When you read from or write to the memory area that's mapped to the file, the operating system transparently handles the actual I/O operations with the file on the disk. For example, when you write to a memory address that's mapped to a file, the OS will eventually write those changes back to the file. This process is often optimized and may not happen immediately.

4. **Efficiency**: Memory-mapped I/O can be more efficient than traditional file I/O for several reasons:
    - **Reduced System Calls**: Because you're accessing memory directly, you don't need to make system calls for each read or write operation. System calls are relatively expensive in terms of CPU time because they require switching from user mode to kernel mode.
    - **Page Caching**: The OS can use its virtual memory system to cache file data, which can improve performance, especially for random access patterns.
    - **Lazy Loading**: The entire file does not need to be loaded into memory at once. The OS can load pages of the file as they are accessed (demand paging), which can be more efficient for large files.

5. **Use Cases**: Memory-mapped file I/O is particularly useful for applications that require frequent, random access to large files, such as databases or large data processing tasks.

In summary, memory-mapped file I/O can avoid explicit read/write system calls by mapping file contents directly into a process's memory space, allowing file data to be accessed just like regular memory. This can lead to performance improvements due to reduced system call overhead and better utilization of the OS's virtual memory and caching capabilities.

----
----

## How memory mapped file IO works step by step

Memory-mapped file I/O is a method where a file on disk is mapped to a segment of memory. This process simplifies file access by treating file data as part of the application's memory space. Here's a step-by-step explanation of how it works:

1. **Open the File**: The process begins with opening the file that needs to be memory-mapped. This is typically done using standard file opening functions provided by the operating system.

2. **Create a Memory Mapping**: The application requests the operating system to create a memory mapping of the file. This is usually done through a specific system call (e.g., `mmap` on Unix-like systems, `CreateFileMapping` and `MapViewOfFile` on Windows). The application specifies the file descriptor, the desired access (read, write, etc.), and the size of the file or the portion of the file to map.

3. **Associate the File with Memory Space**: The operating system allocates a portion of the virtual memory space of the process to the file. The file's content is not immediately loaded into memory; instead, a virtual address space is created. This space will be used to access the file as if it were in memory.

4. **Accessing File Data**: Once the mapping is established, the application can access the file data using pointers, just like it would with any other block of memory. When the application reads from or writes to this memory, the operating system automatically handles reading from or writing to the file on disk. This process is transparent to the application.

5. **Page Faults and Lazy Loading**: Initially, the file data is not present in physical memory. When the application first accesses a part of the mapped memory, a page fault occurs. The operating system then loads the required part of the file (a page) into physical memory. This is known as "demand paging" or "lazy loading," as the file is loaded in chunks as needed.

6. **Write-back Mechanism**: If the file is mapped with write access and the application modifies the data in memory, these changes are not immediately written back to the disk. The operating system may delay writing this data back to the file to optimize disk I/O. This process is controlled by the OS's paging and caching mechanisms.

7. **Synchronizing Changes**: The application can request the operating system to synchronize the changes made in memory with the file on disk. This is usually done with specific system calls (e.g., `msync` on Unix-like systems).

8. **Unmapping**: When the application no longer needs access to the file, it informs the operating system, which then unmaps the file from the virtual memory. Any unsynchronized changes are typically written back to the disk at this point.

9. **Closing the File**: Finally, the file is closed using standard file closing functions.

Memory-mapped file I/O is particularly effective for applications that require random access to large files, as it allows portions of the file to be accessed and modified without reading the entire file into memory or making numerous system calls. This technique is commonly used in databases, file editors, and multimedia applications. However, it requires careful handling of synchronization and can have implications for data integrity and security, especially in systems where multiple processes may access the same memory-mapped file.

----
----

## Explain Memory-mapped file I/O at high level

Memory-mapped file I/O for reading a file involves creating a mapping between a portion of the process's virtual memory and a file on the disk. This allows the file to be accessed directly through memory, rather than using traditional read operations. Here's a high-level explanation of the process:

1. **Mapping the File**: The process begins by requesting the operating system to map the file into its virtual memory. This is typically done using specific system calls or API functions. The operating system then sets up a mapping, creating a direct correlation between a region of the process's virtual memory and the contents of the file.

2. **Accessing File Data**: Once the mapping is established, the file can be accessed just like any other array or block of memory. The process can read from specific locations in the mapped memory as if it were reading from an array. This bypasses the need for traditional file I/O system calls like `read()`.

3. **Efficient Data Access**: When the process reads from the mapped memory, the operating system transparently fetches the corresponding part of the file from the disk. This is generally more efficient than regular file reading, especially for random access, as it reduces the overhead of system calls and allows for faster data retrieval.

4. **Lazy Loading**: The entire file is not loaded into memory at once. Instead, the operating system loads only the necessary portions of the file into memory as they are accessed. This approach is particularly efficient for large files and reduces the overall memory footprint.

5. **Page Faults and Loading**: When the process accesses a part of the file that is not currently in memory, a page fault occurs. The operating system then loads the required part of the file into memory. This process is handled automatically and is transparent to the application.

6. **Shared Memory**: If multiple processes map the same file into their memory, they can read the file concurrently. This can be an effective way for processes to share data.

7. **Automatic Synchronization**: The operating system manages the synchronization between the file on disk and the memory-mapped region. Any updates made to the file by other processes or external changes are typically reflected in the memory-mapped region.

Memory-mapped file I/O for reading files is particularly useful when dealing with large files, as it allows for efficient and fast access to file data without the overhead of repeated system calls. It's widely used in applications like file viewers, text editors, databases, and any software that requires efficient access to large amounts of data on disk.

----
----

## Why Efficient Data Access

Memory-mapped file I/O offers efficient data access primarily due to the following reasons:

1. **Reduced System Call Overhead**: In traditional file I/O, every read or write operation involves a system call, which is a request to the kernel to perform I/O operations. These system calls are expensive in terms of CPU time because they require context switches between user space and kernel space. Memory-mapped file I/O bypasses these system calls for data access, allowing the application to access file data directly through memory. This reduction in system call overhead leads to faster data access.

2. **Leveraging Virtual Memory and Paging**: Memory-mapped files utilize the operating system's virtual memory system. The OS loads portions of the file into physical memory on-demand through a mechanism called paging. This means the application accesses data directly from RAM when it's available there, which is much faster than disk access. Additionally, the OS can optimize memory usage by only loading the necessary parts of the file into RAM, which is particularly beneficial for large files.

3. **Caching and Lazy Loading**: Operating systems typically cache frequently accessed data in RAM. When a memory-mapped file is accessed repeatedly, its data is likely to be cached, resulting in very fast subsequent access. Also, the lazy loading approach (loading data on-demand) ensures that the system's memory is used efficiently, as only the accessed parts of the file are loaded.

4. **Page Fault Handling**: When a process accesses a part of the memory-mapped file that is not currently in memory, a page fault occurs, and the OS loads the required data from disk to memory. This process is managed efficiently by the OS, and once the data is loaded into RAM, access to it is very fast.

5. **Concurrency and Shared Memory**: In scenarios where multiple processes need to access the same file, memory-mapping can be more efficient than traditional file I/O. Multiple processes can map the same file into their address spaces and access it concurrently. This shared memory approach can be more efficient than having multiple copies of the file data in each process's memory space.

6. **Operating System Optimizations**: Modern operating systems are highly optimized for handling virtual memory and paging. They employ advanced techniques to manage memory resources efficiently, predict access patterns, and preload data, further enhancing the efficiency of memory-mapped file I/O.

In summary, memory-mapped file I/O is efficient due to its reduced reliance on system calls, effective use of the virtual memory system, caching mechanisms, and the inherent advantages of accessing data in memory versus disk-based I/O. These factors make it a preferred method for high-performance applications that require frequent or random access to large files.
