# Source

- Command line

```shell script
https://github.com/jlevy/the-art-of-command-line
https://gnu.moe/list/
https://dev.to/_darrenburns/10-tools-to-power-up-your-command-line-4id4
https://github.com/alebcay/awesome-shell
https://ketancmaheshwari.github.io/pdfs/LPT_LISA.pdf
```

# Pre-install

- [Disable Secure Boot](https://askubuntu.com/a/843678/978081)


# nvidia problems
[install, remove]
```
https://linoxide.com/how-to-install-nvidia-driver-on-ubuntu/
https://linuxize.com/post/how-to-nvidia-drivers-on-ubuntu-20-04/
```

https://askubuntu.com/questions/1148785/gnome-suddenly-switching-from-hardware-gpu-to-llvmpipe

https://askubuntu.com/questions/762764/cannot-change-brightness-ubuntu-16-04-lts-and-onward

```shell script
sudo apt install inxi  #https://askubuntu.com/questions/1072427/what-can-inxi-be-used-for

# check graphic card you have
lspci -vnnn | perl -lne 'print if /^\d+\:.+(\[\S+\:\S+\])/' | grep VGA
lspci -k | grep -A 2 -E "(VGA|3D)"
lspci -k | grep VGA

glxinfo|egrep "OpenGL vendor|OpenGL renderer"
```

## Hardware
- Check RAM info
    ```shell script
    sudo dmidecode --type memory
  
    Memory Device
    	Array Handle: 0x0002
    	Error Information Handle: Not Provided
    	Total Width: 64 bits
    	Data Width: 64 bits
    	Size: 16384 MB
    	Form Factor: SODIMM
    	Set: None
    	Locator: ChannelA-DIMM0
    	Bank Locator: BANK 0
    	Type: DDR4
    	Type Detail: Synchronous
    	Speed: 2667 MT/s
    	Manufacturer: SK Hynix
    	Serial Number: 33C80836
    	Asset Tag: None
    	Part Number: HMA82GS6CJR8N-VK    
    	Rank: 2
    	Configured Memory Speed: 2667 MT/s
    	Minimum Voltage: Unknown
    	Maximum Voltage: Unknown
    	Configured Voltage: 1.2 V
    ```
    - System RAM speed is controlled by bus width and bus speed. Bus width refers to the number of bits that can be sent to the CPU simultaneously, and bus speed refers to the number of times a group of bits can be sent each second. A bus cycle occurs every time data travels from memory to the CPU. For example, a 100-MHz 32-bit bus is theoretically capable of sending 4 bytes (32 bits divided by 8 = 4 bytes) of data to the CPU 100 million times per second, while a 66-MHz 16-bit bus can send 2 bytes of data 66 million times per second. If you do the math, you'll find that simply changing the bus width from 16 bits to 32 bits and the speed from 66 MHz to 100 MHz in our example allows for three times as much data (400 million bytes versus 132 million bytes) to pass through to the CPU every second.
    - https://computer.howstuffworks.com/computer-memory3.htm 
# Install

### Install from releases page
- Check architecture first.
```shell script
dpkg --print-architecture
```
- Download zip or (something else) file
- Extract zip file
- Copy extracted file (usually is executable binary file) to the directory which is reside in `$PATH` env variable.

-----
### Packages

- update
```shell script
sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y
```

- snap
    - avoid using snap whenever possible(it's like [flatpak](https://itsfoss.com/flatpak-guide/), it has more cons than pros)
```shell script
sudo apt install snapd
```

- pip3
```shell script
sudo apt -y install python3-pip

pip3 install <package>
pip3 uninstall <package>
```

- slack
```shell script
sudo snap install slack --classic
```

- skype
```shell script
sudo snap install skype --classic

#https://askubuntu.com/questions/517780/how-do-i-stop-skype-from-auto-launching
sudo find ./ -regextype posix-egrep -regex "./snap/skype/[0-9]+/.config/autostart/skypeforlinux.desktop" -delete
```

- libre
```shell script
sudo apt install libreoffice
```

- csvkit
```shell script
sudo apt install csvkit
```

- Java
```shell script
sudo apt install openjdk-8-jdk openjdk-8-jdk-headless
```

- [SDKMAN and Springboot](https://docs.spring.io/spring-boot/docs/current/reference/html/getting-started.html)
```shell script
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install springboot
```

- Golang
```shell script
sudo snap install go --classic
```

- Rust
```shell script
sudo snap install rustup --classic
```

- jq
```shell script
sudo apt install jq
```

- python3
```shell script
sudo apt install python3-pip -y
```

- nvm
```shell script
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

nvm ls-remote
nvm install <SPECIFIC_NODE_VERSION>
nvm use <SPECIFIC_NODE_VERSION>
```

- yarn
```shell script
sudo curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

OR

sudo apt install --no-install-recommends yarn
```

- Sublime Text
```shell script
sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo apt install sublime-text
```

- Google Chrome
```shell script
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

- Brave
```shell script
sudo snap install brave
```

- qutebrowser
```
sudo apt install qutebrowser
```

- Tor
```shell script
sudo add-apt-repository ppa:micahflee/ppa
sudo apt update
sudo apt install torbrowser-launcher
```

- Docker

```shell script

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce && sudo chmod 666 /var/run/docker.sock
```

- Docker-compose
```shell script
pip3 install docker-compose

OR

sudo wget --output-document=/usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$(wget --quiet --output-document=- https://api.github.com/repos/docker/compose/releases/latest | grep --perl-regexp --only-matching '"tag_name": "\K.*?(?=")')/run.sh"
sudo chmod +x /usr/local/bin/docker-compose
```

- Mysql 

```shell script
mkdir -p $HOME/docker/mysql56

cd $HOME/docker/mysql56

docker pull mysql:5.6

docker run -p 3307:3306 --name mysql56 \
-v $PWD/conf:/etc/mysql \
-v $PWD/logs:/var/log/mysql \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql:5.6 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci

docker exec -ti mysql56 /bin/bash
mysql -u root -p123456
create database prism_dev;
docker exec -i mysql56 bash -c 'exec mysql -uroot -p"123456"' < /some/path/on/your/host/all-databases.sql
```

- MongoDB
```shell script
sudo docker run -d --name=mongo44 -p=27017:27017 mongo:latest
```

- Jenkins
```shell script
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
#Note that after add repo to source list, pls update available packages
sudo apt update
sudo apt install jenkins -y

OR

docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v dbdata:/var/jenkins_home jenkins/jenkins:lts
```


- Rabbit MQ
```shell script
echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
sudo apt install erlang
wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add -
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -

# Ubuntu 20.04 ---
echo "deb https://dl.bintray.com/rabbitmq-erlang/debian focal erlang-22.x" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
sudo apt install rabbitmq-server -y
sudo systemctl enable rabbitmq-server

#Plugins
sudo rabbitmq-plugins list
sudo rabbitmq-plugins enable rabbitmq_management

# localhost:15672, guest/guest
```

- Elasticsearch

```shell script
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt install elasticsearch
```

#### Handy Tools
- synaptic package manager
```shell script
sudo apt update
sudo apt install synaptic
```

- [yq, xq](https://github.com/kislyuk/yq)
```
pip3 install yq
```

- selenium
    - [Install script](https://gist.github.com/ziadoz/3e8ab7e944d02fe872c3454d17af31a5)
```shell script
# Versions
CHROME_DRIVER_VERSION=`curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE`
SELENIUM_STANDALONE_JAR=`curl https://selenium-release.storage.googleapis.com | xq | jq 'last(.ListBucketResult|.Contents|.[]|.Key| select(test(".*selenium-server-standalone.*.jar")))`

# Remove existing downloads and binaries so we can start from scratch.
# sudo apt-get remove google-chrome-stable
# rm ~/selenium-server-standalone-*.jar
# rm ~/chromedriver_linux64.zip
# sudo rm /usr/local/bin/chromedriver
# sudo rm /usr/local/bin/selenium-server-standalone.jar

# Install dependencies.
sudo apt-get update
sudo apt-get install -y unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4

# Install ChromeDriver.
wget -N https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

# Install Selenium.
wget -N https://selenium-release.storage.googleapis.com/$SELENIUM_STANDALONE_JAR -P ~/
sudo mv -f ~/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar /usr/local/bin/selenium-server-standalone.jar
sudo chown root:root /usr/local/bin/selenium-server-standalone.jar
sudo chmod 0755 /usr/local/bin/selenium-server-standalone.jar
```

- httpie
```
sudo apt install httpie
```

- lazygit
```
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
```

- [exa](modern replacement for ls)
```shell script
sudo apt install exa

exa -l
exa -bghHliS
```

- #### Media

    - [terminalizer](https://github.com/faressoft/terminalizer): record terminal gif
    ```shell script
    # using node v10.23.0
    # https://github.com/faressoft/terminalizer/issues/139
    
    sudo npm install --global --allow-root --unsafe-perm=true terminalizer
    ```
    
    - [peek](https://github.com/phw/peek#ubuntu): record as gif
    ```shell script
    sudo add-apt-repository ppa:peek-developers/stable
    sudo apt update
    sudo apt install peek
    ```
    
    - byzanz
    ```shell script
    sudo apt install byzanz
    byzanz-record --duration=10 --delay=2 --x=0 --y=0 --width=1920 --height=1080 ~/Desktop/out.gif
    ```
    
    - kazam
    ```shell script
    sudo apt install kazam
    ```
    
    - vlc
    ```shell script
    sudo apt install vlc
    ```
    - [mplayer](https://linuxhint.com/play_media_linux_terminal/)
    ```shell script
    sudo apt install mplayer
    ```
    
    - ffmpeg
    ```shell script
    sudo apt install ffmpeg
    ```
  
    - gimp (edit/crop image)
    ```shell script
    sudo apt install aptitude
    sudo aptitude install gimp
  
    # tutorial
    # https://www.youtube.com/watch?v=hfhJcIGH4o0
    ```

- [cargo](https://github.com/max-niederman/ttyper)
```shell script
cargo install ttyper
PATH=$PATH:~/.cargo/bin
```

- wpm
```shell script
pip3 install wpm
```

- neofetch
```shell script
sudo apt install -y neofetch
```

- [ranger](https://github.com/ranger/ranger)

```shell script
# https://codeyarns.com/tech/2013-08-26-how-to-install-and-use-ranger.html
# https://www.chrisatmachine.com/Neovim/07-ranger/

sudo -H pip3 install ranger-fm
#sudo apt install w3m-img
pip3 install ueberzug
sudo apt install kitty       # Use with kitty terminal emulator
```

- openssh-server
```shell script
sudo apt install -y openssh-server
```

- xclip
```shell script
sudo apt install xclip
```

- htop
```shell script
sudo apt install htop
```

- tree
```shell script
sudo apt install tree
```

- rename
```shell script
sudo apt install rename
```

- mlocate
```shell script
sudo apt install mlocate
```

- finger (display user info)
```shell script
sudo apt install finger
```

- [whois](https://www.howtogeek.com/680086/how-to-use-the-whois-command-on-linux/)
```shell script
sudo apt install whois  #gets whois information for domain
```

- [bpytop](https://github.com/aristocratos/bpytop)
```shell script
sudo apt install bpytop
pip3 install bpytop --upgrade
```

- [ngrok](https://ngrok.com/product)
```shell script
sudo snap install ngrok
```

- [duf](https://github.com/muesli/duf)
```shell script
# dpkg --print-architecture 
curl --silent curl --silent "https://api.github.com/repos/muesli/duf/releases/latest" | jq -r ".assets[] | select(.name | test(\"linux_$(dpkg --print-architecture).deb\")) | .browser_download_url" | wget -O duf-latest.deb -i - && sudo dpkg -i duf-latest.deb
```
- [riprep](https://github.com/BurntSushi/ripgrep#installation)
```shell script
sudo apt install ripgrep
echo $(rg --version)
```

- [copyq](https://linuxhint.com/install-copyq-ubuntu/)

```shell script
sudo add-apt-repository -y ppa:hluk/copyq
sudo apt install -y copyq 
```

- ibus(unikey)
```shell script
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo -y
sudo apt update
sudo apt-get install ibus-bamboo
ibus restart
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'BambooUs')]"

# gsettings get org.gnome.desktop.input-sources sources (check input source)
```

- neovim
```shell script
sudo apt install neovim

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- glow
```shell script
sudo snap install glow
```

- bat
```shell script
curl https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r ".assets[] | select (.name | test(\"^.*$(dpkg --print-architectures).deb$\")) | .browser_download_url" | wget -O bat-latest.deb -i - && sudo dpkg -i bat-latest.deb
```

- [cheat](https://github.com/chubin/cheat.sh)
```shell script
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
chmod +x /usr/local/bin/cht.sh
```

- lastpass cli
```shell script
sudo apt install lastpass-cli
```

- virtualbox
```shell script
sudo apt install virtual box
```

- [Jekyll Blog](https://github.com/academicpages/academicpages.github.io)
```shell script
sudo apt install ruby-dev ruby-bundler nodejs
echo 'passwd' | bundle install
bundle exec jekyll liveserve 
```

#### Memes
-Doge
```shell script
pip3 install doge
```

## User

- username
    ```shell script
     whoami
    ```
-hostname (computer's name)
    ```shell script
      hostname
    ```

## [Get command description and location](tecmint.com/find-linux-command-description-and-location/)
```shell script
type -a <COMMAND>
command -v <COMMAND>
which <COMMAND>
whereis <COMMAND>
```

## Man/Manual pages
- What is it?
  ```shell
  man -f printf
      man (1)              - an interface to the system reference manuals
      man (7)              - macros to format man pages
  ```
- Search key word
  ```shell
   man -k printf

      asprintf (3) - print to allocated string
      dprintf (3) - formatted output conversion
      dprintf (3p) - print formatted output
      fprintf (3) - formatted output conversion
  ```
-  Find the Filesystem Location of a Command’s Manual Page  
  ```shell
    man -w ping

        /usr/share/man/man8/ping.8.gz (zcat to view, zless, zmore, zgrep...)
  ```
- [Reference](https://www.baeldung.com/linux/man-command)
## List of commands in Linux

  <pre>
  compgen          # compgen is bash built-in command and it will show all available commands, aliases, and functions for you
      compgen -c      # List all available command in Linux
      compgen -b      # List all builtin command in Linux (https://www.cyberciti.biz/faq/linux-unix-bash-shell-list-all-builtin-commands/)

  alias            # prints the list of aliases in the reusable form 'alias NAME=VALUE' on standard output.
  </pre>

- maybe you're missing package's name 
    - `apropos` command (search through man page)

## Build in commands

-  Overview
    ```shell
     man bash
    ```

- Get help of specific command
    ```shell
    [command] --help (Eg: set --help or help set)
    ```

- Notes
  > [double dash](https://unix.stackexchange.com/questions/11376/what-does-double-dash-mean) (--) signify the end of the options.

## APT command
- Ubuntu 16.04 introduced apt commands, simply put, apt is a collection of most common used command options from `apt-get` and `apt-cache`.

- Check version of package
  - Using package's option
    ```shell
    [package] -v
    
    [package] --version
    ```
  - Using package manager
    - `apt` is a "front-end" for `apt-get`
    ```shell
    apt policy [command] 2>&1 | grep -i installed
    apt-cache policy [command] | grep -i installed
    script -c "apt policy elasticsearch" /dev/null | grep -i installed
    ```
  - Check mysql version
  ```shell script
    mysqld --version
  ```  
## Kill process
- pgrep (find or signal process by name)
  ```shell
  pgrep mongo
  
  pgrep -u <user> mongo            # Search for process run by a specific user

  ```
- kill port using `npx` (tool for execute `Node` package) and npm package `kill-port` 
  ```shell
   npx kill-port 27017
  ```
  
- netstat (network statistic tool)
  ```shell
  sudo kill -9 $(sudo netstat --listening --program --numeric --tcp \
  | grep "27017" \
  | awk '{print $7}' \
  | awk -F/ '{print $1}')  

  sudo netstat -lpnt      -   list network statistic include port number of all TCP connections.
  grep "27017"            -   filter process using port 27017
  awk '{print $7}'       -  get process id and name
  awk -F/ '{print $1}'   -   get process id
  ```
- lsof (list open files)
  ```shell
  sudo kill -9 $(sudo lsof -t -i:27017)
  
  -t       - show only process ID
  -i       - show only internet connections related process
  :27017   - show only processes in this port number
  ```


## ls (List directory content)
- List with line number
  ```shell
  ls | nl 
  ls | cat -n 
  ```


## rm (Remove files or directories)
- Remove all subdirectories
  ```shell
  rm -R -- */
  ```
  
## mv (move command)
  
- Move ignore exits
  ```shell script
  mv -n from to
  ``` 
  
## grep

-https://thenewstack.io/tutorial-hunting-the-secrets-of-unix-grep/  
-https://thenewstack.io/brian-kernighan-remembers-the-origins-of-grep/
  
## Working with text
- [awk command](https://viblo.asia/p/tim-hieu-awk-co-ban-gGJ59229KX2)
  - https://java2blog.com/awk-print-1/
  
- cat command (concatenate files and print on the standard output)
  
- sed command (**S**tream **Ed**itor)
## Build bootable usb


- Firstly, determine the device name of your plugged USB and then [unmount the device](https://askubuntu.com/questions/590849/why-do-we-have-to-unmount-a-usb-and-format-it-to-fat-or-ntfs-partition-before-ma).
```shell
sudo umount /dev/sdb1
dd if=/home/logbasex/Downloads/ubuntu-20.04.2.0-desktop-amd64.iso of=/dev/sdb1 status=progress
```


## Process Management
- https://www.bogotobogo.com/Linux/linux_process_and_signals.php
- https://www.tecmint.com/linux-process-management/  
- Each process is allocated a unique number, process identifier (PID). It's an integer between 2 and `cat /proc/sys/kernel/pid_max` (2<sup>22</sup>). When a process is started, the numbers restart from 2, and the number 1 is typically reserved for the init process (`ps -ef | grep init`)
  
- Find the ID of a process
  ```shell
  pidof systemd
  pidof htop
  ```
  
- Find the process ID and parent process ID of the current shell
  ```shell
  echo $$
  echo $PPID
  ```
  
- [Get process Id of just started process](How to get pid of just started process)
  ```shell script
    myCommand & echo $!             # & send process to background
  ```  
- `w`: show who is logged on and what they are doing
- `who`: show who is logged on
- `tty`: show current users pseudo terminal
## Disk management
- https://www.tecmint.com/duf-linux-disk-monitoring-utility/


## curl
- Download url(s) automatically
  ```shell
  curl https://www.python.org/static/apple-touch-icon-144x144-precomposed.png > image.png
  xargs -n 1 curl -O < files.txt
  ```
  
## Change hostname of bash prompt
- [Customize linux terminal](https://itsfosscom/customize-linux-terminal/)
- http://bashrcgenerator.com/  
  

- A `hostname` is a name assigned to a `host`  i.e. a computer on a network. The `hostname` is basically just your computer’s name. It’s used to identify your computer on the network.
- Ex: Your current hostname is
  ```shell
    logbasex@thinkpad-x1
  ```
- Your can change `thinkpad-x1` to another using the following command
  ```shell
    sudo hostnamectl set-hostname <CUSTOM-NAME>
  ```
  
## Network manager

- openvpn
  ```shell
  sudo openvpn --config client.ovpn
  ```
  
- https://www.cyberciti.biz/faq/linux-import-openvpn-ovpn-file-with-networkmanager-commandline/

- ip addr 


## Find command

 "This is a match on the whole path, not a search."

```shell script
# Error
sudo find ./ -regextype posix-egrep -regex "/[0-9]+/.config/autostart/skypeforlinux.desktop" -delete        

#Work
sudo find ./ -regextype posix-egrep -regex "./snap/skype/[0-9]+/.config/autostart/skypeforlinux.desktop" -delete
```

## [scp command](https://unix.stackexchange.com/questions/188285/how-to-copy-a-file-from-a-remote-server-to-a-local-machine)
If you are **`ON the LOCAL  from which you want to SEND FILE to a REMOTE COMPUTER`**. Here the remote can be a FQDN or an IP address.
                                                                                  
```shell script
scp /file/to/send remote_username@remote_host:/where/to/put
```

On the other hand if you are **`ON the LOCAL COMPUTER wanting to RECEIVE FILE from a REMOTE COMPUTER`**:

```shell script
scp username@remote:/file/to/send /where/to/put
```

Copy between two remote computers
```shell script
scp username@source:/location/to/file username@destination:/where/to/put
```

## ssh-keygen command
```shell script
ssh-keygen -t rsa -b 4096 -C "contact.hoducanh@gmail.com"
```

## getent command
```shell script
# Find which service is using specific port
getent services 22

# Get the info for current logged in user
getent passwd `whoami`
```

--------------------
Resources

1.http://linuxadministrative.blogspot.com/
