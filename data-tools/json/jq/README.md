## [Filter](https://gist.github.com/ipbastola/2c955d8bf2e96f9b1077b15f995bdae3)

JQ to filter JSON by value
Syntax: <strong>`cat <filename> | jq -c '.[] | select( .<key> | contains("<value>"))'`</strong>

Example: To get json record having _id equal 611
```bash
cat my.json | jq -c '.[] | select( ._id | contains(611))'
```
Remember: if JSON value has no double quotes (eg. for numeric) to do not supply in filter i.e. in `contains(611)`

## Cheatsheet

- https://gist.github.com/olih/f7437fb6962fb3ee9fe95bda8d2c8fa4