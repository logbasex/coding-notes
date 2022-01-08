## [Does a multithreaded program run faster than a program with just a single thread?](https://www.quora.com/Does-a-multithreaded-program-run-faster-than-a-program-with-just-a-single-thread)
- Running on a single processor, the multi-threaded program would run slower - there are only so many machine cycles available, and the thread scheduler imposes overhead.

- Running on multiple processors, a multi-threaded program might run faster, or it might not. It is not easy to write code that takes advantage of multiple processors, and for some problems it is impossible.


## [How does multi-threading work in Java?](https://www.quora.com/How-does-multi-threading-work-in-Java)
It works by:

- Allowing a program with multiple threads to run on multiple CPUs if they are available at the same time.
- using context switching to stop one thread and start Another to give the appearance of threads running to the same time.
- Java has a memory model which provided guarantees which allow threads to co-ordinate work.

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