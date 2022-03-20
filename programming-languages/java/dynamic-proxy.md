### [What is a Proxy?](https://dzone.com/articles/java-dynamic-proxy)
  
Proxy is a design pattern. We create and use proxy objects when we want to add or modify some functionality of an already existing class. The proxy object is used instead of the original one. Usually, the proxy objects have the same methods as the original one and in Java proxy classes usually extend the original class. The proxy has a handle to the original object and can call the method on that.

This way proxy classes can implement many things in a convenient way:

- logging when a method starts and stops
- perform extra checks on arguments
- mocking the behavior of the original class
- implement lazy access to costly resources

Without modifying the original code of the class. (The above list is not extensive, it only list some  examples).

- [Log method execution time?](https://www.baeldung.com/java-dynamic-proxies)