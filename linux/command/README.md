## List of commands in Linux

  <pre>
  compgen          # compgen is bash built-in command and it will show all available commands, aliases, and functions for you
      compgen -c      # List all available command in Linux
      compgen -b      # List all builtin command in Linux (https://www.cyberciti.biz/faq/linux-unix-bash-shell-list-all-builtin-commands/)

  alias            # prints the list of aliases in the reusable form 'alias NAME=VALUE' on standard output.
  </pre>

groups            # print the groups a user is in

## Build in commands

-  Overview
    ```shell
     man bash
    ```

- Get help of specific command
    ```shell
    [command] --help (Eg: set --help or help set)
    ```

- Notes
  > [double dash](https://unix.stackexchange.com/questions/11376/what-does-double-dash-mean) (--) signify the end of the options.

## APT command
- Ubuntu 16.04 introduced apt commands, simply put, apt is a collection of most common used command options from `apt-get` and `apt-cache`.

- Check version of package
  ```shell
  [package] -v
   
  [package] --version
   
  apt/apt-cache show [package]
  ```
## Kill process
- pgrep (find or signal process by name)
  ```shell
  pgrep mongo
  ```
- kill port using `npx` (tool for execute `Node` package) and npm package `kill-port` 
  ```shell
   npx kill-port 27017
  ```
  
- netstat (network statistic tool)
  ```shell
  sudo kill -9 $(sudo netstat --listening --program --numeric --tcp \
  | grep "27017" \
  | awk '{print $7}' \
  | awk -F/ '{print $1}')  

  sudo netstat -lpnt      -   list network statistic include port number of all TCP connections.
  grep "27017"            -   filter process using port 27017
  awk '{print $7}'       -  get process id and name
  awk -F/ '{print $1}'   -   get process id
  ```
- lsof (list open files)
  ```shell
  sudo kill -9 $(sudo lsof -t -i:27017)
  
  -t       - show only process ID
  -i       - show only internet connections related process
  :27017   - show only processes in this port number
  ```


## ls (List directory content)
- List with line number
  ```shell
  ls | nl 
  ls | cat -n 
  ```


## rm (Remove files or directories)
- Remove all subdirectories
  ```shell
  rm -R -- */
  ```