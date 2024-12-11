### **Phân biệt JSON Web Tokens (JWT) và Opaque Tokens**

JWT và Opaque Tokens là hai loại **token** được sử dụng để xác thực và ủy quyền trong các hệ thống ứng dụng. Dưới đây là sự khác biệt chi tiết giữa chúng:

---

### **1. JSON Web Tokens (JWT)**

- **Cấu trúc**:
    - JWT có định dạng chuẩn, bao gồm 3 phần được mã hóa Base64, ngăn cách bởi dấu chấm (`.`):
        - **Header**: Chứa metadata, như loại token (`JWT`) và thuật toán mã hóa (`HS256`, `RS256`).
        - **Payload**: Chứa thông tin (claims) về người dùng hoặc ứng dụng.
        - **Signature**: Chữ ký được tạo bằng cách mã hóa header và payload với khóa bí mật hoặc khóa riêng.
    - Ví dụ:
      ```
      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
      ```

- **Đặc điểm**:
    - **Self-contained**: JWT chứa tất cả thông tin cần thiết, như user ID, quyền hạn, hoặc thời gian hết hạn (**expiration**) mà không cần tham chiếu server.
    - **Stateless**: Không cần lưu trữ token trong cơ sở dữ liệu trên server.
    - **Readable**: Payload của JWT có thể được giải mã từ Base64 mà không cần khóa, khiến nó **dễ dàng bị đọc** (nếu không được mã hóa).
    - **Bảo mật**: Chữ ký (Signature) đảm bảo token không bị sửa đổi, nhưng **không bảo mật nội dung**.
    - **Kích thước lớn**: Do chứa nhiều metadata và claims, JWT thường lớn hơn Opaque Tokens.

- **Ưu điểm**:
    - Không cần truy vấn database để kiểm tra tính hợp lệ (phù hợp cho hệ thống phân tán).
    - Khả năng tùy chỉnh thông tin (claims) trong payload.

- **Nhược điểm**:
    - Không thể thu hồi (revoke) trừ khi triển khai blacklist.
    - Nếu bị đánh cắp, kẻ tấn công có thể sử dụng trong thời gian token còn hiệu lực.

---

### **2. Opaque Tokens**

- **Cấu trúc**:
    - Opaque Tokens không có cấu trúc cụ thể mà thường là một chuỗi ngẫu nhiên (**random string**), không thể giải mã trực tiếp.
    - Ví dụ:
      ```
      abcd1234efgh5678ijkl9101mnopqr
      ```

- **Đặc điểm**:
    - **Not self-contained**: Không chứa thông tin bên trong token. Mọi thông tin cần thiết đều được lưu trữ ở phía server.
    - **Stateful**: Server phải duy trì một cơ sở dữ liệu hoặc kho lưu trữ để kiểm tra tính hợp lệ của token.
    - **Bảo mật**: Token không thể giải mã hay đọc được, khiến nó an toàn hơn trước các cuộc tấn công giải mã nội dung.
    - **Kích thước nhỏ**: Do không chứa metadata hay claims, Opaque Tokens nhẹ hơn JWT.

- **Ưu điểm**:
    - Dễ dàng thu hồi (revoke) bằng cách xóa token trong cơ sở dữ liệu.
    - Ít bị rủi ro nếu token bị đánh cắp (vì không thể đọc trực tiếp nội dung).
    - Quản lý tập trung hơn, dễ kiểm soát.

- **Nhược điểm**:
    - Cần truy vấn database mỗi khi kiểm tra token.
    - Không phù hợp cho các hệ thống phân tán lớn (phụ thuộc vào database).

---

### **So sánh nhanh**

| **Tiêu chí**             | **JWT**                                | **Opaque Tokens**                      |
|--------------------------|---------------------------------------|---------------------------------------|
| **Cấu trúc**             | 3 phần (Header, Payload, Signature)   | Chuỗi ngẫu nhiên, không giải mã được |
| **Thông tin**            | Tự chứa thông tin (self-contained)    | Tham chiếu tới thông tin trên server |
| **Stateless/Stateful**   | Stateless                             | Stateful                              |
| **Khả năng đọc**         | Có thể giải mã và đọc payload          | Không thể đọc                          |
| **Quản lý thu hồi**      | Khó thu hồi                           | Dễ thu hồi                             |
| **Hiệu suất**            | Nhanh hơn (do không cần database)     | Chậm hơn (phải truy vấn database)     |
| **Ứng dụng**             | Hệ thống phân tán                    | Hệ thống tập trung                    |

---

### **Khi nào sử dụng JWT và Opaque Tokens?**

- **JWT**:
    - Phù hợp với các hệ thống phân tán, microservices, hoặc yêu cầu tốc độ xử lý cao.
    - Khi không cần thu hồi token thường xuyên.
    - Ví dụ: Single Sign-On (SSO), giao tiếp API giữa các dịch vụ.

- **Opaque Tokens**:
    - Phù hợp với hệ thống tập trung hoặc cần quản lý token chặt chẽ.
    - Khi cần thu hồi token nhanh chóng.
    - Ví dụ: OAuth 2.0 Authorization Server.