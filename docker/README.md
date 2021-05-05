# Virtualization
- https://news.cloud365.vn/kvm-tong-quan-ve-virtualization-va-hypervisor/
- https://bizflycloud.vn/tin-tuc/tong-quan-ve-hypervisor-va-virtualization-20210120095225811.htm
- https://viblo.asia/p/tan-man-ao-hoa-ai-cung-biet-nhung-cu-the-no-la-gi-Do754NV3ZM6

# Overview
https://docs.docker.com/get-started/overview/

# Architecture
https://docs.docker.com/get-started/overview/

https://nickjanetakis.com/blog/understanding-how-the-docker-daemon-and-docker-cli-work-together#it-is-a-client-server-architecture

- Docker components: https://www.youtube.com/watch?v=rOTqprHv1YE&t=5s

# Terms
- [What is the difference between Docker Daemon and Docker Engine?](https://stackoverflow.com/questions/60527336/what-is-the-difference-between-docker-daemon-and-docker-engine/67262061#67262061)
- [What is the difference between Docker Host and Container](https://stackoverflow.com/questions/33307538/what-is-the-difference-between-docker-host-and-container)

- Container Orchestration
    - Container orchestration là các công cụ, dịch vụ dùng để điều phối và quản lý nhiều container sao cho chúng làm việc một cách hiệu quả nhất. Khi người người sử dụng container, nhà nhà sử dụng container, các công ty cũng sử dụng container để deploy một cách rộng rãi hơn thì việc tìm ra một tool quản lý tất cả container trong hệ thống hạ tầng chúng ta có là một vấn đề cấp thiết.

# glossary

- https://docs.docker.com/glossary/
- dangling images
    >A dangling image means that you've created a new build of the image but haven't given it a new name. Think about those old, forgotten images that no one knows what to do with anymore – those are "dangling images".
  > 
- unused images
    > an unused image means that it has not been assigned or is not being used in a container.

- Registry
  >A service responsible for hosting and distributing images. The default registry is the Docker Hub.

- Repository
  >A collection of different docker images with same name, that have different tags.

- Tag
  >An alphanumeric identifier attached to images within a repository (e.g., 14.04 or stable ).
  
#image

docker run -it <image> /bin/sh
> [check if image has all the files](https://stackoverflow.com/questions/44726832/how-to-check-if-the-docker-image-has-all-the-files)

docker inspect <image>
> find default shell in "Cmd".

docker tag <image> <repository>:<tag>
> rename docker
  >> docker tag c7ded1cb37e7 helloworld:latest

# container
- **access container**
    ```shell script
        docker exec -it <container> /bin/sh
    ```
    > -it can replaced by attach: docker exec attach it /bin/bash
    <pre>
    -i, --interactive=true|false
            - Keep STDIN open even if not attached. The default is false.
    
    -t, --tty=true|false
            - Allocate a pseudo-TTY. The default is false.
            - When  set  to true Docker can allocate a pseudo-tty and attach to the standard input of any container. This can be used, for example, to run a throwaway interactive shell. The
           default is false.
            - The -t option is incompatible with a redirection of the docker client standard input.
    </pre>
    
    <pre>
    A tty is essentially a text input output environment aka shell.
    
    The -it flag gives u an interactive tty to the docker container. It is as if you are inside the shell for the docker container.
    
    The stdout for the docker container is piped to your current shell and your input is piped to the docker container.
    </pre>

- **remove exited container**
    ```shell script
    docker rm $(docker ps -q -f status=exited)
    ```
- **show dangling images**
    ```shell script
    docker images -qf "dangling=true"
    ```
- **remove all images without at least one container associated to them.**
    ```shell script
    docker image prune -a 
    ```
- **Add a restart policy to a container that was already created**
    ```shell script
    docker update --restart=always <container>
    ```  
    
# install


## bug
Unsupported config option for services.volumes
>volume needs to be at the same indentation with services

## docker swarm


### docker service

```shell
docker service create	       # Create a new service
docker service inspect	       # Display detailed information on one or more services
docker service logs	       # Fetch the logs of a service or task
docker service ls	       # List services
docker service ps	       # List the tasks of one or more services
docker service rm	       # Remove one or more services
docker service rollback	       # Revert changes to a service’s configuration
docker service scale	       # Scale one or multiple replicated services
docker service update	       # Update a service
```
