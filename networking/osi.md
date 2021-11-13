## OSI model (Open Systems Interconnect)
- http://www.practicalnetworking.net/series/packet-traveling/osi-model/#osi-layer-23
- https://www.reddit.com/r/ccna/comments/3spbm7/osi_stack_how_well_do_you_know_it/

## TCP/IP stack
An IP is basically for the purpose of logical addressing. In easy terms it's a unique id given to each connected device(Different from physical address) for representing the connection.

A TCP is a connection oriented protocol (like telephone). It basically deals with how a packet of data will travel to its destination. The destination of the packet is an IP address.

----- 

Lets think in terms of a Post Office. There is clerk who deals with addressing(and sorting) your drafts and there is a postman who delivers the drafts to the right addresses.

IP is the clerk - deals with addressing of packets like mapping the logical/network address to MAC address.

TCP is the postman which deals with delivering the data packets to various hosts over the internet. It is dependent on the IP. Provides services like Flow control , error detection and correction.

https://www.quora.com/What-is-the-difference-between-TCP-and-IP-protocols

## [TCP ELI5](https://dev.to/ben/explain-tcp-like-im-five)

You and a friend need to share a toy:

1. You ask a friend if he can play with the toy.

2. Your friend asks you if you actually asked him for the toy.

3. You tell your friend that you asked for that toy.

4. He gives you the toy.

----
[How would you explain TCP/IP to your grandmother?](https://www.quora.com/How-would-you-explain-TCP-IP-to-your-grandmother)

I would ask her to imagine taking a 1,000 page letter, numbering the pages, and putting it into 1,000 envelopes and mailing it in 1000 pieces. Then putting it back in order on the other side, and mailing back a request to resend any pieces that were lost in the mail. When she asks why anyone would do that you can explain a little bit about how computers communicate, and the need to split things up into datagrams.

## TCP (Transmission Control Protocol)
- The Transmission Control Protocol (TCP) is a communications standard that enables application programs and computing devices to exchange messages over a network.


# Question

- [Connection without TCP/IP over Internet [closed]](https://stackoverflow.com/questions/29722186/connection-without-tcp-ip-over-internet)
  - **It is possible to connect two computer without tcp/ip over internet?**
  - From the first line of Wikipedia on `Internet`:

    > The Internet is a global system of interconnected computer networks that use the standard Internet protocol suite (TCP/IP) to link several billion devices worldwide.

    The internet is **built upon** the IP framework. You can't "not use" IP through the internet. That's like to say I want to use the post system without addresses. Without the IP framework, there is no way to identify devices from each other or have any standard format to route packets anywhere at all. This is not to say that it is the _only_ way to establish networked communications, it's just the most popular and most used way.

    Regarding the first part of your question: `It is possible to connect two computer without tcp/ip?` There are plenty of ways this is done e.g. Bluetooth, RS-232, proprietary RF communications and so forth.

    Also, towards `competitor of Internet` is that really such a good idea? For once we have one system that is universally compatible with all devices around the globe (almost!). I don't think the rest of the world would be keen on a brand new system unless it is much much much better (in which it'll probably be implemented into the Internet Protocol Suite anyway).

      


## OSI flow

- ### Layer Seven: Application Layer
  - In our url-clicking case, the application is the browser. The browser selects which web server it is sending data to, contacts the server and send the request. When a response is returned, the browser displays the desired content on the web page.
  - HTTP hoạt động ở layer này
  
- ### Layer Six: Presentation Layer
  - Usually a web page contains different formats of data: HTML files, Javascript files, image files, etc. In the presentation layer these files are transformed by Abstract Syntax Notation One into XML format to be displayed on the browser.

- ### Layer Five: Session Layer
  - The session layer controls the connections between two computers by establishing, managing, and terminating sessions. Whenever we visit any website, our computer is creating a session with the web server. In applications that uses Remote Procedure Calls, the session layer is is commonly implemented explicitly.
  
- ### Layer Four: Transport Layer
  - Transmission Control Protocol (TCP) and User Datagram Protocol (UDP) are two of the most well-known protocols in Layer 4.

...

- https://medium.com/@jinghua.shih/networking-the-osi-model-4a508d84444
- https://www.freecodecamp.org/news/osi-model-networking-layers-explained-in-plain-english/
- https://stackoverflow.com/questions/38596488/in-which-layer-is-http-in-the-osi-model
  - ![](https://i.stack.imgur.com/WG5r8.jpg)
  - **HTTP in application layer**
  - ![](https://i1.wp.com/cybermaohi.com/iT3k/wp-content/uploads/2015/01/osi.gif)  
- http://cybermaohi.com/iT3k/2015/the-7-layers-of-the-osi-model/    

## Network Topology
  - [Why is it called network “topology”? Why not network “graph”?](https://softwareengineering.stackexchange.com/questions/307189/why-is-it-called-network-topology-why-not-network-graph)
    - Topology is the study of fundamental properties that exist no matter the arrangement of elements (for example the ratio of points, edges and faces in a polygon that does not change as you add or reduce points).
    - This term fits networks well because what you are looking for with network topology is the different arrangements of the network to perform the same function, with the goal being to produce the simplest configuration that you can to perform the task (thus eliminating waste)
    - A graph has a much more limited definition in mathematics and is not really about discovering the fundamental properties of arrangements.
