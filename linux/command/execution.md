## Way to execute shell scripts
```shell script
bash script.sh  (script.sh as parameter, launch new shell) (not require permission)
source script.sh 
./script.sh (run in current shell) (require permission)
```

## [What is the difference between running “bash script.sh” and “./script.sh”?](https://unix.stackexchange.com/questions/136547/what-is-the-difference-between-running-bash-script-sh-and-script-sh)
```shell script
 - `bash script.sh` will ignore the shebang(#!) line, because bash is specified as the program to run script.sh.
 - `./script.sh` will read the shebang(#!) line to determine the program to run `script.sh`.
```