## Friendly Interactive Shell
- [Autocomplete](https://dev.to/tbodt/comment/1gd)
- [Fish Shell - Is it time to replace Bash and Zsh ?](https://dev.to/0x96f/fish-shell-is-it-time-to-replace-bash-and-zsh-2bbc)
- [Fish vs. Zsh vs. Bash and Why You Should Switch to Fish](https://betterprogramming.pub/fish-vs-zsh-vs-bash-reasons-why-you-need-to-switch-to-fish-4e63a66687eb)

## Plugin manager
- [Fisher](https://github.com/jorgebucaran/fisher)

## Alias
- https://gist.github.com/tikolakin/d59b4fc87c0af9720d0d
- ```
  alias ssh='kitty +kitten ssh'
  funcsave ssh
  
  alias eto='eko test oauth'
  funcsave eto
  
  alias etm='eko test mail'
  funcsave etm
  
  alias ets='eko test search'
  funcsave ets
  
  alias etp='eko test portal'
  funcsave etp
  
  alias et='xpanes -t -c "ssh fruitful@192.168.5.21 tail -fn500 eko/app/test/logs/eko-{}-test.log" portal mail oauth search'
  funcsave et
  ```
  
## Function
- https://dev.to/jethrolising/fish-shell-functions-2e7i

## [Plugins](https://github.com/jorgebucaran/awsm.fish)

- z
  ```
  # fisher update
  fisher install jethrokuan/z
  ```
- [fzf](https://github.com/PatrickF1/fzf.fish)
  > CTRL-R: search on recent history based on $HISTFILE, then return selected entry to the terminal
  > 
  > CTRL-T: recursively search for a filename under $PWD, then return selected entries to the terminal
  > 
  > ALT-C: recursively search for a directory name under $PWD, then cd into the selected entry

  ```
  fisher install PatrickF1/fzf.fish
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  sudo apt install fd-find
  ln -s $(which fdfind) ~/.local/bin/fd
  
  sudo apt install bat
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
  ```
  
- [Starship](https://starship.rs/)
  ```shell
  curl -sS https://starship.rs/install.sh | sh
  echo "starship init fish | source" >> ~/.config/fish/config.fish
  
  ## Config
  https://starship.rs/presets/plain-text.html
  ```
  
## [Tools]
- [Modern Unix](https://github.com/ibraheemdev/modern-unix)
- [Awesome alternatives in rust](https://github.com/TaKO8Ki/awesome-alternatives-in-rust)
- [exa](https://github.com/ogham/exa)
  ```shell
  # Install rust: https://www.rust-lang.org/tools/install
  # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  # sudo apt install cargo
  # sudo cargo install exa
  
  1. Download exa-linux-x86_64-v0.10.1.zip: 
  https://github.com/ogham/exa/releases/tag/v0.10.1
  2. Extract here
  3. sudo cp exa-linux../bin/exa /usr/bin/
  ```
- [peco](https://github.com/peco/peco)
  ```shell
  sudo apt install peco
  ```
- [tldr](https://github.com/tldr-pages/tldr)
  ```shell
  pip3 install tldr
  ```