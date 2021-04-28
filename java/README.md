## Overview
- `oracle-jdk` and `open-jdk`
    - https://openplanning.net/12571/lich-su-cua-java-va-su-khac-biet-giua-oracle-jdk-va-openjdk
    - https://www.baeldung.com/oracle-jdk-vs-openjdk
    - Both Default JDK aka Oracle JDK and openJDK are owned by Oracle only.
      
      [But Oracle JDK is not open for tweaking the implementations, for that you have openJDK.](https://www.quora.com/What-is-the-difference-between-open-JDK-and-default-JDK/answer/Jatin-Tamboli)
      
      Also in Cloud environment like Cloudfoundry the jdk used for java compilation is openJDK not the OracleJDK and this will hold true for other cloud PaaS as well.
      
      Many Tech giants have their own JDK implementations crafted out from openJDK. One such example is Twitter.
- **LTS** (long-term support) versions. Pls check [Java’s Time-Based Releases.](https://www.baeldung.com/java-time-based-releases)
    - jdk-8
    - jdk-11

- [Do Java 1.8 and Java 8 refer to the same thing?](https://www.quora.com/Do-Java-1-8-and-Java-8-refer-to-the-same-thing)        
    - When the version string for the product is reported as `java version 1.8.0_5`, the product will be called `JDK` 8u5, `JDK 8 update 5` or, when the update version is not important, `JDK 8`.
    
- ![](https://i.stack.imgur.com/CBNux.png)

## Concepts
- **JDK**: `Java Devlopement Kit` let you develop Java application.
- **JRE**: `Java Runtime Enviroment` let you run Java application. 

    - Note that from `Java 9/11?` onward, the separate `JRE` is no longer exist, only the `JDK` is offered ([by Oracle](https://stackoverflow.com/a/59187135/10393067)). [Java is now a **modular platform**, where you can create your own **JRE** distribution with specifically the modules that you need to run your application](https://stackoverflow.com/a/53733414/10393067).
    
        > [In this release, the JRE or Server JRE is no longer offered. Only the JDK is offered. Users can use **jlink** to create smaller custom runtimes](https://www.oracle.com/java/technologies/javase/11-relnote-issues.html).
        - **jlink** is a tool that generates a custom Java runtime image that contains only the platform modules that are required for a given application.
        - [Build your own **JRE** with **jink**](https://dzone.com/articles/jlink-in-java-9)
 
- [The Java Platform Module System](https://dzone.com/articles/the-java-platform-module-system)        
    - https://www.baeldung.com/java-9-modularity
    - https://viblo.asia/p/what-is-java-9-module-RQqKLYkmZ7z
- [Summary](https://stackoverflow.com/a/54737381/10393067)
    ![](https://i.stack.imgur.com/P4Gmt.png)    

## Install
- **JDK/JRE**
    1. Check Ubuntu is 32-bit or 64-bit
        ```shell script
        file /lib/systemd/systemd 
        ```
    2. install java versions
        ```shell script
        # standard version (current is jdk-11)
        sudo apt install
        
        # java-8
        sudo apt install openjdk-8-jdk-headless
        sudo apt install openjdk-8-jre-headless
        ```
    3. [where is java-jdk folder?](https://stackoverflow.com/questions/16931327/where-is-the-java-sdk-folder-in-my-computer-ubuntu-12-04)
        ```shell script
        # usually reside in
        /usr/lib/jvm
        
        # check
        readlink -f $(which java)
        ```     
    4. Manage difference version
        1. Using [`update-alternatives`](https://linux.die.net/man/8/update-alternatives) command
            ```shell script
            # guides
            - https://linuxhint.com/update_alternatives_ubuntu/
            - https://askubuntu.com/questions/233190/what-exactly-does-update-alternatives-do
            - https://unix.stackexchange.com/questions/385578/why-use-the-alternatives-command
            - https://www.redhat.com/sysadmin/alternatives-command
            ```
        - You may have a need to keep multiple versions of an executable (like `java`) on your system. Perhaps most of your system will work with Java 8, but one application needs Java 7.
          
          The alternatives program lets you switch from one version to another, quickly.   
        - Ubuntu keeps track of the default programs by maintaining a list of symbolic links, under `/etc/alternatives` directory. Each entry here is a shortcut points to the actual program, which may have more than one option (i.e. alternatives).
       
            ```shell script
            cd /etc/alternatives
            find . -name java -exec ls -l '{}' \;
         
            # lrwxrwxrwx 1 root root 46 Thg 4  28 01:06 ./java -> /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java      
            ```
        - Moreover, the regular /usr/bin binaries are also symlinks
            ```shell script
            ls -l $(which java)
            
            # lrwxrwxrwx 1 root root 22 Thg 3  10 00:30 /usr/bin/java -> /etc/alternatives/java
            ```
        2. Add a group of alternatives to the system
            ```shell script
            sudo update-alternatives --install “/usr/bin/java” “java” “</path/to/jdk>/bin/java” 1
            sudo update-alternatives --install “/usr/bin/javac” “javac” “</path/to/jdk>/bin/javac” 1
            
            # sudo update-alternatives --install “/usr/bin/java” “java” “/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java” 1 
            # sudo update-alternatives --install <link> <name> <path> <priority>
            ```
        3. Set default version from list alternatives
            ```shell script
            sudo update-alternatives --set java </path/to/jdk>/bin/java
            sudo update-alternatives --set javac </path/to/jdk>/bin/java
            ```
        4. Make sure the correct version is checked for both Java and compiler:
            ```shell script
            sudo update-alternatives --config java
            sudo update-alternatives --config javac
            
           # there is command: update-java-alternatives
            ```  
        5. List the installed Java alternatives with:
            ```shell script
            sudo update-alternatives --list java
            sudo update-alternatives --list javac
            ```           
        6. Tips and trick
            - https://aboullaite.me/switching-between-java-versions-on-ubuntu-linux/
            - https://medium.com/@ayeshajayasankha/how-to-install-and-switch-between-alternative-java-versions-66b3671fc382
    
- **Jshell**
    - jshell is only available on jdk-9 onward.
        ```shell script
        sudo apt install openjdk-11-jdk-headless 
        ```
-   **JAVA_HOME** env variable
    - [`JAVA_HOME` and `JRE_HOME` are not used by Java itself](https://stackoverflow.com/a/27716151/10393067). Some third-party programs (for example Apache Tomcat, Maven, [Gradle](https://stackoverflow.com/a/67284400/10393067)) expect one of these environment variables to be set to the installation directory of the `JDK` or `JRE`. If you are not using software that requires them, you do not need to set `JAVA_HOME` and `JRE_HOME`.
    
    - [`JAVA_HOME` allows you to run any of multiple java installations](https://stackoverflow.com/a/48654332/10393067). Even if you have  the `/usr/lib/jvm/java-1.8.0/bin/java`  in your PATH first, it's useful to be able to say `JAVA_HOME=/usr/lib/jvm/java-1.5.0` and have the default "java" with which you run programs use the other one, instead, as a matter of an environment setting. This allows a programmer to use the java they need, even if it's not installed in a normal system location, and test or provide reverse compatibility with that alternate version. And it's not vulnerable to being reset in the PATH by another installed program, such as a major version update for java itself.
    - [Should JAVA_HOME point to JDK or JRE?](https://stackoverflow.com/questions/17601827/should-java-home-point-to-jdk-or-jre)    
        - If you're doing any sort of development, or building with Maven or Ant, you need to point to the JDK (Java Development Kit) where utilities such as javac (the Java Compiler) reside. Otherwise, you can point to the JRE (Java Runtime Environment).
      
        - [**As a developer**, you should point your `JAVA_HOME` at `JDK` to access `javac` compiler etc](https://stackoverflow.com/a/17601950/10393067). It's good if you can test your program to run on the JRE though. If you are using an `app server` you often also need the JDK instead of the JRE but that depends on the particular server.
        
        -  [To run the program we only need JRE( java Runtime Environment)](https://www.quora.com/Is-it-possible-to-execute-a-Java-programme-without-using-JDK/answer/Pawan-Kumar-285). 
        **But to develop `java` program and compile it we need different tools like javac jar etc** which are provided in JDK (Java Development KIT) every JDK internally have JRE.
        
        - In the server, you only need `JRE` to run `.jar` file. You don't need `javac`. Thus, even with [**JAVA_HOME=/path/to/bin/java**](https://stackoverflow.com/a/5102050/10393067) is enough to works flawlessly. You can [create executable `.jar` file](https://www.tecmint.com/create-and-execute-jar-file-in-linux/) and execute with `java` command as the following:
            ```shell script
            java -jar myclass.jar
            ``` 
        - From `java-11` onward, you only need `java` to compile and run `java` application with [Single line source code](https://www.baeldung.com/java-single-file-source-code) feature          

          


## java command

<pre>
    java -Xdiag                         # prints out a stacktrace when the program crashed.
    java packageName.MainClassName      # start java application (packageName is lying right beside the <b>package</b> keyword)
    
</pre>


## Collection

```shell
Sets.symmetricDifference(qualifiers, crawledQualifiers).isEmpty()
```

## String

- Join strings skip null
```shell
import com.google.common.base.Joiner;

Joiner.on(" ").skipNulls().join("I", null, "love", null, "null");
```

- Deal with unicode space char
    - There are rare case which is white-space char is not **white-space** char as you see (`U+0020`), it looks like the same with the naked eyes, but it exactly is **non-breaking space** (`U+00A0`), this is why `StringUtils.containsWhitespace(user.getDisplayName())` return `false` and I have to use `Guava` function `CharMatcher.whitespace().matchesAnyOf(user.getDisplayName())` instead.
    
    ![](images/white-space-unicode.png)

- Check if character is unicode space char
    ```shell script
    Character.isSpaceChar(int codePoint);
    ```

## Enum
- Enum constructor is fine with private or default constructor, causing an error with protected or public constructor because that would allow more instances to be created.
	- Enums contain a fixed set of values, which must all be known at compile-time. It doesn't make sense to create new literals at run-time, which would be possible if the constructor were visible.


## Map

- [Convert map to request param string](https://www.leveluplunch.com/java/examples/build-convert-map-to-query-string/)
    ```
     String mapJoined = Joiner.on("&").withKeyValueSeparator("=")
            .join(mapToConvert);
    ```

## Jackson

#### Jackson history
- https://github.com/FasterXML/jackson/wiki/Jackson-Releases
- http://www.cowtowncoder.com/blog/archives/2013/08/entry_479.html

#### Jackson docs
- https://github.com/FasterXML/jackson-docs
- [Jackson and JAXB](https://stackoverflow.com/a/33873971/10393067)

--

**Jackson is a suite of data-processing tools for Java comprising of [three components](https://www.quora.com/What-is-the-difference-between-fasterxmls-jackson-core-and-jackson-databind-Do-I-need-to-use-both-or-can-I-use-only-one-of-them/answer/Prashanth-Ambure):**

- Streaming (jackson-core) defines low-level streaming APIs and includes JSON-specific implementations.
    - JsonParser, JsonGenerator
- Annotations (jackson-annotations) contains standard Jackson annotations.
- Databind (jackson-databind) implements data-binding (and object serialization) support on the streaming package. This package depends on both the streaming and annotations packages.
    - converts JSON to and from POJOs based either on property accessor conventions or annotations.

- More: [Jackson-modules-java8](https://github.com/FasterXML/jackson-modules-java8)

**I. Jackson Serialization and Deserialization Annotations**

The Jackson library provides annotations that you can use in POJOs to control both serialization and deserialization between POJOs and JSON. These annotations that are used in both serialization and deserialization operations are:

- @JsonIgnore
- @JsonIgnoreProperties
- @JsonIgnoreType
- @JsonAutoDetect