## Overview
![](https://miro.medium.com/max/700/1*vw8KWDkB4pcmTyzU2sYMAw.png)

[Do not blindly implement the Serializable Interface](https://levelup.gitconnected.com/do-not-blindly-implement-the-serializable-interface-12b596d49687)

> Túm cái quần lại là có nhiều serialize/deserialize scheme khác nhau, phổ biến như **JSON** hay **Protocol Buffers**...Chỉ gặp trường hợp serialize dạng binary stream thì mới dùng java.io.Serializble interface thôi, đơn cử như Oauth2Token, Redis Object.

## [Java Serialization, Why no Serialization Exception when saving into DB?](https://stackoverflow.com/questions/64303567/java-serialization-why-no-serialization-exception-when-saving-into-db)

The word "serialize" is overused, which can be confusing.

It is *generally* used to describe the conversion of a Java class instance to some storage/transmission format, binary or text, e.g.

- We can serialize to XML text using JAXB. This requires some use of `@Xml...` annotations, e.g. at lease one class must have `@XmlRootElement`.

- We can serialize to JSON text using some JSON library. Annotations like `@Json...` can optionally be used.

- We can serialize to a database using JPA/Hibernate. This requires an `@Entity` annotation.

- We can serialize to a binary file using an [`ObjectOutputStream`][1]. This requires the class to implement [`Serializable`][2].

- ... and other ways ...

Only serializing to a binary file using an `ObjectOutputStream` will throw [`NotSerializableException`][3].

The others throw different kinds of exceptions, and uses different mechanisms to customize the serialization process, e.g. `@XmlElement` annotations for JAXB, `@JsonProperty` annotations for JSON, `@Column` annotations for JPA, etc.

You can use all 4 at the same time on a class, if needed, since they are non-overlapping.

Short answer is that only serialization using an `ObjectOutputStream` requires `Serializable`, so you don't need to implement `Serializable`, if you're not serializing to a binary file.


[1]: https://docs.oracle.com/javase/8/docs/api/java/io/ObjectOutputStream.html
[2]: https://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html
[3]: https://docs.oracle.com/javase/8/docs/api/java/io/NotSerializableException.html

----------
## [Everything You Need to Know About Java Serialization Explained](https://dzone.com/articles/what-is-serialization-everything-about-java-serial)

- **Serialization** is the process of saving an object's state to a sequence of bytes, which then can be stored on a file or sent over the network, and **deserialization** is the process of reconstructing an object from those bytes.
- Only **subclasses** of the **Serializable** interface can be serialized.
- If our class **does not implement Serializable** interface, or if it is having a reference to a non-Serializable class, then the JVM will throw **NotSerializableException**.
- All **transient** and **static** fields do not get serialized.
- The **serialVersionUID** is used to verify that the serialized and deserialized objects have the same attributes and thus are compatible with deserialization.
- We should create a **serialVersionUID** field in our class so if we change our class structure (adding/removing fields), the JVM will not through **InvalidClassException**. If we do not provide it, the JVM provides one that might change when our class structure changes.
- We can override the default serialization behaviour inside our Java class by providing the implementation of **writeObject** and **readObject** methods.
- And we can call **ObjectOutputStream.defaultWriteObject()** and **ObjectInputStream.defaultReadObject** from **writeObject** and **readObject** methods to get the default serialization and deserialization logic.
- We can throw **NotSerializableException** exception from writeObject and readObject , if we do not want our class to be serialized or deserialized.

------

> You don't need to implement Serializable and Deserializable for your DTO because it is already handled by Spring Boot Jackson Package.
> 


---

[Spring MVC - should my domain classes implement Serializable for over-the-wire transfer?](https://stackoverflow.com/questions/38457074/spring-mvc-should-my-domain-classes-implement-serializable-for-over-the-wire-t)

The specific examples you have mentioned do not transfer objects over the wire. From the example links I see that the controller methods return a domain object with `ResponseBody` annotation. Just because the return type of the method is the domain object it is not necessary that the whole object is being sent to the client. One of the handler method in Spring mvc framework internally intercepts the invocation and determines that the method return type does not translate to direct `ModelAndView` object. **`RequestResponseBoodyMethodProcessor`** which handles the return value of such annotated methods and uses one of the message converters to write the return object to the http response body. In the case the message converter used would be **`MappingJackson2HttpMessageConverter`**. So if are to follow the same coding style you are not required to implement `Serializable` for your domain objects.

Have a look at this [link][1] for the Http message converters provided by default from spring. The list is quiet extensive however not exhaustive and if requirements arise you can implement your own custom message converter to user as-well.


[1]: http://websystique.com/springmvc/spring-mvc-requestbody-responsebody-example/

----
----
There are many ways to serialize an object. Java's object serialization is just one of them. From the [official documentation][1]:

> To serialize an object means to convert its state to a byte stream

REST APIs usually send and receive JSON or XML. In that case serializing an object means converting its state to a `String`.

There is no direct connection between "sending an object over the wire" and implementing `Serializable`. The technologies you use dictate whether or not `Serializable` has to be implemented.

[1]: https://docs.oracle.com/javase/tutorial/jndi/objects/serial.html

