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

      

