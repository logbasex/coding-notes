## Run Graphical X Applications Over SSH
````shell script
Tutorial
https://www.youtube.com/watch?v=hdXDMIvQuTs

X11
https://www.youtube.com/watch?v=mV1TNyWGQQ8

X11 from 9.00
https://www.youtube.com/watch?v=07Q9oqNLXB4

https://ubunsys.com/display-server-va-window-server-la-gi/
````

- In /ssh/ssh_config 
    change ForwardX11 no -> FowardX11 yes
- Install xorg
    ```shell script
    sudo apt install xorg
    ```
- ssh -Y username@host
- firefox
    
      
