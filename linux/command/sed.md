## Convert snake case to camel case
```shell script
echo "my_long_variable" | sed -r 's/_([a-z])/\U\1/gi'
```