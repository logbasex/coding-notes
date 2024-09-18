## InnoDB create index concurrently

Trong MySQL 5.6, khả năng thực hiện các thao tác đọc và ghi trong khi tạo chỉ mục trên bảng InnoDB mà không khóa toàn bộ bảng là một cải tiến quan trọng. Dưới đây là giải thích chi tiết về cách MySQL thực hiện điều này ở cấp độ thấp:

### 1. **Tạo chỉ mục trực tuyến trong InnoDB**

Trước MySQL 5.6, khi tạo một chỉ mục mới, bảng sẽ bị khóa, ngăn không cho các thao tác đọc và ghi xảy ra cho đến khi quá trình tạo chỉ mục hoàn tất. Điều này có thể gây ra sự gián đoạn lớn nếu bảng chứa nhiều dữ liệu hoặc khi cần chỉ mục mới để tối ưu hóa hiệu suất truy vấn.

Với MySQL 5.6 trở đi, việc tạo chỉ mục trực tuyến (online DDL) cho phép quá trình tạo chỉ mục diễn ra ở chế độ nền, đồng thời vẫn cho phép đọc và ghi dữ liệu bình thường.

### 2. **Quy trình tạo chỉ mục trực tuyến**

Khi tạo chỉ mục trực tuyến, MySQL thực hiện các bước sau để đảm bảo tính toàn vẹn và hiệu quả của quá trình này:

#### **Giai đoạn 1: Chuẩn bị cho thao tác trực tuyến**
- Bảng vẫn cho phép các thao tác đọc và ghi.
- MySQL sẽ ghi lại các thay đổi mới phát sinh (các thao tác chèn, cập nhật, xóa) vào một bộ đệm riêng gọi là *change buffer*. Bộ đệm này giúp đảm bảo rằng tất cả các thay đổi trong suốt quá trình tạo chỉ mục sẽ được phản ánh trong chỉ mục mới.

#### **Giai đoạn 2: Xây dựng chỉ mục**
- MySQL tiến hành quét dữ liệu hiện tại trong bảng để bắt đầu xây dựng chỉ mục mới, nhưng thay vì khóa bảng, chỉ mục được xây dựng dần dần trong chế độ nền. Điều này cho phép các truy vấn đọc và ghi vẫn tiếp tục.
- Trong khi đó, các thay đổi đối với bảng tiếp tục được ghi vào *change buffer*, giúp giảm xung đột giữa việc cập nhật và tạo chỉ mục.

#### **Giai đoạn 3: Áp dụng các thay đổi từ bộ đệm**
- Sau khi hoàn tất việc xây dựng chỉ mục cho tập dữ liệu hiện tại, MySQL áp dụng các thay đổi đã được ghi lại trong *change buffer*. Điều này đảm bảo chỉ mục mới sẽ bao gồm tất cả các thay đổi mới nhất.
- Trong giai đoạn này, MySQL sẽ cẩn thận quản lý sự đồng bộ giữa các thao tác ghi tiếp theo và việc áp dụng thay đổi từ bộ đệm để tránh xung đột dữ liệu.

#### **Giai đoạn 4: Hoàn tất**
- Sau khi các thay đổi được áp dụng, MySQL sẽ hoàn tất chỉ mục mới và làm cho nó sẵn sàng cho tất cả các truy vấn. Các thao tác đang bị trì hoãn trong quá trình tạo chỉ mục sẽ được xử lý, đảm bảo không có dữ liệu nào bị mất hoặc không nhất quán.

### 3. **Cơ chế nền tảng hỗ trợ**

#### **MVCC (Kiểm soát song song đa phiên bản)**
InnoDB sử dụng cơ chế MVCC (Multiversion Concurrency Control) để cho phép các giao dịch thấy được trạng thái dữ liệu nhất quán ngay cả khi chỉ mục đang được tạo. Điều này giúp cô lập các thao tác đọc khỏi các thao tác ghi, đảm bảo quá trình tạo chỉ mục không ảnh hưởng đến tính toàn vẹn của dữ liệu.

#### **Change Buffering (Bộ đệm thay đổi)**
Change buffering là một cơ chế quan trọng trong quá trình này. Thay vì áp dụng ngay lập tức các thay đổi vào chỉ mục mới, MySQL ghi lại chúng trong bộ đệm và chỉ áp dụng chúng khi quá trình tạo chỉ mục hoàn tất. Điều này giúp giảm tải trong quá trình xây dựng chỉ mục.

#### **Chiến lược khóa**
InnoDB sử dụng khóa ở mức hàng (row-level locking) thay vì khóa toàn bộ bảng trong quá trình tạo chỉ mục. Điều này cho phép các truy vấn đọc và ghi tiếp tục mà không gặp nhiều trở ngại.

