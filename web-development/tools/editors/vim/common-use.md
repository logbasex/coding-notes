## open crontab as vim and comment multi line
```shell
export EDITOR=vi && crontab -e 

# if crontab line start with number, comment it out
# https://unix.stackexchange.com/questions/382208/regex-to-match-beginning-and-end-of-line-in-vim-quote-around-whole-line
:%s/^\([0-9].*\)/#&/
```