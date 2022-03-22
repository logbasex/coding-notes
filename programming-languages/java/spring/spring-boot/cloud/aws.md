## [Getting Started With AWS SQS and Spring Cloud](https://reflectoring.io/spring-cloud-aws-sqs/)
  - The `QueueMessageHandlerFactory` allows Spring to use our custom message converter for deserializing the messages it receives in its listener method. 
    ```
    @Bean
    pulic QueueMessageHandlerFactory queueMessageHandlerFactory(AmazonSQSAsync amazonSQS, BeanFactory beanFactory, ObjectMapper objectMapper) { 
       QueueMessageHandlerFactory factory = new QueueMessageHandlerFactory();
       factory.setAmazonSqs(amazonSQS);
       factory.setBeanFactory(beanFactory);    
       MappingJackson2MessageConverter mappingJackson2MessageConverter = new MappingJackson2MessageConverter();
       mappingJackson2MessageConverter.setSerializedPayloadClass(String.class);
       mappingJackson2MessageConverter.setObjectMapper(objectMapper);
       mappingJackson2MessageConverter.setStrictContentTypeMatch(false);
       factory.setArgumentResolvers(Collections.singletonList(new NotificationMessageArgumentResolver(mappingJackson2MessageConverter)));  
       return factory; 
	    }
    ```