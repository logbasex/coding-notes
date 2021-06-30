## One-liners

- Open edtior in terminal with current command

    ```Ctrl + x + e```
- Browse through list of argumnet in previous command

    ```alt + .```


## Debug bash script
  ```
  #!/bin/bash -x
  ```

## Special character

- **$0**
  - $0 is the name of the shell or shell script
  - If the output of echo $0 command is **-bash** it means that bash was invoked as a **login shell**.
  

## Tips

```shell
sudo systemctl status sshd.service
susdo systemctl restart sshd.service
alias stre='^status^restart'
```