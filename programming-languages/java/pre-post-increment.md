## [When to use post increment and pre increment in Java](https://stackoverflow.com/a/35390766/10393067)

PRE-increment is used when you want to use the incremented value of the variable in that expression., whereas POST-increment uses the original value before incrementing it.

Whenever your code encounters a PRE-increment, it increments the value of that variable in the memory, then load that value and continues reading the expression.

POST-increment does the opposite, it loads that value of that variable in the memory, then increments the value and continues reading the expression.

To make it more clear, consider this

    int i = counter++;

is equivalent to

    int i = counter;
    counter = counter + 1;

WHEREAS

    int i = ++counter;

is equivalent to

    counter = counter + 1;
    int i = counter;


EDIT: My StackOverflow comments arent working, so I'll just edit it here.

What I'm saying it, it only matters when you use that value in an expression.

    sum = 0
    counter = 0;
    sum = (++counter)+(++counter)+(counter++)

evaluates as

    sum = 0
    counter = 0
    //For first ++counter
    counter = counter + 1
    sum = counter
    
    //For second ++counter
    counter = counter + 1
    sum = sum + counter
    
    //For first counter++
    sum = sum + counter
    counter = counter + 1

----

In both cases it first calculates value, but in post-increment it holds old value and after calculating returns it

**++a**

1. a = a + 1;
2. return a;

**a++**

1. temp = a;
2. a = a + 1;
3. return temp;

---

## [A Guide to Increment and Decrement Unary Operators in Java](https://www.baeldung.com/java-unary-operators)