## Overview
Pushdown trong MySQL là một kỹ thuật tối ưu hóa nhằm giảm thiểu số lượng dữ liệu được xử lý ở các tầng cao hơn của cơ sở dữ liệu (ví dụ như SQL engine) bằng cách đẩy các thao tác xử lý xuống tầng thấp hơn, thường là tầng lưu trữ hoặc tầng cơ sở hạ tầng. Điều này giúp giảm bớt khối lượng công việc cần thiết tại tầng trên và cải thiện hiệu suất tổng thể.

Các loại pushdown phổ biến trong MySQL bao gồm:

### 1. **Predicate Pushdown**
- **Giải thích:** Predicate Pushdown đẩy điều kiện của câu lệnh SQL (ví dụ: `WHERE`, `HAVING`) xuống tầng lưu trữ. Thay vì lấy toàn bộ dữ liệu lên tầng SQL engine rồi lọc, MySQL sẽ lọc ngay từ tầng lưu trữ, do đó giảm bớt lượng dữ liệu cần xử lý và truyền lên.
- **Ví dụ:** Nếu bạn có câu lệnh `SELECT * FROM orders WHERE order_date > '2023-01-01'`, thay vì lấy toàn bộ bảng `orders`, MySQL sẽ chỉ lấy các bản ghi thoả mãn điều kiện `order_date > '2023-01-01'` từ tầng lưu trữ.

### 2. **Derived Condition Pushdown**
- **Giải thích:** Derived Condition Pushdown liên quan đến việc đẩy điều kiện từ các bảng phụ (derived table, subquery) vào trong quá trình thực thi truy vấn. Điều này giúp giới hạn số lượng dữ liệu được lấy từ các bảng con thay vì để quá trình xử lý xảy ra ở tầng trên.
- **Ví dụ:** Với câu lệnh `SELECT * FROM (SELECT * FROM orders WHERE order_date > '2023-01-01') AS recent_orders`, điều kiện `order_date > '2023-01-01'` được đẩy xuống tầng thấp hơn ngay từ đầu thay vì chờ đến khi bảng phụ được tạo xong.

### 3. **Join Pushdown**
- **Giải thích:** Join Pushdown đẩy phép nối (JOIN) xuống tầng lưu trữ khi có thể, giúp giảm khối lượng dữ liệu được tải về tầng trên và xử lý kết nối ngay từ tầng dưới. Điều này đặc biệt hữu ích khi sử dụng các cơ chế lưu trữ mạnh mẽ như InnoDB.
- **Ví dụ:** Khi bạn sử dụng phép nối trên hai bảng lớn, Join Pushdown sẽ thực hiện phép nối ngay ở tầng lưu trữ thay vì tải dữ liệu lên tầng SQL engine trước rồi mới xử lý nối.

### 4. **Function Pushdown**
- **Giải thích:** Function Pushdown cho phép các hàm (functions) như `SUM`, `COUNT`, `AVG`, hoặc các hàm xử lý dữ liệu khác được thực hiện tại tầng lưu trữ. Điều này giúp tối ưu hóa hiệu suất khi xử lý các phép tính phức tạp trên lượng dữ liệu lớn.
- **Ví dụ:** Khi bạn sử dụng câu lệnh `SELECT SUM(sales) FROM orders`, phép tính `SUM` có thể được đẩy xuống tầng lưu trữ thay vì được tính toán ở tầng trên.

### 5. **Projection Pushdown**
- **Giải thích:** Projection Pushdown đẩy việc lựa chọn các cột cần thiết xuống tầng lưu trữ. Điều này giảm thiểu lượng dữ liệu không cần thiết được đưa vào bộ nhớ từ tầng lưu trữ. Nếu một truy vấn chỉ cần một vài cột, hệ thống sẽ chỉ lấy những cột đó thay vì lấy toàn bộ dữ liệu.
- **Ví dụ:** Với câu lệnh `SELECT order_id, order_date FROM orders`, thay vì lấy toàn bộ các cột của bảng `orders`, chỉ hai cột `order_id` và `order_date` được lấy từ tầng lưu trữ.

