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

## show example: If your code uses classes or methods from legacy-java8-lib, the compiler looks for these references in the classpath.


Certainly! Let's create a hypothetical example to illustrate how your code might use classes or methods from a Java 8-dependent library (`legacy-java8-lib`) and how the compiler handles this during the build process in a Gradle project.

### Scenario Setup

Assume `legacy-java8-lib` is a library that provides a utility class named `Java8Utility`. This class contains a method `performAction()` that you want to use in your application.

### Step 1: Add the Dependency in `build.gradle`

Your `build.gradle` file includes the dependency:

```groovy
dependencies {
    implementation 'com.example:legacy-java8-lib:1.0.0'
}
```

### Step 2: Write Code Using `legacy-java8-lib`

You write a class in your project that uses `Java8Utility` from `legacy-java8-lib`. Here is an example Java class:

```java
import com.example.legacy.Java8Utility;

public class MyApp {
    public void useLegacyLib() {
        Java8Utility utility = new Java8Utility();
        utility.performAction();
    }
}
```

### Step 3: Compile the Project with Gradle

When you execute the build (e.g., `gradlew build`), the following happens:

1. **Gradle Resolves Dependencies**: Gradle downloads `legacy-java8-lib` and makes it available on the classpath.

2. **Compilation**: The Java compiler compiles your code. It sees the import statement `import com.example.legacy.Java8Utility;` and looks for `Java8Utility` in the classpath.

3. **Classpath Check**: Because `legacy-java8-lib` is in the classpath, the compiler finds `Java8Utility` and its method `performAction()`.

4. **Successful Compilation**: Assuming there are no other issues (like syntax errors), the compiler successfully compiles your `MyApp` class, as it can resolve all references.

### Compile-Time vs. Runtime

- **Compile-Time**: The compiler only needs to ensure that all referenced classes and methods are present in the classpath. It doesn't execute the code or check the runtime environment's library versions.
- **Runtime**: When you run the application, the JVM will try to load `Java8Utility` and execute `performAction()`. If `Java8Utility` or any of its dependencies use classes that are not available in the runtime environment (for example, Java 21), you will encounter a `NoClassDefFoundError` or similar runtime errors.

This example illustrates how a project can compile successfully because all dependencies are resolved at compile-time, but still fail at runtime if the runtime environment differs significantly from the compile-time environment, such as using a different Java version that doesn't include certain classes or APIs.

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

----
----

Certainly! Let's create a hypothetical example to illustrate how your code might use classes or methods from a Java 8-dependent library (`legacy-java8-lib`) and how the compiler handles this during the build process in a Gradle project.

### Scenario Setup

Assume `legacy-java8-lib` is a library that provides a utility class named `Java8Utility`. This class contains a method `performAction()` that you want to use in your application.

### Step 1: Add the Dependency in `build.gradle`

Your `build.gradle` file includes the dependency:

```groovy
dependencies {
    implementation 'com.example:legacy-java8-lib:1.0.0'
}
```

### Step 2: Write Code Using `legacy-java8-lib`

You write a class in your project that uses `Java8Utility` from `legacy-java8-lib`. Here is an example Java class:

```java
import com.example.legacy.Java8Utility;

public class MyApp {
    public void useLegacyLib() {
        Java8Utility utility = new Java8Utility();
        utility.performAction();
    }
}
```

### Step 3: Compile the Project with Gradle

When you execute the build (e.g., `gradlew build`), the following happens:

1. **Gradle Resolves Dependencies**: Gradle downloads `legacy-java8-lib` and makes it available on the classpath.

2. **Compilation**: The Java compiler compiles your code. It sees the import statement `import com.example.legacy.Java8Utility;` and looks for `Java8Utility` in the classpath.

3. **Classpath Check**: Because `legacy-java8-lib` is in the classpath, the compiler finds `Java8Utility` and its method `performAction()`.

4. **Successful Compilation**: Assuming there are no other issues (like syntax errors), the compiler successfully compiles your `MyApp` class, as it can resolve all references.

### Compile-Time vs. Runtime

- **Compile-Time**: The compiler only needs to ensure that all referenced classes and methods are present in the classpath. It doesn't execute the code or check the runtime environment's library versions.
- **Runtime**: When you run the application, the JVM will try to load `Java8Utility` and execute `performAction()`. If `Java8Utility` or any of its dependencies use classes that are not available in the runtime environment (for example, Java 21), you will encounter a `NoClassDefFoundError` or similar runtime errors.

This example illustrates how a project can compile successfully because all dependencies are resolved at compile-time, but still fail at runtime if the runtime environment differs significantly from the compile-time environment, such as using a different Java version that doesn't include certain classes or APIs.