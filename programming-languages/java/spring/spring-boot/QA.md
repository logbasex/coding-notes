## [Is it necessary to use main method when we develop web application using spring boot?](https://stackoverflow.com/questions/57652798/is-it-necessary-to-use-main-method-when-we-develop-web-application-using-spring)

[Spring boot supports two modes of work](https://stackoverflow.com/questions/57652798/is-it-necessary-to-use-main-method-when-we-develop-web-application-using-spring):

- **using embedded server (tomcat, jetty, whichever you choose)**. In this mode, you need a main method to start it
- **using external sever**. In this mode, you need to pack your project into a war file, in the old fashion way. `On this mode a main method is not required`.

[Why do I need main method if I develop web app as war using Spring Boot?](https://stackoverflow.com/questions/29782148/why-do-i-need-main-method-if-i-develop-web-app-as-war-using-spring-boot/46816362)


------------

[Return ResponseEntity vs returning POJO](https://stackoverflow.com/questions/49673660/return-responseentity-vs-returning-pojo)

[When use ResponseEntity<T> and @RestController for Spring RESTful applications](https://stackoverflow.com/questions/26549379/when-use-responseentityt-and-restcontroller-for-spring-restful-applications)

ResponseEntity<T> represents the entire HTTP response. Besides the body, its API allows you to set headers and a status code to the response.

Returning just a bean is fine but doesn't give you much flexibility: In the future, if you need to add a header to the response or modify the status code, for example, you need to change the method return type.