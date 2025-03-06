# 📌 **Giải thích chi tiết lý thuyết về Event Sourcing + CQRS và sự khác biệt với hệ thống truyền thống chỉ có Database**

Bạn muốn có một **giải thích chi tiết hơn về mặt lý thuyết**, tôi sẽ **phân tích từng khía cạnh** để bạn hiểu sâu hơn về lý do **Event Sourcing + CQRS** khác biệt so với **hệ thống truyền thống CRUD chỉ có Database**.

---

# 🚀 **1. Cấu trúc dữ liệu trong hệ thống truyền thống vs. Event Sourcing**
### **Hệ thống truyền thống CRUD**
Trong hệ thống CRUD (**Create, Read, Update, Delete**), dữ liệu được lưu trữ dưới dạng **trạng thái cuối cùng**. Khi bạn cập nhật dữ liệu, hệ thống sẽ **ghi đè lên bản ghi cũ**, chỉ giữ lại trạng thái hiện tại.

💡 
**Ví dụ: Một User có số dư ban đầu 1000, sau đó đặt cược 200**

| **User ID** | **Balance** |
|-------------|-------------|
| 1           | 1000        |
| **(Sau khi đặt cược - UPDATE)** |             |
| 1           | 800         |

📌 **Điểm quan trọng**:
- **Không có lịch sử giao dịch**, chỉ có giá trị cuối cùng.
- **Không thể biết được tại sao số dư lại là 800**, vì bản ghi cũ đã bị ghi đè.

---

### **Hệ thống Event Sourcing**
Thay vì lưu **trạng thái cuối cùng**, hệ thống lưu **toàn bộ các sự kiện xảy ra theo thời gian**, tạo thành một chuỗi lịch sử.

💡 **Ví dụ: Dữ liệu Event Sourcing của User đặt cược 200**

| **Event ID** | **User ID** | **Event Type** | **Amount** | **New Balance** | **Timestamp** |
|------------|----------|-------------|---------|--------------|--------------|
| 1 | 1 | AccountCreated | 1000 | 1000 | 12:00 |
| 2 | 1 | BetPlaced | -200 | 800 | 12:05 |

📌 **Điểm quan trọng**:
- **Lịch sử đầy đủ của User**, có thể biết **mọi thay đổi đã xảy ra**.
- **Không có UPDATE, chỉ có sự kiện mới được thêm vào**.

🔥 **Lợi ích của Event Sourcing**:
- **Có thể khôi phục lại trạng thái cũ bất cứ lúc nào** bằng cách **replay lại tất cả sự kiện**.
- **Không mất dữ liệu lịch sử**, giúp kiểm tra giao dịch và phát hiện lỗi dễ dàng hơn.
- **Dễ dàng rollback nếu có lỗi** → chỉ cần hủy bỏ các sự kiện sai.

---

# 🎯 **2. Vấn đề nhất quán dữ liệu (Data Consistency)**
### **Hệ thống truyền thống: Tính nhất quán mạnh (Strong Consistency)**
- Khi user đặt cược, hệ thống **cập nhật trực tiếp vào database**.
- Nếu một giao dịch thất bại, hệ thống phải **rollback ngay lập tức** bằng cơ chế ACID của database.

📌 **Hạn chế**:
- **Hiệu suất thấp khi tải cao** → vì mọi giao dịch đều phải cập nhật trực tiếp database.
- **Khó mở rộng** → phải giữ **database transaction atomicity**.

---

### **Event Sourcing: Tính nhất quán cuối cùng (Eventual Consistency)**
- Khi user đặt cược, hệ thống **ghi sự kiện vào Event Store trước**, không cập nhật database ngay lập tức.
- Một **Event Processor (background job)** sẽ đọc sự kiện và cập nhật hệ thống sau.

📌 **Ưu điểm**:
- **Hiệu suất cao hơn** vì việc cập nhật database được xử lý **bất đồng bộ**.
- **Dễ mở rộng** vì các service chỉ cần subscribe vào sự kiện mà không cần gọi API đồng bộ.

🔥 **Tính nhất quán cuối cùng hoạt động như thế nào?**
1. **User đặt cược → Hệ thống ghi sự kiện `BetPlaced` vào Event Store**.
2. **Event Processor xử lý sự kiện** → cập nhật số dư user, lưu thông tin cược.
3. **Read Model được cập nhật** → User có thể thấy cược trong lịch sử.

