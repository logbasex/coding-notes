## [Pass object reference by value](https://www.infoworld.com/article/3512039/does-java-pass-by-reference-or-pass-by-value.html)
**Common mistakes with object references**
- Trying to change an immutable value by reference.
- Trying to change a primitive variable by reference.
- Expecting the real object won't change when you change a mutable object parameter in a method.

**What to remember about object references**
- Java always passes parameter variables by value.
- Object variables in Java always point to the real object in the memory heap.
- A mutable object’s value can be changed when it is passed to a method.
- An immutable object’s value cannot be changed, even if it is passed a new value.
- “Passing by value” refers to passing a copy of the value.
- “Passing by reference” refers to passing the real reference of the variable in memory.

## [Call by value](https://www.geeksforgeeks.org/parameter-passing-techniques-in-java-with-examples/?ref=lbp)

![](https://media.geeksforgeeks.org/wp-content/cdn-uploads/Call-By-Value.png)

1. **Pass By Value**: Changes made to formal parameter do not get transmitted back to the caller. Any modifications to the formal parameter variable inside the called function or method affect only the separate storage location and will not be reflected in the actual parameter in the calling environment. This method is also called as call by value.

![](https://media.geeksforgeeks.org/wp-content/uploads/20190220113437/CallByReferenceJava.png)

2. **Call by reference(aliasing)**: Changes made to formal parameter do get transmitted back to the caller through parameter passing. Any changes to the formal parameter are reflected in the actual parameter in the calling environment as formal parameter receives a reference (or pointer) to the actual data. This method is also called as call by reference. This method is efficient in both time and space.

-------------

[There are two ways to pass arguments in most languages: By Value (which copies the argument) and By Reference which simply passes the address/location of the object.](https://www.quora.com/Does-the-fact-that-Java-makes-copies-of-variables-when-passed-into-methods-make-it-bad-for-memory-usage-What-are-the-advantages-of-this-principle)
The arguments that are passed “by value” do get copied, but the copy resides on a Stack. As soon as the method returns, the stack memory is reclaimed and does not affect your memory usage. These copies are tiny and short lived. Making a copy ensures that you can’t modify the argument inside the method (you can change it, but that change will only modify a copy and will have no affect on the original value). Most of the time, you want methods that compute and return a value and have no “side effects”. In some cases, you do want to affect the state of multiple objects and that’s where passing By Reference is useful

In Java, primitives (int, byte, short, double, float, boolean) are passed by value. All objects including primitive wrappers: Integer, Double, …, Boolean, …, String, Object, Customer, Dog, Account, etc, etc, are passed by reference. In other words all the “big” complex objects are not copied. However, the reference itself is passed by value (gets copied). So the only thing that gets copied when you pass a huge object is an address which is only a few bytes (negligible).

To summarize, this is typically not an issue. Most memory issues are created when people mismanage the Heap memory. When object are created with a new operator and then you application is holding on to these object long after outlived their usefulness, the Garbage Collector “thinks” that they are still being used because there are still references to them and therefore will not clean them up causing a “memory leak”. As long as you are not holding references to objects much longer than you need to, the Garbage Collector will clean them up and your Heap memory will be reclaimed.

-----

Java tạo ra bản sao của biến (primitive) hoặc bản sao của object reference (non-primitive) khi truyền vào method nên chỉ là pass by value. Bản sao của object refrence thường chỉ là địa chỉ ô nhớ trong stack sẽ được reclaim sau khi method return nên chả xảy xảy ra vấn đề gì phức tạp cả. Memory leak thường gây ra bởi mismanage heap space.

---
https://www.journaldev.com/3884/java-is-pass-by-value-and-not-pass-by-reference

pass by value, tuy nhiên nếu method của method pass vào được gọi thì sẽ ảnh hưởng đến object trên heap. nếu reassign object thì k sao..
```
a.method() //affect
a = b // non-issue
```