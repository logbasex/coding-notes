# Inode
https://www.grymoire.com/Unix/Inodes.html

We are used to thinking about a directory containing files. This is really an illusion. **Directories do not contain files**. The data of the files is not stored in the directory.

**A directory is really just a file**. It's a special file with special rules (you can't just type "cp /dev/null directory" to erase it. It's got special bits to make sure a mere mortal can't mess it up. Because if a file system gets corrupted, then you can say goodbye to your data. On older UNIX systems, you actually could "read" the contents, using 'cat .', of a directory. But let me get back to that in a second...

**A Unix file is "stored" in TWO different parts of the disk**. (I won't get into superblocks and other esoteric information.)
- The data blocks
- The inodes

- The data blocks contain the "contents" of the file.
- The information about the file is stored elsewhere - in the inode.

Both the inodes and data blocks are stored in a "filesystem" which is how a disk partition is organized. But these inodes are strange and confusing. Let me give you an introduction.

![](https://i.stack.imgur.com/Et9HC.gif)

[Most Unix filesystems contain](https://superuser.com/questions/520107/how-are-directory-structures-stored-in-unix-filesystem)

- A boot block
- A superblock (disk geometry, partition layout, inode count, etc)
- Inode blocks
- Data blocks

--------
### [What exactly is an Inode and Inode number?](https://esc.sh/blog/inode-hardlink-softlink-explained/)


Inode is a data-structure that represents a file or a directory. An Inode number is a unique number given to an inode. In plain English, this is what it means.

- Everything in a unix system is represented as a file ( including regular files like your movies, documents, audio files )
- A file is stored in a file system ( ext3, ext4 etc ).
- But when you store a file in a file system, you need to have some kind of identification mechanism so that you can retrieve the file later, modify it, or even delete it. If there is no unique identification mechanism, you have a filesystem full of random garbage data that you have no way of identifying or using.
- So, we need a way to identify each file in a file system. We use inode number for that.
- Inode number of a file points to the inode corresponding to that file. And each inode represents a file.
- When I say "represent", I mean, each inode contains a lot of information about the file [ size of the file, owner, group, permissions and all kinds of stuff like that ]
- **There is a limit to the maximum number of inodes in a file system**. So, it is possible that you can't store any more files even if you have plenty of storage left ( That's right, you have GBs of storage space left, but you have a huuuuge number of files in your disk that you have used up all the inodes and you cannot store any more data. )


# Commands

`ls -i` lists the inode of a file
`ls -lai`

```shell script
cd /

ls -lai
2 drwxr-xr-x  21 root root  4096 Thg 4   1 09:53 .
2 drwxr-xr-x  21 root root  4096 Thg 4   1 09:53 ..
2 drwxr-xr-x  23 root root  5240 Thg 5  21 09:12 dev
```

The `dev` directory has the inode `2`. I suspect that when the filesystem was created, the `/dev` directory was the first file to be created.

- Check number of inodes
```shell script
# get current partition
partition=$(df -i . | tail -1 | awk -F' ' '{print $1}')

df -i $partition
```

- [File level inode](https://www.redhat.com/sysadmin/inodes-linux-filesystem)
```shell script
ls -i <file-name>
```

- Directory level inode
```shell script
ls -idl <directory-name>
```

### find which file(s) belongs to a specific inode number

```shell script
find / -inum <inode number>
```

# Specific inode number

https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Special_inodes


| Syntax | Description |
| ----- | -------------------------------------------------------------------------------------------------------------------|
| 0     | Doesn't exist; there is no inode 0.                                                                                |
| 1     | List of defective blocks.                                                                                          |
| 2     | Root directory.                                                                                                    |
| 3     | User quota.                                                                                                        |
| 4     | Group quota.                                                                                                       |
| 5     | Boot loader.                                                                                                       |
| 6     | Undelete directory.                                                                                                |
| 7     | Reserved group descriptors inode. ("resize inode")                                                                 |
| 8     | Journal inode.                                                                                                     |
| 9     | The "exclude" inode, for snapshots(?)                                                                              |
| 10    | Replica inode, used for some non-upstream feature?                                                                 |
| 11    | Traditional first non-reserved inode. Usually this is the lost+found directory. See s_first_ino in the superblock. |

## Directory
A directory is a file that contains directory entries.

## Directory entry
- Logically, we can think of each directory entry as containing a filename along with a structure of information describing the attributes of the file. The attributes of a file are such things as the type of file (regular file, directory), the size of the file, the owner of the file, permissions for the file (whether other users may access this file), and when the file was last modified. The stat and fstat functions return a structure of information containing all the attributes of a file.

- **Directory Entry is basically the mapping of filename to its inode**. The user generally accesses the file by its name, however such filenames are not understood by the kernel.
 
- https://unix.stackexchange.com/questions/186992/what-is-directory-entry  

# Question

- [Is it possible to change the inode of a file](https://unix.stackexchange.com/questions/345940/is-it-possible-to-change-the-inode-of-a-file-what-are-the-different-conditions)
    - The inode is actually what identifies the file (rather than any filename, say). That's why hardlinks work in the first place.
      
      **So the only way to change the inode number is to copy the file to a new file (which then would get a new inode)**.
      
      The filesystem is responsible for managing the inodes, you can't just "choose" one you like.
      
- [Why do files sometimes change but not the inode or vice versa?](https://unix.stackexchange.com/questions/343511/why-do-files-sometimes-change-but-not-the-inode-or-vice-versa)      
    - If you edit a file with an editor and such, often a new file (with a new inode) will be created - but containing the same/edited data. The original file (with original inode) may be retained as back-up.
      
      The shell redirections (> and >>) on the other hand, reuse the inode, so the inode remains the same after you overwrite/add to the file. (The drawback being that the old content typically will be overwritten, so there is no way of rescuing the old content if you overwrote it by mistake.)

- [How many inodes are there](https://www.redhat.com/sysadmin/inodes-linux-filesystem)
    - First up, and less important, the theoretical maximum number of inodes is equal to 2^32 (approximately 4.3 billion inodes). Second, and far more important, is the number of inodes on your system. Generally, the ratio of inodes is 1:16KB of system capacity.

- [How many bytes per inodes](https://stackoverflow.com/questions/3618820/how-many-bytes-per-inodes)    
    - The default bytes per inode is usually **16384**, which is the default inode_ratio in `/etc/mke2fs.conf` (it's read prior to filesystem creation.
    
        ```shell script
        cat /etc/mke2fs.conf
        ```