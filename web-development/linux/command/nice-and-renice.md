`nice` launches a new command with a modified nice level (lower priority than it would have otherwise had, or higher priority if you have permission). You specify which command to launch by providing it as an argument to `nice` itself. `nice` actually `exec`s that command, so `nice` itself doesn't terminate until the command does.

`renice` changes the priority of an existing running process, then terminates immediately. You specify which process by giving its PID (as well as the new desired nice level) as an argument to `renice`.

Note also that `nice` takes a *relative* nice level (i.e. less or more than before) whereas `renice` requires an *absolute* level.


https://unix.stackexchange.com/questions/266346/what-is-the-difference-between-nice-and-renice

-----
 Must read

- https://medium.com/@chetaniam/a-brief-guide-to-priority-and-nice-values-in-the-linux-ecosystem-fb39e49815e0

-----

https://bytexd.com/nice-and-renice-commands/
