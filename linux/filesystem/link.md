## readlink
- display value of a symbolic link

## Concepts
https://unix.stackexchange.com/questions/22394/why-are-hard-links-to-directories-not-allowed-in-unix-linux

First, to understand this, let's talk about inodes. The data in the filesystem is held in blocks on the disk, and those blocks are collected together by an inode. You can think of the inode as THE file. Inodes lack filenames, though. That's where links come in.

A link is just a pointer to an inode. A directory is an inode that holds links. Each filename in a directory is just a link to an inode. Opening a file in Unix also creates a link, but it's a different type of link (it's not a named link).

A hard link is just an extra directory entry pointing to that inode. When you ls -l, the number after the permissions is the named link count. Most regular files will have one link. Creating a new hard link to a file will make both filenames point to the same inode

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

- [Why are hard links not allowed for directories?](https://askubuntu.com/questions/210741/why-are-hard-links-not-allowed-for-directories)

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
- symlink always has default permisson

## Difference hardlink and soft link

- [ELI5: The difference between a soft and hard link](https://www.reddit.com/r/linuxquestions/comments/lkwsi/eli5_the_difference_between_a_soft_and_hard_link/)

![](https://i.stack.imgur.com/f7Ijz.jpg)
- https://askubuntu.com/a/801191/978081