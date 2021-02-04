# terms
- dangling images
    >A dangling image means that you've created a new build of the image but haven't given it a new name. Think about those old, forgotten images that no one knows what to do with anymore – those are "dangling images".
  > 
- unused images
    > an unused image means that it has not been assigned or is not being used in a container.

#image

docker run -it <image> /bin/sh
> [check if image has all the files](https://stackoverflow.com/questions/44726832/how-to-check-if-the-docker-image-has-all-the-files)

docker inspect <image>
> find default shell in "Cmd".

docker tag <image> <repository>:<tag>
> rename docker
  >> docker tag c7ded1cb37e7 helloworld:latest

# access container

docker exec -it <container> /bin/sh
> -it can replaced by attach: docker exec attach it /bin/bash
<pre>
-i, --interactive=true|false
Keep STDIN open even if not attached. The default is false.
</pre>
<pre>
-t, --tty=true|false
          Allocate a pseudo-TTY. The default is false.

       When  set  to true Docker can allocate a pseudo-tty and attach to the standard input of any container. This can be used, for example, to run a throwaway interactive shell. The
       default is false.

       The -t option is incompatible with a redirection of the docker client standard input.
</pre>

<pre>
A tty is essentially a text input output environment aka shell.

The -ti flag gives u an interactive tty to the docker container. It is as if you are inside the shell for the docker container.

The stdout for the docker container is piped to your current shell and your input is piped to the docker container.
</pre>

- remove exited container
  > docker rm $(docker ps -q -f status=exited)
  > 
- show dangling images
  > docker images -qf "dangling=true"
  > 
- remove all images without at least one container associated to them.
  > docker image prune -a 

# install
- [elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/7.5/docker.html)


## bug
Unsupported config option for services.volumes
>volumes needs to be at the same indentation with services

