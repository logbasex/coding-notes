- [Avoid utility class](https://www.vojtechruzicka.com/avoid-utility-classes/)
- https://www.baeldung.com/java-sonar-hide-implicit-constructor

## What is Utility Class?

Utility Class, also known as Helper class, is a class, which contains just static methods, it is **stateless** and **cannot be instantiated**. It contains a bunch of related methods, so they can be reused across the application. As an example consider Apache StringUtils, CollectionUtils or java.lang.Math.

[Object-Oriented Design Decisions: Stateful or Stateless Classes?](https://dzone.com/articles/stateful-or-stateless-classes)
- Make entity classes stateful.
- Helper / Operation classes should be stateless.
- Make sure the Helper classes are not static.
- Even if there is a hybrid class, make sure it's not violating the SRP.
- Spend some time on the class design before coding. Show the class diagram to 2-3 fellow programmers and get their opinions.
- Name the class wisely. The names will help us to decide state. There is no hard rule for naming

[What is Stateless Object in Java?](https://stackoverflow.com/questions/9735601/what-is-stateless-object-in-java)
- Stateless object is an instance of a class without instance fields (instance variables). The class may have fields, but they are compile-time constants (static final).

[Extension function in kotlin for better utility class](https://dev.to/earroyoron/kotlin-for-better-helper-methods-256c)
- import method instead of import class.