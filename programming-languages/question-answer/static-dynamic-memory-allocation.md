> [Memory allocated during the **compiled time** is called **static memory allocation**. The memory allocated is fixed or cannot be changed during run-time.](https://medium.com/@ankitachaturvedi0310/static-and-dynamic-memory-allocation-1f43a0d45f83)
> 
> Static memory allocation assigns the memory before its execution whereas **dynamic memory allocation** assigns the memory to a process **during the execution**.

---

[There are no pointers in java. Java works with references](https://stackoverflow.com/questions/18249834/pointers-are-replaced-with-what-in-java).

**There is no concept of dynamic memory allocation in Java**. And hence there is no alternative of `malloc/calloc` in java. The JVM takes care of creating and releasing the memory for objects. As JVM has built in functionality of garbage collection hence no alternative to free is also provided.

```
String str = new String("efi");

// str is NOT the string object.
// It is a reference to the String object.
```