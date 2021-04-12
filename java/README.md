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