#### **Quản lý song song**
MySQL cẩn thận quản lý các thao tác song song bằng cách xếp hàng các thao tác ghi, đảm bảo các thay đổi được áp dụng theo đúng thứ tự mà không làm gián đoạn các giao dịch đang diễn ra.

### 4. **Tác động đến hiệu suất I/O và CPU**

- **I/O**: Việc tạo chỉ mục ở chế độ nền giúp giảm tình trạng tranh chấp I/O, vốn thường xảy ra khi chỉ mục được xây dựng trong một lần duy nhất. Bằng cách tạo chỉ mục dần dần và trì hoãn áp dụng các thay đổi, MySQL tránh gây quá tải cho hệ thống I/O.

- **CPU**: Quá trình tạo chỉ mục nền phân bổ công việc cho CPU một cách hợp lý hơn theo thời gian. Trong khi CPU vẫn tham gia vào việc sắp xếp và tổ chức dữ liệu cho chỉ mục mới, quá trình này có thể diễn ra mà không làm chậm các thao tác khác.

### 5. **Xử lý lỗi và phục hồi**

Nếu quá trình tạo chỉ mục gặp lỗi ở bất kỳ giai đoạn nào, MySQL có thể hoàn tác quá trình mà không ảnh hưởng đến các giao dịch đang diễn ra. Điều này là nhờ vào việc các thay đổi được cô lập trong *change buffer*, và bảng gốc vẫn giữ nguyên tính nhất quán.

### 6. **Tóm tắt**

Nhờ vào các cơ chế như buffering, MVCC, và khóa ở mức hàng, MySQL 5.6 cho phép tạo chỉ mục ở chế độ nền mà không ảnh hưởng đến khả năng truy cập dữ liệu, mang lại sự linh hoạt và hiệu quả cao hơn trong việc xử lý các thay đổi của cơ sở dữ liệu.

=====
=====

## Khi MySQL vừa xử lý xong các thay đổi trong change buffer, nếu lại có thêm các thay đổi mới, thì liệu MySQL có quyết định hoàn tất việc tạo chỉ mục ngay lập tức hay lại tiếp tục xử lý các thay đổi mới trong change buffer? Và nếu cứ tiếp tục như thế, quá trình tạo chỉ mục có bị kéo dài mãi mãi không?

Để giải thích điều này rõ ràng hơn:

### 1. **Quy trình tạo chỉ mục trực tuyến và *change buffer***

- Trong quá trình tạo chỉ mục trực tuyến (online index creation), MySQL có thể tiếp nhận các thao tác thay đổi dữ liệu (INSERT, UPDATE, DELETE) trong khi vẫn tạo chỉ mục. Những thay đổi này được lưu vào *change buffer*.
- *Change buffer* hoạt động như một vùng đệm giúp MySQL quản lý các thay đổi mà không cần phải dừng quá trình tạo chỉ mục.

### 2. **Khi nào MySQL quyết định hoàn tất việc tạo chỉ mục?**

MySQL **sẽ luôn hoàn tất** việc tạo chỉ mục khi quá trình chính của việc xây dựng chỉ mục cho dữ liệu hiện có ban đầu đã hoàn thành. Khi đó, ngay cả khi có thêm thay đổi mới trong *change buffer*, điều đó **không ngăn cản** MySQL hoàn tất quá trình tạo chỉ mục.

Dưới đây là cách MySQL xử lý:

- **Quá trình chính tạo chỉ mục**: Khi MySQL xây dựng chỉ mục dựa trên dữ liệu hiện có, quá trình này không bị gián đoạn bởi *change buffer*. Đây là phần chính của quá trình tạo chỉ mục và sẽ được thực hiện cho toàn bộ dữ liệu ban đầu trong bảng.

- **Hợp nhất các thay đổi từ *change buffer***: Sau khi tạo chỉ mục cho dữ liệu ban đầu, MySQL sẽ áp dụng các thay đổi từ *change buffer* vào chỉ mục. Quá trình này được thực hiện theo từng đợt nhỏ và không phải tất cả thay đổi đều cần được áp dụng ngay lập tức.

### 3. **Quá trình xử lý liên tục của *change buffer***

Khi MySQL vừa hợp nhất xong một loạt thay đổi từ *change buffer* và lại có thêm thay đổi mới, MySQL **không cần phải dừng việc tạo chỉ mục để chờ hợp nhất tất cả các thay đổi mới**. Thay vào đó, nó sẽ hoàn tất chỉ mục với dữ liệu hiện có và sau đó:

