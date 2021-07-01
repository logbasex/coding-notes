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
  

## binding

- Custom binding
  ```shell
  vi ~/.inputrc
  # alt + z
  # 015 is octal value of carriage return
  "\ez": 'cd -\015'
  # alt + p
  "\ep": 'pwd\015'
  ```
- Reload `.inputrc`  
  ```shell
  By default, C-x C-r is bound to re-read-init-file.
  bind -f  ~/.inputrc
  ```

- https://brettterpstra.com/2015/07/09/shell-tricks-inputrc-binding-fun/
## Tips

```shell
sudo systemctl status sshd.service
susdo systemctl restart sshd.service
alias stre='^status^restart'
```