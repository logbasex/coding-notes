## ISO image ([Optical disk image](https://en.wikipedia.org/wiki/Optical_disc_image))
- #### Description
    - Optical disc images are **uncompressed** and do not use a particular container format; they are a sector-by-sector copy of the data on an optical disc, stored inside a binary file. Other than ISO 9660 media, an ISO image might also contain a UDF (ISO/IEC 13346) file system (commonly used by DVDs and Blu-ray Discs), including the data in its files in binary format, **copied exactly as they were stored on the disc. The data inside the ISO image will be structured according to the file system that was used on the optical disc from which it was created**

- #### Usage
    -  .ISO files are commonly used in emulators to replicate a CD image.

- [ISO-9660](https://en.wikipedia.org/wiki/ISO_9660)


- [**What about if instead of copying to another DVD, I copied to a USB flash drive (i.e. DVD > USB), would it still be the same thing as DVD > ISO > USB?**](https://superuser.com/questions/246702/whats-the-difference-between-burning-an-iso-and-copying-a-dvds-contents?rq=1)
  - The major advantage of an ISO is that burning it as an image preserves the bootloader, where extracting and burning the contents does not. The bootloader needs to go on a specific part of the CD/DVD/USB drive for it to be bootable. Just burning the contents does not do this. 
  - The other advantage is that you can make a checksum of the entire ISO instead of each file it contains. That can be used to make sure that the download happened without error.

