## [Is it necessary to use main method when we develop web application using spring boot?](https://stackoverflow.com/questions/57652798/is-it-necessary-to-use-main-method-when-we-develop-web-application-using-spring)

[Spring boot supports two modes of work](https://stackoverflow.com/questions/57652798/is-it-necessary-to-use-main-method-when-we-develop-web-application-using-spring):

- **using embedded server (tomcat, jetty, whichever you choose)**. In this mode, you need a main method to start it
- **using external sever**. In this mode, you need to pack your project into a war file, in the old fashion way. `On this mode a main method is not required`.

[Why do I need main method if I develop web app as war using Spring Boot?](https://stackoverflow.com/questions/29782148/why-do-i-need-main-method-if-i-develop-web-app-as-war-using-spring-boot/46816362)


------------


