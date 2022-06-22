## [Directive](https://www.quora.com/What-is-a-directive-in-programming/answer/Marius-Myburg-1)

> A directive is a code line (statement ) that tells the compiler something. It is not code that ever gets executed; it is simply to help the compiler compile your code. The most common directive is the #using directive in C#. For example:
>
> `#using System.Collections`
>
> This line of code is not part of your built (or executed) program; it just exists to tell C# where it should look for types that you use in your code. For example, the type List<T> exists in System.Collections. By adding the #using directive, in your code you can now just write:
>
>List<int> myIntList = new List<int>();
>
> If you did not have the #using directive, the above line would not compile, because C# would not know what a List<T> is. To get around that, you would have to add the #using directive once, or alternatively, every time that you use List<T>, you would tell C# where that type is, like so:
>
> System.Collections.List<int> myIntList = new System.Collections.List<int>();
