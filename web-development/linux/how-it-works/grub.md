> [GRUB stands for **GRand Unified Bootloader**. Its function is to take over from BIOS at boot time, load itself, load the Linux kernel into memory, and then turn over execution to the kernel. Once the kernel takes over, GRUB has done its job and it is no longer needed.](https://opensource.com/article/17/3/introduction-grub2-configuration-linux)
> 
> GRUB chịu trách nhiệm chính trong việc cung cấp cho bạn một menu tùy chọn mà từ đó bạn có thể chọn hệ điều hành hoặc môi trường mà bạn muốn boot vào. Ngoài ra, GRUB chịu trách nhiệm load Linux kernel.
> 
> [GRUB không chỉ giới hạn trong việc khởi động vào hệ điều hành Linux, bạn cũng có thể sử dụng nó để khởi động vào các hệ điều hành khác như Windows.](https://quantrimang.com/grub-bootloader-la-gi-182515)

![image](https://user-images.githubusercontent.com/22516811/163780694-1674ecb5-af2d-4909-a1c2-72ade78b9de2.png)

---------

## [Update kernel version](https://askubuntu.com/questions/82140/how-can-i-boot-with-an-older-kernel-version)

---------
## [Difference between GRUB and GRUB2](https://www.cyberithub.com/what-are-the-differences-between-grub-and-grub2-boot-loader/)

Có hai phiên bản chính của GRUB có sẵn tại thời điểm viết bài này.

- **GRUB Legacy**: Đây là phiên bản đầu tiên của GRUB và được phát triển lần đầu vào năm 1995.

- **GRUB 2**: Đây là phiên bản GRUB mới nhất được nhiều bản phân phối Linux chính thống như Manjaro, Ubuntu, Fedora và Red Hat Enterprise Linux (RHEL) sử dụng. GRUB 2 cung cấp cho bạn các công cụ và tùy chọn cấu hình tốt hơn so với phiên bản tiền nhiệm của nó.

Ngoài GRUB, các bản phân phối Linux cũng sử dụng những bootloader khác như Linux Loader (LILO), coreboot và SYSLINUX.

- ### GRUB

  Configure through
  > /boot/grub/grub.conf

- ### GRUB2

  Configure through
  > etc/default/grub 

GRUB 2 cung cấp cho bạn nhiều tính linh hoạt và sức mạnh khi cấu hình bootloader.

Thư mục `/boot/grub` chứa một file có tên `grub.cfg`, là file cấu hình chính cho GRUB. Tuy nhiên, bạn không nên chỉnh sửa trực tiếp file `grub.cfg`, thay vào đó bạn nên chỉnh sửa file `/etc/default/grub`.

Khi bạn thực hiện các thay đổi đối với file `/etc/default/grub`, bạn nên đảm bảo chạy lệnh bên dưới để các thay đổi được ghi tự động vào file `grub.cfg`.
> sudo update-grub

GRUB manual
> info -f grub

-------

## [Why does Windows have to installed first in a dual boot set up?](https://askubuntu.com/questions/152991/in-setting-up-dual-boot-with-windows-and-ubuntu-which-os-do-i-install-first)

The Windows bootloader is very fussy and does NOT work well with other operating systems - it ignores them when installing and will overwrite their bootloader if it is installed in the MBR (master boot record) already. Installing Windows second makes it harder to get back into a workable grub menu.

So the recommended solution is to install Windows first, then install Ubuntu which shouldn't create conflicts in the MBR.


