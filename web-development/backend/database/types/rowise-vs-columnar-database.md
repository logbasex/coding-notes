## Refenences
- https://mangatmodi.medium.com/rowise-vs-columnar-database-theory-and-in-practice-53f54c8f6505

----
----

Columnar database stores are getting increasingly popular lately especially in analytical query systems as data warehouse solutions. But how do they differ from old classic **row-oriented** databases? How do I decide which ones do I need to use for a given use case?

## The Theory
The major difference in both the datastores lies in the way they physically store the data on the disk. We know that persistent storage disks(hard disks?) are organized in blocks and have following usual properties for reading/write operations
> Head Seek operation is expensive in disks due to mechanical movement required. Read/Write is quite fast.
1. The whole block with data is loaded into the memory for reading by the operating system. Any further read for data for this block will happen from memory and will be super fast.
2. Read/Writing operations disks are not slow. only seek operation is slow. i.e. to move the head to the correct block to perform the operation.
3. Due to the above point — sequential read/writes are much faster on disks rather than the random access.

Here comes to major difference about row and columnar DBs
> Row oriented database tries to store whole row of the database in the same block but columnar database stores the values of the columns of subsequent in the same block

Following is an excellent diagram from Redshift’s documentation[1] to understand the difference.

![image](https://gist.github.com/assets/22516811/df777575-fd8d-466a-ad0c-045d06eb8124)
Figure1: Row wise.

![image](https://gist.github.com/assets/22516811/b6fa46a5-4637-41af-a1c6-1c3f2e9a53e6)
Figure2: Columnar wise

In Figure-1: SSN, Name etc all other properties of a row is stored in the same block, but however in Figure-2: SSN values of 33 consecutive rows are stored together.
## In Practice?

So now we understand the theoretical difference in the two popular ways to organize data on disk. But how does this difference translates to performance and difference use-cases?
1. Easy to guess — Row oriented databases perform best for the operations on the whole row and columnar for the operations on the columns.
2. Row oriented operations: Add/Delete/Update whole row. Retrieve the whole row.
3. Column Oriented Operations: Update columns, Aggregations, selecting a few columns, and any other operation, stored procedures, etc. which work on the columns only.
4. Since disk block contributes a lot to the performance it is recommended to have block size which is enough to fit the whole row for row wise DBs and for columnar keep reasonably high block size so that you can operate of more columnar data at one read.
5. Columnar Databases are quite slow for insertions as you insert a whole row.
6. Columnar DBs can optimize a lot of space as they keep homogenous data in a single block, so they can apply strategies to compress the data in a block. Similarly, over a huge number of columns and rows, they will have considerably less fragmentation as compared to row wise.
7. This is one of the reasons that Columnar DBs are popular as big data DBs because less storage means fewer costs, faster reads (read fewer blocks). And since OLAP systems generally work with big data and aggregations to produce small columns as output, Columnar DBs hit the sweet spots there
8. Due to the inherit nature of transactions, row-wise DBs are best fitted for OLTP systems.