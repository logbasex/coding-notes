## References

----
----

## [Type Parameter vs Wildcard in Java Generics](https://www.baeldung.com/java-generics-type-parameter-vs-wildcard)

> **We can’t use wildcards to define a generic class or interface.**
 
> **We can’t use wildcards directly to specify the type of a parameter in a method.**
 
> **If a type parameter appears only once in the method declaration, we should consider replacing it with a wildcard.**

> **When a generic method returns a generic type, we should use a type parameter instead of a wildcard**


```java
public static <E> List<E> mergeTypeParameter(List<? extends E> listOne, 
                                             List<? extends E> listTwo) {
    return Stream.concat(listOne.stream(), listTwo.stream())
            .collect(Collectors.toList());
}
```