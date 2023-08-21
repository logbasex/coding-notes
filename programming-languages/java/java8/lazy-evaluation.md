Without lazy evaluation, expressions are evaluated eagerly, which means that they are evaluated as soon as they are encountered. This can be inefficient in situations where the expression does not need to be evaluated immediately, or where the expression is expensive to evaluate.

For example, consider the following code:

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

long sum = 0;
for (int number : numbers) {
  sum += number;
}

System.out.println("The sum is " + sum);
```

In this code, the `sum` variable is evaluated eagerly. This means that the sum of all the numbers in the `numbers` list is calculated as soon as the `for` loop starts. This can be inefficient if the `numbers` list is large.

If lazy evaluation were used, the `sum` variable would not be evaluated until the `System.out.println()` statement is executed. This would only happen if the `sum` variable was actually needed, which would improve the performance of the code.

Here are some other reasons why lazy evaluation can be more efficient than eager evaluation:

* Lazy evaluation can avoid unnecessary work. For example, if an expression is only used in a conditional statement, it can be evaluated lazily to avoid evaluating it if the condition is not met.
* Lazy evaluation can save memory. For example, if an expression creates a large object, it can be evaluated lazily to avoid creating the object if it is not needed.
* Lazy evaluation can be used to implement infinite data structures. For example, the lazy evaluation of the Fibonacci sequence can be used to create an infinite list of Fibonacci numbers.

Overall, lazy evaluation can be a powerful tool for improving the performance of your code. However, it is important to use it carefully to avoid errors.

----

## Có thể khai báo stream ở đâu đấy rồi lúc nào cần mới gọi.

Sure. Here are some more details about how lazy evaluation can save memory in the context of streams:

* When a lazy evaluation operation is performed, a new stream is created that contains the results of the operation. However, this new stream is not actually evaluated until a terminal operation is called.
* This means that the intermediate results of the lazy evaluation operation are not created until they are actually needed. This can save memory if the intermediate results are large.
* For example, the following code uses the `filter()` method to create a new stream that contains only the even numbers in a list:

```
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

Stream<Integer> evenNumbers = numbers.stream().filter(number -> number % 2 == 0);
```

The `filter()` method is a lazy evaluation operation. This means that the new stream is not created until the `forEach()` method is called.

```
evenNumbers.forEach(System.out::println);
```

The `forEach()` method is a terminal operation. This means that the new stream is evaluated and the elements are printed to the console.

In this example, the `filter()` method is not evaluated until the `forEach()` method is called. This means that the new stream is not created until it is actually needed. This can save memory if the list is large.

The amount of memory that can be saved by lazy evaluation depends on the size of the intermediate results and the number of times that the lazy evaluation operation is performed. In general, lazy evaluation can save a significant amount of memory if the intermediate results are large or if the lazy evaluation operation is performed many times.

I hope this explanation is helpful. Let me know if you have any other questions.