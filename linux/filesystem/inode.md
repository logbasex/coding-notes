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

# Commands

`ls -i` lists the inode of a file
`ls -lai`

```shell script
cd /

ls -lai
2 drwxr-xr-x  21 root root  4096 Thg 4   1 09:53 .
2 drwxr-xr-x  21 root root  4096 Thg 4   1 09:53 ..
```

- ### find which file(s) belongs to a specific inode number

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