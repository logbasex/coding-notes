## Install

- **zsh (Z shell)**
```shell script
sudo apt install -y zsh
zsh --version
```

- **zsh** framework
    - **oh-my-zsh**
    
        ```shell script
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        ```
       - zsh-autosuggestions
       
          ```shell script
         git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
          ```
       - zsh-syntax-highlighting
          
          ```shell script
         git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
          ```
         
    - **prezto**
        - https://medium.com/@timonbimon/yet-another-step-by-step-guide-for-a-better-terminal-setup-6c5e879d4c8c
        - https://wikimatze.de/better-zsh-with-prezto/
            ```shell script
            cd ~/.zprezto
            git clone https://github.com/belak/prezto-contrib contrib
            cd contrib
            git submodule init
            git submodule update
            ```
        - [Custom prompt](https://github.com/decayofmind/dotfiles/blob/master/.zshrc)  
        - [Module not found error](https://github.com/sorin-ionescu/prezto/issues/1674)
            - Please remove trailing spaces in the end of module name.   

## Config

- Set `nvim` as default editor
    ```shell script
    vi .zshrc
    
    # Add the following line  
    export EDITOR=nvim
    export VISUAL=nvim
    ```
  
## Environment variables
-  [$VISUAL vs $ EDITOR](https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference)

    ```shell script
    /editors/vim/README.md
    ```


## Get summarized options of command

```shell
ls - <TAB>
curl - <TAB>
```

## zsh plugin manager
- [zinit](https://github.com/zdharma/zinit#option-1---automatic-installation-recommended)
    ```shell script
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    ```

## fzf

- [Search include hidden file](https://github.com/junegunn/fzf/issues/337)
  ```shell
  find . | fzf
  ```
- Search maching name
  ```shell
  find . | fzf -E
  ```
- [~/.fzf.zsh not found](https://github.com/junegunn/fzf/issues/1385)  
    - Enable shortcut `CTRL + T`, `CTRL + R`, `ALT + C`
    
    ```shell script
    Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    
    Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:
    source /usr/share/doc/fzf/examples/completion.zsh
    ```
    - Custom shortcut
    ```shell script
    https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
    ```  
- [Key binding](https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings)

## Utilities

- Open editor
    ```shell script
    Ctrl + X; Ctrl + e
    ```
  
## Binding
- Custom binding
```shell
vi ~/.zshrc

# F12
bindkey -s '^[[24~' 'You`ve just pressed F12'
```

## DIY Oh-my-zsh
- https://medium.com/@dpeachesdev/intro-to-zsh-without-oh-my-zsh-part-1-c039de5ee22e
- https://ianyepan.github.io/posts/moving-away-from-ohmyzsh/
