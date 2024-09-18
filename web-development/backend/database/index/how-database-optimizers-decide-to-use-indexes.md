## References
- https://www.udemy.com/course/database-engines-crash-course/learn/lecture/25739154#content

=====

Cách **bộ tối ưu hóa cơ sở dữ liệu** quyết định sử dụng chỉ mục nào khi có nhiều chỉ mục trong một bảng, và giải thích các kịch bản khác nhau về quyết định này. Dưới đây là phần giải thích chi tiết:

### 1. **Kịch bản có nhiều chỉ mục**:
Khi bảng có nhiều chỉ mục, ví dụ như trên các cột `F1` và `F2`, bộ tối ưu hóa phải quyết định có nên:
- Sử dụng cả hai chỉ mục và hợp nhất kết quả.
- Chỉ sử dụng một chỉ mục và áp dụng bộ lọc cho điều kiện còn lại.
- Bỏ qua cả hai chỉ mục nếu chúng không hiệu quả và thay vào đó quét toàn bộ bảng.

Ví dụ với câu truy vấn `SELECT * FROM table WHERE F1 = 1 AND F2 = 4`, bộ tối ưu hóa sẽ xem xét những phương án này để đưa ra quyết định.

### 2. **Kịch bản 1 – Sử dụng cả hai chỉ mục**:
Trong trường hợp này, bộ tối ưu hóa sẽ thực hiện truy vấn trên chỉ mục `F1` để tìm các hàng khớp với `F1 = 1`, sau đó truy vấn trên chỉ mục `F2` để tìm các hàng khớp với `F2 = 4`. Sau khi thu thập kết quả từ cả hai chỉ mục, nó sẽ thực hiện giao (nếu điều kiện là `AND`) hoặc hợp (nếu điều kiện là `OR`) các tập kết quả. Cách tiếp cận này được lựa chọn khi bộ tối ưu hóa ước tính rằng kết quả trả về sẽ nhỏ và hiệu quả khi xử lý.

### 3. **Kịch bản 2 – Chỉ sử dụng một chỉ mục**:
Nếu bộ tối ưu hóa nhận thấy rằng chỉ cần sử dụng một chỉ mục là đủ, nó có thể chỉ sử dụng chỉ mục `F1`, lấy các hàng liên quan, sau đó áp dụng điều kiện `F2 = 4` như một bộ lọc trên các hàng đã được chọn. Điều này xảy ra khi bộ tối ưu hóa ước tính rằng chỉ mục `F1` sẽ trả về ít hàng hơn so với chỉ mục `F2`. Điều này thường dựa trên **thống kê** mà cơ sở dữ liệu thu thập về dữ liệu, chẳng hạn như số lượng giá trị duy nhất trong mỗi cột.

### 4. **Kịch bản 3 – Bỏ qua cả hai chỉ mục**:
Có lúc bộ tối ưu hóa quyết định rằng cả hai chỉ mục đều không hiệu quả, đặc biệt khi ước tính rằng tập kết quả trả về sẽ rất lớn (ví dụ, câu truy vấn sẽ trả về hầu hết các hàng trong bảng). Trong trường hợp này, bộ tối ưu hóa có thể chọn **quét toàn bộ bảng**, vì điều này đôi khi hiệu quả hơn so với việc phải duyệt qua cấu trúc cây B-tree của các chỉ mục.

### 5. **Thống kê và bộ tối ưu hóa**:
Bộ tối ưu hóa phụ thuộc rất nhiều vào **thống kê bảng** – đây là những thông tin cho biết có bao nhiêu hàng trong bảng, tần suất xuất hiện của các giá trị trong cột, và các thông tin quan trọng khác. Tuy nhiên, những thống kê này không phải lúc nào cũng được cập nhật kịp thời, đặc biệt sau khi thực hiện các thao tác chèn dữ liệu số lượng lớn. Nếu thống kê không được cập nhật, bộ tối ưu hóa có thể đưa ra các quyết định không tối ưu, chẳng hạn như quét toàn bộ bảng vì nó nghĩ rằng bảng chỉ có vài hàng trong khi thực tế có hàng triệu hàng. Vì vậy, cần chạy các lệnh như `ANALYZE` (trong PostgreSQL) hoặc `GATHER STATISTICS` (trong Oracle) sau khi có thay đổi lớn trong dữ liệu để cập nhật thống kê.

### 6. **Sử dụng gợi ý trong cơ sở dữ liệu**:
Trong một số trường hợp, lập trình viên có thể cung cấp **gợi ý** cho bộ tối ưu hóa, buộc nó sử dụng một chỉ mục cụ thể hoặc một kế hoạch thực thi nhất định. Điều này rất hữu ích khi bạn biết rằng thống kê của cơ sở dữ liệu chưa được cập nhật hoặc khi bạn có kiến thức đặc biệt về truy vấn mà bộ tối ưu hóa không có.

### 7. **Tác động của các điều kiện AND và OR**:
Quyết định của bộ tối ưu hóa cũng thay đổi tùy thuộc vào việc các điều kiện trong truy vấn được kết hợp bằng `AND` hay `OR`. Với `AND`, bộ tối ưu hóa thường ưu tiên chỉ mục trả về ít hàng hơn, vì kết quả cuối cùng sẽ nhỏ hơn. Với `OR`, kết quả có thể lớn hơn, và quá trình quyết định trở nên phức tạp hơn.

### 8. **Ví dụ thực tế**:
Một ví dụ được đưa ra là về cơ sở dữ liệu khách hàng có chỉ mục trên cột `state` (bang). Nếu hầu hết các hàng trong bảng có giá trị `California`, chỉ mục trên cột này trở nên gần như vô dụng cho các truy vấn liên quan đến `California` vì nó sẽ trả về hầu hết bảng. Tuy nhiên, nếu chỉ có vài hàng thuộc về các bang như `Texas` hoặc `Florida`, chỉ mục sẽ trở nên rất có giá trị cho các truy vấn tìm kiếm trong những bang này.

### **Tóm lại**:
Quyết định của bộ tối ưu hóa phụ thuộc nhiều vào thống kê của bảng, kích thước ước tính của tập kết quả, và chi phí của việc quét chỉ mục so với việc quét bảng. Hiểu rõ cách bộ tối ưu hóa hoạt động có thể giúp bạn quyết định xem bảng của mình có cần thêm chỉ mục hay không, và cách điều chỉnh truy vấn của bạn để có hiệu suất tốt hơn.