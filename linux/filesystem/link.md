## readlink
- display value of a symbolic link

## Hard Link

- https://www.baeldung.com/linux/symbolic-and-hard-links

```shell script
# syntax
ln <source file> <link>

# create hard link
ls -l
-rw-rw-r-- 2 runner3 ubuntu 0 Sep 29 11:22 originalFile

ln originalFile sampleHardLink

# inode numbers
ls -i
2835126 originalFile
2835126 sampleHardLink
```

- **A hard link is just another file that points to the same underlying inode as the original file.**
In the example above, `originalFile` and `sampleHardLink` has the same inode, thus delete original file (`originalFile`) does not affect `sampleHardLink` file. 

- We can't create hardlink for directory

## Soft Link
- A **symbolic or soft link** is a new file that just stores the path of the original file and **not its contents**

```shell script
# create soft link
ln -s originalFile sampleSoftLink

# inode number
ls -i
2835126 originalFile
2835217 sampleSoftLink
```