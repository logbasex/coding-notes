## How GUIs works
- [It’d be hardware -> kernel/kernel driver -> X server/X server driver -> Xlib -> Xt/Motif/GTK/QT](https://www.quora.com/How-does-a-Linux-GUI-work-at-the-lowest-level/answer/Sergiusz-Jarczyk)
- [Gnome and X11](https://stackoverflow.com/questions/17251293/what-is-the-relationship-between-x11-and-gnome)
- [Windowing System](http://www.linfo.org/windowing_system.html)
    - A windowing system, also referred to as a window system, is a collection of software that creates the basic GUI (graphical user interface) on computer display screens, including the drawing of windows and other graphics primitives (i.e., basic shapes) for application programs.
      
      A GUI is a type of human-computer interface that uses windows, icons (i.e., small images), pull-down menus and a pointer and that can be manipulated by a mouse (and usually to some extent by a keyboard as well). A window is a (usually) rectangular portion of the display on a computer monitor that presents its contents (e.g., the contents of a directory, a text file or an image) seemingly independently of the rest of the display screen, including other windows on the screen.
      
      The X Window System, often referred to merely as X, is a complete, cross-platform and free windowing system for managing GUIs on single computers and on networks of computers. It is one of the most powerful and useful software packages for Linux and other Unix-like operating systems, and it is the de facto standard windowing system for such operating systems. Other windowing systems have been developed for Unix-like operating systems, such as Y Window System, but generally are not widely used.
      
      Some operating systems use windowing systems that are integral parts of the operating system, such as the various Microsoft Windows systems and Mac OS 9 and earlier. Apple Computer's development of the Quartz Compositor windowing system for the Mac OS X has been a major factor in the outstanding performance and growing popularity of OS X.
      
      The relatively small number of high quality windowing systems available, and their slow evolution, is largely a result of the extremely complex nature of such systems and the consequent difficulty in developing them. For example, it is said that the X Window System has an order of complexity as great as that of an operating system itself.
      
      The term graphic engine is sometimes used as a synonym for windowing system. However, it can also refer to a layer of software that is used by specific application programs, or groups thereof, on top of the windowing system rather than the basic windowing system itself. For example, many games that operate on the Microsoft Windows systems employ special, high-performance graphic engines that are used on top of the Microsoft Windows windowing system.
- [How to know whether Wayland or X11 is being used](https://unix.stackexchange.com/questions/202891/how-to-know-whether-wayland-or-x11-is-being-used)

- [What is Linux’s native GUI API?](https://stackoverflow.com/questions/12717138/what-is-linux-s-native-gui-api)
    - In Linux the graphical user interface is not a part of the operating system. The graphical user interface found on most Linux desktops is provided by software called the X Window System, which defines a device independent way of dealing with screens, keyboards and pointer devices.
      
      X Window defines a network protocol for communication, and any program that knows how to "speak" this protocol can use it. There is a C library called Xlib that makes it easier to use this protocol, so Xlib is kind of the native GUI API. Xlib is not the only way to access an X Window server; there is also XCB.
      
      Toolkit libraries such as GTK+ (used by GNOME) and Qt (used by KDE), built on top of Xlib, are used because they are easier to program with. For example they give you a consistent look and feel across applications, make it easier to use drag-and-drop, provide components standard to a modern desktop environment, and so on.
      
      How X draws on the screen internally depends on the implementation. X.org has a device independent part and a device dependent part. The former manages screen resources such as windows, while the latter communicates with the graphics card driver, usually a kernel module. The communication may happen over direct memory access or through system calls to the kernel. The driver translates the commands into a form that the hardware on the card understands.
      
      As of 2013, a new window system called Wayland is starting to become usable, and many distributions have said they will at some point migrate to it, though there is still no clear schedule. This system is based on OpenGL/ES API, which means that in the future OpenGL will be the "native GUI API" in Linux. Work is being done to port GTK+ and QT to Wayland, so that current popular applications and desktop systems would need minimal changes. The applications that cannot be ported will be supported through an X11 server, much like OS X supports X11 apps through Xquartz. The GTK+ port is expected to be finished within a year, while Qt 5 already has complete Wayland support.
      
      To further complicate matters, Ubuntu has announced they are developing a new system called Mir because of problems they perceive with Wayland. This window system is also based on the OpenGL/ES API.
      
- [What is the lowest level of GUI abstraction in Linux?](https://www.quora.com/What-is-the-lowest-level-of-GUI-abstraction-in-Linux)      
    - The monitor/screen drawing is handled in hardware by a video card/GPU/video processor. There are special cases where a CPU and a GPU are on a single die, merged together (Intel i-series chips, for example) but functionally the GPU and the CPU are differently visible to the kernel.
      
      The kernel communicates with the GPU by means of a driver. e.g. radeon, fglrx, nouveau. Different cards and different drivers support different features (e.g. OpenGL, KMS etc.) to varying levels. GPUs may also have an Application Binary Interface (ABI) for communications/commands that a program (Xorg) may need to send.
      
      Xorg can draw into an in-memory structure called a framebuffer and upload it to the kernel, which in turn can ask the GPU to draw it on the actual hardware screen, or Xorg can convert what it needs to paint/draw into card-specific commands (from the ABI) and ask the kernel to pass these commands to the card.
      
      The latter method is how hardware-acceleration works. Xorg uses a library called libdrm (DRM: Direct Rendering Manager) to pass these commands to the kernel.
      
- Restart X server
    ```shell script
    sudo systemctl restart lightdm.service
    ```      
- [Why is the Linux X Window System bad?](https://www.quora.com/Why-is-the-Linux-X-Window-System-bad)
    - When X was invented in 1984, computing in general was expensive and limited to universities and large corporations who could afford it. Even the vaunted workstations of that era were 200-pound weaklings in comparison to the cheapest laptop you can buy today.
      
      Back then, the general computing model was "run the expensive computations on the Big Hardware that's somewhere else, and display the results on my screen". In that respect, X was a major hit. The client programs simply had to call the necessary Xlib routines to draw on a virtual canvas, and the result can be viewed on one or more computers running X server software, anywhere in the country. Imagine Xconq running on a server and displaying on two screens over 2,000 miles apart. That was my old friend and me on Friday nights all those years ago.
      
      Things...are very different now. Computation and display on the same box, HD video playback, and other previously-unthinkable computing modes are now commonplace. X has evolved to keep up, but mostly via extensions rather than fundamental rethinking and reimplementing. Dissatisfaction with the status quo led the rise of start-from-scratch projects like Wayland and Mir.  