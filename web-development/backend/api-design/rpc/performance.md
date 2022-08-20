## [Unary vs Stream benchmark](https://stackoverflow.com/questions/47971020/unary-vs-stream-benchmark)
> Sending unary almost always faster. Use streaming to send big files.
> 
> Unless you expect to have very large files that will be processed asynchronously (line by line), unary must be the right choice.

Use streams when
1. **You would otherwise need a polling** e.g. notifications, listening for events, sending data followed by deltas
2. **Transactions** i.e lots of serial calls that must be served by a single server
3. **A large call that can be broken down into multiple smaller request** e.g. file upload, text to speech translation

## [Grpc vs Rest benchmark](https://github.com/logbasex/a-little-bit-about-spring/tree/master/grpc-benchmark)

## [Is gRPC(HTTP/2) faster than REST with HTTP/2?](https://stackoverflow.com/questions/44877606/is-grpchttp-2-faster-than-rest-with-http-2)