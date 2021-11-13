[Network socket](https://en.wikipedia.org/wiki/Network_socket)

-------
[Is http based on socket?](https://stackoverflow.com/questions/38650547/is-http-based-on-socket)

HTTP is an application protocol, Socket is an operating system API. This means HTTP can not be based on sockets the same as cars are not based on gasoline.

Relationship between Socket and HTTP:

Sockets can be used to implement a HTTP server/client since sockets can be used to implement any kind of TCP server/client and HTTP is an application layer protocol on top of TCP.
But note that sockets are not essential to implement HTTP, i.e. you could use any other kind of API which manages to send network packets to implement it.

--------
[A socket is an endpoint. It exists before a connection is established (TCP), or in the absence of a connection (UDP)](https://stackoverflow.com/questions/152457/what-is-the-difference-between-a-port-and-a-socket)


---------

[[Networking] Socket hoạt động như thế nào ?](https://viblo.asia/p/networking-socket-hoat-dong-nhu-the-nao-aWj53LxYK6m)

--------


[Socket is layer 5 protocol (Session) in OSI Model and is not dependent on underlying layers which means it can be over TCP, UDP, MPTCP, ... (Layer 4 - Transport layer protocols). Socket connection is used for continues exchange of data between nodes (it creates a session between them) but TCP connection makes a reliable transmission of data segments between nodes.](https://stackoverflow.com/questions/6419811/any-difference-between-socket-connection-and-tcp-connection)