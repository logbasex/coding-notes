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