Những loại pushdown này giúp MySQL xử lý dữ liệu hiệu quả hơn, tiết kiệm tài nguyên, và tăng tốc độ truy vấn, đặc biệt là trên các tập dữ liệu lớn.

-----

### Giải thích chi tiết và sâu sắc hơn về sự hiệu quả của pushdown trong MySQL

Để hiểu sâu sắc tại sao các kỹ thuật pushdown lại hiệu quả, chúng ta cần xem xét quá trình xử lý dữ liệu trong hệ thống cơ sở dữ liệu từ gốc đến ngọn, từ nơi dữ liệu được lưu trữ (tầng lưu trữ) đến nơi truy vấn SQL được thực thi (tầng SQL engine).

### 1. **Tối thiểu hóa I/O**

**Nguyên lý cơ bản:**
Trong bất kỳ hệ thống cơ sở dữ liệu nào, các thao tác I/O (đọc và ghi dữ liệu từ đĩa hoặc bộ nhớ) thường là những bước tốn thời gian nhất. Điều này là do tốc độ truy xuất từ đĩa (ngay cả với SSD) vẫn chậm hơn rất nhiều so với việc xử lý dữ liệu trong bộ nhớ (RAM) hoặc CPU.

**Tác động của Pushdown:**
- **Predicate Pushdown:** Khi đẩy các điều kiện lọc (`WHERE`) xuống tầng lưu trữ, hệ thống chỉ cần truy xuất những bản ghi thỏa mãn điều kiện thay vì đọc toàn bộ bảng. Điều này giảm thiểu số lần đọc đĩa và giảm khối lượng dữ liệu cần phải tải lên bộ nhớ để xử lý thêm.
- **Function Pushdown:** Thay vì lấy tất cả các bản ghi lên và sau đó tính toán, các hàm tổng hợp như `SUM` hoặc `AVG` được tính toán ngay tại nơi dữ liệu nằm, tránh được việc phải chuyển khối lượng lớn dữ liệu lên tầng SQL. Ví dụ, tính tổng lương của một triệu nhân viên chỉ cần chuyển một giá trị duy nhất (kết quả của `SUM`) thay vì một triệu giá trị.

### 2. **Giảm tải bộ nhớ và CPU**

**Nguyên lý cơ bản:**
Khi dữ liệu được tải lên từ tầng lưu trữ để xử lý trong tầng SQL, nó chiếm dụng bộ nhớ và CPU của hệ thống. Nếu lượng dữ liệu này quá lớn, nó có thể gây ra tình trạng tràn bộ nhớ hoặc quá tải CPU, làm chậm hệ thống hoặc thậm chí dẫn đến các lỗi về tài nguyên.

**Tác động của Pushdown:**
- **Projection Pushdown:** Khi chỉ cần chọn một vài cột trong bảng, Pushdown giúp giảm lượng dữ liệu tải lên bộ nhớ bằng cách chỉ chuyển những cột cần thiết. Điều này giảm tải bộ nhớ, cho phép hệ thống xử lý nhiều truy vấn đồng thời mà không bị quá tải.
- **Join Pushdown:** Khi phép nối giữa các bảng được thực hiện ngay tại tầng lưu trữ, chỉ kết quả của phép nối (thay vì toàn bộ các bảng) mới được chuyển lên tầng SQL. Điều này giảm bớt khối lượng dữ liệu cần phải giữ trong bộ nhớ và giảm số lượng thao tác CPU cần thực hiện để nối các bảng này.

### 3. **Tối ưu hóa việc sử dụng bộ nhớ đệm (Cache)**

**Nguyên lý cơ bản:**
Các hệ thống cơ sở dữ liệu thường sử dụng bộ nhớ đệm để giữ lại những dữ liệu thường xuyên truy cập, giúp tăng tốc độ truy vấn. Tuy nhiên, bộ nhớ đệm có dung lượng giới hạn, và việc sử dụng không hiệu quả có thể dẫn đến tình trạng bộ nhớ đệm bị quá tải, khiến hiệu suất giảm sút.

