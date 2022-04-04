## [Why is C considered faster than other languages ?](https://www.geeksforgeeks.org/c-considered-faster-languages/)

First let’s list out functionalities which are provided by languages like Java and not C : 

- Array index bound checking
- Uninitialized variable values checking
- Check for memory leaks
- Check for null pointer dereference
- Automatic garbage collection
- Run-time type checking
- Exception handling

and there are more such features which are not present in C.
Extra features comes at cost and the cost includes decreased speed and increased size.

-----

## [Why is C so fast, and why aren't other languages as fast or faster?](https://stackoverflow.com/questions/418914/why-is-c-so-fast-and-why-arent-other-languages-as-fast-or-faster)

> C tends to be faster because almost everything else is written in C.

> Modern languages like Java or .NET langs are oriented more on programmer productivity rather than performance. Hardware is cheap now days. Also compilation to intermediate representation gives a lot of bonuses such as security, portability etc

> Although if you wrote a program once in C and again in Assembly, the C version would probably be faster because the compiler is smarter than you are.

> C is faster because it does less (for you).

---

[In what cases is Java faster, if at all, than C++ ?](https://www.quora.com/In-what-cases-is-Java-faster-if-at-all-than-C)