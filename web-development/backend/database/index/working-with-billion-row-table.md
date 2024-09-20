### Working with a billion row table

Khi xử lý những bảng dữ liệu rất lớn (**billion row tables**) như trong bài toán của Twitter với các mối quan hệ "follower-following", ta cần các kỹ thuật để tối ưu hóa việc tìm kiếm và lưu trữ dữ liệu. Dưới đây là 5 giải pháp chính, cùng với giải thích ngắn gọn:

1. **Brute Force (Cách làm thủ công)**:
    - **Cách làm**: Chia bảng thành các phần nhỏ và xử lý đồng thời bằng nhiều luồng (**multithreading**) hoặc nhiều tiến trình (**multiprocessing**).
    - **Ví dụ**: Giống như bạn có 1000 trang sách cần tìm, bạn chia cho 10 người, mỗi người tìm trên 100 trang để tìm nhanh hơn.
    - **Điểm mạnh**: Tăng tốc bằng cách chia việc cho nhiều người (hoặc máy).
    - **Điểm yếu**: Không hiệu quả nếu bảng quá lớn và máy chủ không đủ mạnh.

2. **Indexing (Tạo chỉ mục)**:
    - **Cách làm**: Tạo chỉ mục (**index**) trên cột chứa thông tin quan trọng. Chỉ mục như là một thư mục giúp bạn tìm nhanh dữ liệu cần.
    - **Ví dụ**: Thay vì tìm cả sách để tra tên người, bạn dùng chỉ mục bảng chữ cái để tìm nhanh hơn.
    - **Điểm mạnh**: Giảm số lượng hàng cần tìm kiếm, tiết kiệm thời gian.
    - **Điểm yếu**: Tạo chỉ mục sẽ chiếm thêm dung lượng và cần thời gian cập nhật.

3. **Partitioning (Phân mảnh)**:
    - **Cách làm**: Chia bảng thành nhiều phân vùng nhỏ hơn, gọi là phân mảnh (**partitioning**), thường theo từng khoảng giá trị. Dữ liệu mỗi phân vùng lưu ở vị trí khác nhau trên ổ cứng.
    - **Ví dụ**: Chia danh sách 1000 người thành các phân vùng A-D, E-H,... để dễ tìm hơn.
    - **Điểm mạnh**: Giảm dữ liệu cần tìm trong một lần truy vấn.
    - **Điểm yếu**: Phải biết cách chọn **partition key** phù hợp để tìm đúng phân vùng.

4. **Sharding (Phân tán dữ liệu)**:
    - **Cách làm**: Chia bảng ra và lưu trên nhiều máy chủ khác nhau. Mỗi máy chỉ chứa một phần nhỏ dữ liệu, gọi là **shard**.
    - **Ví dụ**: Chia danh sách 1000 người ra nhiều máy chủ, mỗi máy chỉ lưu 200 người.
    - **Điểm mạnh**: Giảm tải cho hệ thống khi xử lý dữ liệu lớn.
    - **Điểm yếu**: Phức tạp trong việc đảm bảo tính toàn vẹn dữ liệu giữa các **shard**.

5. **Asynchronous Write (Ghi nhận không đồng bộ)**:
    - **Cách làm**: Khi có người theo dõi người khác, thay vì cập nhật ngay lập tức, ta dùng **message queue** để xử lý sau trong nền.
    - **Ví dụ**: Giống như khi bạn nhắn tin, tin nhắn có thể không gửi ngay lập tức mà đợi một lát để gửi.
    - **Điểm mạnh**: Giảm tải hệ thống khi có nhiều người dùng hoạt động cùng lúc.
    - **Điểm yếu**: Có thể có độ trễ nhỏ trong việc cập nhật dữ liệu.

---

### Dễ ghi nhớ hơn với ví dụ thực tế:
- **Brute Force**: Giống như khi bạn cố tìm một thứ gì đó bằng cách kiểm tra từng thứ một.
- **Indexing**: Giống như có một bảng tra cứu để tìm kiếm nhanh.
- **Partitioning**: Chia dữ liệu thành từng phần để dễ xử lý.
- **Sharding**: Chia dữ liệu trên nhiều máy để giảm tải.
- **Asynchronous Write**: Xử lý các yêu cầu trong nền để hệ thống không bị chậm.

Những giải pháp này giúp quản lý bảng dữ liệu khổng lồ một cách hiệu quả, đặc biệt với hệ thống lớn như Twitter, nơi có hàng tỷ kết nối người dùng.

----
> Khi xem xét vấn đề về mặt tư duy xử lý, các kỹ thuật như Brute Force, Indexing, Partitioning, Sharding, và Asynchronous Write đều nhằm mục tiêu duy nhất: **giảm thiểu khối lượng công việc cần xử lý để tối ưu hóa hiệu suất của hệ thống**. Chúng giúp chúng ta tư duy có hệ thống khi đối mặt với các bảng dữ liệu khổng lồ, bằng cách chia nhỏ vấn đề và giải quyết từng phần một cách hiệu quả.