**Tác động của Pushdown:**
- **Predicate Pushdown:** Khi dữ liệu được lọc ngay tại tầng lưu trữ, chỉ những dữ liệu quan trọng nhất được tải vào bộ nhớ đệm. Điều này giúp bộ nhớ đệm được sử dụng hiệu quả hơn, vì nó không bị lấp đầy bởi dữ liệu không cần thiết.
- **Function Pushdown:** Các hàm tổng hợp được xử lý ngay tại tầng lưu trữ cũng giúp giảm tải bộ nhớ đệm vì chỉ những giá trị cuối cùng (kết quả của các phép tính) được đưa vào bộ nhớ đệm thay vì toàn bộ dữ liệu nguồn.

### 4. **Giảm thiểu việc tạo ra các tập dữ liệu trung gian**

**Nguyên lý cơ bản:**
Trong quá trình thực thi truy vấn, đôi khi hệ thống phải tạo ra các tập dữ liệu trung gian để xử lý các phép toán như nối, lọc, hoặc tính toán tổng hợp. Những tập dữ liệu này có thể rất lớn và chiếm nhiều tài nguyên, đặc biệt là khi phải lưu trữ tạm thời trong bộ nhớ hoặc đĩa.

**Tác động của Pushdown:**
- **Join Pushdown:** Khi phép nối được đẩy xuống tầng lưu trữ, không cần tạo ra các tập dữ liệu trung gian lớn tại tầng SQL, do phép nối được thực hiện trực tiếp với dữ liệu thô từ tầng lưu trữ. Điều này không chỉ tiết kiệm tài nguyên mà còn giảm thiểu độ phức tạp của kế hoạch thực thi.
- **Derived Condition Pushdown:** Đẩy điều kiện từ các bảng phụ hoặc truy vấn con (subquery) xuống tầng lưu trữ giúp tránh việc tạo ra các tập dữ liệu trung gian lớn tại tầng SQL, chỉ giữ lại những dữ liệu cần thiết cho các bước tiếp theo.

### 5. **Cải thiện tính đồng thời và khả năng mở rộng**

**Nguyên lý cơ bản:**
Hệ thống cơ sở dữ liệu cần phải xử lý nhiều truy vấn đồng thời từ nhiều người dùng hoặc ứng dụng. Nếu mỗi truy vấn đều tốn nhiều tài nguyên, hệ thống có thể trở nên chậm chạp hoặc không thể đáp ứng kịp thời.

**Tác động của Pushdown:**
- **Parallelism tại tầng lưu trữ:** Một số hệ thống lưu trữ, như InnoDB trong MySQL, có thể xử lý các thao tác pushdown song song bằng cách sử dụng nhiều luồng. Điều này cho phép các truy vấn được xử lý nhanh hơn và hệ thống có thể xử lý nhiều truy vấn đồng thời mà không bị quá tải.
- **Giảm thiểu tải lên tầng SQL:** Khi tải lên tầng SQL giảm, tầng này có thể tập trung vào việc tối ưu hóa các bước khác của truy vấn, và xử lý được nhiều truy vấn hơn trong cùng một thời điểm.

### 6. **Cải thiện tính nhất quán và khả năng dự đoán**

**Nguyên lý cơ bản:**
Một hệ thống cơ sở dữ liệu tốt không chỉ cần nhanh mà còn phải ổn định và có khả năng dự đoán hiệu suất. Các biến động lớn về hiệu suất có thể làm gián đoạn dịch vụ và gây khó khăn trong việc duy trì chất lượng dịch vụ.

**Tác động của Pushdown:**
- **Hiệu suất nhất quán hơn:** Khi các thao tác nặng nề như lọc, tính toán, và nối được thực hiện tại tầng lưu trữ, các truy vấn phức tạp sẽ ít gặp phải những biến động lớn về thời gian thực thi. Điều này giúp duy trì hiệu suất ổn định hơn và dễ dự đoán hơn.
- **Giảm nguy cơ nghẽn cổ chai:** Bằng cách giảm bớt khối lượng công việc tại tầng SQL, pushdown giúp tránh được tình trạng nghẽn cổ chai tại các điểm quan trọng trong hệ thống, đảm bảo hệ thống không bị chậm lại đột ngột khi tải tăng cao.

