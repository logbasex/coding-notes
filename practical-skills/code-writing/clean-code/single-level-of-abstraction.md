## References
- [Single Level of Abstraction (SLA)](http://principles-wiki.net/principles:single_level_of_abstraction)
- [Clean Code](https://gpcoder.gitbook.io/clean-code/the-key-principles-of-clean-code/functions)

====
====

## Why difference levels of abstraction is hard to read?

Mixing different levels of abstraction in a method makes the code harder to read and maintain for several reasons:

### 1. **Cognitive Load**
When a method contains both high-level and low-level details, it increases the cognitive load on the reader. The reader has to constantly switch context between understanding the overall flow of the method (high-level) and the specific implementation details (low-level). This context switching is mentally taxing and makes it difficult to understand the purpose and function of the method quickly.

### 2. **Loss of Clarity**
A method that mixes different levels of abstraction lacks clarity. The primary purpose of the method can get lost among the low-level details. This makes it harder for a reader to grasp the overall intention and flow of the method, as they are distracted by the detailed implementation scattered throughout.

### 3. **Reduced Reusability and Maintainability**
When low-level details are mixed with high-level logic, it becomes harder to reuse and maintain the code. Any change in the low-level logic requires changes in the method, which can also affect the high-level logic. This tight coupling makes the code less modular and harder to update or refactor without risking breaking something.

### 4. **Increased Complexity**
Mixing abstraction levels increases the complexity of a method. A complex method is harder to debug, test, and reason about. Each level of abstraction should ideally encapsulate a specific concern or responsibility. When these concerns are mixed, the method becomes a tangled mess that is difficult to disentangle.

### Benefits of Adhering to SLAP

1. **Improved Readability**
    - The high-level method (`processPayment`) is easier to read and understand because it clearly outlines the sequence of operations without getting bogged down in details.

2. **Easier Maintenance**
    - Low-level details are encapsulated in separate methods. Changes to logging, inventory updates, or email sending can be made independently without affecting the high-level logic.

3. **Enhanced Reusability**
    - Low-level methods like `logStartTime`, `logEndTime`, and `updateInventoryItem` can be reused in other parts of the code, reducing duplication.

4. **Clearer Debugging**
    - It is easier to pinpoint where an error might occur when the code is organized by abstraction levels. If there's an issue with inventory updates, you know exactly which method to inspect.

By maintaining a single level of abstraction within a method, you make your codebase cleaner, more understandable, and more maintainable.

====
====

### Example1: Loops

A typical example for the application of SLA is a loop iterating over a certain data structure:

```java
public List<ResultDto> buildResult(Set<ResultEntity> resultSet) {
    List<ResultDto> result = new ArrayList<>();
    for (ResultEntity entity : resultSet) {
        ResultDto dto = new ResultDto();
        dto.setShoeSize(entity.getShoeSize());        
        dto.setNumberOfEarthWorms(entity.getNumberOfEarthWorms());
        dto.setAge(computeAge(entity.getBirthday()));
        result.add(dto);
    }
    return result;
}
```

There are two levels of abstractions in this method. First there is the loop which acts upon the whole result set and second there is the loop body which converts a single entity to a [DTO](http://principles-wiki.net/patterns:data_transfer_object "patterns:data_transfer_object"). For the latter there is no syntactical grouping. The reader of the code has to find out that the first four lines of the loop body belong together. The code also doesn't explicitly state that these four lines convert an entity to a DTO. So the following code is better:

```java
public List<ResultDto> buildResult(Set<ResultEntity> resultSet) {
    List<ResultDto> result = new ArrayList<>();
    for (ResultEntity entity : resultSet) {
        result.add(toDto(entity));
    }
    return result;
}
 
private ResultDto toDto(ResultEntity entity) {
    ResultDto dto = new ResultDto();
    dto.setShoeSize(entity.getShoeSize());        
    dto.setNumberOfEarthWorms(entity.getNumberOfEarthWorms());
    dto.setAge(computeAge(entity.getBirthday()));
    return dto;
}
```


Now there are two smaller methods each of which is written in terms of a single level of abstraction. This is better readable as no mental grouping is necessary. Furthermore the two methods are still separately understandable ([PSU](http://principles-wiki.net/principles:principle_of_separate_understandability "principles:principle_of_separate_understandability")) so no mental inlining is necessary and if you don't care about the details of the `toDto` method, you can just read and understand `buildResult` without being distracted by unnecessary detail.

====
====

## Example 2

The Single Level of Abstraction Principle (SLAP) is a software design principle that states that a method should operate at a single level of abstraction. This means that a method should not mix high-level operations with low-level operations. High-level operations refer to abstract, more conceptual steps, while low-level operations refer to detailed, concrete steps.

When a method adheres to SLAP, it becomes easier to read, understand, and maintain, because each method has a clear and consistent level of detail.

### Example in Java

Let's illustrate SLAP with an example. Suppose we have a class that processes orders in an e-commerce system. We will show a method that violates SLAP and then refactor it to adhere to SLAP.

#### Violating SLAP

```java
public class OrderProcessor {
    public void processOrder(Order order) {
        // High-level: Check if the order is valid
        if (order.isValid()) {
            // Low-level: Log the order processing start time
            long startTime = System.currentTimeMillis();
            System.out.println("Processing order at: " + startTime);

            // High-level: Charge the customer
            chargeCustomer(order);

            // Low-level: Update inventory
            for (OrderItem item : order.getItems()) {
                updateInventory(item);
            }

            // High-level: Send confirmation email
            sendConfirmationEmail(order);

            // Low-level: Log the order processing end time
            long endTime = System.currentTimeMillis();
            System.out.println("Finished processing order at: " + endTime);
        }
    }

    private void chargeCustomer(Order order) {
        // Implementation
    }

    private void updateInventory(OrderItem item) {
        // Implementation
    }

    private void sendConfirmationEmail(Order order) {
        // Implementation
    }
}
```

In the `processOrder` method, high-level operations (like checking if the order is valid, charging the customer, and sending a confirmation email) are mixed with low-level operations (like logging the start and end times, and updating the inventory).

#### Adhering to SLAP

Let's refactor the `processOrder` method to adhere to SLAP:

```java
public class OrderProcessor {
    public void processOrder(Order order) {
        if (order.isValid()) {
            logOrderProcessingStart();

            chargeCustomer(order);
            updateInventory(order);
            sendConfirmationEmail(order);

            logOrderProcessingEnd();
        }
    }

    private void logOrderProcessingStart() {
        long startTime = System.currentTimeMillis();
        System.out.println("Processing order at: " + startTime);
    }

    private void logOrderProcessingEnd() {
        long endTime = System.currentTimeMillis();
        System.out.println("Finished processing order at: " + endTime);
    }

    private void chargeCustomer(Order order) {
        // Implementation
    }

    private void updateInventory(Order order) {
        for (OrderItem item : order.getItems()) {
            updateInventoryItem(item);
        }
    }

    private void updateInventoryItem(OrderItem item) {
        // Implementation
    }

    private void sendConfirmationEmail(Order order) {
        // Implementation
    }
}
```

In this refactored version, the `processOrder` method now only contains high-level operations. The low-level operations have been moved to separate methods, such as `logOrderProcessingStart`, `logOrderProcessingEnd`, `updateInventory`, and `updateInventoryItem`.

By doing this, each method operates at a single level of abstraction, making the code more readable and easier to maintain. The high-level flow of `processOrder` is clear, and the details are encapsulated in well-named, focused methods.