⏳ Nếu bước 2 bị trễ vài mili-giây, hệ thống vẫn **đảm bảo dữ liệu cuối cùng sẽ chính xác**.

---

# 🔥 **3. So sánh cách xử lý giao dịch**
## ✅ **Hệ thống truyền thống CRUD**
💡 **Ví dụ: Một User đặt cược 200**
1. **Bước 1:** Kiểm tra số dư (`SELECT balance FROM users WHERE id = 1`)
2. **Bước 2:** Nếu đủ tiền, cập nhật (`UPDATE users SET balance = balance - 200 WHERE id = 1`)
3. **Bước 3:** Lưu cược (`INSERT INTO bets (user_id, match_id, amount, status) VALUES (1, 123, 200, 'PENDING')`)

📌 **Hạn chế**:
- **Database bị khóa (Locking) trong lúc giao dịch** → làm giảm hiệu suất.
- **Không có lịch sử giao dịch** → nếu User khiếu nại, không có cách nào kiểm tra.
- **Nếu database bị crash giữa chừng, giao dịch có thể bị mất**.

---

## ✅ **Event Sourcing + CQRS**
💡 **Ví dụ: Một User đặt cược 200**
1. **Bước 1:** Ghi sự kiện `BetPlaced` vào Event Store.
2. **Bước 2:** Một Background Job xử lý sự kiện:
    - **Trừ tiền User** (`UPDATE users SET balance = balance - 200 WHERE id = 1`).
    - **Ghi cược vào Read Model** (`INSERT INTO read_model_bets`).
3. **Bước 3:** API đọc lịch sử cược từ Read Model.

📌 **Ưu điểm**:
- **Không khóa database** → Write Model và Read Model tách biệt.
- **Nếu hệ thống bị lỗi, có thể replay lại sự kiện để khôi phục trạng thái**.
- **Lịch sử giao dịch đầy đủ**, dễ kiểm tra và xác thực.

---

# 🎯 **4. So sánh chi tiết về mặt lý thuyết**
| **Tiêu chí** | **Hệ thống CRUD truyền thống** | **Event Sourcing + CQRS** |
|-------------|-----------------|-----------------|
| **Ghi dữ liệu** | Ghi trực tiếp vào database | Ghi vào Event Store trước, xử lý sau |
| **Đọc dữ liệu** | Truy vấn trực tiếp từ database | Truy vấn từ Read Model đã được tối ưu hóa |
| **Hiệu suất đọc** | Chậm nếu có nhiều truy vấn | Nhanh hơn vì Read Model chỉ chứa dữ liệu cần thiết |
| **Lịch sử thay đổi** | Không có, chỉ lưu trạng thái cuối cùng | Lưu **mọi thay đổi**, có thể replay lại |
| **Rollback dữ liệu** | Không thể rollback từng bước | **Có thể rollback bằng cách replay lại sự kiện** |
| **Hỗ trợ real-time** | Phải polling database liên tục | Hỗ trợ real-time với Event-Driven Architecture |
| **Khả năng mở rộng** | Khó mở rộng khi lượng giao dịch lớn | Dễ dàng mở rộng với Microservices |
| **Tính nhất quán** | **Strong Consistency** (ACID) | **Eventual Consistency** (tính nhất quán cuối cùng) |

---

# 📌 **5. Kết luận**
1. **Hệ thống CRUD truyền thống** phù hợp với hệ thống **nhỏ, ít giao dịch**, không yêu cầu lịch sử dữ liệu.
2. **Event Sourcing + CQRS phù hợp với hệ thống có tải cao**, nơi **cần lưu lịch sử thay đổi, hỗ trợ rollback, mở rộng tốt**.
3. **Event Sourcing lưu mọi thay đổi** dưới dạng **các sự kiện** giúp **dữ liệu không bao giờ bị mất**.
4. **CQRS tách biệt ghi và đọc**, giúp **truy vấn nhanh hơn** mà không ảnh hưởng đến hiệu suất ghi.

👉 **Nếu hệ thống của bạn cần tính toàn vẹn dữ liệu, khả năng mở rộng cao, Event Sourcing + CQRS là lựa chọn tối ưu!** 🚀