## Cracking sudo password
https://linuxize.com/post/etc-shadow-file/
https://null-byte.wonderhowto.com/how-to/crack-shadow-hashes-after-getting-root-linux-system-0186386/


## Provide sudo password without type

- Script
    ```shell script
    echo 'password' | sudo -S apt update

    sudo -S <<< 'password' apt update
    ```
- Option
    ```shell script
    -S, --stdin
                     Write the prompt to the standard error and read the password from the standard input instead of using the terminal device.
    ```  

    > Note that password is expose in history   