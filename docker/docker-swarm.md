## [What's the main advantage of using replicas in Docker Swarm Mode?](https://stackoverflow.com/questions/41449454/whats-the-main-advantage-of-using-replicas-in-docker-swarm-mode)
- > [What Makes a System Highly Available?](https://www.digitalocean.com/community/tutorials/what-is-high-availability)
  > 
  > One of the goals of high availability is to eliminate single points of
  > failure in your infrastructure. A single point of failure is a
  > component of your technology stack that would cause a service
  > interruption if it became unavailable.
  
  ---
  
  Let's take your example of a replica that consists of a single instance. Now let's suppose there is a failure. Docker Swarm will notice that the service failed and restart it. The service restarts, but a restart isn't instant. Let's say the restart takes 5 seconds. For those 5 seconds your service is unavailable. Single point of failure.
  
  What if you had a replica that consists of 3 instances. Now when one of them fails (no service is perfect), Docker Swarm will notice that one of the instances is unavailable and create a new one. During that time you still have 2 healthy instances serving requests. To a user of your service, it appears as if there was no down time. This component is no longer a single point of failure.
  
## Docker service
- [What is the difference between Docker Service and Docker Container?](https://stackoverflow.com/questions/43408493/what-is-the-difference-between-docker-service-and-docker-container)
    - **docker service create** is used to create **instances** (called **tasks**) of that service running in a **cluster** (called **swarm**) of computers (called **nodes**). Those tasks are containers of cource, but not standalone containers. In a sense a service acts as a template when instantiating tasks.

    - Docker run will start a single container.
    - With docker service you manage a group of containers (**from the same image**). You can scale them (start multiple containers) or update them.
  