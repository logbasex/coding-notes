The general form for a here document is:

```shell
command << delimiter
document
delimiter
```

For example:
```shell
$wc -l << EOF
This is a simple lookup program for good (and bad) restaurants in Cape Town.
EOF
3
```

https://superuser.com/questions/1003760/what-does-eof-do