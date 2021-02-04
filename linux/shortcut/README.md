# Gnome-terminal

## Editing command shortcuts
<pre>
Ctrl+a           # go to the start of the command line 
Ctrl+e           # go to the end of the command line
Ctrl+k           # delete from cursor to the end of the command line
Ctrl+u           # delete from cursor to the start of the command line
Ctrl+w           # delete backward one word (doesn't copy to clipboard)
Ctrl+y           # paste word or text that was cut using one of the deletion shortcuts (such as the one above) after the cursor

Ctrl+xx          # move between start of command line and current cursor position (and back again)
ALt+b            # move backward one word
Alt+f            # move forward one word
Alt+d            # delete to end of word starting at cursor
Alt+c            # capitalize to end of word starting at cursor (whole word if cursor is at the beginning of word)
Alt+u            # make uppercase from cursor to end of word
Alt+l            # make lowercase from cursor to end of word
Alt+t            # swap current word with previous
Ctrl+b           # move backward one character
Ctrl+d           # delete character under the cursor
Ctrl+h           # delete character before the cursor
Ctrl+t           # swap character under cursor with the previous one
</pre>

## Command recall shortcuts

<pre>
Ctrl+r           # search the history backward
Ctrl+g           # escape from history search mode
Ctrl+p           # previous command in history
Ctrl+n           # next command in history
Alt+.            # use the last word of the previous command

# repeat last command (https://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history/)
- Ctrl+p
- up arrow key

# execute last command
- !!
- !-1
- fc -e -
</pre>

## Command control shortcuts

```bash
Ctrl+l           # clear the screen
Ctrl+s           # stops the output to the screen (for long running verbose command)
Ctrl+q           # allow output to the screen (if previously stopped using command above)
Ctrl+c           # terminate the process
Ctrl+z           # suspend/stop the process (send process to background)
Ctrl+o           # execute command

- Get list of suspend process: jobs
- Continue the suspend process/send back to foreground: fg jobs-number
```


---

https://quantrimang.com/14-lenh-linux-thu-vi-trong-terminal-160595