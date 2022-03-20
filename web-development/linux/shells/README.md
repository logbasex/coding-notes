## What is "the Shell" ?

Simply put, the shell is a program that takes commands from the keyboard and gives them to the operating system to perform. In the old days, it was the only user interface available on a Unix-like system such as Linux. Nowadays, we have graphical user interfaces (GUIs) in addition to command line interfaces (CLIs) such as the shell.

On most Linux systems a program called **bash** (which stands for Bourne Again SHell, an enhanced version of the original Unix shell program, **sh**, written by Steve Bourne) acts as the shell program. Besides **bash**, there are other shell programs available for Linux systems. These include: **ksh**, **tcsh** and **zsh**.o

Related: https://unix.stackexchange.com/a/11465/363633

## Type of shells ?

* **login** shell: A login shell logs you into the system as a specific user, necessary for this is a username and password. When you hit <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>F1</kbd> to login into a virtual terminal you get after successful login: a login shell (that is interactive). Sourced files:
* `/etc/profile` and `~/.profile` for Bourne compatible shells (and `/etc/profile.d/*`)
* `~/.bash_profile` for bash
* `/etc/zprofile` and `~/.zprofile` for zsh
* `/etc/csh.login` and `~/.login` for csh

* **non-login** shell: A shell that is executed without logging in, necessary for this is a current logged in user. When you open a graphic terminal in gnome it is a non-login (interactive) shell. Sourced files:
* `/etc/bashrc` and `~/.bashrc` for bash

* **interactive** shell: A shell (login or non-login) where you can interactively type or interrupt commands. For example a gnome terminal (non-login) or a virtual terminal (login). In an interactive shell the prompt variable must be set (`$PS1`). Sourced files:
* `/etc/profile` and `~/.profile`
* `/etc/bashrc` or `/etc/bash.bashrc` for bash

* **non-interactive** shell: A (sub)shell that is probably run from an automated process you will see neither input nor output when the calling process don't handle it. That shell is normally a non-login shell, because the calling user has logged in already. A shell running a script is always a non-interactive shell, but the script can emulate an interactive shell by prompting the user to input values. Sourced files:
* `/etc/bashrc` or `/etc/bash.bashrc` for bash (but, mostly you see this at the beginning of the script: `[ -z "$PS1" ] && return`. That means don't do anything if it's a non-interactive shell).
* depending on shell; some of them read the file in the `$ENV` variable.

- interactive login shell (`CTRL + ALT + F1`)
- interactive non-login shell (Open new terminal)
- non-interactive non-login shell (run a script)
- non-interactive login shell (`echo ls | ssh root@192.168.5.21`)
- [More](https://askubuntu.com/questions/879364/differentiate-interactive-login-and-non-interactive-non-login-shell)

- An interactive shell is a shell with which you can interact, that means you can type commands in it. Most shells you will use are interactive shells.
- A non-interactive shell is a shell with which you cannot interact. Shell scripts run inside non-interactive shells.
- A login shell is the shell which is started when you login to your system.
- A non-login shell is a shell which is started after the login process.

## What's a "Terminal" ?

It's a program called a **terminal emulator**. This is a program that opens a window and lets you interact with the shell. There are a bunch of different terminal emulators we can use. Some Linux distributions install several. These might include **gnome-terminal**, **konsole**, **xterm**, **rxvt**, **kvt**, **nxterm**, and **eterm**.

##https://askubuntu.com/a/506880/978081

terminal = text input/output environment

console = physical terminal (something you can actually physically touch)

shell = command line interpreter

## [Difference tty and GNOME terminal](https://askubuntu.com/questions/466688/whats-the-difference-between-the-tty-and-the-gnome-terminal)

tty: virtual terminal, interactive, login shell
gnome-terminal: terminal emulator, interactive, non-login shell

## .bashrc and .bash_profile
https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_01.html 

.bash_profile is executed for login shells, while .bashrc is executed for interactive non-login shells.

When you login (type username and password) via console, either sitting at the machine, or remotely via ssh: .bash_profile is executed to configure your shell before the initial command prompt.

But, if you’ve already logged into your machine and open a new terminal window (xterm) then .bashrc is executed before the window command prompt. .bashrc is also run when you start a new bash instance by typing /bin/bash in a terminal.

On OS X, Terminal by default runs a login shell every time, so this is a little different to most other systems, but you can configure that in the preferences.


## reset shell environment

```shell
exec <SHELL>

source ~/.<SHELL>rc
```
https://unix.stackexchange.com/questions/14885/how-to-reset-a-shell-environment


## .bashrc .bash_profile

- Ubuntu uses ~/.profile .

- You can check if your Bash shell is started as a login-shell by running:
```shell script
shopt login_shell
```  

```shell script
export me="logbasex" >> .bash_profile

ctrl + alt + f1

ctrl + alt + T

bash -l            #make bash behave as if it is a login shell even if started after your have logged in

echo $me
```
- Note that with gnome-terminal -> go to preferences -> default profile -> command -> run command as login shell (with `tty` we don't need to do that)

- `.bash_profile` is executed for login shells, while `.bashrc `is executed for interactive non-login shells.
  
- Create a ~/.bash_profile file. If bash is started as a login shell it will first look for ~/.bash_profile before looking for ~/.profile. If bash finds ~/.bash_profile then it will not read ~/.profile.  

- [More](https://askubuntu.com/a/132319/978081)

- [.bash_logout](https://unix.stackexchange.com/questions/371161/bash-logout-is-not-running-on-exit-of-putty)

- From `man bash`
    - When bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option, it first reads and executes commands from the file /etc/profile, if that file exists. After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and executes commands from the first one that exists and is readable. The --noprofile option may be used when the shell is started to inhibit this behavior.
    
    - When an interactive shell that is not a login shell is started, bash reads and executes commands from ~/.bashrc, if that file exists. This may be inhibited by using the --norc option. The --rcfile file option will force bash to read and execute commands from file instead of ~/.bashrc.
    
- `/etc/profile` and `/etc/bash.bashrc`
- `/etc/bashrc` for `Redhat`

- [When you login, bash runs ~/.bash_profile and ~/.bash_profile runs ~/.bashrc. Indeed ~/.bashrc isn't bash initialization file, because bash doesn't run it.](https://unix.stackexchange.com/a/45805/363633)
  
- [Difference between .profile and .bash_profile](https://unix.stackexchange.com/questions/45684/what-is-the-difference-between-profile-and-bash-profile)  

- [When is /etc/bash.bashrc invoked?](https://unix.stackexchange.com/questions/187369/when-is-etc-bash-bashrc-invoked)

    ```shell script
    vi /etc/profile
  
    if [ -f /etc/bash.bashrc ]; then
        . /etc/bash.bashrc
    fi

    ```
  
 ![https://unix.stackexchange.com/a/45734/363633](https://what.thedailywtf.com/uploads/files/1462690324423-upload-f8cce917-e33c-4671-ac56-f1b0da9f687f.png) 