### **Kết luận**

Sự hiệu quả của các kỹ thuật pushdown trong MySQL không chỉ đến từ việc giảm khối lượng dữ liệu cần xử lý mà còn từ việc tối ưu hóa cách thức hệ thống xử lý dữ liệu tại mỗi tầng. Bằng cách tận dụng tối đa khả năng của tầng lưu trữ, pushdown giúp giảm thiểu sự di chuyển dữ liệu không cần thiết, giảm tải bộ nhớ và CPU, cải thiện khả năng sử dụng bộ nhớ đệm, và tăng tính nhất quán trong hiệu suất hệ thống. Điều này không chỉ giúp cải thiện tốc độ truy vấn mà còn giúp hệ thống cơ sở dữ liệu hoạt động ổn định hơn, có khả năng mở rộng tốt hơn, và đáp ứng nhu cầu của người dùng một cách hiệu quả hơn.

====
====

## Example

Tất nhiên! Tôi sẽ cung cấp cho bạn một ví dụ cụ thể về việc sử dụng và không sử dụng predicate pushdown, cùng với phân tích chi tiết về hiệu suất. Chúng ta sẽ sử dụng một kịch bản thực tế và xem xét cách MySQL xử lý truy vấn trong cả hai trường hợp.

Giả sử chúng ta có một hệ thống bán hàng với các bảng sau:

```sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE INDEX idx_customer_city ON customers(city);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_product_category ON products(category);
```

Bây giờ, chúng ta có truy vấn sau:

```sql
SELECT c.name, o.order_date, SUM(oi.quantity * p.price) as total_value
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE c.city = 'Hanoi'
  AND o.order_date >= '2023-01-01'
  AND p.category = 'Electronics'
GROUP BY c.id, o.id
HAVING total_value > 10000000;
```

Trường hợp 1: Không sử dụng Predicate Pushdown

Nếu MySQL không sử dụng predicate pushdown, quá trình thực hiện có thể như sau:

1. Đọc tất cả bản ghi từ bảng `customers`.
2. Đọc tất cả bản ghi từ bảng `orders`.
3. Thực hiện JOIN giữa `customers` và `orders`.
4. Đọc tất cả bản ghi từ bảng `order_items`.
5. Thực hiện JOIN kết quả trước với `order_items`.
6. Đọc tất cả bản ghi từ bảng `products`.
7. Thực hiện JOIN kết quả trước với `products`.
8. Áp dụng các điều kiện WHERE.
9. Thực hiện GROUP BY.
10. Áp dụng điều kiện HAVING.

Kế hoạch thực thi có thể trông như sau:

```
1. Scan table customers
2. Nested loop join with orders
3. Nested loop join with order_items
4. Nested loop join with products
5. Filter rows (WHERE conditions)
6. Group and aggregate
7. Filter groups (HAVING condition)
```

Trường hợp 2: Sử dụng Predicate Pushdown

Với predicate pushdown, MySQL có thể tối ưu hóa truy vấn như sau:

1. Sử dụng chỉ mục `idx_customer_city` để nhanh chóng tìm khách hàng ở Hà Nội.
2. Sử dụng chỉ mục `idx_order_date` để tìm đơn hàng từ 2023-01-01.
3. Sử dụng chỉ mục `idx_product_category` để tìm sản phẩm thuộc danh mục Electronics.
4. Thực hiện JOIN giữa các kết quả đã được lọc.
5. Tính toán tổng giá trị và áp dụng điều kiện HAVING.

Kế hoạch thực thi có thể trông như sau:

```
1. Index scan on customers using idx_customer_city
2. Index scan on orders using idx_order_date
3. Index scan on products using idx_product_category
4. Hash join between filtered customers and orders
5. Hash join with filtered products
6. Nested loop join with order_items
7. Group and aggregate
8. Filter groups (HAVING condition)
```

