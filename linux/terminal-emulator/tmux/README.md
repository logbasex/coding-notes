## Install

```shell
sudo apt install tmux
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


