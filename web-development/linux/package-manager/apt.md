## [Generating list of manually installed packages and querying individual packages](https://askubuntu.com/questions/2389/generating-list-of-manually-installed-packages-and-querying-individual-packages)
```shell
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)

apt-mark showmanual
apt-mark showauto
```
## [Ignore update package](https://askubuntu.com/questions/678630/how-can-i-avoid-kernel-updates)
```
apt-mark hold [package]
```
## [Increase bandwidth](https://superuser.com/questions/945015/why-is-apt-get-downloads-so-slow)
```
// sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
// Use apt bandwidth limit feature, this example limits the download
// speed to 70kb/sec
Acquire::http::Dl-Limit "70";
```
