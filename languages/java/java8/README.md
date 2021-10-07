## Stream

- Convert Iterable to Stream using Java 8 JDK
    ```shell
    # JDK
    StreamSupport.stream(iterable.spliterator(), false)
             .filter(...)
             .moreStreamOps(...);
  
    # Guava
    Streams.stream(iterable);
    ```