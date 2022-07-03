[[Java] What does the "new" keyword in java mean, in simple english?](https://www.reddit.com/r/learnprogramming/comments/7585dt/java_what_does_the_new_keyword_in_java_mean_in/)

---

[Java’s new keyword under the hood](https://medium.com/@winwardo/javas-new-keyword-under-the-hood-8b2f0d8c8665)

---

[When the reference to an object is created in Java?](https://stackoverflow.com/questions/59580835/when-the-reference-to-an-object-is-created-in-java)

In the line **a = new myClass()**; several things are happening:

1. **new myClass()**; creates an instance of the new object. `a` would still be null at this point. Strictly speaking, it is not even a null, it is not initialized state.
2. Assignment operator = assigns a a new value, which is a link to the object, created in step 1

**So `a` has proper value only after the assignment is completed**.


---
[How object creation or constructors called implicitly in Java](https://stackoverflow.com/questions/36868239/how-object-creation-or-constructors-called-implicitly-in-java)

```shell
public static voi main(String[] args) {
  Object o = new Object();
}

public static void main(java.lang.String[]);
    Code:
       0: new           #3                  // class java/lang/Object
       3: dup
       4: invokespecial #8                  // Method java/lang/Object."<init>":()V
       7: astore_1
       8: return
```

- Tại ví trí `0`, khi dùng từ khóa `new` object được tạo ra nhưng chưa được khởi tạo (uninitialized).
- Tại ví trí `4`, khi gọi constructor, object mới được khởi tạo.

[Explain](https://developpaper.com/as-far-as-i-know-the-bytecode-instruction-set-and-parsing-of-jvm-virtual-machine-operand-stack-management-instruction/)

![image](https://user-images.githubusercontent.com/22516811/177036764-312318ce-bd0f-452e-9928-7cec4d206627.png)

![image](https://user-images.githubusercontent.com/22516811/177036802-26fe81ec-2353-4d57-8ea1-2e14b4dcab31.png)

![image](https://user-images.githubusercontent.com/22516811/177036812-b1807c10-d936-4178-833a-a056e40c692f.png)

`invokespecial` nhận vào **#1** là object's heap address từ stack mà không trả về (call constructor return void) nên trước khi call `invokespecial` cần `dup` stack top value trước, nếu không sau khi call `invokespecial` thì stack sẽ bị rỗng, hay nói cách khác là sau khi object được khởi tạo thì không trả về object's heap address.

[Because **`INVOKESPECIAL` will consume value created by `NEW`** from the operand stack, but you may need to actually use this value, so the reference is duplicated in advance.](https://stackoverflow.com/questions/7282585/why-do-dup-when-creating-new-instance)

![https://stackoverflow.com/questions/61634385/is-that-a-correct-depiction-of-the-process-of-creating-a-new-object-in-java](https://user-images.githubusercontent.com/22516811/177038133-206aa173-8e4d-4f19-b5cc-1ceaf6ca0c1a.png)

![https://www.jrebel.com/blog/java-bytecode-tutorial](https://user-images.githubusercontent.com/22516811/177038249-101a0d13-5f3c-450e-8894-2a1cfb164a1c.png)


![http://asmsupport.github.io/jvmref/ref-dup.html](https://user-images.githubusercontent.com/22516811/177038524-6046c855-f771-4ce9-9eb7-156f33ac5cc2.png)

![image](https://user-images.githubusercontent.com/22516811/177036849-ffb8e08f-a3d4-4570-9901-d2673205004e.png)

**[astore](http://asmsupport.github.io/jvmref/ref-astore.html)**: Store reference into **local variable**


