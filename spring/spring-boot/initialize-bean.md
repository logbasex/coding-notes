# [dynamically initialized bean](https://medium.com/davebarda/creating-a-dynamically-initialized-bean-in-spring-18d6d41d24df)

If you are using Spring for a while, you probably got into a situation where you need to initialize a Spring bean that receives different arguments as an input in each of its inialization

1. Creating a new bean using the Application context
    - Many drawbacks
2. Lookup method injection
   - Few drawbacks 
3. Factory method
4. ObjectProvider(Since Spring 4.3)


