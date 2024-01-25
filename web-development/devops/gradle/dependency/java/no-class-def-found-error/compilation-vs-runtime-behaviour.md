# Behaviour

The reason a version mismatch can work at compile time but cause issues at runtime involves how Java class loading and Gradle dependency resolution work.

### Compile-Time Behavior:

1. **Classpath Assembly:**
   At compile time, Gradle assembles a classpath that includes all declared dependencies. This classpath contains the classes needed to compile your code.

2. **Dependency Resolution:**
   Gradle resolves dependencies and their transitive dependencies. In case of version conflicts (like the scenario with `LibraryA` and `LibraryB` depending on different versions of `CommonLibrary`), Gradle typically picks the latest version available (unless otherwise configured).

3. **Compilation Against APIs:**
   During compilation, Java compiles against class and method signatures (the API). As long as the API needed for compilation is present in the classpath (irrespective of the version), the compilation will succeed. This means if `CommonLibrary` version 2.0 still contains all the API signatures that `LibraryA` and `LibraryB` use, the compilation will not have any issues.

4. **No Runtime Behavior Check:**
   Compile time doesn't involve actual execution of methods or creation of objects. It's primarily concerned with type checking and ensuring that all class and method references are resolved.

### Runtime Behavior:

1. **Dynamic Class Loading:**
   At runtime, Java dynamically loads classes as they are needed. This is when it becomes apparent if a required class or method version is missing.

2. **Use of Actual Implementations:**
   Unlike at compile time, runtime execution depends on the specific implementations of methods, which can vary between versions. If `CommonLibrary` version 2.0 removed or changed a method that `LibraryA` relies on, it will lead to a `NoClassDefFoundError` or similar.

3. **Single Version of Class:**
   At runtime, only one version of a class is loaded by the classloader. If there are conflicting versions, the one chosen at compile time (usually the latest) is used. If this version is incompatible with what some parts of the code expect (due to the version mismatch), it can lead to errors.

### Example:

Let's assume `LibraryA` uses a method `doSomething()` from `CommonLibrary` version 1.0, and this method was removed in version 2.0.

- **Compile Time:** Both `LibraryA` and `LibraryB` compile fine because `CommonLibrary` version 2.0 is chosen, and it has all the necessary APIs for compilation.
- **Run Time:** When `LibraryA` tries to call `doSomething()`, it's not found because `CommonLibrary` version 2.0 (which doesn't have this method) is loaded. This leads to a `NoClassDefFoundError`.

In summary, version mismatches can work at compile time because compilation focuses on API signatures rather than actual implementations. However, at runtime, the specific implementation details and the presence of actual classes/methods become critical, which is why version mismatches can lead to errors like `NoClassDefFoundError`.

----
----

## Show example of Compilation Against APIs

Certainly! Let's go through an example to illustrate how Java compiles against APIs during the compile-time phase, using a simple scenario with a hypothetical library.

### Scenario: Using a Library with an API

Imagine you are developing a Java application that uses an external library, `MyLibrary`. This library provides a class `LibraryClass` with a method `performAction`.

#### Version 1.0 of `MyLibrary`:

```java
// In MyLibrary version 1.0
public class LibraryClass {
    public void performAction() {
        System.out.println("Action performed in version 1.0");
    }
}
```

#### Your Java Application:

```java
import com.example.mylibrary.LibraryClass;

public class MyApp {
    public static void main(String[] args) {
        LibraryClass lib = new LibraryClass();
        lib.performAction();
    }
}

```

#### Compilation Process:

1. **Adding Dependency:** You declare `MyLibrary` version 1.0 as a dependency in your build configuration (like `build.gradle` for Gradle).

    ```groovy
    dependencies {
        implementation 'com.example:MyLibrary:1.0'
    }
    ```

2. **Compiling Your Code:** When you compile your application, the Java compiler checks that the method `performAction()` exists in `LibraryClass`. It does not execute the method but ensures the method signature is present.

3. **Successful Compilation:** Since `performAction()` is present in `MyLibrary` version 1.0, your application compiles successfully.

### Upgrading the Library

Now, let's say `MyLibrary` gets updated to version 2.0, and you decide to upgrade the library in your project.

#### Version 2.0 of `MyLibrary`:

```java
// In MyLibrary version 2.0
public class LibraryClass {
    public void performAction() {
        System.out.println("Action performed in version 2.0");
    }

    // New method added in version 2.0
    public void newMethod() {
        System.out.println("New method in version 2.0");
    }
}
```

#### Updating the Dependency:

```groovy
dependencies {
    implementation 'com.example:MyLibrary:2.0'
}
```

#### Re-Compilation Process:

1. **Re-Compiling:** You recompile your application with the new version of `MyLibrary`.

2. **API Signature Check:** The compiler again checks for the presence of `performAction()` in `LibraryClass`.

3. **Successful Compilation:** The method `performAction()` still exists in `LibraryClass` in version 2.0, so the compilation is successful. The compiler doesn't care about the internal implementation of the method or other additional methods like `newMethod()`.

### Summary:

In this example, the Java compilation process focuses on ensuring that the necessary API signatures (methods, classes) are present and correctly referenced in your code. It doesn't delve into the actual implementation details or execute any methods. This allows for changes in the library (like adding new methods or changing internal implementations) without affecting the ability of dependent code to compile, as long as the API signatures remain consistent.