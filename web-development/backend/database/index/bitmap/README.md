## References
- [Bitmap Indexing in DBMS](https://www.geeksforgeeks.org/bitmap-indexing-in-dbms/)
- [Insights into Bitmap Index](https://levelup.gitconnected.com/insights-into-indexing-using-bitmap-index-c28a3db1ad97)
- [003: Hiểu về Index để tăng performance với PostgreSQL P2](https://viblo.asia/p/003-hieu-ve-index-de-tang-performance-voi-postgresql-p2-m68Z049MZkG)

## Overview
> Bitmap Indexing is a data indexing technique used in database management systems (DBMS) to improve the performance of read-only queries that involve large datasets. It involves creating a bitmap index, which is **a data structure that represents the _`presence`_ or _`absence`_ of data values in a table or column**.

> In a bitmap index, each distinct value in a column is assigned a bit vector that **represents the _`presence`_ or _`absence`_ of that value in each row of the table**. The bit vector contains one bit for each row in the table, where a set bit indicates the presence of the corresponding value in the row, and a cleared bit indicates the absence of the value

![](bitmap-index.png)


> A bitmap is the combination of two words: **bit** and **map**. A bit can be termed as the smallest unit of data in a computer and a map can be termed as a way of organizing things.


![](bitmap-index-data.png)

4 rows -> 4 bits 

![](bitmap-index-indexing-1.png)

![](bitmap-index-indexing-2.png)

Only the second bit value = 1 => Only row 2 is the matching row.

![](bitmap-index-and-operator.png)