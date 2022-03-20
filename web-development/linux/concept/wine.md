## [How wine works](https://www.reddit.com/r/linux/comments/axg3go/how_does_wine_work_and_how_is_it_not_always/)
The way that wine works is by running the windows executable directly on your Linux system. It converts the windows system calls to Linux ones. This is not the same as an emulator or virtual machine, they both are essentially "pretending" to be a real windows pc. Wine will generally run a lot faster than virtualization, but the software doesn't always support everything perfectly.

### [ELI5](https://www.reddit.com/r/linux4noobs/comments/245qqo/eli5_how_does_wine_work/)
Basically windows and linux run the same way,

- program is loaded into memory, execution starts at specific place indicated in the header of the program

- any requested library files are provided, because any windows program calls procedures from other libraries (file access, audio/video, interface, anything).

Wine includes a loader for windows executable format, to make first point happen, and system api to allow loading of those dependency libraries. Also it has reimplemented a lot of that low-level system libraries, sometimes native windows libraries have to be provided though (and they are handled same way the .exe files are).

The actual code inside the program is only dependent on your cpu, which is where wine does not have to interfere. No CPU instructions are translated, which is why people keep repeating that "Wine is not an emulator".

---------
In general wine loads the windows binary files (exe, dll and such) and extracts the actual code out of them, directly running it.

There is no emulation, the instructions inside binary files are for your cpu, and will work. What wine does is provide the windows api, which application use. Pretty much everything application does when interfacing with the system is achieved with this api - such as drawing dialogs on screen, click events, file access, making sound, drawing stuff on the screen, etc. Everywhere the application asks system for something, wine takes over and provides its own implementation of system calls to make the program work.

That is basically how every operating system works. You have a program that displays a window with "Yes/No" dialog, you ask the operating system or some other system libraries to draw it for you, and return what the user clicked. You don't have to worry with how display or mouse works, or how to make the video card draw a window on screen - that's the job of the operating system.

Wine simply hooks into the windows program's system calls and connects them to its implementation of windows api.

----------

The basic idea is that Windows and Linux (or other Unix like operating systems) have a different way of programming them. For example, if you want to create a new process on Windows, you use the call CreateProcessA, on Linux, you use fork(). WINE essentially is a layer you plug in that allows a program on Linux to call CreateProcessA and it should behave EXACTLY like Windows (or close enough to not cause bugs).

The reason this is so hard is because there are so many different Windows interfaces that don't exist on Linux, like DirectX. So essentially the entirety of DirectX needs to be recreated from scratch on Linux, that's what the WINE devs are doing. Also, they are not allowed to directly reverse engineer Windows or look at it's code (for legal reasons) which makes it harder. Also, there are situations where things just act weird on Windows, or directly against the way the documentation says it's supposed to work so they have to figure out how it actually does work, so they can cause that exact same behavior in WINE.

https://www.reddit.com/r/linux_gaming/comments/atnoha/what_is_wine_really_doing_under_the_hood/

## More

An emulator will "read" instructions from a game (or any progam), step by step, and execute them in their own way. That's not what wine do.

Wine will open a *Portable Executable* file (usually a .exe), find the CPU instructions, and tell the CPU to execute them. It's the CPU which execute the code; Wine is just a launcher.

Now, Wine has a second part: it implements the various Windows API, the same way any API are implemented: by creating libraries. Some of these libraries are just a "translation" layer (eg: `OpenFile()` will call `open()`), but it has nothing to do with translating instructions.

Wine does not any of the tasks a classic emulator need to do (memory mapping, step-by-step code execution, ...)