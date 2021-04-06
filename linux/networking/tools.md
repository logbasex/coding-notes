## nmcli

- List all available connection
    ```
    nmcli con show --active
    ```
- Turn off wifi
    ```
    nmcli con down <Access Point name>
    ```
- Turn on wifi
    ```
    nmcli con down PreviousAP
    ```
- Connect to new Access Point
    ```
    nmcli device wifi connect <AP name> password <password>
    ```

- Reference
    - https://askubuntu.com/questions/377687/how-do-i-connect-to-a-wifi-network-using-nmcli

## nmtui 
- https://askubuntu.com/questions/896140/how-to-connect-to-wifi-network-with-i3wm
