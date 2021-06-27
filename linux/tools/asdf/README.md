## Introduction
- The final (?) package manager
- Tutorial: https://dev.to/video/asdf-the-final-version-manager-19am

## [Install](https://asdf-vm.com/#/core-manage-asdf?id=install)
- Bashscript
    ```shell
    #!/bin/bash -ex

    if [ ! -d ~/.asdf ]
    then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    fi

    cd ~/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"

    config=.$(echo $SHELL | rev | cut -d/ -f1 | rev)rc

    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/$config
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/$config   
    ```

- asdf can install via zsh plugin.  
