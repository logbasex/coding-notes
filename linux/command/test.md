##  [test command](https://www.computerhope.com/unix/test.htm)

> info test (docs for test command)

> On Unix-like operating systems, the test command checks file types and compares values.
  


```shell script
test 100 -gt 99 && echo "Yes, that's true." || echo "No, that's false."

# check file has symbolci link
test -L test.txt && echo "Yes, that's true." || echo "No, that's false."
```