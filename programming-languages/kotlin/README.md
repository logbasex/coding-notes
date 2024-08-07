## Name and default arguments

- https://www.baeldung.com/kotlin/default-named-arguments

# Packages
Unlike Java, Kotlin doesn’t impose any restrictions on the layout and naming of source files: you can put multiple classes in the same file, and choose any directory structure you’re comfortable with.

- https://proandroiddev.com/the-kotlin-guide-for-the-busy-java-developer-93dde84a77b7
- https://github.com/HugoMatilla/KotlinCheatSheet/blob/master/Kotlin%20In%20Action.md
- https://medium.com/@calren24/kotlin-in-action-chapter-1-what-and-why-9d2899560755
- http://www.tellmehow.co/advanced-kotlin-tips-pro-developers/
- https://agrawalsuneet.github.io/blogs/safe-calls-vs-null-checks-in-kotlin/

# Keywords

### 1. val vs var

- Summary
  ```kotlin
  +----------------+-----------------------------+---------------------------+
  |                |         val (value)         |       var (variable)      |
  +----------------+-----------------------------+---------------------------+
  | Reference type | Immutable(once initialized  | Mutable(can able to change|
  |                | can't be reassigned)        | value)                    |
  +----------------+-----------------------------+---------------------------+
  | Example        | val n = 20                  | var n = 20                |
  +----------------+-----------------------------+---------------------------+
  | In Java        | final int n = 20;           | int n = 20;               |
  +----------------+-----------------------------+---------------------------+
  ```
  
# Nothing Type

Nothing is a type in Kotlin that represents “a value that never exists”, that means just “no value at all”.

Nothing can be used as the return type of a function that never returns the code execution — like, looped forever or always throws Exception. Don’t get confused because Java does not have anything similar to the Nothing type.

Assume we have reportError() method

- Java
  ```java
   void reportError() {
        throw new RuntimeException();
   } 
  ```
- Kotlin  
  ```kotlin
  fun reportError(): Nothing {
        throw RuntimeException();
  }
  ```
  
### 1. Missing return statement

- Java
  ```java
  String exampleThree(int n) {
      if (n > 5) {
          return "Ok";
      }
      reportError();
      // Won't compile - 'Missing return statement' error. 
  }
  ```
- Kotlin
  ```kotlin
  fun exampleThree(n: Int): String {
      if (n > 5) {
          return "Ok";
      }
      reportError(); // throws RuntimeException 
      // Compiles!
  }
  ```

# String

- https://kotlinlang.org/docs/idioms.html#if-not-null-shorthand
- https://kotlinlang.org/docs/java-to-kotlin-idioms-strings.html#create-a-string-from-collection-items


### 1. Pad end

- Java
    ```java
    String str = "Hello";
    int size = str.length();
    for ( int i = 0; i < 10 - size; i++ ) {
        str+="!";
    }
  
    #common-lang3 library already support this feature.
    StringUtils.rightPad("hello", 10);
    ```
- Kotlin
   ```kotlin
   println("Hello".padEnd(10, '!'))
   ```

### 2. Template

- Java
    ```java
    // embeded expression
    String message = "n = " + n;

    // String template
    int n = 5;
    String message = "" + n + " is " + (n > 0 ? "positive" : "not positive");
    ```

- Kotlin
    ```kotlin
    // embeded expression
    val message = "n = $n"

    // String template
    val n = 5
    val message = "$n is ${if(n > 0) "positive" else "not positive"}"
    ```

### 3. Raw String (Triple-quoted strings)

- Java
    ```java
    String path = "C:\\Repository\\read.me"
    ```

- Kotlin
    ```shell
    val path = """C:\Repostitory\read.me"""
    ```

# Null

### 1. Safe call

- Java
  ```java
  String email = null;
  if (client != null) {
      PersonalInfo personalInfo = client.getPersonalInfo();
          if (personalInfo != null) {
              email = personalInfo.getEmail(); 
          }
      } 
  }
  ```
- Kotlin
  ```kotlin
  // This calls the method if the property is not null 
  // or returns null if that property is null without throwing an NPE (null pointer exception).
  val email = client?.personalInfo()?.email
  ```

# Function

### 1. Positional and Named Arguments

- Java
    ```java
    public static void main(String[]args){
        // Positional arguments are method arguments that must be passed in the same order they are declared.
        openFile("file.txt", true);
    }

    public static File openFile(String filename, boolean readOnly) { }
    ```

- Kotlin
    ```kotlin
    fun main(args: Array<String>) {
        // In Kotlin 1.4, we can mix named and positional arguments provided the order is maintained. 
        openFile("file.txt", readOnly = true)
  
        // Kotlin’s named arguments can be passed in any order
        openFile(readOnly = true, filename = "file.txt")
    }

    fun openFile(filename: String, readOnly: Boolean) : File { }
    ```

### 2. Option/Default Arguments

- Java
  ```java
  public static void main(String[]args){
      createFile("file.txt");

      createFile("file.txt", true);

      createFile("file.txt", true, false);

      createExecutableFile("file.txt");
  }

  public static File createFile(String filename) { }

  public static File createFile(String filename, boolean appendDate) { }

  public static File createFile(String filename, boolean appendDate, boolean executable) { }

  public static File createExecutableFile(String filename) { }
  ```  

- Kotlin
  ```kotlin
  fun main(args: Array<String>) {
      createFile("file.txt")

      createFile("file.txt", true)
      createFile("file.txt", appendDate = true)

      createFile("file.txt", true, false)
      createFile("file.txt", appendDate = true, executable = true)

      createFile("file.txt", executable = true)
  }

  // Optional arguments with default value
  fun createFile(filename: String, appendDate: Boolean = false, executable: Boolean = false): File { }
  ```
