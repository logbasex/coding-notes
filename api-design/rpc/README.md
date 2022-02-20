## [Little GRPC History](https://dev.to/nixon1333/little-grpc-history-3271)

### Problem:
There are so many client server protocol exits. Like, http/1, http/2, tcp/ip etc. These are the basic protocols which are used to communicate between multiple servers to server, server to client, client to client. But they are not languages agnostic. Their implementation of each programming language is very different. Plus there are so many libraries to support. If one protocol is being changed the whole supported library needs to adapt that feature and update the library. And the consumer also needs to adapt the libraries too.

### Solution:
So the gRPC solves the loads of client libraries for different protocols, different types of languages.

- One client side library for all languages. No need to change all libraries for new changes like before. It has a generator which will generate client side libraries for all types of major languages.
- It’s using http/2 under the hood. So no need to add new codes to adapt the changes for converting http/1 to http/2. Or in future if the protocol is being changed to http/3, it will be the same too for the client side.
- The messaging format is using protobuf or protocol buffers. So any client with supported grpc client libraries can communicate with each other


## [Understanding gRPC](https://betterprogramming.pub/understanding-grpc-60737b23e79e)
RPC stands for Remote Procedure Call. As the name suggests, the idea is that we can invoke a function/method on a remote server. RPC protocol allows one to get the result for a problem in the same format regardless of where it is executed. It can be local or in a remote server using better resources.

RPC is a much older protocol than REST. It has been used since the time of ARPANET in the 1970s to perform network operations. The term RPC was first coined by Bruce Jay Nelson in 1981. But as we are going to see, RPC is still relevant and implemented in API-based modern applications in different ways.

The idea is the same. An API is built by defining public methods. Then the methods are called with arguments. RPC is just a bunch of functions, but in the context of an HTTP API, it entails putting the method in the URL and the arguments in the query string or body.

RPC APIs will be using something like POST /deleteResource with a body of { “id”: 1 } instead of the REST approach, which would be DELETE /resource/1.

RPC is very popular for IoT devices and other solutions requiring custom contracted communications for low-power devices, as much of the computation operations can be offloaded to another device. Traditionally, RPC can be implemented as RPC-XML and RPC-JSON.

gRPC is the latest framework to be created on the RPC protocol. It makes use of its advantages and tries to correct the issues of traditional RPC.

## [Giới thiệu về RPC](https://zalopay-oss.github.io/go-advanced/ch3-rpc/ch3-01-rpc-go.html)

Remote Procedure Call (RPC) là phương pháp gọi hàm từ một máy tính ở xa để lấy về kết quả. Trong lịch sử phát triển của Internet, RPC đã trở thành một cơ sở hạ tầng không thể thiếu cũng giống như là IPC (Inter Process Communication).

![](https://zalopay-oss.github.io/go-advanced/images/ch3-1-operating-system-remote-call-procedure-working.png)

## [gRPC là gì? Vũ khí tối thượng tăng tải Microservices](https://viblo.asia/p/grpc-la-gi-vu-khi-toi-thuong-tang-tai-microservices-ORNZqnqel0n)