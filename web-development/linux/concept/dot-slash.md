http://www.linfo.org/dot_slash.html


The combination of a dot followed directly by a forward slash (./) is often used to precede commands in Linux and other Unix-like operating systems. Although this requirement can seem confusing and even tedious to new users, it exists for good reason and can be useful to understand.

Commands in Unix-like operating systems are either built-ins or executables. The former (e.g., alias, cd, echo, kill, ls and pwd) are part of the shell that is currently running, and thus the shell can always locate them. In contrast, the shell needs help in finding the latter, which can be divided into compiled programs and shell scripts. A compiled program is a program whose source code (i.e., its original, human-readable form) has been converted through the use of a compiler into an executable file (i.e., a ready-to-run form).

A shell is a program that provides the traditional, text-only user interface for Unix-like operating systems. Its primary function is to read commands that are typed in at the command line (i.e., in a text-only mode) and then execute (i.e., run) them. A shell script is a short program that is written in a shell programming language and interpreted (i.e., converted into runnable form) by a shell process.

When some text is typed into a shell and then the ENTER key is pressed, the shell assumes that it is a command. The shell immediately checks to see if the first string (i.e., sequence of characters) in that text is a built-in command or the absolute path (i.e., location relative to the root directory) to an executable.

If it is neither of these, the shell will search the directories listed in that users' PATH environmental variable for a file with that name. PATH (all upper case letters) tells the shell which directories to search for commands in response to commands issued by the user.

If the command is found, it will be executed, assuming that there are no other problems. If it is not found, an error message, such as command not found, will be returned.

Most users work most of the time in their home directory and subdirectories thereof because of convenience and for safety reasons. However, by default such directories are not included in the user's PATH variable. Thus when the user creates a script or compiles a program in one of those directories and attempts to run it by merely typing in its name, an error message will be returned.

However, this problem can be easily overcome by typing a dot and slash in front of the command name. This is merely an abbreviated way to inform the shell that the absolute path of that file is the current directory (i.e., the directory in which the user is currently working). In Unix-like operating systems, a single dot is used to represent the current directory in a path (i.e., the location of a file or directory in the filesystem), including those used in commands. Likewise, forward slashes are used to separate directories and files in paths.

Files in the current directory can be accessed for reading and writing by merely entering the command name (e.g., cat or vi) followed by the name of the file. That is, no absolute path is necessary. However, when execution is desired, either an absolute path (or its dot slash equivalent) or the inclusion of the directory containing the command's executable file in the PATH variable is necessary. This is a built-in safety mechanism.

A user could eliminate the need to precede commands by a dot slash by appending a single dot to the PATH variable, because this would tell the shell to also search the current directory. However, this is generally not advisable on safety and security grounds. For example, were the user to inadvertently create a shell script with the same name as a standard command, the shell could execute the former instead of the latter, thereby causing the system to malfunction, or worse<sup>1</sup>.

A better alternative if one wants to eliminate the need to precede commands by a dot slash is to create a special directory for the executable files of such commands, and then add this directory to the PATH variable. For example, a user named bob could create a directory named bin in his home directory (i.e., /home/bob/bin/) for this purpose.

Another approach for making it easy to run a program that is installed in a non-standard directory is to create a symbolic link to it (using the ln command with its -s option), and then put the link in a directory that is already in the PATH variable. This can be a safer alternative to adding more directories to PATH.

The dot slash should not be confused with Slashdot, which is the name of a popular web site about computer technology.


________
<sup>1</sup>An extreme example would be the situation in which an ordinary user created a shell script such as rm -r /, which would delete all files and directories in the system for which the user had writing permission, and named this script ls. Were the system administrator to navigate to the directory in which this script was located and attempt to run the standard ls command in order to view the contents of that directory, the shell would instead run the script with the same name and thereby remove the contents of all currently mounted partitions on the computer!