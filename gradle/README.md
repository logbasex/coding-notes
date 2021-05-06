- ## Source
    - Gradle life cycle
        - https://medium.com/@shivam.gosavi340_58315/gradle-103-build-life-cycle-6d1b595d72cc
        - https://proandroiddev.com/understanding-gradle-the-build-lifecycle-5118c1da613f
    - How gradle works
        - https://www.devopsschool.com/blog/what-is-gradle-dag-directed-acyclic-graph/
        - https://stackoverflow.com/questions/2414281/what-are-real-world-examples-of-gradles-dependency-graph    
        - https://mail2lakshmi12.medium.com/gradle-gradle-all-about-gradle-a15504a9e4c9

- ## Install
    ```shell script
    //install pup
    https://github.com/ericchiang/pup
  
    //don't include space around = 
    GRADLE_FILE_NAME=`curl https://services.gradle.org/distributions/ | pup --color 'div ul li a span.name json{}' | jq -r 'first(.[].text | select(test("gradle.*-bin.zip")))'`
    wget https://services.gradle.org/distributions/$GRADLE_FILE_NAME -P /tmp
    GRADLE_VERSION=`echo $GRADLE_FILE_NAME | awk -F '-' '{print $2}'`
    sudo unzip -d /opt/gradle /tmp/$GRADLE_VERSION
    sudo ln -s /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest
  
    //https://unix.stackexchange.com/questions/261599/how-can-we-prevent-parameter-expansion
    //https://stackoverflow.com/questions/82256/how-do-i-use-sudo-to-redirect-output-to-a-location-i-dont-have-permission-to-wr
    //https://unix.stackexchange.com/questions/77277/how-to-append-multiple-lines-to-a-file
    sudo bash -c 'echo -e "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\${GRADLE_HOME}/bin:\${PATH}" > /etc/profile.d/gradle.sh'  
    sudo chmod +x /etc/profile.d/gradle.sh
    source /etc/profile.d/gradle.sh
    gradle -v
    # https://linuxize.com/post/how-to-install-gradle-on-ubuntu-20-04/
    ```
  
- Set up JVM version for Gradle
    - https://stackoverflow.com/a/67284400/10393067  

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
  
- ## [Gradle: build.gradle vs. settings.gradle vs. gradle.properties](https://www.baeldung.com/gradle-build-settings-properties)
  
## Tip an tricks
- https://tomgregory.com/5-tips-for-using-gradle-with-intellij-idea-2019/  