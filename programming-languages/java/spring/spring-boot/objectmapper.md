## [How to Define a Custom Object Mapper In Spring Boot Without Impacting Default Object Mapper of Spring Boot?](https://stackoverflow.com/questions/60640245/how-to-define-a-custom-object-mapper-in-spring-boot-without-impacting-default-ob)

JacksonAutoConfiguration

```java
@Configuration(proxyBeanMethods = false)
	@ConditionalOnClass(Jackson2ObjectMapperBuilder.class)
	static class JacksonObjectMapperConfiguration {

		@Bean
		@Primary
		@ConditionalOnMissingBean
		ObjectMapper jacksonObjectMapper(Jackson2ObjectMapperBuilder builder) {
			return builder.createXmlMapper(false).build();
		}

	}
```

The Spring Jackson auto configuration uses **@ConditionalOnMissingBean** to create the default **ObjectMapper**. This means it only creates it if there isn't an existing bean of the same type. So by creating your own **ObjectMapper** bean, the Spring auto config doesn't create one.

I think you have a couple of options:

If you need to control the behavior of the default Spring **ObjectMapper**, then you can use the **spring.jackson.*** properties to configure its behavior.
If you really need 2 **ObjectMapper** objects with different behavior, you'll have to create them both as beans, give them unique names, and mark one as **@Primary** to control when/where they are autowired.

## Docs
- [Example](https://www.appsdeveloperblog.com/jackson-objectmapper-tutorial/)
- [Customize the Jackson ObjectMapper](https://docs.spring.io/spring-boot/docs/current/reference/html/howto.html#howto.spring-mvc.customize-jackson-objectmapper)
  > If you want to replace the default ObjectMapper completely, either define a @Bean of that type and mark it as @Primary or, if you prefer the builder-based approach, define a Jackson2ObjectMapperBuilder @Bean. **Note that, in either case, doing so disables all auto-configuration of the ObjectMapper**.