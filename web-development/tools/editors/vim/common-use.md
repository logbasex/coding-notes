## open crontab as vim and comment multi line
```shell
export EDITOR=vi && crontab -e 

# if crontab line start with number or *, comment it out
# https://unix.stackexchange.com/questions/382208/regex-to-match-beginning-and-end-of-line-in-vim-quote-around-whole-line
:%s/^\([0-9|*].*\)/#&/

## uncomment
%s/^#\([0-9|*].*\)/\1/
```

### Comment
- ![vim-crontab-comment](https://user-images.githubusercontent.com/22516811/163707745-f8543801-c665-49fe-b006-2dd29986ada7.gif)

### Uncomment
- ![vim-crontab-uncomment](https://user-images.githubusercontent.com/22516811/163707711-7dfa4039-6ac2-4739-97cd-265e2b0a608d.gif)

