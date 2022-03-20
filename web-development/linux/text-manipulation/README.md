- show uncommented line
```shell script
    cat file.yml | grep -v "#"
```

- show not empty line
```shell script
    cat file.yml | grep -v "^$"
```

- split line into token
```shell script
echo "hello abc dad" | fmt -1 -
```                      
