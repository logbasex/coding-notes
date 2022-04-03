## [Is the constructor for an object invoked after object creation on heap (Java)?](https://stackoverflow.com/questions/2419286/is-the-constructor-for-an-object-invoked-after-object-creation-on-heap-java)

Once `new` is called it knows how much memory needs to be allocated into the heap for a variable of type, in your case Foo.  Once that memory is allocated only then are the values set.  Think about it how else are you going to assign member variables if you don't have memory for the member variable?  If there is no memory new will throw an exception which you need to handle.

Process:

1. JVM sees `new`
2. Allocates memory on the heap to store the object (Ref type)
3. Assigns default values
4. If of object type assigns `null`
5. Call constructor

---

Your `new Object()` doesn't have a reference. Its just an object which will be allocated on the heap space.

If it were like:

    Object someReference = new Object();

then `someReference` would be on the *stack* space of *thread*. However the object itself will always be on the heap.

***Lets take an example:***

If you were to execute this statement:

    Employee emp = new Employee();

You'd have memory like:

- **Heap**: stores `new Employee()` i.e. actual object
- **Stack**: stores information about `emp` i.e. reference
- [**Perm Space/Metaspace**: stores information about `Employee` class](https://stackoverflow.com/questions/52436675/in-java-how-much-memory-is-allocated-on-stack-and-heap-for-new-object)

---
## [How do constructors in Java allocate memory and initialize instance variables?](https://www.quora.com/How-do-constructors-in-Java-allocate-memory-and-initialize-instance-variables)

- Memory is allocated by new operator NOT BY constructors. 
- Constructors can initialize data member.

```shell
class Demo 
{ 
	int a; 
	int b; 
	public: 
	Demo()//constructor 
	{ 
		a=10; //a is initialized with value 10 
		b=20; //b is initialized with value 20 
	} 
 
	public static void main(string args[]) 
	{ 
		Demo demo = new Demo();//memory gets allocated for object demo.then,Constructor gets called which is initializing data members(i.e, a & b) 
	} 
}  
```