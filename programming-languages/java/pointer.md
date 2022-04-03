[There are no pointers in java. Java works with references](https://stackoverflow.com/questions/18249834/pointers-are-replaced-with-what-in-java).

---
[Java does have pointers, which are known under the name "reference".](https://stackoverflow.com/questions/2629357/does-java-have-pointers)

Java has pointers in the sense of variables that store references to data in memory. All variables of Object types in Java are pointers in this sense.

However, the Java language does not allow arithmetic operations on the values of pointers, like you'd be able to do in a language like C.

---

## [Why Java Does Not Support Pointers?](https://www.thejavaprogrammer.com/why-java-does-not-support-pointers/)

![](images/Why-Java-Does-Not-Support-Pointers.png)


### Simple

The pointer concept is very confusing, difficult to understand (especially for beginners) and causes bugs in code. To make java simpler and less complex the java creators decided to remove the concept of pointers.

### Secure
Security is one of the biggest issue in programming world. Pointer provides direct access to memory address. One can access some arbitrary memory location and do read and write operations on it. This results in loss of security. So to make java secure it doesn’t support pointers.

### Memory Management

Pointers can be used to allocate and deallocate memory. This is good feature of pointers but sometimes it causes headache for programmers to manage memory manually. As java provides the automatic garbage collection feature so there is no need of pointers and it makes memory management easier.

> Java doesn’t provide any explicit option to use pointers but internally pointers are used. Java has the concept of reference which is more simple and secure than pointer.

---
## [Converting C Pointer to Java Reference](https://www.semanticscholar.org/paper/Converting-C-Pointers-to-Java-References-Demaine/2267c53045bed4eb37c936258eb2f032a3ad591c)

We consider the problem of converting C pointers to the less exible concept of references

![](images/c-pointer-to-java.png)