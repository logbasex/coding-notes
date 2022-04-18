# Signal
   - `SIGINT` is the interrupt signal. The terminal sends it to the foreground process when the user presses `ctrl-c`. **The default behavior is to `terminate the process`**, _**BUT it CAN BE caught** or **ignored**_. The intention is to provide a mechanism for an orderly, graceful shutdown.
      > Some time ctrl+c can be caught using `trap` or `ignored`. Even nothing happen when we press ctrl + c.  
      >
      - Signal value is 2
      - Equivalent command is `kill -2 <PROCESS ID>`
   - `SIGQUIT` is the dump core signal. The terminal sends it to the foreground process when the user presses `ctrl-\\` (ctrl + backslash). **The default behavior is to terminate the process and dump core, but it can be caught or ignored**. The intention is to provide a mechanism for the user to abort the process. You can look at SIGINT as "user-initiated happy termination" and SIGQUIT as "user-initiated unhappy termination."
      - Signal value is 3
      - Equivalent command is `kill -3 <PROCESS ID>` 
    
   - `SIGTERM` is the termination signal. The default behavior is to terminate the process, but it also `CAN BE CAUGHT OR IGNORED`. **The intention is to kill the process, gracefully or not, but to first allow it a chance to cleanup**.
    
   - `SIGKILL` is the kill signal. The only behavior is to kill the process, immediately. **The signal cannot be caught, blocked or ignored**. As the process cannot catch the signal, it cannot cleanup, and thus this is a signal of last resort.
      - Signal value is 9
   - `SIGSTOP` is the pause signal. The only behavior is to pause the process; **the signal cannot be caught, blocked or ignored**. The shell uses pausing (and its counterpart, resuming via SIGCONT) to implement job control.
   
   - Nearly impossible to kill send `SIGKILL` or `SIGTOP` from the keyboard.
        - https://superuser.com/questions/288772/shell-sigkill-keybinding
   - List keybinding
        ```shell script
        stty -a
        ```    
   ![](https://qph.fs.quoracdn.net/main-qimg-1180ef2465c309928b02481f02580c6a)
   
   
### More about signal
- [Difference between SIGTERM and SIGKILL](https://www.quora.com/What-is-the-difference-between-the-SIGINT-and-SIGTERM-signals-in-Linux-What%E2%80%99s-the-difference-between-the-SIGKILL-and-SIGSTOP-signals/answer/Luis-Otavio-Martins)       
- [Intro to SIGNAL](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_01.html)
- [Signal more detail](https://unix.stackexchange.com/questions/6332/what-causes-various-signals-to-be-sent) 
- [List of signal](https://unix.stackexchange.com/questions/317492/list-of-kill-signals)