## java command

<pre>
    java -Xdiag                         # prints out a stacktrace when the program crashed.
    java packageName.MainClassName      # start java application (packageName is lying right beside the <b>package</b> keyword)
    
</pre>


## Collection

```shell
Sets.symmetricDifference(qualifiers, crawledQualifiers).isEmpty()
```

## String

- Join strings skip null
```shell
import com.google.common.base.Joiner;

Joiner.on(" ").skipNulls().join("I", null, "love", null, "null");
```

## Enum
- Enum constructor is fine with private or default constructor, causing an error with protected or public constructor because that would allow more instances to be created.
	- Enums contain a fixed set of values, which must all be known at compile-time. It doesn't make sense to create new literals at run-time, which would be possible if the constructor were visible.


## Map

- [Convert map to request param string](https://www.leveluplunch.com/java/examples/build-convert-map-to-query-string/)
    ```
     String mapJoined = Joiner.on("&").withKeyValueSeparator("=")
            .join(mapToConvert);
    ```

## Jackson
Jackson is a suite of data-processing tools for Java comprising of [three components](https://www.quora.com/What-is-the-difference-between-fasterxmls-jackson-core-and-jackson-databind-Do-I-need-to-use-both-or-can-I-use-only-one-of-them/answer/Prashanth-Ambure):

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