## Allocation
- **To allocate memory to an object, we must use new()**. So the object is always allocated memory on heap.
  - ```
    public static void main(String[] args)
    {
        Test t; /isn't allocate memory yet'
         
        // Error here because t
        // is not initialized
        t.show();
    }
    ```
    
## De-allocation



## [Shallow and Retained Sizes](https://www.quora.com/How-does-JVM-allocate-memory-during-the-execution-of-the-Java-program)
All individual objects, as well as sets of objects have their shallow and retained sizes.

Shallow size of an object is the amount of allocated memory to store the object itself, not taking into account the referenced objects. Shallow size of a regular (non-array) object depends on the number and types of its fields. Shallow size of an array depends on the array length and the type of its elements (objects, primitive types). Shallow size of a set of objects represents the sum of shallow sizes of all objects in the set.

Retained size of an object is its shallow size plus the shallow sizes of the objects that are accessible, directly or indirectly, only from this object. In other words, the retained size represents the amount of memory that will be freed by the garbage collector when this object is collected. In general, retained size is an integral measure, which helps to understand the structure (clustering) of memory and the dependencies between object subgraphs, as well as find potential roots of those subgraphs.

## [Dynamic memory allocation](https://www.geeksforgeeks.org/what-is-dynamic-memory-allocation/)

## [java dynamic memory allocation?](https://stackoverflow.com/questions/2532767/java-dynamic-memory-allocation)
- It's dynamic since you don't know when it needs allocating - you allocate upon demand.

