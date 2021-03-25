- ## Source compatibility
    ```groovy
    sourceCompatibility = '1.8'
    ```
    - sourceCompatibility = specifies that version of the Java programming language be used to compile .java files. e.g sourceCompatibility 1.6 =specifies that version 1.6 of the Java programming language be used to compile .java files.
    - https://stackoverflow.com/a/29519066/10393067
    
- ## Extra properties (ext block)
  ```groovy
  ext.springVersion = '3.2.2.RELEASE'
  dependencies() {
          compile "org.springframework:spring-orm:$springVersion"
  }
  ```    