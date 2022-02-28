## Overview

- Check Spring Version
    ```shell
    public static void main(String[] args) {
		    System.out.println(SpringVersion.getVersion());
		    System.out.println(SpringBootVersion.getVersion());
	 }
  
  
    5.2.9.RELEASE
    2.3.4.RELEASE
    ```
- [Spring Boot application starters](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#using-boot-starter)


## Install Spring boot CLI
- https://docs.spring.io/spring-boot/docs/current/reference/html/getting-started.html

## How to scaffold a Spring Boot application
- https://attacomsian.com/blog/scaffolding-spring-boot-application

## Bean
  > In Spring, the objects that form the backbone of your application and that are managed by the Spring IoC container are called beans. A bean is an object that is instantiated, assembled, and otherwise managed by a Spring IoC container.

## ApplicationRunner and CommandLineRunner
- [Need to execute some custom code before your Spring Boot application finishes starting up? You can make that happen with a couple of runners.](https://dzone.com/articles/spring-boot-applicationrunner-and-commandlinerunne)

## Bugs

- ### [Resolving “Failed to Configure a DataSource” Error](https://www.baeldung.com/spring-boot-failed-to-configure-data-source)
  - Add data source config
  - Add **exclude={DataSourceAutoConfiguration.class}**
  