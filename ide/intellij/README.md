## Command line launcher

- In linux, it reside in `~/bin` folder
- Config here [here](https://stackoverflow.com/questions/26879172/how-to-open-webstorm-from-terminai) and [here](https://blog.jetbrains.com/blog/2018/08/23/toolbox-app-1-11-whats-new/)


## Navigate

<pre>
ctrl+shift+m                  # moving between bracket/parenthesis
</pre>

## See the port of all spring boot services

Help -> Find Action (ctrl + shift + a) -> Run Dashboard -> Click add service -> select spring boot

![](https://s3-ap-southeast-1.amazonaws.com/logbasex.github.io/intellij-run-dashboard.png)

## Git double click checkout

File -> Settings -> Keymap -> Search -> Checkout Selected -> Add mouse shortcut -> Double Click

![](https://s3-ap-southeast-1.amazonaws.com/logbasex.github.io/intellij-git-checkout-branch.png)

![](https://s3-ap-southeast-1.amazonaws.com/logbasex.github.io/intellij-git-double-click-checkout.png) 

## IntelliJ shows decompiled .class file instead of source code

Because your source path is empty (File -> Project Structure)

![](https://s3-ap-southeast-1.amazonaws.com/logbasex.github.io/intellij-sdk-source-path-empty.png)

Download and select which one has source path

![](https://s3-ap-southeast-1.amazonaws.com/logbasex.github.io/intellij-project-sdk.png)

Further reading here: https://stackoverflow.com/questions/49558009/intellij-shows-decompiled-class-file-instead-of-source-code


## Replace empty line 
```regexp
^(?:[\t ]*(?:\r?\n|\r)){1,}
```


## Convention

Package's name cannot use reserve word (like enum, class) 
