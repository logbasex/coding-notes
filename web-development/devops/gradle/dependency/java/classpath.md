**What is an implementation dependency?**

When you’re building and running a Java project there are two classpaths involved:

**Compile classpath** – Those dependencies which are required for the JDK to be able to compile Java code into .class files.

**Runtime classpath** – Those dependencies which are required to actually run the compiled Java code.

When we’re configuring Gradle dependencies all we’re really doing is configuring which dependencies should appear on which classpath. Given there are only two classpaths, it makes sense that we have three options to declare our dependencies.

1. **compileOnly** – put the dependency on the compile classpath only.
2. **runtimeOnly** – put the dependency on the runtime classpath only.
3. **implementation** – put the dependency on both classpaths.

> **Use the implementation dependency configuration if you need the dependency to be on both the compile and runtime classpaths. If not,
> consider compileOnly or runtimeOnly.**