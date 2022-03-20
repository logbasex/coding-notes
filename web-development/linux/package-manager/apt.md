- [Generating list of manually installed packages and querying individual packages](https://askubuntu.com/questions/2389/generating-list-of-manually-installed-packages-and-querying-individual-packages)
```shell
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)

apt-mark showmanual
apt-mark showauto
```
- 

