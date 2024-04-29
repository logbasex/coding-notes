## References
- [What the heck is the event loop anyway? | Philip Roberts](https://www.youtube.com/watch?v=8aGhZQkoFbQ)
- [Ôn tập callback, promise, async/await](https://duthanhduoc.com/blog/on-tap-callback-promise-async-await)


----
----

##  Call stack, task queue, and event loop

Let's consider a simple JavaScript example that involves both synchronous and asynchronous operations. This will help illustrate the interaction between the call stack, task queue, and event loop:

```javascript
console.log("Start");

setTimeout(function timeoutCallback() {
    console.log("Timeout done");
}, 1000);

console.log("End");
```

Here's the flow of execution for this code, step by step:

1. **Start of Execution**
    - The script begins execution.

2. **First console.log()**
    - `console.log("Start")` is added to the call stack.
    - It executes immediately, logging "Start" to the console.
    - It's then removed from the call stack.

3. **setTimeout() Function**
    - `setTimeout()` is called with a callback (`timeoutCallback`) and a delay of 1000 milliseconds (1 second).
    - `setTimeout()` itself is added to the call stack.
    - JavaScript registers the timer and the callback, but does not block the call stack—it quickly completes and is removed from the call stack.
    - The callback (`timeoutCallback`) is now scheduled to run after at least 1000 milliseconds. It moves to the Web APIs environment (not shown in typical diagrams but exists in environments like browsers), which handles the timing.

4. **Second console.log()**
    - `console.log("End")` is added to the call stack.
    - It executes immediately, logging "End" to the console.
    - It's then removed from the call stack.

5. **Waiting Period**
    - At this point, the call stack is empty. JavaScript’s engine is idle but the timer for `setTimeout()` is still running in the background (Web APIs).

6. **Timer Expires**
    - After the 1000 milliseconds delay, the `timeoutCallback` is ready to be executed.
    - The callback is moved from the Web APIs environment to the task queue.
    - The event loop checks if the call stack is empty. Seeing that it is, the event loop moves the `timeoutCallback` from the task queue to the call stack.

7. **timeoutCallback Execution**
    - `timeoutCallback()` is now on the call stack.
    - `console.log("Timeout done")` is called within `timeoutCallback`, added to the call stack, logs "Timeout done" to the console, and is removed from the call stack.
    - `timeoutCallback()` finishes execution and is removed from the call stack.

8. **End of Script**
    - Both the call stack and task queue are empty. The script finishes its execution completely.

This example clearly demonstrates how the call stack handles immediate, synchronous operations, while the event loop oversees asynchronous tasks, managing them via the task queue to ensure that the single-threaded JavaScript engine can execute non-blocking operations effectively.


-----
-----

## why second console.log need to remove from the call stack

The second `console.log("End")` needs to be removed from the call stack for several reasons that are fundamental to how the JavaScript execution model operates:

1. **Completion of Execution**: In JavaScript, when a function is called, it gets pushed onto the call stack. After the function executes, it must be removed from the call stack to make room for the next function that needs to be executed. This ensures that the stack doesn't overflow from having too many finished function calls still on it.

2. **Maintaining the LIFO (Last In, First Out) Order**: The call stack operates on a LIFO principle, meaning that the last function that gets pushed onto the stack is the first one to be executed and removed. This order must be strictly maintained to ensure that functions complete and return control to their calling functions in the correct sequence. After `console.log("End")` finishes logging to the console, it has completed its task and there is no further code to execute within that function, so it is popped off the stack.

3. **Enabling Subsequent Code Execution**: The removal of functions from the call stack after they execute is crucial for the next functions or tasks to start execution. If `console.log("End")` were not removed, it would block the execution of any subsequent operations, including asynchronous callbacks waiting in the task queue. This is critical in maintaining the non-blocking nature and efficiency of JavaScript.

4. **Resource Management**: Removing functions from the call stack after execution helps in managing memory and resources efficiently. It clears up the space occupied by completed function calls, reducing memory usage and preventing potential memory leaks which could occur if the stack were mismanaged.

Thus, removing `console.log("End")` from the call stack after it executes is essential for the proper functioning of the JavaScript engine, allowing it to execute subsequent code, manage resources efficiently, and adhere to its execution model principles.