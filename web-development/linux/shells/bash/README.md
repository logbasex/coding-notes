## One-liners

- Open edtior in terminal with current command

    ```Ctrl + x + e```
- Browse through list of argumnet in previous command

    ```alt + .```


## Debug bash script
  ```
  #!/bin/bash -x
  ```

## [How to call bash functions](https://superuser.com/questions/106272/how-to-call-bash-functions)

Supposed I have file called `say.sh`

  ```shell

  #!/bin/bash

  function talk()
  {
          echo "hi!"
  }
  ```

now I want to call its `talk()` function from the command line:

```shell
source say.sh; talk
```

## Special character

- **$0**
  - $0 is the name of the shell or shell script
  - If the output of echo $0 command is **-bash** it means that bash was invoked as a **login shell**.
  

## binding

- [Terminals send characters to applications, not keys](https://unix.stackexchange.com/questions/89802/terminator-ctrl-tab-key-binding?noredirect=1&lq=1). Keys are encoded as characters or character sequences; most function keys send a sequence beginning with the escape character (character 27 = 033 = 0x1b = ^[ = \e).
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
  
- [Find key sequence](https://www.zdnet.com/article/find-and-bind-key-sequences-in-bash/)
  ```shell
  - gõ read command
  - nhập key
  ```

- Keymap
  - https://www.linuxjournal.com/files/linuxjournal.com/linuxjournal/articles/001/0138/0138l1.html

- bind setting
  - https://brettterpstra.com/2015/07/09/shell-tricks-inputrc-binding-fun/
  - https://linux.101hacks.com/unix/bind/
  - https://www.reddit.com/r/commandline/comments/kbeoe/you_can_make_readline_and_bash_much_more_user/
  - https://bluz71.github.io/2018/03/15/bash-shell-tweaks-tips.html
    
## Tips
- https://cfenollosa.com/misc/bash.pdf
  ```shell
  sudo systemctl status sshd.service
  susdo systemctl restart sshd.service
  alias stre='^status^restart'

  ls + alt + shift + *

  alt + space -> set mark
  ctrl + x + ctrl + x -> navigate to mark
  ```

## Color vs escape code
- [Bash Color](https://gist.github.com/vratiu/9780109)
  ```shell
  echo -e '\033[1;42m'This is text with green background
  ```
  ![](https://www.nayab.xyz/assets/img/terminal-text-decoration.png)

- [Escape code](https://www.nayab.xyz/linux/escapecodes.html)

## Scripts
- Last time apt-get update
  ```shell
  #!/bin/bash -x

  function info()
  {
  local -r message="${1}"

      echo -e "\033[1;36m${message}\033[0m" 2>&1
  }

  function getLastAptGetUpdate()
  {
  local aptDate="$(stat -c %Y '/var/lib/apt/periodic/update-success-stamp')"
  local nowDate="$(date +'%s')"

      echo $((nowDate - aptDate))
  }

  function runAptGetUpdate()
  {
  local lastAptGetUpdate="$(getLastAptGetUpdate)"

      # Default To 24 hours
      updateInterval="$((24 * 60 * 60))"

      if [[ "${lastAptGetUpdate}" -gt "${updateInterval}" ]]
      then
          info "apt-get update"
          apt-get update -m
      else
          local lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"

          info "\nSkip apt-get update because its last run was '${lastUpdate}' ago"
      fi
  }
  ```