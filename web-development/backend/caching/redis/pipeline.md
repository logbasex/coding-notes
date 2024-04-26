## References
- [Redis: Pipelining, Transactions and Lua Scripts](https://rafaeleyng.github.io/redis-pipelining-transactions-and-lua-scripts)

=====
=====

> Redis offers 3 ways of grouping commands: pipelining, transactions and Lua scripts. The subtleties of using one instead of the other are explored on this post, in terms of the benefits they present, their limitations and atomicity.


## Why Redis Pipeline is not atomic

Redis operates on a single-threaded model, meaning that commands are processed one at a time. While each individual command is atomic—executed fully without interruption—the order in which they are processed can vary, especially with multiple clients sending pipelines.

Here’s a deeper look at why Redis pipelining isn’t inherently atomic:

1. **Multiple Clients**:
    - Redis is designed to handle many clients concurrently. When clients send pipelined commands, Redis treats each pipeline as a separate batch. However, because it's single-threaded, it can switch between processing batches from different clients. This interleaving means that, even if one client sends a series of pipelined commands, another client's pipeline can get processed in between, disrupting the expected sequence of operations.

2. **Command Queuing and Latency**:
    - Redis processes commands sequentially, but certain commands can take longer to execute than others. For example, commands involving large data sets or complex computations (like `SORT` or `ZRANGEBYSCORE`) may have higher latency. If a high-latency command is encountered within a pipeline, it could delay the rest of the commands, allowing Redis to process commands from other client pipelines first.

3. **Redis’s Single Execution Queue**:
    - Although Redis operates with a single execution queue, it's shared across all clients. This means that when commands are added to the queue, there's no guarantee that they'll be processed in strict order, especially when multiple pipelines are involved. This shared queue also explains why a single-threaded Redis server can handle high throughput; the lack of context switching overhead enables quick processing, but at the cost of deterministic order when multiple pipelines are involved.

4. **Command Interleaving**:
    - Because Redis can switch between client pipelines, the exact sequence of operations can become unpredictable. This interleaving occurs because Redis can dequeue commands from different clients based on its internal scheduling, leading to situations where commands from one pipeline are interleaved with those from another.

In summary, Redis pipelining can be non-atomic due to its handling of multiple client pipelines, the potential for high-latency commands, and the single-threaded execution model that allows for interleaving of commands across pipelines. This non-atomic nature requires careful design and coordination to ensure consistent behavior when multiple clients are interacting with Redis simultaneously.