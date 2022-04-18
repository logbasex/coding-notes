## [rootfs - root file system](https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt)

> That rootfs entry is the real root filesystem. It has no device; it is a tmpfs that is automatically mounted by the kernel very early during initialization. Later during the boot process, your disk root filesystem is mounted over top of the rootfs, hiding it from view.

> The rootfs is the filesystem in which the actual / mountpoint is mounted as. Of course, this being Linux, almost any of the directories up to that point can themselves be their own filesystem, usually /boot and /home and sometimes but not always /usr.


Source: https://frameboxxindore.com/android/what-is-rootfs-in-linux.html

The rootfs is a file system. In linux, all file systems have a mount point, which is the directory where the mounted file system connects to the root file system. However, where does the root file system connect? It connects to / .

So, for example, on my machine, I have 34 file systems, of which there are 33 mount points in the root file system and one root file system, or rootfs

```shell
jeffs@jeffs-desktop:~$ sudo mount 
'[sudo] password for jeffs:  
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime) 
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime) 
udev on /dev type devtmpfs (rw,nosuid,relatime,size=8139420k,nr_inodes=2034855,mode=755) 
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000) 
tmpfs on /run type tmpfs (rw,nosuid,noexec,relatime,size=1632672k,mode=755) 
/dev/sda1 on / type ext3 (rw,relatime,errors=remount-ro,data=ordered)   <======== rootfs 
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime) 
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev) 
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k) 
tmpfs on /sys/fs/cgroup type tmpfs (rw,mode=755) 
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd) 
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime) 
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer) 
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices) 
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio) 
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event,release_agent=/run/cgmanager/agents/cgm-release-agent.perf_event) 
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct) 
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio) 
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids,release_agent=/run/cgmanager/agents/cgm-release-agent.pids) 
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory) 
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset,clone_children) 
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb,release_agent=/run/cgmanager/agents/cgm-release-agent.hugetlb) 
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=18619) 
mqueue on /dev/mqueue type mqueue (rw,relatime) 
debugfs on /sys/kernel/debug type debugfs (rw,relatime) 
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime) 
fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime) 
/dev/sdb1 on /home type ext4 (rw,relatime,data=ordered) 
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,relatime) 
lxcfs on /var/lib/lxcfs type fuse.lxcfs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other) 
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=1632668k,mode=700,uid=1000,gid=1000) 
gvfsd-fuse on /run/user/1000/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,relatime,user_id=1000,group_id=1000) 
/dev/sdc1 on /media/jeffs/Jeff_Silverman_b type ext4 (rw,nosuid,nodev,relatime,stripe=8191,data=ordered,uhelper=udisks2) 
jeffs@jeffs-desktop:~  
```

Now, I know that 34 file systems seems like a lot, but in fact, most of these file systems are actually pseudo file systems. Anything that begins with /dev is real. [The one file system noted on line 8 is actually the rootfs](https://www.quora.com/In-Linux-what-is-the-rootfs).

## [Pseudo file system](https://superuser.com/questions/1198292/what-is-a-pseudo-file-system-in-linux)

A pseudo file system maintains information about the currently running system

this information doesn't persist across reboots. It exists while the system in running only in RAM; in Window this would be the `HKLM`

in linux `/dev` this includes things like `/dev/tty#` `/dev/ttyS#` they indicate devices as they are connected and they be created dynamically

`/sys` shows a representation of the physical devices in the machine

`/proc` maintain alot of info about the current control set

example `free` command is just importing info from `/proc/meminfo` file

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
    
## [Ramdisk](https://cuongquach.com/tim-hieu-ram-disk-la-gi-tmpfs-la-gi-tren-linux.html)

- [tmpfs - temporary filesystem](https://bizflycloud.vn/tin-tuc/ram-disk-va-tmpfs-tren-linux-la-gi-vay-2018030911590498.htm)
- `/dev/shm`
- [/var/lock](https://askubuntu.com/questions/169495/what-are-run-lock-and-run-shm-used-for)
- [Web browser caching with tmpfs](https://medium.com/for-linux-users/easy-two-step-browser-speedup-with-ram-d55dbd760d5f)

## Layout

![](http://www.porcupine.org/forensics/forensic-discovery/figure3.3.gif)    

http://www.porcupine.org/forensics/forensic-discovery/chapter3.html#figure3.2

- Directory
![https://twitter.com/climagic/status/1251504373286436864](https://pbs.twimg.com/media/EV47AIyXsAEDvp4?format=jpg&name=small)