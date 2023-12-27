## References
- https://vijini.medium.com/all-you-need-to-know-about-deleting-keys-from-b-trees-9090f3334b5c
- https://www.baeldung.com/cs/b-tree-data-structure
- https://www.youtube.com/watch?v=UzHl2VzyZS4
- https://iorilan.medium.com/those-data-structures-can-not-be-learned-from-leetcode-b-tree-b-tree-1d7ada823fae

## Root / Internal / Leaf node.

![image](https://user-images.githubusercontent.com/22516811/285895747-bdd6a60a-0492-41f3-9643-26ee2a927005.png)

![image](https://user-images.githubusercontent.com/22516811/285897369-c30be5d5-a96c-4906-8e19-7f6c39c22dd2.png)

## Comparison

### [B Tree](https://www.cs.usfca.edu/~galles/visualization/BTree.html)

![image](https://user-images.githubusercontent.com/22516811/285912031-5c2da061-404d-4968-b442-c32c7583c6f9.png)

### [B+ Tree](https://www.cs.usfca.edu/~galles/visualization/BPlusTree.html)

![image](https://user-images.githubusercontent.com/22516811/285912518-c7bdabf3-6600-40d5-91f5-ca2bbaeffb6a.png)

B+ trees offer several advantages over B-trees, particularly in database and file system applications. To illustrate these advantages, let's use an example involving a database storing a large number of records. We'll consider a simplified scenario with keys ranging from 1 to 30 and assume a maximum of 4 keys per node for both tree types.

### Example Scenario

Suppose we have a database that stores records with keys from 1 to 30. We want to organize these keys in either a B-tree or a B+ tree for efficient querying, updating, and deletion.

### B-Tree Structure with Example

In a B-tree:
- Each node can store up to 4 keys and have a maximum of 5 children.
- Both internal and leaf nodes store keys and data.

A possible B-tree structure might look like this:

```
            [8,     16,     24]
           /     |       |     \
        [1-7] [9-15]  [17-23] [25-30]
```

### B+ Tree Structure with Example

In a B+ tree:
- Internal nodes only store keys for navigation.
- Leaf nodes contain all the keys and their associated data.
- Leaf nodes are linked sequentially.

A possible B+ tree structure might look like this:

```
                     [16]
                 /            \
             [8]                   [24]
           /     \                /    \
 [1-4]  [5-7]   [9-12] [13-15] [17-20] [21-30]
```

### Advantages of B+ Tree Over B-Tree

1. **Efficient Range Queries and Sequential Access**:
    - In the B+ tree, since all keys are stored in the leaf nodes and these nodes are linked, range queries (e.g., find all records from 10 to 20) are much more efficient. You can simply find the starting point and follow the leaf node links.
    - In contrast, B-trees require more traversal because the data is spread throughout the tree.

2. **Better Disk I/O Performance**:
    - B+ trees have a higher branching factor for internal nodes (since they only store keys, not data), leading to a shallower tree. Fewer levels mean fewer disk accesses, which is crucial for performance.
    - In our example, the B+ tree is shallower compared to the B-tree.

3. **Consistent Data Access**:
    - In B+ trees, all leaf nodes are at the same depth, ensuring uniform data access times.
    - In B-trees, data can be stored at various depths, leading to inconsistent access times.

4. **Improved Space Utilization**:
    - B+ trees store data only in leaf nodes, allowing more keys in internal nodes. This results in better space utilization and a wider branching factor.
    - B-trees have less space for keys in internal nodes because they also include data.

5. **Simpler Deletion Algorithms**:
    - Deletion in a B+ tree is typically easier and more efficient because it only involves leaf nodes. Adjustments for maintaining tree balance are less complex.
    - In a B-tree, deletions might require rearranging or merging nodes at various levels.

### Conclusion

In the context of our example with keys 1 to 30, a B+ tree would allow for faster and more efficient range queries, better use of disk space, more consistent read times, and simpler maintenance compared to a B-tree. These advantages make B+ trees particularly suitable for database and file systems where large amounts of data are involved and disk access speed is a critical factor.

---
---

In the given B+ tree structure, to retrieve the range of numbers from 3 to 7, you would follow these steps:

1. **Start at the Root**: Begin at the root node `[16]`.

2. **Navigate to the First Key (3)**:
    - Since 3 is less than 16, move to the left child of the root, which is `[8]`.
    - In node `[8]`, since 3 is less than 8, move to its left child, which covers keys `[1-4]`.

3. **Retrieve Key 3**:
    - In the leaf node `[1-4]`, find and retrieve key 3.

4. **Sequentially Traverse to Key 7**:
    - Continue to the next key in the same leaf node for key 4.
    - Once you reach the end of this leaf node, follow the leaf node link to the next leaf node `[5-7]`.
    - In the leaf node `[5-7]`, retrieve keys 5, 6, and 7.

5. **End of Range Query**:
    - The range query concludes after retrieving key 7.

Here's a visualization of the path taken in the tree:

```
                     [16]
                 /            \
             [8]                   [24]
           /     \                /    \
 [1-4]  [5-7]   [9-12] [13-15] [17-20] [21-30]
```

- **Traversal Path**: Root (`[16]`) → Left child (`[8]`) → Left child (`[1-4]`) → Next leaf node (`[5-7]`).

- **Keys Retrieved**: 3, 4 from `[1-4]` and 5, 6, 7 from `[5-7]`.

This example demonstrates the efficiency of B+ trees in handling range queries, as it leverages the sequential organization of keys in the leaf nodes and the linked nature of these leaf nodes for quick access and retrieval.

---
---

## [What are the differences between B trees and B+ trees?](https://stackoverflow.com/questions/870218/what-are-the-differences-between-b-trees-and-b-trees)

![image](https://user-images.githubusercontent.com/22516811/285908169-a75f88ab-35f9-404f-bfcb-7e539a0145c2.png)

1. In a B tree search keys and data are stored in internal or leaf nodes. But in a B+-tree data is stored only in leaf nodes.
2. Full scan of a B+ tree is very easy because all data are found in leaf nodes. Full scan of a B tree requires a full traversal.
3. In a B tree, data may be found in leaf nodes or internal nodes. Deletion of internal nodes is very complicated. In a B+ tree, data is only found in leaf nodes. Deletion of leaf nodes is easy.
4. Insertion in B tree is more complicated than B+ tree.
5. B+ trees store redundant search keys but B tree has no redundant value.
6. In a B+ tree, leaf node data is ordered as a sequential linked list but in a B tree the leaf node cannot be stored using a linked list. Many database systems' implementations prefer the structural simplicity of a B+ tree.