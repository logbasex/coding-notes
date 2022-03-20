##  Common directory

<pre>
/usr/sbin/login             # /sbin/nologin or /usr/sbin/nologin used as a shell in Linux to politely refuse a login attempt. It is a per-account way to disable login on Linux. Many system user using this shell (cat /etc/passwd | grep nologin)

/bin/true                   # Binary file exit with a status code indicating success. (which true)
/bin/false                  # Binary file exit with a status code indicating failure. (which false)

Related:
    - In the modern shell, true and false were shipped with coreutils package, type `man true` for more  (https://wiki.debian.org/coreutils)
    - https://unix.stackexchange.com/questions/419697/why-are-true-and-false-so-large

/var/lib/apt/lists/         # When you run sudo apt-get update (or use the Refresh button in a package manager), a list of packages will get downloaded from the Ubuntu servers. These files are then stored in here.

/var/cache/apt/archives/    # where .deb package stored.
</pre>

- sbin
    - System binary
- bin
    - binary
    
- Binary folder        
    - https://www.interserver.net/tips/kb/linux-binary-directories-explained/
    
## Layout

![](http://www.porcupine.org/forensics/forensic-discovery/figure3.3.gif)    

http://www.porcupine.org/forensics/forensic-discovery/chapter3.html#figure3.2

- Directory
![](https://pbs.twimg.com/media/EV47AIyXsAEDvp4?format=jpg&name=small)

https://twitter.com/climagic/status/1251504373286436864