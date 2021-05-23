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

[Example:](https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html)
- The default umask 002 used for normal user. With this mask default directory permissions are 775 and default file permissions are 664.
- The default umask for the root user is 022 result into default directory permissions are 755 and default file permissions are 644.
- For directories, the base permissions are (rwxrwxrwx) 0777 and for files they are 0666 (rw-rw-rw).