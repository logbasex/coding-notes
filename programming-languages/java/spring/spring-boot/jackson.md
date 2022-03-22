## Jackson

#### Jackson history
- https://github.com/FasterXML/jackson/wiki/Jackson-Releases
- http://www.cowtowncoder.com/blog/archives/2013/08/entry_479.html

#### Jackson docs
- https://github.com/FasterXML/jackson-docs
- [Jackson and JAXB](https://stackoverflow.com/a/33873971/10393067)
- https://stackabuse.com/definitive-guide-to-jackson-objectmapper-serialize-and-deserialize-java-objects/
--

**Jackson is a suite of data-processing tools for Java comprising of [three components](https://www.quora.com/What-is-the-difference-between-fasterxmls-jackson-core-and-jackson-databind-Do-I-need-to-use-both-or-can-I-use-only-one-of-them/answer/Prashanth-Ambure):**

- Streaming (jackson-core) defines low-level streaming APIs and includes JSON-specific implementations.
    - JsonParser, JsonGenerator
- Annotations (jackson-annotations) contains standard Jackson annotations.
- Databind (jackson-databind) implements data-binding (and object serialization) support on the streaming package. This package depends on both the streaming and annotations packages.
    - converts JSON to and from POJOs based either on property accessor conventions or annotations.

- More: [Jackson-modules-java8](https://github.com/FasterXML/jackson-modules-java8)

**I. Jackson Serialization and Deserialization Annotations**

The Jackson library provides annotations that you can use in POJOs to control both serialization and deserialization between POJOs and JSON. These annotations that are used in both serialization and deserialization operations are:

- @JsonIgnore
- @JsonIgnoreProperties
- @JsonIgnoreType
- @JsonAutoDetect


## How it works
- [JsonGenerator for serialization and JsonParser for deserialization](https://www.stackchief.com/blog/Java%20ObjectMapper%20%7C%20What%20it%20is%20%7C%20How%20it%20works)
- Jackson auto-detect field
  - [Jackson JSON - Using @JsonAutoDetect to define fields/methods access visibility rules](https://www.logicbig.com/tutorials/misc/jackson/json-auto-detect.html)
  - [How to specify jackson to only use fields - preferably globally](https://stackoverflow.com/questions/7105745/how-to-specify-jackson-to-only-use-fields-preferably-globally)
    ```
    Specifically for boolean is*() getters:

    @JsonAutoDetect(isGetterVisibility = Visibility.NONE, ...          
    setVisibility(PropertyAccessor.IS_GETTER, JsonAutoDetect.Visibility.NONE);
    ```
- [How does Jackson @JsonProperty() work when used to annotate private fields?](https://stackoverflow.com/questions/63420195/how-does-jackson-jsonproperty-work-when-used-to-annotate-private-fields)
- [How does the Jackson mapper know what field in each Json object to assign to a class object?](https://stackoverflow.com/questions/22162916/how-does-the-jackson-mapper-know-what-field-in-each-json-object-to-assign-to-a-c)
- [How to get the JsonFactory settings using Jackson in Java?](https://www.tutorialspoint.com/how-to-get-the-jsonfactory-settings-using-jackson-in-java)
  - The JsonFactory class is a thread-safe and responsible for creating instances of writer and reader. The list of settings that can be turned on/off is present in an enumeration JsonFactory.Feature, it contains static method values() that return the enum constant of this type with the specified name.
  
- [Change default for TokenStreamFactory.Feature.INTERN_FIELD_NAMES to false](https://github.com/FasterXML/jackson-core/issues/378)

## Security
- [BSides Rochester 2019 - Jackson Deserialization Vulnerabilities](https://www.youtube.com/watch?v=Kd75BubLsUo)
- [On Jackson CVEs: Don’t Panic — Here is what you need to know](https://cowtowncoder.medium.com/on-jackson-cves-dont-panic-here-is-what-you-need-to-know-54cd0d6e8062)
-------

## [Jackson overcoming underscores in favor of camel-case](https://stackoverflow.com/questions/10519265/jackson-overcoming-underscores-in-favor-of-camel-case)
```java
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
public static class Request {

    String businessName;
    String businessLegalName;

}
```

## [Customize your Java-JSON serialization using Jackson Annotations](https://medium.com/trabe/customize-your-serialization-using-jackson-annotations-d6b81c4785a6)

- Exclude fields 
  - `@JsonIgnore`
- Customize date formats 
  - ` @JsonFormat(shape = JsonFormat.Shape.STRING)`
- Specifying custom names for the fields 
  - `@JsonProperty("date")`
- Snake Case 
  - `@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)`
- Customize enum representation. We can annotate any method of the enum with `@JsonValue` and the result of that method will be the value used for the serialization. Let’s say we annotate the method `getA()`:
  ```
  import com.fasterxml.jackson.annotation.JsonValue;
  public enum JacksonExampleEnum {
    OPTION_1("0", "0"), OPTION_2("1", "1");

    private String a;
    private String b;

    JacksonTestEnum(String a, String b) {
      this.a = a;
      this.b = b;
    }

    @JsonValue
    public String getA() {
      return a;
    }
    
    public String getB() {
      return b;
    }
  }
  
  ...
  {
    "field_one": "Some text",
    "some_date": "2019-02-26T18:58:38.283+0000",
    "some_enum": "0"
  }
  ``` 
  - ....

## Annotations

# Jackson Annotations

Multiple sets of annotations may be used to configure how Jackson databinding works.
Document is split along the lines of Jackson component that defines annotations and/or adds support for handling annotations.

* [Core Jackson annotations](../../jackson-annotations/wiki/Jackson-Annotations) are defined by `jackson-annotations` core component, which has no dependencies to any other package
* [Jackson Databind annotations](../../jackson-databind/wiki/Databind-Annotations) are defined by `jackson-databind` and depend on types of `jackson-core` and `jackson-annotations`
* [Support for JAXB annotations](../../jackson-module-jaxb-annotations/) is optional add-on, usually used when handling [XML](../../jackson-datatype-xml), or when using Java Object generated using `JAXB` tools (usually from XML Schema definitions)


- ### [Serialization](https://dzone.com/articles/jackson-annotations-for-json-part-2-serialization)
  - @JsonValue
    >The @JsonValue annotation is used at the method level. This annotation tells Jackson to use this method to generate the JSON string from the Java object.
  - @JsonInclude
    > The @JsonInclude annotation is used to exclude properties or fields of a class under certain conditions.
  - @JsonGetter
    > The @JsonGetter annotation is used to customize the generated JSON keys. This is accomplished with the value argument of @JsonGetter. The value passed is the name that should be used as the JSON key.
  - @JsonAnyGetter
    > The @JsonAnyGetter annotation can be used when you don’t want to declare a property or a method for every possible key in JSON. This annotation is used on the getter methods which enables you to use a Map to hold all your properties that you want to serialize.
    > 
    > Thay vì khai báo @JsonProperty mỗi field thì dùng luôn cái map, nhét data vào rồi serialize phát cho nó nhanh.
  - @JsonPropertyOrder
    > The @JsonPropertyOrder annotation tells Jackson to serialize the Java object to JSON in the order specified as the arguments of the annotation. This annotation also allows partial ordering. The properties are first serialized in the order in which they are found, followed by any other properties not included in the annotation.
  - @JsonRawValue
    > The @JsonRawValue annotation is used on methods and fields. It tells Jackson to serialize the field or property as declared. For example, if you have a String field in your Java class, the JSON value that Jackson generates is enclosed within quotes (" "). But when you annotate the field with @JsonRawValue, Jackson omits the quotes.
  - @JsonSerialize
    > The @JsonSerialize annotation is used tell Jackson to use the declared custom serializer during the serialization of the field, which is marked with this annotation. Let us consider a POJO that uses the @JsonSerializeannotation.
  - @JsonRootName
    > The @JsonRootName annotation can be used to tell Jackson to wrap the object to be serialized with a top-level element. You can pass the name as a parameter to the @JsonRootName annotation. Let us consider that you want to wrap your serialized Java object with the key user.
    ```
    @JsonRootName(value = "user")
      public class RootNameDemoBean {
      public long personId = 0;
      public String  name = "James Clark";
    }
    
    {"user": {}}
    ```
- ### [Deserialization](https://dzone.com/articles/jackson-annotations-for-json-part-2-serialization)
  - @JsonSetter
    ```
    @JsonSetter("id")
    public void setPersonId(long personId) {
        this.personId = personId;
    }
    ```
  - @JsonAnySetter
    ```
    public class AnySetterDemoBean {
        public long personId = 123L;
        public String  personName = "James Clark";
        private Map<String, String> properties = new HashMap<String, String>();
    
        @JsonAnySetter
        public void setProperties(String key, String value){
            properties.put(key, value);
        }
    }
    
    ....
    
    String jsonString = "{\"personId\": 231, \"personName\": \"Mary Parker\", \"emailId\": \"mary@gmail.com\", \"gender\": \"female\"}";
    ObjectMapper mapper = new ObjectMapper();
    AnySetterDemoBean bean = objectMapper.readValue(jsonString, AnySetterDemoBean.class);
    ```
  - @JsonCreator
    > The @JsonCreator annotation tells Jackson that the JSON properties can be mapped to the fields of a constructor of the POJO.
  - @JacksonInject
    > The @JacksonInject annotation is used to tell Jackson that particular values of the deserialized object will be injected and not read from the JSON string.
    
  - @JsonDeserialize
    > The @JsonDeserialize annotation tells Jackson to use a custom deserializer while deserializing the JSON to Java object. To do so, you need to annotate the field to which you need to apply the custom deserializer.
    
    ```
    @JsonDeserialize(using = CustomDateDeserializer.class)
    public Date activeDate;
    ```
- ## [General Annotations](https://dzone.com/articles/jackson-annotations-for-json-part-4-general)
  - @JsonProperty
    > The @JsonProperty annotation is used to map property names with JSON keys during serialization and deserialization.
  - @JsonFormat
    > The @JsonFormat annotation is used to tell Jackson that the format in which the value for a field is serialized. It specifies the format using the JsonFormat.Shape enum.
  - @JsonUnwrapped
    > The @JsonUnwrapped annotation unwraps the values during serialization and deserialization. It helps in rendering the values of a composed class as if they belonged to the parent class. (expand sub object)
  - @JsonView
    > The @JsonView annotation is used to include or exclude a property dynamically during serialization and deserialization. It tells the view in which the properties are rendered.
  - @JsonManagedReference and @JsonBackReference
    > The @JsonManagedReference and @JsonBackReference annotation are used to create JSON structures that have a bidirectional relationship.
  - @JsonIdentityInfo
    > The @JsonIdentityInfo tells Jackson to perform serialization or deserialization using the identity of the object. This annotation works similar to the @JsonManagedReference and @JsonBackReference annotations with the difference that @JsonIdentityInfo includes the back reference object.
  - @JsonFilter
    > The @JsonFilter annotation is used to tell Jackson to use a custom defined filter to serialize the Java object. To define your filter, you need to use the FilterProvider class. This provider gets the actual filter instance to use. The filter is then configured by assigning the FilterProvider to ObjectMapper.
    - https://stackoverflow.com/questions/11036366/filter-nested-objects-using-jacksons-beanpropertyfilter



  




