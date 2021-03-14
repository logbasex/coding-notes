- [Two type of pipes](https://www.baeldung.com/linux/anonymous-named-pipes)
- [named pipe](https://opensource.com/article/18/8/introduction-pipes-linux)
- https://unix.stackexchange.com/questions/128975/why-doesnt-grep-using-pipe-work-here
- https://stackoverflow.com/questions/6893714/why-does-ps-o-p-list-the-grep-process-after-the-pipe
- https://stackoverflow.com/questions/9834086/what-is-a-simple-explanation-for-how-pipes-work-in-bash
Do
```shell script
ls logbasex | grep a
```
Only show output without red highlighted `ls`. It's mean pipe(`|`) only redirect `stdout` for `grep` command use, not `stderr` so caused `grep` get nothing to fit in. 

```shell script
ls: cannot access 'logbasex': No such file or directory
```

[pipe `stderr` instead of `stdout`](https://stackoverflow.com/questions/2342826/how-can-i-pipe-stderr-and-not-stdout)

```shell script
ls logbasex 2>&1 >/dev/null | grep ls
```
[Redirect to /dev/null](https://unix.stackexchange.com/questions/119648/redirecting-to-dev-null)

[Syntax](https://tldp.org/LDP/abs/html/io-redirection.html)
```shell script
   M>&N
     # "M" is a file descriptor, which defaults to 1, if not set.
     # "N" is another file descriptor.

   2>&1
      # Redirects stderr to stdout.
```


### Shell redirection order
https://stackoverflow.com/questions/17975232/shell-redirection-i-o-order