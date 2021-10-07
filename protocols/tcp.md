## slow-start

- TCP slow start is an algorithm which balances the speed of a network connection. Slow start gradually increases the
  amount of data transmitted until it finds the network’s maximum carrying capacity.


- One of the most common ways to optimize the speed of a connection is to increase the speed of the link (i.e. increase
  the amount of bandwidth). However, any link can become overloaded if a device tries to send out too much data.
  Oversaturating a link is known as congestion, and it can result in slow communications or even data loss.

- Slow start prevents a network from becoming congested by regulating the amount of data that’s sent over it. It
  negotiates the connection between a sender and receiver by defining the amount of data that can be transmitted with
  each packet, and slowly increases the amount of data until the network’s capacity is reached. This ensures that as
  much data is transmitted as possible without clogging the network.