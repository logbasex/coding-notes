![https://www.oreilly.com/library/view/learning-the-bash/1565923472/ch04.html](https://www.oreilly.com/library/view/learning-the-bash/1565923472/tagoreillycom20070222oreillyimages99946.png)

- Whenever you run a shell script, it creates a new process called subshell and your script will get executed using a subshell.
- A Subshell can be used to do parallel processing.
- We can make the variable known to subshells with export command.
- If you start another shell on top of your current shell, it can be referred to as a subshell.

[`source` command vs `bash` command](A brief introduction to the method of executing shell command under Linux
)

--- 

> [Whenever we run any command in a Bash shell, a subshell is created by default, and a new child process is spawned (forked) to execute the command. When using **exec**, however, the command following exec replaces the current shell. This means no subshell is created and the current process is replaced with this new command.](https://www.baeldung.com/linux/exec-command-in-shell-script)

```shell
exec bash print-current-time.sh
```

- Sau khi chạy xong tự động tắt terminal -> This means no subshell is created and the current process is replaced with this new command.

```
bash print-current-time.sh
```
- Sau khi chạy xong terminal vẫn nguyên -> Chỉ có child process/subshell là kết thúc.

> [When you don't `exec`, the shell forks itself, execs in the fork, and waits around for the child process to exit, collecting its return status, in the hope there might be additional commands to run afterwards (`fork` + `exec` is the standard procedure by which new commands get spawned).
Since there are none, the `fork` is a complete waste of time and you might as well exec directly and save on that `fork`ing time.](https://unix.stackexchange.com/questions/286378/why-do-some-linux-shell-scripts-use-exec-to-run-commands)

----

[`export` command](https://www.baeldung.com/linux/bash-variables-export)

---

[Shell Scripting – Subshell vs Subprocess](https://jitpaul.blog/2018/09/16/shell-scripting-sub-shell-vs-sub-process/)

[Why Do We Need to Create A Child Process?](https://www.geeksforgeeks.org/difference-between-process-parent-process-and-child-process/)