- **Chỉ mục sẽ được hoàn tất và khả dụng**: Sau khi xây dựng chỉ mục xong cho dữ liệu ban đầu và áp dụng phần lớn các thay đổi từ *change buffer*, MySQL sẽ quyết định hoàn tất quá trình tạo chỉ mục. Chỉ mục lúc này đã sẵn sàng cho các truy vấn.

- **Xử lý các thay đổi mới sau đó**: Các thay đổi mới có thể tiếp tục được xử lý sau khi chỉ mục đã hoàn thành. Điều này có nghĩa là, ngay cả khi MySQL vẫn phải tiếp tục xử lý *change buffer*, chỉ mục vẫn đã sẵn sàng để sử dụng cho các truy vấn.

### 4. **Tại sao chỉ mục **vẫn hoàn tất** và không bị kéo dài mãi mãi?**

- **MySQL tách biệt quá trình tạo chỉ mục và xử lý *change buffer***: Quá trình chính của việc tạo chỉ mục (dựa trên dữ liệu ban đầu) và quá trình hợp nhất các thay đổi từ *change buffer* là hai quá trình **tách biệt**. Chỉ mục chính sẽ được hoàn tất trước, còn việc xử lý *change buffer* sẽ tiếp tục sau đó mà không ngăn cản việc hoàn tất chỉ mục.

- **Ưu tiên xử lý chỉ mục**: Khi dữ liệu trong *change buffer* quá nhiều, MySQL có thể ưu tiên việc hợp nhất các thay đổi để đảm bảo rằng chỉ mục vẫn được hoàn tất đúng thời hạn.

- **Hợp nhất *change buffer* theo đợt**: Thay vì phải hợp nhất tất cả thay đổi từ *change buffer* ngay lập tức, MySQL xử lý chúng từng đợt. Điều này đảm bảo rằng MySQL không bị "kẹt" trong việc xử lý thay đổi liên tục và chỉ mục vẫn có thể hoàn thành.

### 5. **Ví dụ minh họa chi tiết**

Giả sử bạn đang tạo chỉ mục `idx_age` cho bảng `employees`, và trong quá trình đó, liên tục có nhiều thay đổi xảy ra. Quá trình diễn ra như sau:

1. **Bước 1: Bắt đầu tạo chỉ mục**  
   Bạn chạy câu lệnh:
   ```sql
   ALTER TABLE employees ADD INDEX idx_age(age);
   ```
   MySQL bắt đầu tạo chỉ mục trên cột `age`.

2. **Bước 2: Liên tục có thay đổi**  
   Trong lúc MySQL tạo chỉ mục, nhiều thao tác thay đổi dữ liệu xảy ra, ví dụ:
   ```sql
   INSERT INTO employees (id, name, age) VALUES (101, 'John', 35);
   UPDATE employees SET age = 40 WHERE id = 5;
   DELETE FROM employees WHERE id = 10;
   ```
   Những thay đổi này sẽ được lưu vào *change buffer* và MySQL tiếp tục tạo chỉ mục trên dữ liệu hiện có.

3. **Bước 3: MySQL xử lý *change buffer***  
   MySQL sẽ hợp nhất các thay đổi từ *change buffer* vào chỉ mục theo từng đợt. Ví dụ, nó áp dụng thay đổi của `John (age = 35)` và cập nhật `age = 40` của `id = 5` vào chỉ mục mới.

4. **Bước 4: Thêm thay đổi mới**  
   Trong lúc MySQL vừa hợp nhất xong *change buffer*, lại có thêm thay đổi mới:
   ```sql
   INSERT INTO employees (id, name, age) VALUES (102, 'Alice', 28);
   ```
   Thay đổi này sẽ lại được ghi vào *change buffer*, nhưng điều này **không ngăn** MySQL hoàn thành việc tạo chỉ mục với dữ liệu hiện có.

5. **Bước 5: Hoàn tất chỉ mục**  
   MySQL hoàn thành việc xây dựng chỉ mục `idx_age` với dữ liệu hiện có và chỉ mục trở nên **sẵn sàng cho các truy vấn**. Dù vẫn còn thay đổi mới trong *change buffer*, chỉ mục vẫn đã hoàn tất và có thể sử dụng.

6. **Bước 6: Xử lý các thay đổi mới**  
   Sau khi chỉ mục được hoàn tất và khả dụng, MySQL tiếp tục hợp nhất các thay đổi mới từ *change buffer* mà không làm gián đoạn quá trình truy vấn chỉ mục.

### Tóm tắt:
- MySQL **sẽ không trì hoãn vô thời hạn** việc hoàn thành chỉ mục chỉ vì có thay đổi liên tục trong *change buffer*.
- Quá trình chính của việc tạo chỉ mục được ưu tiên hoàn thành trước, và *change buffer* được xử lý theo từng đợt sau đó.
- Chỉ mục sẽ **hoàn tất** và sẵn sàng cho sử dụng ngay cả khi còn thay đổi trong *change buffer* chưa được áp dụng.

