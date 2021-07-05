## [Where do files go when the rm command is issued?](https://unix.stackexchange.com/questions/10883/where-do-files-go-when-the-rm-command-is-issued)

- Nowhere, gone, vanished. Well, more specifically, the file gets unlinked. The data is still sitting there on disk, but the link to it is removed. It used to be possible to retrieve the data, but nowadays the metadata is cleared and nothing's recoverable.

- There is no Trash can for `rm`, nor should there be. If you need a Trash can, you should use a higher-level interface. There is a command-line utility in `trash-cli` on Ubuntu, but most of the time GUI file managers like Nautilus or Dolphin are used to provide a standard Trash can. The Trash can is standard itself. Files trashed in Dolphin will be visible in the Trash from Nautilus.

- Files are usually moved to somewhere like `~/.local/share/Trash/files/` when trashed. The `rm` command on UNIX/Linux is comparable to `DEL` on DOS/Windows which also deletes and does not move files to the Recycle Bin. Another thing to realize is that moving a file across filesystems like to your USB disk from your hard disk drive is really 1) a copy of the file data followed by 2) unlinking the original file. You wouldn't want your Trash to be filled up with these extra copies.


## [How is rm command different from the delete button?](https://askubuntu.com/questions/174906/how-is-rm-command-different-from-the-delete-button)

- Your understanding is essentially correct - the <kbd>Del</kbd> key as used in Nautilus (or other file manager) is NOT the same as using `rm`; it "moves" the file to Trash instead so that it can be recovered unless you *Empty Trash* (which is the same as `rm`).

- **Note that even if you `rm` a file, the actual data is still on the disk after the inode is deleted**. If you act immediately before the data is eventually overwritten, you can still recover the data using a tool such as `testdisk/photorec`.


## [rm vs shred command](https://matthewboyd123.medium.com/linux-rm-vs-shred-command-2c3501315d27)

`rm` will simply delete the file from the file system, however the bytes from the contents will still remain until they are overwritten by another file. However, with `shred` it will populate the file with random bytes so that your content is destroyed, and then if specified it will delete the contents.


## [Why is rm allowed to delete a file under ownership of a different user?](https://unix.stackexchange.com/questions/226563/why-is-rm-allowed-to-delete-a-file-under-ownership-of-a-different-user)

The reason why this is permitted is related to what removing a file actually does. Conceptually, `rm`'s job is to remove a name entry from a directory. The fact that the file may then become unreachable if that was the file's only name and that the inode and space occupied by the file can therefore be recovered at that point is almost incidental. The name of the system call that the `rm` command invokes, which is `unlink`, is even suggestive of this fact.

And, removing a name entry from a directory is fundamentally an operation *on that directory*, so that directory is the thing that you need to have permission to write.


----

Yes. rm simply deletes the pointer. If you have multiple pointers to the file (hard links), then deleting one of those pointers with rm leaves the others completely untouched and the data still available.

Deleting all of those links still does not touch the data, however the OS is now free to reuse the blocks which previously were reserved for storing that data.

It's worth noting that any process which opens a file creates a file handle for it. This adds to the overall count of references to the file. If you delete all of the pointers from your filesystem, but the operating system still has a process running with an open file handle for your file, then the count of pointers will not be zero and the file will not really be deleted. Only when that final pointer is closed will the filesystem register the disk space as having been released, and only at that point will the OS be free to overwrite the blocks previously reserved for storing that data.

You may or may not be able to recover that data at any point in the future depending on whether any reuse of the blocks in question has occurred.

Incidentally, you have no guarantee that your data is sitting there in a contiguous block in the first place.

---

https://unix.stackexchange.com/questions/50179/what-happens-when-you-delete-a-hard-link

In Unix all normal files are Hardlinks. Hardlinks in a Unix (and most (all?)) filesystems are references to what's called an `inode`. The `inode` has a reference counter, when you have one "link" to the file (which is the normal modus operandi) the counter is 1. When you create a second, third, fourth, etc link, the counter is incremented (increased) each time by one. When you delete (`rm`) a link the counter is decremented (reduced) by one. If the link counter reaches 0 the filesystem removes the `inode` and marks the space as available for use.

In short, as long as you do not delete the last link the file will remain.

` Edit:` The file will remain _even if the last link is removed_. This is one of the ways to ensure security of data contained in a file is not accessible to any other process. Removing the data from the filesystem completely is done only if the data has 0 links to it as given in its metadata and is not being used by any process.

[This][1] IMHO is by far the easiest way to understand hard-links (and its difference from softlinks).


[1]: http://linuxgazette.net/105/pitcher.html


---- 

https://www.computernetworkingnotes.com/linux-tutorials/permanently-and-securely-delete-files-in-linux.html

---

```shell
ls -l 

drwxr-xr-x   3 logbasex logbasex     4096 Jun 15 10:51  Desktop
drwxr-xr-x   9 logbasex logbasex     4096 Jul  2 11:22  Documents
drwxr-xr-x   7 logbasex logbasex     4096 Jun 30 23:11  Downloads

# column 2 contains link count
```