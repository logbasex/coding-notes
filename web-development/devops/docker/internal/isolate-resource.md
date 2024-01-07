## Reference
- [Linux Containers (LXC)](https://lass.cs.umass.edu/~shenoy/courses/spring16/lectures/Lec06.pdf)
- https://faun.pub/kubernetes-story-linux-namespaces-and-cgroups-what-are-containers-made-from-d544ac9bd622
- https://www.alibabacloud.com/blog/getting-started-with-kubernetes-%7C-further-analysis-of-linux-containers_596290
- https://blog.kubesimplify.com/understanding-how-containers-work-behind-the-scenes

![image](https://gist.github.com/assets/22516811/33954513-6862-4138-a0ff-4f4fe6c70d12)
![image](https://gist.github.com/assets/22516811/03345bb4-d61c-4a9f-9282-f63128639ac2)

## [Introduction](https://www.baeldung.com/linux/cgroups-and-namespaces)

**cgroups** and **namespaces** are powerful tools for managing resources and isolating processes in Linux systems. They play a crucial role in system administration and containerization. 

> **cgroups**, short for control groups, allow administrators to limit and distribute resources among different groups of processes.

> **Namespaces**, on the other hand, create isolated environments for processes, separating them from the host system and other processes. Together, they provide a robust solution for resource management and isolation.
> 

## cgroups

cgroups, or control groups, are a Linux kernel feature that **enables the management and limitation of system resources like CPU, memory, and network bandwidth**, among others. 

## Namespaces

Namespaces are a Linux kernel feature that isolates various aspects of a process. **They provide a process with its own isolated view of the system, such as its own file system, network, hostname, and more.** 

