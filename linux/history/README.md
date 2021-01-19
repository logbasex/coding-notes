## basic

```bash


```

## env
```bash
# https://linux.die.net/man/1/bash
man history 
help history 

HISTTIMEFORMAT          # time stamp associated with each history entry displayed by the history builtin. (https://man7.org/linux/man-pages/man1/date.1.html)
HISTSIZE                # the number of lines or commands that are stored in memory in a history list while your bash session is ongoing.
HISTFILESIZE            # the number of lines or commands that (a) are allowed in the history file at startup time of a session, and (b) are stored in the history file at the end of your bash session for use in future sessions.

# .bashrc
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=$HISTCONTROL:ignoredups
export HISTTIMEFORMAT='%F, %T  '
```