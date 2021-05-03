## FTP (File Transfer Protocol)
FTP is used to transfer files between computers on a network. You can use FTP to exchange files between computer accounts, transfer files between an account and a desktop computer, or access online software archives. Keep in mind, however, that many FTP sites are heavily used and require several attempts before connecting.

## SSH (Secure Shell)
- [How does the SSH protocol work](https://www.ssh.com/academy/ssh/protocol)

    ![](https://www.ssh.com/hubfs/Imported_Blog_Media/How_does_the_SSH_protocol_work_-2.png)
    The protocol works in the client-server model, which means that the connection is established by the SSH client connecting to the SSH server. The SSH client drives the connection setup process and uses public key cryptography to verify the identity of the SSH server. After the setup phase the SSH protocol uses strong symmetric encryption and hashing algorithms to ensure the privacy and integrity of the data that is exchanged between the client and server.
    

- Change default port ssh
    1. In the remote machine, edit **sshd_config** to change port
        ```shell script
        sed -i 's/#Port 22/Port 888' /etc/ssh/sshd_config
        ```
    2. Connect SSH to new port
        ```shell script
        ssh -p <port> <username>@<ip_address>
        ```
       