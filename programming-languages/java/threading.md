## [How Java thread maps to OS thread?](https://medium.com/@unmeshvjoshi/how-java-thread-maps-to-os-thread-e280a9fb2e06)

## How jvm threads communicate with underlying OS threads?
- https://www.quora.com/How-jvm-threads-communicate-with-underlying-OS-threads
- https://www.quora.com/How-lightweight-are-Java-threads

## [Green Threads vs Non Green Threads](https://stackoverflow.com/questions/5713142/green-threads-vs-non-green-threads?noredirect=1&lq=1)

**JAVA Multi-Threading is implemented by two models:**

1. Green Thread Model
2. Native OS Model

**Green Thread Model**: The Thread which is managed by JVM, without taking underlying OS support is called Green Thread. Very few OS like Sun Solaris provide support for green thread model. It is deprecated and not recommended to use.

**Native OS Model**: The Thread which is manged by the JVM with the help of underlying OS is called Native OS Model. All windows OS provide support for native OS model.

## [What is the difference between normal thread and daemon thread in JVM?](https://www.quora.com/What-is-the-difference-between-normal-thread-and-daemon-thread-in-JVM)
JVM has 2 types of threads i.e. Daemon & Non-Daemon. Daemon threads are generally started by the JVM itself for background tasks such as Garbage Collection and Non-Daemon (normal) threads are started by the application user to achieve multi-tasking. Eg. Main thread is a Non-Daemon thread.

Though the threads started by user are Non-Daemon but user can create Daemon threads as well by setting the setDaemon(boolean) api of thread class.

Key differences between Daemon & Non-Daemon threads is that JVM will not exit untill all the Non-Daemon thread have been terminated. Daemon threads can't stop JVM from shutting. In simple words JVM will shut down when all Non-Daemon threads had terminated.
    
------------

## [Does a multithreaded program run faster than a program with just a single thread?](https://www.quora.com/Does-a-multithreaded-program-run-faster-than-a-program-with-just-a-single-thread)
- Running on a single processor, the multi-threaded program would run slower - there are only so many machine cycles available, and the thread scheduler imposes overhead.

- Running on multiple processors, a multi-threaded program might run faster, or it might not. It is not easy to write code that takes advantage of multiple processors, and for some problems it is impossible.


## [How does multi-threading work in Java?](https://www.quora.com/How-does-multi-threading-work-in-Java)
It works by:

- Allowing a program with multiple threads to run on multiple CPUs if they are available at the same time.
- using context switching to stop one thread and start Another to give the appearance of threads running to the same time.
- Java has a memory model which provided guarantees which allow threads to co-ordinate work.

## [Parallel coding Vs Multithreading (on single cpu)](https://stackoverflow.com/questions/1073098/parallel-coding-vs-multithreading-on-single-cpu)

https://dev.to/kwereutosu/multi-threading-and-parallel-programming-1l9m

Parallel coding is the concept of executing multiple actions in parallel(Same time).

### Multi-threaded Programming on a Single Processor

Multi-threading on a single processor gives the illusion of running in parallel. Behind the scenes, the processor is switching between threads depending on how threads have been prioritized.

### Multi-threaded Programming on Multiple Processors

Multi-threading on multiple processor cores is truly parallel. Each microprocessor is running a single thread. Consequently, there are multiple parallel, concurrent tasks happening at once.

## [Threading vs Parallelism, how do they differ?](https://stackoverflow.com/questions/806499/threading-vs-parallelism-how-do-they-differ)
There are two different kinds of concurrency:

- Threading: CPU switches between different threads really fast, giving a falsehood of concurrency. Keypoint: **only one thread is running at any given time**. When one thread is running, others are blocked. You might think, how is this any useful than just running procedurally? Well, think of it as a priority queue. Threads can be scheduled. CPU scheduler can give each thread a certain amount of time to run, pause them, pass data to other threads, then give them different priorities to run at a later time. It's a must for **not instant running processes that interact with each other**. It's used in servers extensively: thousands of clients can request something at the same time, then getting what they requested at a later time (If done procedurally, only one client can be served at a time). **Philosophy: do different things together**. It doesn't reduce the total time (moot point for server, because one client doesn't care other clients' total requests).
- Parallelism: threads are running parallel, usually in different CPU core, true concurrency. Keypoint: **multiple threads are running at any given time**. It's useful for heavy computations, super long running processes. Same thing with a fleet of single core machines, split data into sections for each machine to compute, pool them together at the end. Different machines/cores are hard to interact with each other. **Philosophy: do one thing in less time**.

