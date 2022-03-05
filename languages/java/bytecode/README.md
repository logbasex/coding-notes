## Tutorial
- https://medium.com/swlh/an-introduction-to-jvm-bytecode-5ef3165fae70
    - this keyword
    - constructor
    - reference value (pass by value)
## [opcode](https://en.wikipedia.org/wiki/Opcode)
A Java Virtual Machine instruction consists of a one-byte opcode specifying the operation to be performed, followed by zero or more operands supplying arguments or data that are used by the operation. Many instructions have no operands and consist only of an opcode.

https://www.informit.com/articles/article.aspx?p=2024315&seqNum=11

---------
## [stack-based machine vs register-based machine](https://www.youtube.com/watch?v=7hrLD4z8eUA&list=PLGNbPb3dQJ_446PjTYQ0mCn2OGoHSKraB&index=2)

### [The JVM as a Stack Machine](https://courses.cs.ut.ee/MTAT.05.085/2014_spring/uploads/Main/JVM%20Bytecode.pdf)
### [STACK BASED VS REGISTER BASED VIRTUAL MACHINE ARCHITECTURE, AND THE DALVIK VM](https://markfaction.wordpress.com/2012/07/15/stack-based-vs-register-based-virtual-machine-architecture-and-the-dalvik-vm/)

- Stack Based Virtual Machines

    - A stack based virtual machine implements the general features described as needed by a virtual machine in the points above, but the memory structure where the operands are stored is a stack data structure. Operations are carried out by popping data from the stack, processing them and pushing in back the results in LIFO (Last in First Out) fashion. In a stack based virtual machine, the operation of adding two numbers would usually be carried out in the following manner (where 20, 7, and ‘result’ are the operands).
    - ![](https://markfaction.files.wordpress.com/2012/07/stackadd_thumb.png?w=356&h=133&zoom=2)
    - 
      Because of the PUSH and POP operations, four lines of instructions is needed to carry out an addition operation. An advantage of the stack based model is that the operands are addressed implicitly by the stack pointer (SP in above image). This means that the Virtual machine does not need to know the operand addresses explicitly, as calling the stack pointer will give (Pop) the next operand. In stack based VM’s, all the arithmetic and logic operations are carried out via Pushing and Popping the operands and results in the stack.
- Register Based Virtual Machines
    - In the register based implementation of a virtual machine, the data structure where the operands are stored is based on the registers of the CPU. There is no PUSH or POP operations here, but the instructions need to contain the addresses (the registers) of the operands. That is, the operands for the instructions are explicitly addressed in the instruction, unlike the stack based model where we had a stack pointer to point to the operand. For example, if an addition operation is to be carried out in a register based virtual machine, the instruction would more or less be as follows:
    - 
    - ![](https://markfaction.files.wordpress.com/2012/07/registeradd_thumb.png?w=456&h=224&zoom=2)
    - 
      As I mentioned earlier, there is no POP or PUSH operations, so the instruction for adding is just one line. But unlike the stack, we need to explicitly mention the addresses of the operands as R1, R2, and R3. The advantage here is that the overhead of pushing to and popping from a stack is non-existent, and instructions in a register based VM execute faster within the instruction dispatch loop.


 
## [Build your own virtual machine](https://github.com/danistefanovic/build-your-own-x#build-your-own-emulator--virtual-machine)
- https://github.com/parrt/simple-virtual-machine
- https://bzotto.medium.com/building-a-java-virtual-machine-how-hard-could-it-be-810a98d9c798
- [So You Want to Build a Language VM - Part 01 - Overview and a Simple VM](https://blog.subnetzero.io/post/building-language-vm-part-01/)
- [Building a stack-based virtual machine](https://dev.to/jimsy/building-a-stack-based-virtual-machine-5gkd)

## [Virtual Method Table/Virtual method invocation](https://stackoverflow.com/questions/2486160/java-virtual-methods)
All methods in java are virtual by default. That means that any method can be overridden when used in inheritance, unless that method is declared as final or static.

```
public static void main(String[] args) {
    A myA = new B();
    System.out.println(myA.getName());
}
```
If Java didn't have virtual method invocation, it would determine at compile time that the getName() to be called is the one that belongs to the A class. Since it doesn't, but determines this at runtime depending on the actual class that myA points to, we get the above result.

https://www.delftstack.com/howto/java/virtual-function-in-java/#virtual-function-in-java

### [Does method invoke cost remain constant with more interface implementions](https://stackoverflow.com/questions/44335865/does-method-invoke-cost-remain-constant-with-more-interface-implementions)

When calling an interface method, a so called v-table is used to determine the memory address of the called method. Each type has its own v-table that contains pointers to each implemented method, and every object of that type has a pointer to its type's v-table. Thus, during method invocation, there is no branching or searching for the right memory address, since the pointers will always uniquely point to the right v-table and method addresses.

![](https://i.stack.imgur.com/6CHpc.png)
----------
## [Dynamic dispatch](https://stackoverflow.com/questions/4343247/what-is-dynamic-method-dispatch-and-how-does-it-relate-to-inheritance)
    
    
----
## Derived class

A derived class is a Java class that inherits properties from its super class.
A class can be derived from the base class in Java by using the extends keyword            
            
                



    

            