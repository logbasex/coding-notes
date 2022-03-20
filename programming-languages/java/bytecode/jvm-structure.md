## Stack
![https://www.overops.com/blog/jvm-architecture-101-get-to-know-your-virtual-machine/](https://overops.com/wp-content/uploads/2020/09/JVM-2.png)

## [Frame](https://docs.oracle.com/javase/specs/jvms/se11/html/jvms-2.html#jvms-2.6)
A frame
  is used to store data and partial results, as well as to perform
  dynamic linking, return values for methods, and dispatch
  exceptions.

A new frame is created each
  time a method is invoked. A frame is destroyed when its method
  invocation completes, whether that completion is normal or abrupt (it
  throws an uncaught exception). Frames are allocated from the Java Virtual Machine
  stack (§2.5.2) of the thread creating the
  frame. Each frame has its own array of local variables
  (§2.6.1), its own operand stack
  (§2.6.2), and a reference to the run-time
  constant pool (§2.5.5) of the class of the
  current method.
            
![](https://overops.com/wp-content/uploads/2020/09/FRAME-1.png)            

The JVM playground for executing a method is the method frame. The frame consists of two main parts:

- **Local Variables Array** – where the method’s parameters and local variables are stored
- **Operand Stack** – where the method’s computations are performed