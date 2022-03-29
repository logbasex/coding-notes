## Concept
![](https://danielmiessler.com/images/tmuxnesting.png)

https://danielmiessler.com/study/tmux/

## Install

- Install
  ```shell
  sudo apt update
  sudo apt install tmux
  ```

- Check version
  ```shell
  tmux -V
  ```

## Config
- Default config file, create if not exits
    ```shell
    ~/.tmux.conf
    ```
- Some custom shortcut
  ```shell
  bind-key -n C-n new-window
  bind-key -n C-w kill-window
  bind-key -n C-Tab next-window
  bind-key -n C-h split-window -h
  ```
  
- [Apply config](https://stackoverflow.com/questions/17041647/unable-to-source-tmux-conf/17041896)
  ```shell
  tmux source-file ~/.tmux.conf
  ```

## Shortcut

- Ctrl + b + [ -> using arrow key to scroll.
