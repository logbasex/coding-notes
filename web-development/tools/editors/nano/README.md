## Docs
- https://www.cheatsheet.wtf/Nano/
## Cut, paste

To cut and paste text in nano:

1. nano hairyspiders

    At the shell prompt, type nano followed by the name of the file to edit.

2. Move the cursor to the first line of the text you want to cut.
3. `Ctrl + ^`

    Press `Ctrl + ^` to mark the beginning of the text you want to cut. (Note that `Ctrl + ^` is really `Ctrl + Shift + 6`— it might work without `Shift`, but it might not, depending on your terminal program. Try it out and see what happens.)

4. Use the arrow keys to move the cursor to the end of the text you want to cut.

    Note that the text gets highlighted as you select it.

5. `Ctrl + K`

    This “kuts” the text.

6. Using the arrow keys, move the cursor to where you want to insert the cut text.
7. `CTRL + U`
   Use this key combination to paste the cut text into the file at the new location.

## Undo, redo
Undo: `M-U` -> `Alt + U`

Redo: `M-E` -> `Alt + E`

## Line number
Show line number: `Alt + #` -> `Alt + Shift + 3`

Goto line number: `Ctrl + _`

## [Cursor movement](https://linuxhint.com/move_cursor_nano/)
Forward a screen: `Ctrl + V`

Backward a screen: `Ctrl + Y`

Beginning of line: `Ctrl + A`

End of line: `Ctrl + E`