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



## What's a "Terminal" ?

It's a program called a **terminal emulator**. This is a program that opens a window and lets you interact with the shell. There are a bunch of different terminal emulators we can use. Some Linux distributions install several. These might include **gnome-terminal**, **konsole**, **xterm**, **rxvt**, **kvt**, **nxterm**, and **eterm**.

##https://askubuntu.com/a/506880/978081

terminal = text input/output environment

console = physical terminal (something you can actually physically touch)

shell = command line interpreter