====
====

## Luc nao change buffer duoc su dung?

Sau khi chỉ mục (index) được tạo xong và sẵn sàng sử dụng, các thay đổi mới (như `INSERT`, `UPDATE`, `DELETE`) **sẽ được ghi trực tiếp vào cả bảng và chỉ mục**, thay vì chỉ được lưu tạm trong *change buffer*. Điều này có nghĩa là:

### 1. **Thay đổi trực tiếp trên chỉ mục**:
- Khi bạn thực hiện một thao tác ghi như thêm mới bản ghi (`INSERT`), cập nhật bản ghi (`UPDATE`), hoặc xóa bản ghi (`DELETE`), MySQL sẽ **đồng bộ hóa** thay đổi này cả vào bảng và các chỉ mục liên quan. Các thay đổi sẽ được áp dụng ngay lập tức vào chỉ mục mà không cần đi qua *change buffer*.

Ví dụ:
- **INSERT**: Thêm bản ghi mới sẽ ghi trực tiếp vào bảng và đồng thời cập nhật chỉ mục để phản ánh bản ghi mới này.
- **UPDATE**: Nếu cập nhật cột có liên quan đến chỉ mục (ví dụ cột `age` đã có chỉ mục), MySQL sẽ cập nhật trực tiếp trên chỉ mục tương ứng.
- **DELETE**: Khi xóa bản ghi, MySQL cũng sẽ xóa bản ghi đó khỏi chỉ mục liên quan.

### 2. **Khi nào *change buffer* được sử dụng?**

- *Change buffer* chỉ được sử dụng trong **quá trình tạo chỉ mục** trực tuyến, khi chỉ mục chưa hoàn toàn sẵn sàng và MySQL cần một nơi tạm thời để lưu các thay đổi.
- Sau khi chỉ mục đã được tạo hoàn toàn, MySQL **không còn sử dụng *change buffer*** cho các thao tác trên chỉ mục nữa. Thay vào đó, các thay đổi sẽ trực tiếp cập nhật vào chỉ mục.

### 3. **Lợi ích của việc cập nhật trực tiếp vào chỉ mục**

- **Truy vấn nhanh hơn**: Khi các thay đổi được ghi trực tiếp vào chỉ mục, các truy vấn liên quan đến chỉ mục đó sẽ có thể tận dụng ngay lập tức các thay đổi mới mà không cần phải hợp nhất thêm từ *change buffer*.

- **Giảm độ trễ**: So với việc sử dụng *change buffer*, việc cập nhật trực tiếp vào chỉ mục sẽ giảm độ trễ trong việc phản ánh các thay đổi mới vào chỉ mục, giúp hệ thống hoạt động nhanh hơn và hiệu quả hơn.

### 4. **Tóm tắt quá trình sau khi chỉ mục hoàn thành:**

- **Trước khi chỉ mục hoàn thành**: Thay đổi được lưu vào *change buffer*, sau đó được hợp nhất dần vào chỉ mục.
- **Sau khi chỉ mục hoàn thành**: Các thay đổi sẽ **trực tiếp ghi vào cả bảng và chỉ mục**, không còn cần thông qua *change buffer* nữa.

### 5. **Ví dụ chi tiết**:

Giả sử bạn đã tạo xong chỉ mục `idx_age` trên cột `age` trong bảng `employees`:

#### Trước khi chỉ mục hoàn thành:
1. Bạn thực hiện thao tác:
   ```sql
   INSERT INTO employees (id, name, age) VALUES (104, 'Tom', 25);
   ```
    - Bản ghi mới sẽ được lưu tạm vào *change buffer*, và sau đó sẽ được hợp nhất vào chỉ mục `idx_age` sau khi chỉ mục hoàn tất.

#### Sau khi chỉ mục hoàn thành:
2. Sau khi chỉ mục `idx_age` đã được tạo hoàn tất:
   ```sql
   INSERT INTO employees (id, name, age) VALUES (105, 'Lisa', 30);
   ```
    - Bản ghi `Lisa` sẽ được **ghi trực tiếp vào bảng và cập nhật ngay lập tức trong chỉ mục** `idx_age`, giúp chỉ mục phản ánh tức thì thay đổi và sẵn sàng cho các truy vấn.

### **Kết luận**:
- **Sau khi chỉ mục được tạo xong**, các thay đổi sẽ **không còn đi qua *change buffer*** mà được ghi trực tiếp vào chỉ mục. Điều này giúp tối ưu hóa hiệu suất và đảm bảo chỉ mục luôn cập nhật tức thì với mọi thay đổi mới.