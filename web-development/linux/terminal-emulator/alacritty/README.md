## Install

- https://github.com/alacritty/alacritty 
```
sudo snap install alacritty --classic
```

## Edit config

- Get alacritty version
```
alacritty -h
```

- Download alacritty config (alacritty.yml) according to alacritty version to `~/.config/alacritty`, create that folder if not exits.
    - https://github.com/alacritty/alacritty/releases

- Edit font size
    - [Simply put WINIT_X11_SCALE_FACTOR: "1.0" under env: section of your default alacritty.yml config.](https://github.com/alacritty/alacritty/issues/1501#issuecomment-614867213)
