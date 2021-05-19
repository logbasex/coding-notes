## Config
- Tutorial
    - https://github.com/addy-dclxvi/i3-starterpack
    - https://kifarunix.com/install-and-setup-i3-windows-manager-on-ubuntu-20-04/
- location: `~/.config/i3`

- `i3`: copy `/etc/i3/config` to `~/.config/i3`
- `i3status`: copy `/etc/i3status.conf` to `~/.config/i3status` and rename `i3status.conf` to `config`
    ```
    dpkg -L i3status          #list all files of the i3status package
    $mod + shift + r          #reload i3status config
    ```
- [swap the Alt and Super keys](https://www.reddit.com/r/i3wm/comments/bakkpg/can_i_completely_swap_the_alt_and_super_keys/)
    ```
    setxkbmap -option altwin:swap_alt_win

    config file -> https://www.reddit.com/r/i3wm/comments/9r4brm/changing_mod1_to_mod4_tedious/
    ```
- Default terminal: `bindsym $mod+Return exec kitty`
- [i3, i3bar, i3status](https://www.reddit.com/r/i3wm/wiki/faq/i3i3bari3status)
- [Debug i3](https://i3wm.org/docs/debugging.html)

- [Brightness](https://stackoverflow.com/questions/25588367/how-to-control-backlight-by-terminal-command)
    ```
    sudo apt install xbacklight
    
    - ~/.config/i3/config
    bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
    bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness
    ```

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


# change order of window in one workspace
$mod+shift+left/right
</pre>


## Containers

<pre>
# default (splith/splitv), repeat to toggle splith/splitv
$mod+e

# https://www.reddit.com/r/i3wm/comments/ek4urs/xubuntu_i3_cannot_split_windows/
# Horizontal split container
$mod+h

# Vertical split container
$mod+v

# Tabbed container mode
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

- Undo split container
    - I don't know if this is helpful or not, but, on a node that has either a vertical or horizontal preselected split, if you attempt to move it left or right, it clears the split instead of moving it.
    - https://www.reddit.com/r/i3wm/comments/enl5to/is_there_a_way_to_undo_a_split_intention/


## Application

<pre>
# Open terminal
$mod+Enter

# Open dmenu
$mod+d
</pre>
