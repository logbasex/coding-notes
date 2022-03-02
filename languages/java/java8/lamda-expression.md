- [Java8 Lambdas vs Anonymous classes](https://stackoverflow.com/a/46024789/10393067)
- [Lambda expression vs method reference](https://stackoverflow.com/questions/24487805/lambda-expression-vs-method-reference)
  - Is not about performance, it's about readability.


## Performance
- [Lamda performance study](https://www.oracle.com/technetwork/java/jvmls2013kuksen-2014088.pdf)

## Capture/Non-capture | Stateless/Stateful lambda expression

### Java 8 in action (p.476)
- The strategy used to translate the lambda expression body to bytecode becomes a pure
  implementation detail. It could also be changed dynamically, or optimized and modified in future
  JVM implementations, preserving the bytecode’s backward compatibility.
- There’s no overhead, such as additional fields or static initializer, if the lambda is never used.
- For stateless (noncapturing) lambdas it’s possible to create one instance of the lambda object, cache it,
  and always return the same. This is a common use case, and people were used to doing this explicitly
  before Java 8; for example, declaring a specific Comparator instance in a static final variable.
  
- There’s no additional performance cost because this translation has to be performed, and its result
  linked, only when the lambda is invoked for the first time. All subsequent invocations can skip this
  slow path and call the formerly linked implementation.

- Some operations such as filter and map are stateless; they don’t store any state. Some operations
  such as reduce store state to calculate a value. Some operations such as sorted and distinct also
  store state because they need to buffer all the elements of a stream before returning a new stream.
  Such operations are called stateful operations

## [Lexical scoped](https://github.com/ngminhtrung/You-Dont-Know-JS/blob/master/scope%20%26%20closures/ch2.md)
Listing 10

```
class Hello {
  public Runnable r = new Runnable() {
      public void run() {
        System.out.println(this);
        System.out.println(toString());
      }
    };

  public String toString() {
    return "Hello's custom toString()";
  }
}

public class InnerClassExamples {
  public static void main(String... args) {
    Hello h = new Hello();
    h.r.run();
  }
}
```
=>> Hello$1@f7ce53

Listing 11


```
class Hello {
  public Runnable r = new Runnable() {
      public void run() {
        System.out.println(Hello.this);
        System.out.println(Hello.this.toString());
      }
    };

  public String toString() {
    return "Hello's custom toString()";
  }
}
```

[Lambdas, however, are **lexically scoped**, meaning that a lambda recognizes the immediate environment around its definition as the next outermost scope.](https://www.oracle.com/technical-resources/articles/java/architect-lambdas-part1.html) So the lambda example in Listing 12 produces the same results as the second Hello nested class example in Listing 11, but with a much more intuitive syntax.

```
class Hello {
  public Runnable r = () -> {
      System.out.println(this);
      System.out.println(toString());
    };

  public String toString() {
    return "Hello's custom toString()";
  }
}
```

## [Variable capture && effective final](http://tutorials.jenkov.com/java/lambda-expressions.html#variable-capture)
> A Java lambda expression is capable of accessing variables declared outside the lambda function body under
certain circumstances.

```
String myString = "Test";

MyFactory myFactory = (chars) -> {
    return myString + ":" + new String(chars);
};
```
As you can see, the lambda body now references the local variable myString which is declared outside the lambda body. **This is possible if, and only if, the variable being references is `effectively final`, meaning it does not change its value after being assigned**. 

- https://www.oracle.com/technical-resources/articles/java/architect-lambdas-part1.html