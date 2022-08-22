- [Java8 Lambdas vs Anonymous classes](https://stackoverflow.com/a/46024789/10393067)
- [Lambda expression vs method reference](https://stackoverflow.com/questions/24487805/lambda-expression-vs-method-reference)
  - Is not about performance, it's about readability.

---------
## Performance
[Lamda performance study](https://www.oracle.com/technetwork/java/jvmls2013kuksen-2014088.pdf)

### [Does a lambda expression create an object on the heap every time it's executed?](https://stackoverflow.com/questions/27524445/does-a-lambda-expression-create-an-object-on-the-heap-every-time-its-executed)
- Short answer: no.  For stateless lambdas (those that do not capture anything from their lexical context), only one instance will ever be created (lazily), and cached at the capture site.  (This is how the implementation works; the spec was carefully written to allow, but not require, this approach.)

- This is covered by The Java® Language Specification, chapter [15.27.4. Run-time Evaluation of Lambda Expressions](http://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.27.4)

  Summarized:

  > These rules are meant to offer flexibility to implementations of the Java programming language, in that:
  >
  > - A new object need not be allocated on every evaluation.
  >
  > - Objects produced by different lambda expressions need not belong to different classes (if the bodies are identical, for example).
  >
  > - Every object produced by evaluation need not belong to the same class (captured local variables might be inlined, for example).
  >
  > - If an "existing instance" is available, it need not have been created at a previous lambda evaluation (it might have been allocated during the enclosing class's initialization, for example).
  > 
  
### [Implementation differences/optimizations between Lambda Expressions and Anonymous Classes](https://stackoverflow.com/questions/32360599/implementation-differences-optimizations-between-lambda-expressions-and-anonymou)
  ```
  s -> s.length == 10
  ``` 
- Since s -> s.length() == 10 is invariant, it always becomes a constant, without the need for the JIT’s help

### [Why does lambda translation need generation of a static method?](https://stackoverflow.com/questions/30014200/why-does-lambda-translation-need-generation-of-a-static-method)

Because this way it's actually cheaper. Generating a lambda from the method on the fly during the first invocation is better than loading a separate class via class loader. Internally it uses `UNSAFE.defineAnonymousClass` which is more light-weight class than normal. Such "lambda-class" is not bound to any class loader, so can be easily garbage-collected when it's no longer necessary

--------------
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

### [Is method reference caching a good idea in Java 8](https://stackoverflow.com/questions/23983832/is-method-reference-caching-a-good-idea-in-java-8/23991339#23991339)
The compiler will optimize lambda creation if the lambda doesn't access variables out of its scope, which means the lambda instance only create once by the JVM

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

## this, super keywords

> Unlike anonymous functions, a lambda expression can be considered as a simple code block when considering about variable scoping. Hence all scoping rules for code blocks also apply to lambda expression. This means a variable defined in the lambda expression can only be accessed within the lambda expression and the variables defined in the enclosing class can be accessed by the lambda expression as well, this also include the this keyword which refers to the enclosing class object.
>
> In short, for anonymous class ‘this’ keyword resolves to anonymous class object, whereas for lambda expression ‘this’ keyword resolves to enclosing class object where lambda is written
> 
- [Lambda this reference in java](https://stackoverflow.com/questions/24202236/lambda-this-reference-in-java)

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

## [First-class citizen and impure function](https://stackoverflow.com/a/15241404/10393067)
> In summary, Java 8 lambdas are more first-class functions than I had originally thought. They just aren't pure first-class functions.
>

## LambdaMetaFactory
> t.jar -> java.lang.invoke
> 
**Q**: [I'm reading through the linked doc specifying the implementation.  AFAICT, s -> s.length() == 10 is lowered to a private static method, but I am still under the impression that the JIT implements the lambda metafactory that decides how to convert that into the interface instance?](https://stackoverflow.com/questions/32360599/implementation-differences-optimizations-between-lambda-expressions-and-anonymou)

**A**: o, the LambdaMetafactory is an ordinary Java class which generates bytecode using the well-known ASM library. You can even step through it using a Java debugger when a lambda expression is instantiated the first time. But due to how the invokedynamic instruction works, subsequent executions will use the result of that first invocation which is either a handle to a constant or a factory method/ constructor invocation.

**Q**: I thought the invokedynamic gave you a handle to a constant method, sure -- but I thought that constant handle was a handle to the method that returned the lambda object, not that the lambda was itself guaranteed to be a constant?


**A**: It depends on what the meta factory returns. In case of a stateless lambda, it will return a handle which wraps a constant whose evaluation merely means “return the constant”. In case of capturing lambda, the handle will indeed represent executable code which in turn produces the lambda instance, i.e. a factory method or constructor invocation.


## invokedynamic, invokestatic, invokevirtual
- http://asmsupport.github.io/jvmref/ref-invokespecial.html
- https://stackoverflow.com/questions/13764238/why-invokespecial-is-needed-when-invokevirtual-exists

### [why-are-java-8-lambdas-invoked-using-invokedynamic](https://stackoverflow.com/questions/30002380/why-are-java-8-lambdas-invoked-using-invokedynamic)

Current Java 8's lambda implementation is a compound decision:

* 1. Compile the lambda expression to a static method in the enclosing class; instead of compiling lambdas to separate inner class files (Scala compiles this way, which generates many $$$ class files)
* 2. Introduce a constant pool: `BootstrapMethods`, which wraps the static method invocation to callsite object (can be cached for later use)

So to answer your question,

* 3. the current lambda implementation using `invokedynamic` is a little bit faster than the separate inner class way, because no need to load these inner class files, but instead create the inner class byte[] on the fly (to satisfy for example the Function interface), and cached for later use.
* 4. JVM team may still choose to generate separate inner class (by referencing the enclosing class's static methods) files: it's flexible


## [Why are only final variables accessible in anonymous class?](https://stackoverflow.com/a/53242527/10393067)

[The local variable is allocated in the `stack`, **and it will fall out of scope after testMethod(). Making the variable final ensures that it is ok to just pass a reference to it to the anonymous class. If it was not final, a later assignment to it in testMethod() could change the value later with confusing results**](https://stackoverflow.com/questions/18230870/why-variables-have-to-be-final-in-anonymous-methods-and-class-fields-dont). (The user might expect the later assigned value used, but that would be impossible).

A field of the parent class, however can be accessed through the parent reference of the anonymous class, so any later assignments can be handled without confusion.