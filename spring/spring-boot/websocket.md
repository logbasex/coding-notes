- ### [Flow of message](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html#websocket-stomp-message-flow)

    ![](https://docs.spring.io/spring-framework/docs/current/reference/html/images/message-flow-simple-broker.png)


- ### [Enable STOMP](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html#websocket-stomp-enable)

![](https://i.imgur.com/mA79YAc.png)


- ### [STOMP vs Websocket](https://stackoverflow.com/questions/40988030/what-is-the-difference-between-websocket-and-stomp-protocols)
    - The **WebSocket** protocol defines two types of messages **(text and binary)**, but their content is undefined.

      **STOMP** protocol defines a mechanism for client and server to negotiate a sub-protocol (that is, a higher-level
      messaging protocol) to use on top of **WebSocket** to define following things:

        - what kind of messages each can send,
        - what the format is,
        - the content of each message, and so on.

      The use of a sub-protocol is optional but, either way, the client and the server need to agree on some protocol
      that defines message content.

- **STOMP**: subprotocol

- ### [Protocol upgrade mechanism](https://developer.mozilla.org/en-US/docs/Web/HTTP/Protocol_upgrade_mechanism)
    - The HTTP/1.1 protocol provides a special mechanism that can be used to upgrade an already established connection
      to a different protocol, using the Upgrade header field.
    - Note also that HTTP/2 explicitly disallows the use of this mechanism; it is specific to HTTP/1.1.

- ### [How Websockets are implemented?](https://stackoverflow.com/questions/34730334/how-websockets-are-implemented)

    - Client makes HTTP request to server with "upgrade" header on the request
    - If server agrees to the upgrade, then client and server exchange some security credentials and the protocol on the
      existing TCP socket is switched from HTTP to webSocket.
    - There is now a lasting open TCP socket connecting client and server.
    - Either side can send data on this open socket at any time.
    - All data must be sent in a very specific webSocket packet format.

- ### Overview
    - https://vietnix.vn/websocket-la-gi/

- ![](https://46c4ts1tskv22sdav81j9c69-wpengine.netdna-ssl.com/wp-content/uploads/2016/02/1_httpvswebsocket-614x1024.png)
- https://blogs.windows.com/windowsdeveloper/2016/03/14/when-to-use-a-http-call-instead-of-a-websocket-or-http-2-0/

- ### [How websockets can be faster than a simple HTTP request?](https://stackoverflow.com/questions/19169427/how-websockets-can-be-faster-than-a-simple-http-request)
    - [Data can be sent either way very efficiently. Because the connection is already established and a webSocket data frame is very efficiently organized (mostly 6 extra bytes, 2 bytes for header and 4 bytes for Mask), one can send data a lot more efficiently than via a HTTP request that necessarily contains headers, cookies etc..](https://stackoverflow.com/questions/44898882/why-to-use-websocket-and-what-is-the-advantage-of-using-it)

- Low latency
    - Low latency means that there is very little delay between the time you request something and the time you get a
      response. As it applies to webSockets, it just means that data can be sent quicker (particularly over slow links)
      because the connection has already been established so no extra packet roundtrips are required to establish the
      TCP connection.

- ![https://medium.com/platform-engineer/web-api-design-35df8167460](https://miro.medium.com/max/2095/1*n-GZzsTgvpoGQ_t_SCkJdw.png)