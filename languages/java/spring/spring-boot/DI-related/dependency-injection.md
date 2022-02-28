## constructor injection

## setter injection

## field injection
- [How Field Injection in Spring Boot works internally?](https://stackoverflow.com/questions/57386896/how-field-injection-in-spring-boot-works-internally)
- Now given this information, its understandable why final fields cannot be autowired. Leave alone spring, In pure Java, final fields must be instantiated directly right during the declaration (final int i = 123) or in the constructor of the class. [**But the autowiring happens after constructor, so its impossible to autowire the final fields**](https://stackoverflow.com/questions/62774713/internal-working-of-field-injection-in-spring-and-why-is-it-not-recommended-to-u).
## method lookup injection

## [Dependency injection in @Bean method parameters](https://www.logicbig.com/tutorials/spring-framework/spring-core/javaconfig-methods-inter-dependency.html)

![](../images/bean-params.png)