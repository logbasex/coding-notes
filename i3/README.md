## Config
- Tutorial
    - https://github.com/addy-dclxvi/i3-starterpack
    - https://kifarunix.com/install-and-setup-i3-windows-manager-on-ubuntu-20-04/
- location: `~/.config/i3`

- [swap the Alt and Super keys](https://www.reddit.com/r/i3wm/comments/bakkpg/can_i_completely_swap_the_alt_and_super_keys/)
    ```
    setxkbmap -option altwin:swap_alt_win

    config file -> add: set $mod Mod4
    ```
- Default terminal: `bindsym $mod+Return exec kitty`


## Controlling i3

<pre>
# Reload i3
$mode+Shift+r

# Exit i3
$mode+Shift+e

</pre>

## Manage Windows
<pre>
# Kill current window
$mode+Shift+q

# Move current window to workspace number <i>num</i>
$mode+Shift+<i>num</i>

# Set window to floating mode
$mode+Shift+f

# Focus on window to the left
$mod+j

# Focus on window to the right
$mod+;

# Focus on window above
$mod+k

# Focus on window below
$mod+l

# Move window left
$mod+Shift+j

# Move window right
$mod+Shift+;

# Move window up
$mod+Shift+k

# Move window down
$mod+Shift+l
</pre>

## Containers

<pre>
# Default container
$mod+e

# https://www.reddit.com/r/i3wm/comments/ek4urs/xubuntu_i3_cannot_split_windows/
# Horizontal split container
$mod+h

# Vertical split container
$mod+v

# Tabbed container
$mod+w

# Toggle fullscreen mode
$mod+f

# Toggle stacking mode
$mod+s

# Toggle floating mode
$mod+Shift+Space

# Full screen
$mod+f    

</pre>

## Application

<pre>
# Open terminal
$mod+Enter

# Open dmenu
$mod+d
</pre>