So sánh hiệu suất:

1. Số lượng bản ghi được xử lý:
    - Không có pushdown: Xử lý tất cả bản ghi từ mỗi bảng.
    - Có pushdown: Chỉ xử lý các bản ghi phù hợp với điều kiện từ mỗi bảng.

2. Sử dụng chỉ mục:
    - Không có pushdown: Có thể không sử dụng hiệu quả các chỉ mục.
    - Có pushdown: Sử dụng tối đa các chỉ mục có sẵn.

3. Sử dụng bộ nhớ:
    - Không có pushdown: Cần nhiều bộ nhớ hơn để lưu trữ kết quả trung gian lớn.
    - Có pushdown: Sử dụng ít bộ nhớ hơn do xử lý ít bản ghi hơn.

4. Thời gian thực hiện:
    - Không có pushdown: Thời gian thực hiện lâu hơn do phải xử lý nhiều dữ liệu không cần thiết.
    - Có pushdown: Thời gian thực hiện nhanh hơn đáng kể.

Ví dụ về số liệu (giả định):

```
Không có Predicate Pushdown:
- Số bản ghi xử lý: 1,000,000
- Thời gian thực hiện: 10 giây
- Sử dụng bộ nhớ: 500MB

Có Predicate Pushdown:
- Số bản ghi xử lý: 50,000
- Thời gian thực hiện: 0.5 giây
- Sử dụng bộ nhớ: 50MB
```

Trong thực tế, sự khác biệt có thể còn lớn hơn, đặc biệt là với các cơ sở dữ liệu lớn và các truy vấn phức tạp.

Để xác nhận việc sử dụng predicate pushdown, bạn có thể sử dụng lệnh `EXPLAIN` trong MySQL để xem kế hoạch thực thi của truy vấn. Nếu bạn thấy các điều kiện được áp dụng sớm trong kế hoạch và có sử dụng các chỉ mục thích hợp, đó là dấu hiệu của việc áp dụng predicate pushdown.

=====
=====

## Make the most out of pushdown technique

Để tận dụng sức mạnh của kỹ thuật pushdown trong MySQL, bạn cần viết các câu lệnh SQL sao cho các điều kiện lọc, phép nối và các phép tính tổng hợp được thực thi tại tầng lưu trữ, thay vì xử lý toàn bộ tại tầng SQL. Dưới đây là một số nguyên tắc và ví dụ giúp bạn tối ưu câu lệnh SQL để MySQL có thể áp dụng pushdown hiệu quả.

### 1. **Sử dụng các điều kiện lọc sớm nhất có thể**

**Nguyên tắc:** Áp dụng điều kiện lọc ngay trong câu lệnh SQL của bạn, thay vì để nó ở các bước cuối của truy vấn. Điều này giúp MySQL lọc dữ liệu ngay từ tầng lưu trữ.

**Ví dụ:**
Thay vì:
```sql
SELECT * FROM employees;
-- Lọc ở ứng dụng hoặc tầng trên
```
Bạn nên:
```sql
SELECT * FROM employees WHERE salary > 50000;
```
Điều này sẽ giúp MySQL áp dụng Predicate Pushdown, chỉ lấy những dòng thỏa mãn điều kiện từ tầng lưu trữ.

### 2. **Chọn cột cụ thể thay vì `SELECT *`**

**Nguyên tắc:** Chỉ lấy các cột cần thiết thay vì toàn bộ bảng. Điều này giúp MySQL chỉ đọc dữ liệu từ các cột cần thiết tại tầng lưu trữ.

**Ví dụ:**
Thay vì:
```sql
SELECT * FROM employees WHERE department_id = 5;
```
Bạn nên:
```sql
SELECT name, salary FROM employees WHERE department_id = 5;
```
Việc chỉ chọn các cột `name` và `salary` sẽ kích hoạt Projection Pushdown, giúp giảm lượng dữ liệu được truyền tải.

### 3. **Sử dụng các phép tính tổng hợp tại tầng SQL**

