## Stack
![https://www.overops.com/blog/jvm-architecture-101-get-to-know-your-virtual-machine/](https://overops.com/wp-content/uploads/2020/09/JVM-2.png)

## [Frame/Stack Frame](https://docs.oracle.com/javase/specs/jvms/se11/html/jvms-2.html#jvms-2.6)
A frame is used to store data and partial results, as well as to perform
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

> A stack frame contains the state of one Java method invocation. When a thread invokes a method, the Java virtual machine pushes a new frame onto that thread's Java stack. When the method completes, the virtual machine pops and discards the frame for that method.

## Operand stack

Operand stack holds the operand used by operators to perform operations. Each entry on the operand stack can hold a value of any Java Virtual Machine type.

![https://www.artima.com/insidejvm/ed2/jvm8.html](https://www.artima.com/insidejvm/ed2/images/fig5-10.gif)

[What is an operand stack?](https://stackoverflow.com/questions/24427056/what-is-an-operand-stack)

```
   _______________________________
   |        _____________________  |
   |       |         + --------+ | |
   |  JVM  |         | Operand | | | 
   | Stack |  FRAME  |  Stack  | | |
   |       |         +---------+ | |
   |       |_____________________| |
   |_______________________________|
```

> [**See, every operation in JVM is done on operand stack**. So whenever you have to perform any operation on a variable, you have to first load (pushed ) on the operand stack by load command and then perform operation. This is why store is followed by load instruction in bytecode.](https://stackoverflow.com/questions/42779752/why-does-java-bytecode-store-often-followed-by-load)