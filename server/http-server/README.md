- [Nginx vs Apache comparison](https://serverguy.com/comparison/apache-vs-nginx/#4)
- [Basic](https://medium.com/devopscurry/what-is-nginx-understanding-the-basics-of-nginx-in-2021-f8ee0f3d3d54)
- [Detail Nginx (Engine X) and Apache comparison](https://developpaper.com/web-server-king-apache-vs-nginx/)
- Nginx came to existence because C10k problem (handle 10k request concurrently).
- Put simply, **[Apache uses a forked threaded solution](https://code.tutsplus.com/tutorials/apache-vs-nginx-pros-cons-for-wordpress--cms-28540)**, or keep-alive, which keeps a connection open to each user.

  On the other hand, **Nginx uses a non-blocking event loop**, which pools connections working asynchronously via worker processes. 

  Because of this architecture, the result is a single-threaded nginx process, and additional processes are not spawned to handle each new connection. So even at times of a high load, the CPU and RAM don't get caned in this approach.

- [Multithreaded server vs single-threaded server](https://www.quora.com/Why-is-a-multithreaded-web-server-better-than-a-single-thread-server)