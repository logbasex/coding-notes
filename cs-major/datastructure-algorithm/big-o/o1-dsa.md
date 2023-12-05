 ## Which data structure provide O(1) operation

Let's delve into more detail about the \( O(1) \) operations for each of these data structures:

1. **Arrays**
    - **Element Access**: Accessing an element in an array using its index is an \( O(1) \) operation because it involves a direct memory access.

2. **Hash Tables (Hash Maps)**
    - **Insertion, Lookup, and Deletion**: These operations are \( O(1) \) on average. A hash function maps keys to indices in an array, allowing direct access. However, performance can degrade to \( O(n) \) in the worst case due to collisions.

3. **Queues** (Circular Buffer or Linked List)
    - **Enqueue (Insertion)** and **Dequeue (Removal)**: These operations are \( O(1) \) because they involve updating a couple of pointers or indices, with no need to move other elements.

4. **Stacks** (Array or Linked List)
    - **Push (Insertion)** and **Pop (Removal)**: These operations are \( O(1) \) since they only involve adding or removing an element at one end of the stack.

5. **Linked Lists**
    - **Insertion and Deletion at the Head**: These are \( O(1) \) because they require updating only a few pointers, without the need to traverse the entire list.

6. **Heap (Binary Heap)**
    - **Find Min/Max**: The minimum (in a min-heap) or maximum (in a max-heap) element is always at the root, making this operation \( O(1) \).

7. **Priority Queue** (often implemented with Heaps)
    - **Peek**: This operation retrieves the element with the highest priority (in a max-priority queue) or lowest priority (in a min-priority queue), which is \( O(1) \) as this element is always at the root of the underlying heap.

8. **Bloom Filter**
    - **Query for Membership** and **Insertion**: Bloom filters use multiple hash functions to check or set bits in a bit array, which are \( O(1) \) operations.

9. **Direct Address Tables**
    - **Access, Insertion, and Deletion**: When keys are integers and directly map to indices in an array, these operations are \( O(1) \).

10. **Bit Set / Bit Array**
    - **Accessing, Setting, or Clearing a Bit**: These operations involve calculating the specific bit's position and then performing the bit manipulation, which are constant time operations.

11. **Unordered Set (Hash Set)**
    - **Insertion, Deletion, and Lookup**: Similar to hash tables, these operations are \( O(1) \) on average but can degrade in performance due to poor hash functions or high load factors.

12. **Circular Buffer**
    - **Insertion and Deletion**: If the buffer doesn't need resizing, adding or removing elements at the ends (head or tail) is \( O(1) \).

13. **Counting Sort Auxiliary Array**
    - **Incrementing Counts**: In counting sort, an auxiliary array keeps track of the count of each element, and incrementing these counts is a constant time operation.

Each of these data structures is designed to optimize certain operations. The \( O(1) \) complexity is a significant factor in choosing the right data structure for a specific problem, as it ensures that the performance of these operations will not degrade as the size of the dataset increases.