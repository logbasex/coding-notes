## Check sudo privileges
- To check whether you have sudo privileges or not, you can launch the following command.
    ```shell script
    sudo -l
    ```
    - If you see the following lines on your terminal, it means that you currently belongs to the sudo group.
        ```shell script
        User user may run the following commands on server-ubuntu:
            (ALL : ALL) ALL
        ```      
- Alternatively, you can run the “groups” command and verify that “sudo” is one of the entries.
    ```shell script
    groups
    ```  

## File and Directory

For a file :

- **r** = we can see the content of the file
- **w** = we can modify the content
- **x** = we can run the file using command **./< fileName>**

For a directory :

- **r** = we can see contents of the directory
- **w** = we can write files in a directory
- **x** = we can use **cd < dirName>** command to enter into the directory

[r =read, w =write, x =execute]

## Default permisson
If the default settings are not changed, files are created with the access mode **666** and directories with **777**.

![](https://i.stack.imgur.com/JKUg3.jpg)


[Example:](https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html)
- The default umask 002 used for normal user. With this mask default directory permissions are 775 and default file permissions are 664.
- The default umask for the root user is 022 result into default directory permissions are 755 and default file permissions are 644.
- For directories, the base permissions are (rwxrwxrwx) 0777 and for files they are 0666 (rw-rw-rw).


## sudo

```shell
➜ ls -l  $(which sudo)
-rwsr-xr-x 1 root root 166056 Jan 19 21:21 /usr/bin/sudo
```

- `setuid` (**s** permission): run sudo as owner permission (root), not current user permission.
- it runs as the user who owns the executable file instead of the user who invoked the program.  
- That is the "setuid" bit, **which tells the OS to execute that program with the userid of its owner**. This is typically used with files owned by root to allow normal users to execute them as root with no external tools (such as `sudo`).

    You can set the suid bit using **chmod**, eg **chmod 4755** which will give a file give the normal permissions 755 does (`rwxr-xr-x`) and add the suid bit to give `rwsr-xr-x`.

    You can clear the setuid bit by issuing a normal chmod command with a 0 prepended to it. For example, to set permissions back to `rwxr-xr-x` you would use `chmod 0755`.

- [How sudo works?](https://unix.stackexchange.com/questions/80344/how-do-the-internals-of-sudo-work)
- [sudoers syntax](https://unix.stackexchange.com/questions/18877/what-is-the-proper-sudoers-syntax-to-add-a-user)
## Special permissions (the setuid, setgid and sticky bits)
- https://linuxconfig.org/how-to-use-special-permissions-the-setuid-setgid-and-sticky-bits
