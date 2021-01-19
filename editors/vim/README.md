# Vim Cheatsheet

>Disclaimer: This cheatsheet is summarized from personal experience and other online tutorials. It should not be considered as official advice.

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
u                 # undo
Ctrl + r          # redo
         
                  # https://medium.com/usevim/vim-101-efficient-html-editing-with-text-objects-1571734718e3
dat               # delete <b>a</b> <b>t</b>ag block (HTML)
dit               # delete <b>i</b>nner <b>t</b>ag block (HTML)
</pre>


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

## Working with multiple files
```bash
:e file       # edit a file in a new buffer
:bnext or :bn # go to the next buffer
:bprev or :bp # go to the previous buffer
:bd           # delete a buffer (close a file)
:ls           # list all open buffers
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
