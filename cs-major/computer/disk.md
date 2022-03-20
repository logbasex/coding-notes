## Sector

- https://superuser.com/questions/1110355/what-is-the-difference-between-a-disk-block-and-a-sector
- https://en.wikipedia.org/wiki/Disk_sector

A sector has traditional been a fixed 512 byte size, but a few drives have 4096 bytes sectors.

A sector is the smallest individual reference-able regions on a disk.

The block size refers to the allocation size the file system uses. The common options are 512, 1024, 2048, 4096, 8192, 16384, or 32678. Generally anything larger would be so inefficient nobody would use it, and you can't go smaller than 1 disk sector.