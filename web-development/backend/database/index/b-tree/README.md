 ## References
- [The Power of Database Indexing Algorithms: B-Tree vs. Hash Indexing](https://dip-mazumder.medium.com/the-power-of-database-indexing-algorithms-b-tree-vs-hash-indexing-6e3a4112a81)
- [Why do SQL databases use a B-tree index instead of a hash index?](https://medium.com/@saikatb/why-do-sql-databases-use-a-b-tree-index-instead-of-a-hash-index-fdd22ebac21b)

---
---

## The Power of Database Indexing Algorithms: B-Tree vs. Hash Indexing

> A B-tree index is a **self-balancing tree** data structure that **keeps data sorted and allows searches, sequential access, insertions, and deletions in logarithmic time**.
> 
> B-tree indexes are **optimized for range queries** because they can efficiently find all records within a range of values. This is because the records are stored in sorted order in the index. Leverages to use **column comparisons** in expressions that **use the `=`, `>`, `>=`, `<`, `<=`, or `BETWEEN` operators**.

