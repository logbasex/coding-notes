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

```shell
cat << EOF
hello
EOF

# Nếu mà không có EOF (end of file) thì phải có tên file để đọc...
```

https://superuser.com/questions/1003760/what-does-eof-do

---

## EOF example
> [The EOF operator is used in many programming languages. This operator stands for the end of the file. **This means that wherever a compiler or an interpreter encounters this operator, it will receive an indication that the file it was reading has ended**](https://linuxhint.com/what-is-cat-eof-bash-script/).

- [What's the different between (cat EOF) and echo command](https://superuser.com/questions/1434549/whats-the-different-between-cat-some-file-eof-some-stuff-eof-and-echo)
  - same functionality but some cases are better.

---

[Here Document And Here String](https://www.baeldung.com/linux/heredoc-herestring)

```
ssh -T baeldung@example.com "touch log1.txt"
ssh -T baeldung@example.com "touch log2.txt"
```

In the trivial example above, we’re executing two lines of code over ssh on the remote system. **However, if we’ve more commands to execute, the solution above will become cluttered and verbose**. To make it more succinct, we can replace it with a heredoc:

```
ssh -T baeldung@host.com << EOF
touch log1.txt
touch log2.txt
EOF
```
