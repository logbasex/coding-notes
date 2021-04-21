- Install
    ```shell script
    //install pup
    https://github.com/ericchiang/pup
  
    //don't include space around = 
    GRADLE_VERSION=`curl https://services.gradle.org/distributions/ | pup --color 'div ul li a span.name json{}' | jq -r 'first(.[].text | select(test("gradle.*-bin.zip")))'`
    wget https://services.gradle.org/distributions/$GRADLE_VERSION -P /tmp
  
    # https://linuxize.com/post/how-to-install-gradle-on-ubuntu-20-04/
    ```

- ## [Gradle's user home directory](https://docs.gradle.org/current/userguide/directory_layout.html)
    ```shell script
    $USER_HOME/.gradle
    ```
- ## [Project root directory](https://docs.gradle.org/current/userguide/directory_layout.html#dir:project_root)

- Gradle multi version
    - https://stackoverflow.com/questions/42188495/gradle-multiple-versions-of-gradle

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
  
## Tip an tricks
- https://tomgregory.com/5-tips-for-using-gradle-with-intellij-idea-2019/  