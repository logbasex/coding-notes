## Memory allocation
- static lưu trong Metaspace(Java8)/PermGen, nên chỉ có static mới gọi được cho nhau?
- 3: **Binding process**
  - In the static method, the method use compile-time or early binding. For this reason, we can access the static method without creating an instance. In a non-static method, the method use runtime or dynamic binding. So that we cannot access a non-static method without creating an instance.

- 4: **Overriding**
    - In the static method, we cannot override a static method, because of early binding. 
- 5: **Memory allocation**

  - In the static method, memory allocation happens only once, because the static keyword fixed a particular memory for that method in ram. So when the method is called every time in a program, each time that particular memory is used. For that reason, less memory is allocated.
  - In the non-static method, here memory allocation happens when the method is invoked and the memory is allocated every time when the method is called. So much memory is used here. Now, lastly plotting table in order to grasp altogether 


- https://www.geeksforgeeks.org/difference-between-static-and-non-static-method-in-java/
- https://www.geeksforgeeks.org/static-methods-vs-instance-methods-java/?ref=lbp
- https://www.geeksforgeeks.org/understanding-storage-of-static-methods-and-static-variables-in-java/
- https://www.linkedin.com/pulse/static-variables-methods-java-where-jvm-stores-them-kotlin-malisciuc