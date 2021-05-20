# History
<p>

    vi (or vim) IS intuitive and it IS NOT HARD TO USE, once you learn its premises. vim is a TEXT-OBJECT ORIENTED EDITOR, and the commands are applied on the objects. Once you understand that (same way you’ve to learn CUA premises), it’s easy to use.
    
    vi is the “VIsual mode” of ex, an ancient editor, from the time the computers didn’t have a monitor. Yep, there was a time when programmers and users interacted with computers through a thing called teletype. Essentially, anything you typed in a keyboard (almost standard typewriter keyboard!) was sent to a computer, and the computer responded by activating the TYPING, so the user saw the response to his or her command in a continous paper (when not in a paper tape).
    
    That’s the main reason why ed → ex → em → vi → vim is a command driven application. You coudn’t see the code, you had to send commands like “yank three lines”, “move to the end of the paragraph”, “pasted yanked text here”… If you think vim is hard to use, try to use it without a screen interface. That’s hardcore coding. And, the best of all: it is possible! If you're working on a remote server and the connection is slow, you can issue a bunch of commands through the TTY emulator (a.k.a. [x]term) and they well be executed without the need of immediate visual feedback.
    
    When computers started to use CRT or other types of “screens”, ex got the “vi” mode, since it was then possible to see the many lines of text, and a cursor was available to reach text positions. vi uses h j k l because there were no cursor keys back then and the machine the author used to write ex had cursor arrows above those keys.
    vi has no undo or many other “modern” niceties… That’s vim. Vim is far better than standard ex (vi is just the name of a symbolic link that starts ex in vi mode).
    So, that’s why vi/vim is so different (but not worse) than “modern” software.
</p>