**Nguyên tắc:** Khi sử dụng các hàm tổng hợp như `SUM`, `COUNT`, `AVG`, đảm bảo rằng chúng được áp dụng trực tiếp trong câu lệnh SQL để MySQL có thể đẩy các phép tính này xuống tầng lưu trữ.

**Ví dụ:**
Thay vì:
```sql
SELECT salary FROM employees;
-- Sau đó tính tổng lương ở ứng dụng
```
Bạn nên:
```sql
SELECT SUM(salary) FROM employees;
```
Điều này sẽ giúp MySQL thực hiện Function Pushdown, tính tổng ngay tại tầng lưu trữ và chỉ truyền một giá trị tổng duy nhất lên tầng SQL.

### 4. **Sử dụng phép nối (JOIN) một cách tối ưu**

**Nguyên tắc:** Đảm bảo rằng các điều kiện nối giữa các bảng được đặt trực tiếp trong câu lệnh `JOIN`. Điều này giúp MySQL đẩy phép nối xuống tầng lưu trữ, thay vì lấy toàn bộ dữ liệu về trước khi nối.

**Ví dụ:**
Thay vì:
```sql
SELECT * FROM employees e, departments d WHERE e.department_id = d.department_id;
```
Bạn nên:
```sql
SELECT e.name, d.department_name 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id;
```
Việc sử dụng phép nối rõ ràng sẽ kích hoạt Join Pushdown, giúp MySQL xử lý phép nối ngay tại tầng lưu trữ.

### 5. **Sử dụng các bảng phụ (Derived Tables) một cách cẩn thận**

**Nguyên tắc:** Khi sử dụng các bảng phụ hoặc subquery, đảm bảo rằng điều kiện lọc và phép tính tổng hợp nằm bên trong bảng phụ để MySQL có thể áp dụng Derived Condition Pushdown.

**Ví dụ:**
Thay vì:
```sql
SELECT * FROM (SELECT * FROM orders) AS sub WHERE sub.order_total > 1000;
```
Bạn nên:
```sql
SELECT * FROM (SELECT * FROM orders WHERE order_total > 1000) AS sub;
```
Điều này sẽ giúp MySQL đẩy điều kiện `order_total > 1000` xuống tầng lưu trữ trước khi tạo bảng phụ.

### 6. **Sử dụng chỉ mục hợp lý**

**Nguyên tắc:** Để MySQL có thể thực hiện pushdown hiệu quả, đặc biệt là Predicate Pushdown và Join Pushdown, bạn cần đảm bảo rằng các cột được sử dụng trong điều kiện `WHERE` và `JOIN` có chỉ mục (index). Điều này giúp MySQL tìm kiếm và lọc dữ liệu nhanh hơn ngay tại tầng lưu trữ.

**Ví dụ:**
Nếu bạn thường xuyên chạy truy vấn với điều kiện `WHERE department_id`, hãy tạo chỉ mục trên cột `department_id`:
```sql
CREATE INDEX idx_department ON employees(department_id);
```
Điều này sẽ giúp MySQL sử dụng chỉ mục để lọc nhanh chóng và kích hoạt các kỹ thuật pushdown.

### Kết luận

- Sử dụng các điều kiện lọc trực tiếp trong câu lệnh `WHERE` để tận dụng Predicate Pushdown.
- Chọn các cột cụ thể để tận dụng Projection Pushdown.
- Sử dụng các phép tính tổng hợp ngay trong câu lệnh SQL để tận dụng Function Pushdown.
- Tối ưu hóa các phép nối với các điều kiện nối rõ ràng để kích hoạt Join Pushdown.
- Sử dụng chỉ mục trên các cột thường xuyên được truy vấn để hỗ trợ các kỹ thuật pushdown.

Việc viết câu lệnh SQL tuân theo các nguyên tắc trên sẽ giúp MySQL áp dụng các kỹ thuật pushdown một cách hiệu quả, từ đó cải thiện hiệu suất truy vấn và giảm tải tài nguyên hệ thống.
