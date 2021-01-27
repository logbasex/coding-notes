## 

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