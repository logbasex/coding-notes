## Capacity
- [Java8 default capacity is zero](https://stackoverflow.com/questions/34250207/in-java-8-why-is-the-default-capacity-of-arraylist-now-zero)
- [How to define the concept of capacity in ArrayLists?](https://stackoverflow.com/questions/5411095/how-to-define-the-concept-of-capacity-in-arraylists)
  - The class is called ArrayList because it's based on an array. The capacity is the size of the array, which requires a block of contiguous heap memory. However, **note that the array itself contains only references to the elements, which are separate objects on the heap**.
  - Increasing the capacity requires allocating a new, larger array and copying all the references from the old array to the new one, after which the old one becomes eligible for garbage collection.
  - You've cited the main case where performance could be a concern. In practice, I've never seen it actually become a problem, since the element objects usually take up much more memory (and possibly CPU time) than the list.


## [Dynamic vs static array](https://stackoverflow.com/questions/38427339/dynamic-arrays-in-java-using-arraylist-vs-int-array-new-intn)
Java doesn't have dynamic arrays. Once an array has been created it's size cannot be changed.

ArrayList uses an internal array for storage, but it resizes the array internally so you don't have to worry about it.

Internally of course it simply creates a new, larger array and copies things over when it needs more space.

As for if your usage of array is OK, for the given scenario, it is. If your array content size is unknown or if it can change, then switch to ArrayList rather than doing the resizing yourself.

## [Lazy reinit a list to modifiable after declaring with Collections.emptyList()](https://stackoverflow.com/questions/64234824/lazy-reinit-a-list-to-modifiable-after-declaring-with-collections-emptylist)
- Note that even if `Collections.emptyList()` always returns the one instance held in `Collections.EMPTY_LIST`, a reference comparison does not detect when a caller used JDK 9+ `List.of()` to initialize the field. On the other hand, being non-empty does not guaranty mutability either.

- The entire logic is suitable only for a `private` method were all callers and their usage are known.

- But you should consider the alternative of dropping these special cases altogether. Since Java 8, the default constructor `new ArrayList<>()` will not create a backing array. It is deferred until the first addition of an element.

- So you can initialize all fields with a plain `new ArrayList<>()` and implement the `addInfo`, `addWarn`, and `addErr` with a plain `add` call, getting rid of the `addTo` method, the conditionals, and the repeated assignments. Even declaring the fields `final` is possible. While still not requiring a significant amount of memory for the unused lists.

## [new ArrayList()<> object size ~ 24 bytes](https://www.baeldung.com/java-size-of-object)
- http://btoddb-java-sizing.blogspot.com/2012/01/object-sizes.html
- ~40000 new ArrayList() instance take up 1 MB. (when object declare with field = new ArrayList(), it will be create each time class is called?)

## [Best practice for initializing an ArrayList field in Java](https://stackoverflow.com/questions/38124912/best-practice-for-initializing-an-arraylist-field-in-java)