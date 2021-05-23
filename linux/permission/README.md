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