## [Is parallel programming == multithread programming?](https://stackoverflow.com/questions/2287695/is-parallel-programming-multithread-programming)

- No. **multi-thread programming means that you have a single process, and this process generates a bunch of threads**. All the threads are running at the same time, but they are all under the same process space: they can access the same memory, have the same open file descriptors, and so on.
- Multithreaded programming is parallel, but parallel programming is not necessarily multithreaded.
**Unless the multithreading occurs on a single core, in which case it is only concurrent**.


## [Real life example](https://www.quora.com/What-are-some-real-life-examples-of-multi-threading-as-we-study-in-Java)

The main purpose of multithreading is to provide simultaneous execution of two or more parts of a program that can run concurrently.

Threads are independent. If an exception occurs in one thread, it doesn’t affect the others.

[Some multithreaded applications would be](https://www.quora.com/What-are-some-best-examples-of-multithreaded-applications):

- Web Browsers - A web browser can download any number of files and web pages (multiple tabs) at the same time and still lets you continue browsing. If a particular web page cannot be downloaded, that is not going to stop the web browser from downloading other web pages.
- Web Servers - A threaded web server handles each request with a new thread. There is a thread pool and every time a new request comes in, it is assigned to a thread from the thread pool.
- Computer Games - You have various objects like cars, humans, birds which are implemented as separate threads. Also playing the background music at the same time as playing the game is an example of multithreading.
- Text Editors - When you are typing in an editor, spell-checking, formatting of text and saving the text are done concurrently by multiple threads. The same applies for Word processors also.
- IDE - IDEs like Android Studio run multiple threads at the same time. You can open multiple programs at the same time. It also gives suggestions on the completion of a command which is a separate thread.

## [If a computer has only one CPU, do multi-threaded programs provide any performance improvements over single-threaded programs?](https://www.quora.com/If-a-computer-has-only-one-CPU-do-multi-threaded-programs-provide-any-performance-improvements-over-single-threaded-programs)
As you must be knowing that the multi-threading “in a single core system” is just time-interleaved multiple tasks (or threads) running together with context switching between one another during their run on a processor.

*Note: In a multi-core system, different threads become different processes running in parallel in multiple cores, where threads running on the same core only experience the time-slicing.*

This implies:

1. Only one thread runs at a time, but it does not run till it completes.
2. Multiple threads are in the waitlist (pool) and are waiting to execute (to be scheduled) by a thread scheduler.
Now the questions comes, does this help speed up the program?

Let’s have a look at the following scenarios:

**A)** 2 tasks consuming 6 seconds each without multithreading, running serially:

- start -> task1 (6s) -> task2 (6s)
- total time = 12 secs

**B)** We can schedule similar tasks in a multithreaded environment with 2 sec provided to each by the scheduler (considering context switching time to be negligible and fair scheduling)

- start -> task1 (2s) -> task2 (2s) -> task1 (2s) -> task2 (2s) -> task1 (2s) -> task2 (2)
- total time = 12 sec
- considering some context switching time we get total time > 12 sec!

Now why do we use multithreading when it may take more time than what a single threaded program can offer?

To answer, let’s revisit the scenario B again:

We assumed there that the each task takes 6 seconds **in the CPU**, meaning that each task is “**pure computation**” and need at-least 6 seconds to complete. In this case, on a single core system, a single threaded program would yield better results.

But things get interesting when we’re running a program doing a lot of I/O or network bound processing (very common in web-applications) where the entire process is not happening in the CPU.

**B-extended**: consider each task request some resource from I/O which takes 4 seconds out of their 6 seconds running time.

```
x = requestResource()	// takes 4 secondsprocess(x) 				
// takes 2 seconds
```

- start -> task1(2s, requested resource) -> task2(2s, requested resource) -> task1 (result received, 2s) -> task2(result received, 2s) (sau khi task2 request resource thì task1 đã có data và xử lý tiếp mất 2s...)
- total time = 8 secs
- considering 1 sec context switching time (3 context-switches) = 11 secs, still better than single threaded program!
- [While some part of the program waits for I/O, other part can still use the CPU, and/or you can concurrently wait for I/O.](https://www.quora.com/What-is-the-benefit-of-using-asynchronous-programming-on-a-single-core-machine)


PS: The arbitrary values taken are just for demostration purpose, considering that I/O or network bound processes takes more amount of time in relative terms, which is quite true.