- [Line Editor](https://en.wikipedia.org/wiki/Line_editor)
- [Visual Editor](https://en.wikipedia.org/wiki/Visual_editor)
- [vi](https://en.wikipedia.org/wiki/Vi)
- [ed and ex](https://medium.com/usevim/vim-101-ed-and-ex-30314f7a2177)

# Resources
- http://www.yolinux.com/TUTORIALS/LinuxTutorialAdvanced_vi.html
- https://github.com/akrawchyk/awesome-vim#learning-vim
- https://github.com/kyoz/vim-galore-vi
- [Vim graphical cheatsheet](http://www.viemu.com/vi-vim-cheat-sheet.gif)

# Install

- https://betterprogramming.pub/setting-up-neovim-for-web-development-in-2020-d800de3efacd?gi=a7302040f293

- Nerd font (use for install vim-devicons)
```
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
```

- Fzf vim

```
https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko?signin=true

:Files
:Rg
```

# Vim Cheatsheet

>Disclaimer: This cheatsheet is summarized from personal experience and other online tutorials. It should not be considered as official advice.

![](http://www.viemu.com/vi-vim-cheat-sheet.gif)

## Global
```bash
:help keyword # open help for keyword
:o file       # open file
:saveas file  # save file as
:close        # close current pane
```

## Cursor movement
<pre>
h                 # move cursor left
j                 # move cursor down
k                 # move cursor up
l                 # move cursor right
H                 # move to top of screen (<b>H</b>igh)
M                 # move to middle of screen (<b>M</b>iddle)
L                 # move to bottom of screen (<b>L</b>ow)
w                 # jump forwards to the start of a word
W                 # jump forwards to the start of a word (words can contain punctuation)
e                 # jump forwards to the end of a word
E                 # jump forwards to the end of a word (words can contain punctuation)
b                 # jump backwards to the start of a word
B                 # jump backwards to the start of a word (words can contain punctuation)
0                 # jump to the start of the line
^                 # jump to the first non-blank character of the line
$                 # jump to the end of the line
g_                # jump to the last non-blank character of the line
gg                # go to the first line of the document
G                 # go to the last line of the document
5G                # go to line 5
f<b>x</b>                # jump to next occurrence of character <b>x</b>
t<b>x</b>                # jump to before next occurrence of character <b>x</b>
}                 # jump to next paragraph (or function/block, when editing code)
{                 # jump to previous paragraph (or function/block, when editing code)
%                 # jump between matching bracket/parenthesis (under the cursor)
zz                # center cursor on screen
Ctrl + b          # scroll **b**ackword one full screen
Ctrl + f          # scroll **f**orward one full screen
Ctrl + d          # scroll **d**own 1/2 screen
Ctrl + u          # scroll **u**p 1/2 a screen


30G80|                  # goes to line 30, column 80.
:cal cursor(30, 80)     # goes to line 30, column 80.

</pre>


## Insert mode - inserting/appending text
```bash
i        # insert before the cursor
I        # insert at the beginning of the line
a        # insert (append) after the cursor
A        # insert (append) at the end of the line
o        # append (open) a new line below the current line
O        # append (open) a new line above the current line
ea       # insert (append) at the end of the word
bi       # insert (append) at the begin of the word
Esc      # exit insert mode
```

## Editing
<pre>
r                 # replace a single character
J                 # join line below to the current one
cc                # change (replace) entire line
cw                # <b>change</b> (replace) to the start of the next <b>word</b>
ce                # change (replace) to the end of the next word
cb                # change (replace) to the start of the previous word
cib/ciB           # change the text inside the current set of parenthesis () or braces {}, respectively.
c0                # change (replace) to the start of the line
c$                # change (replace) to the end of the line
s                 # delete character and substitute text
S                 # delete line and substitute text (same as cc)
xp                # transpose two letters (delete and paste)
.                 # repeat last command
u                 # undo (:undo)
Ctrl + r          # redo (:redo)
         
                  # https://medium.com/usevim/vim-101-efficient-html-editing-with-text-objects-1571734718e3
dat               # delete <b>a</b> <b>t</b>ag block (HTML)
dit               # delete <b>i</b>nner <b>t</b>ag block (HTML)
</pre>

- Use Ctrl-R (press and hold `Ctrl` and press `r`) to redo the last change. In Vim, you can also use quantifiers. For example, if you want to redo the 4 last changes, you would type `4Ctrl-R`

## Marking text (visual mode)
```bash
v        # start visual mode, mark lines, then do a command (like y-yank)
V        # start linewise visual mode
o        # move to other end of marked area
O        # move to other corner of block
aw       # mark a word
ab       # a block with ()
aB       # a block with {}
ib       # inner block with ()
iB       # inner block with {}
Esc      # exit visual mode
Ctrl + v # start visual block mode
```

## Visual commands
```bash
>       # shift text right
<       # shift text left
y       # yank (copy) marked text
d       # delete marked text
~       # switch case
```

## Cut and paste
```bash
yy       # yank (copy) a line
yiw      # yank (copy) inner word (copy word under cursor)
viwp     # put cursor under another word, select and replace with previous yanked word.
2yy      # yank (copy) 2 lines
yw       # yank (copy) the characters of the word from the cursor position to the start of the next word
y$       # yank (copy) to end of line
p        # put (paste) the clipboard after cursor
P        # put (paste) before cursor
dd       # delete (cut) a line
2dd      # delete (cut) 2 lines
dw       # delete (cut) the characters of the word from the cursor position to the start of the next word
D        # delete (cut) to the end of the line
d$       # delete (cut) to the end of the line
d^       # delete (cut) to the first non-blank character of the line
d0       # delete (cut) to the begining of the line
x        # delete (cut) character
```

## Search and replace
```bash
/pattern       # search for pattern
?pattern       # search backward for pattern
\vpattern      # 'very magic' pattern: non-alphanumeric characters are interpreted as special regex symbols (no escaping needed)
n              # repeat search in same direction
N              # repeat search in opposite direction
:%s/old/new/g  # replace all old with new throughout file
:%s/old/new/gc # replace all old with new throughout file with confirmations
:noh           # remove highlighting of search matches
*              # search forward the word under the cursor
#              # search backward the word under the cursor
```
- Syntax
  ```shell
  :[range]s/{pattern}/{string}/[flags] [count]
  ```
- `:%s`: `%` is the range over which the `:s` command (short for :substitute) will be run. `%` itself is short for the range `:1,$`, which means from the first line to the last line in the buffer.

## Search in multiple files
```bash
:vimgrep /pattern/ {file} # search for pattern in multiple files
:cn                       # jump to the next match
:cp                       # jump to the previous match
:copen                    # open a window containing the list of matches
```

## Exiting
```bash
:w              # write (save) the file, but don't exit
:w !sudo tee %  # write out the current file using sudo
:wq or :x or ZZ # write (save) and quit
:q              # quit (fails if there are unsaved changes)
:q! or ZQ       # quit and throw away unsaved changes
```

## Working with multiple files/ Resize window
```bash
:e file       # edit a file in a new buffer
:bnext or :bn # go to the next buffer
:bprev or :bp # go to the previous buffer
:bd           # delete a buffer (close a file)
:ls           # list all open buffeanrs
:sp file      # open a file in a new buffer and split window
:vsp file     # open a file in a new buffer and vertically split window
Ctrl + ws     # split window
Ctrl + ww     # switch windows
Ctrl + wq     # quit a window
Ctrl + wv     # split window vertically
Ctrl + wh     # move cursor to the left window (vertical split)
Ctrl + wl     # move cursor to the right window (vertical split)
Ctrl + wj     # move cursor to the window below (horizontal split)
Ctrl + wk     # move cursor to the window above (horizontal split)
Ctrl + w>     # increase width (vs split)
ctrl + w<     # decrease width (vs split)
ctrl + w+     # increase height (horizontal split)
ctrl + w-     # decrease height (horizontal split)
```

## Tabs
```bash
:tabnew or :tabnew file # open a file in a new tab
Ctrl + wT               # move the current split window into its own tab
gt or :tabnext or :tabn # move to the next tab
gT or :tabprev or :tabp # move to the previous tab
<number>gt              # move to tab <number>
:tabmove <number>       # move current tab to the <number>th position (indexed from 0)
:tabclose or :tabc      # close the current tab and all its windows
:tabonly or :tabo       # close all tabs except for the current one
:tabdo command          # run the command on all tabs (e.g. :tabdo q - closes all opened tabs)

#fzf https://github.com/junegunn/fzf.vim#commands
Ctrl + g + Ctrl + T     # search file and open in new tab
Ctrl + g + Ctrl + X     # search file and open in new split
Ctrl + g + Ctrl + V     # search file and open in new vertical split

```

## Windows
```shell script
:vsp newfile
```

## Screen Positioning
```bash
https://medium.com/usevim/vim-101-quick-movement-c12889e759e0
https://stackoverflow.com/questions/3458689/how-to-move-screen-without-moving-cursor-in-vim
https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen

zz            # move current line to the middle of the screen
zt            # move current line to the top of the screen
zb            # move current line to the bottom of the screen

+-------------------------------+
^                               |
|c-e (keep cursor)              |
|H(igh)             zt (top)    |
|                   ^           |
|           ze      |      zs   |
|M(iddle)  zh/zH <--zz--> zl/zL |
|                   |           |
|                   v           |
|L(ow)              zb (bottom) |
|c-y (keep cursor)              |
v                               |
+-------------------------------+
```

## Register
```bash
https://medium.com/usevim/vim-101-ctrl-r-c9b9b6812f4c

Ctrl + R        # Insert the contents of a numbered or named register without leaving insert mode.
                # To do this, press CTRL-R then type the name of a register (:help C-R)


```

## FileExplore

```shell script
:Ex           # Explore mode
:bd           # Exit explore mode
:Rex          # Exit explore mode (:Rexplore - recommend)
:Sexplore
:Texplore     # https://askubuntu.com/questions/245387/exit-file-explorer-in-vim-without-closing/1328827#1328827

:e            # Reload current file
              # https://vi.stackexchange.com/questions/444/how-do-i-reload-the-current-file
```


## Mapping
- https://vimways.org/2018/for-mappings-and-a-tutorial/
- https://github.com/kyoz/vim-galore-vi#ctrl-l-t%E1%BB%91t-h%C6%A1n


## Vim anywhere

Using vim in a terminal emulator: set -o vi


## Utilities

1. Execute linux command in Vim
   
   Vim allows you to run the code from within the editor without having to lose track of the code. You can do this by the use of an exclamation mark after the colon. Here’s an example:
    ```shell
    :!ping www.google.com
    ```
2. Insert text from different file
    ```shell
    :r <file name>
    ```
   
3. If you often open a file as a normal user and then realize that you dont have root permissions for writing to the file, you can use `:w !sudo tee %` to save the file w/o closing vim.

4. yank from vim to clipboard
    ```shell script
    v3j"+y      #visual mode
    ```
5. Comment multi line
    ```shell script
       select visual mode 
       :s/^/# /
    ```   
   https://ostechnix.com/comment-multiple-lines-vim-editor/
6. Format json
    ```shell script
    :%!jq .
   
    # https://askubuntu.com/questions/718991/what-do-and-mean-in-vim-commands
    % (:h :%)     Move cursor to the matching bracket.
                  Place cursor on {}[]() and type "%".
   
    ! (:h :!)     filter through external command 
                  Any UNIX command can be executed from the vi command line by typing an "!" before the UNIX command.
                  Autowrite can be intentionally avoided by using "!" to avoid the save when switching files.
    ```
7. Remove directory
    ```
    ! rmdir <FOLDER-NAME>	
    ```
8. Create a new directory and file   
    ```shell script
    :Ex
    
    d for creating a directory
    % for creating a new file
    ```
   
   With `nerdtree`
   ```shell script
    ma <FILENAME>
    ma <DIRECTORY NAME> + /
   ```
   
9. Terminal mode
    ```
    :term
   
    :vs term://zsh

    # terminal in new tab
    :tabnew | term
    ```
10. Reload config
    ```shell script
    :source ~/.vimrc
    :so $MYVIMRC
    ```
11. [Open recent file](https://stackoverflow.com/a/50558960/10393067)
    ```
    :oldfiles
    :History
    ```

## Pitfalls    

1. Debug mapping
- https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping

# Vim plugins

### I. Plugin managers

- [Vim plug](https://github.com/junegunn/vim-plug)
   - [.local/share/nvim/site/autoload/plug.vim](https://vi.stackexchange.com/questions/15042/why-does-vim-plug-add-the-vim-file-to-vim-autoload-and-not-vim-plugin)
- [Vim surround](https://github.com/tpope/vim-surround)
    - Tutorial [here](https://towardsdatascience.com/how-i-learned-to-enjoy-vim-e310e53e8d56?gi=1893fe29902d).
        ```shell
         ys               # surround
         ysiw"            # surround one word by quote
         yss(             # surround entire line with bracket
         ys2aw"           # surround two words with quote
         S""              # surround in visual mode
        
         ds               # delete  
         cs               # change
        ```

- [NerdTree](https://github.com/preservim/nerdtree)
    ```shell script
    o........Open files, directories and bookmarks......................|NERDTree-o|
    go.......Open selected file, but leave cursor in the NERDTree......|NERDTree-go|
             Find selected bookmark directory in current NERDTree
    t........Open selected node/bookmark in a new tab...................|NERDTree-t|
    T........Same as 't' but keep the focus on the current tab..........|NERDTree-T|
    i........Open selected file in a split window.......................|NERDTree-i|
    gi.......Same as i, but leave the cursor on the NERDTree...........|NERDTree-gi|
    s........Open selected file in a new vsplit.........................|NERDTree-s|
    gs.......Same as s, but leave the cursor on the NERDTree...........|NERDTree-gs|
    <CR>.....User-definable custom open action.......................|NERDTree-<CR>|
    O........Recursively open the selected directory....................|NERDTree-O|
    x........Close the current nodes parent.............................|NERDTree-x|
    X........Recursively close all children of the current node.........|NERDTree-X|
    e........Edit the current directory.................................|NERDTree-e|

    double-click....same as |NERDTree-o|.
    middle-click....same as |NERDTree-i| for files, and |NERDTree-e| for directories.

    D........Delete the current bookmark ...............................|NERDTree-D|

    P........Jump to the root node......................................|NERDTree-P|
    p........Jump to current nodes parent...............................|NERDTree-p|
    K........Jump up inside directories at the current tree depth.......|NERDTree-K|
    J........Jump down inside directories at the current tree depth.....|NERDTree-J|
    <C-J>....Jump down to next sibling of the current directory.......|NERDTree-C-J|
    <C-K>....Jump up to previous sibling of the current directory.....|NERDTree-C-K|

    C........Change the tree root to the selected directory.............|NERDTree-C|
    u........Move the tree root up one directory........................|NERDTree-u|
    U........Same as 'u' except the old root node is left open..........|NERDTree-U|
    r........Recursively refresh the current directory..................|NERDTree-r|
    R........Recursively refresh the current root.......................|NERDTree-R|
    m........Display the NERDTree menu..................................|NERDTree-m|
    cd.......Change the CWD to the directory of the selected node......|NERDTree-cd|
    CD.......Change tree root to the CWD...............................|NERDTree-CD|

    I........Toggle whether hidden files displayed......................|NERDTree-I|
    f........Toggle whether the file filters are used...................|NERDTree-f|
    F........Toggle whether files are displayed.........................|NERDTree-F|
    B........Toggle whether the bookmark table is displayed.............|NERDTree-B|

    q........Close the NERDTree window..................................|NERDTree-q|
    A........Zoom (maximize/minimize) the NERDTree window...............|NERDTree-A|
    ?........Toggle the display of the quick help.......................|NERDTree-?|
    ```
  - Select dir -> `Shift + C` -> go inside directory
  - Press m to launch NERDTree menu inside Vim.
  - [CTRL + W + R](https://stackoverflow.com/questions/47375977/how-to-keep-nerdtree-on-the-left-side) -> Move nerdtree to the left side
  
- [vim-fugitive](https://github.com/tpope/vim-fugitive)  
    - https://irian.to/blogs/vim-fugitive/
    - https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
    - https://dev.to/iggredible/working-with-vim-and-git-4nkh
    
    ```shell script
    :vertical Gstatus
    ```
