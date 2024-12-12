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


=====
=====

### **Hạn chế của JWT (JSON Web Token)**

JWT mang lại nhiều lợi ích trong việc xác thực và ủy quyền, nhưng cũng tồn tại một số nhược điểm đáng lưu ý, đặc biệt trong các tình huống yêu cầu hiệu quả và khả năng cập nhật ngay lập tức. Dưới đây là giải thích chi tiết:

---

#### **1. Khó thu hồi hoặc vô hiệu hóa token ngay lập tức**

- JWT được lưu trữ phía client và có thời hạn (**expiry date**) xác định từ trước, thường có thể kéo dài hàng giờ hoặc vài ngày.
- Khi một người dùng bị vô hiệu hóa trong cơ sở dữ liệu (ví dụ: bị khóa tài khoản, thay đổi quyền hạn), **JWT không thể bị thu hồi ngay lập tức**. Thay vào đó, bạn phải đợi token hết hạn để thông tin trở nên không còn hợp lệ.
  - **Tình huống ảnh hưởng:**
    - **API công khai**: Một người dùng “lạm dụng” API (như gửi quá nhiều yêu cầu) có thể làm cạn kiệt tài nguyên hệ thống.
    - **Ứng dụng thương mại điện tử**: Cần cấm ngay lập tức những người dùng gian lận hoặc tài khoản bị tấn công.

- **Giải pháp tiềm năng:**
  - Sử dụng **blacklist**:
    - Lưu các token hoặc ID người dùng bị cấm trong cơ sở dữ liệu.
    - Tuy nhiên, điều này làm mất đi tính "stateless" của JWT vì cần truy vấn database mỗi lần xác thực.
  - Đảm bảo mỗi JWT có một **JWT Id (jti)** duy nhất, giúp dễ dàng theo dõi và vô hiệu hóa trong cơ sở dữ liệu.

---

#### **2. Thách thức trong việc cập nhật quyền hạn ngay lập tức**

- Trong các ứng dụng doanh nghiệp có nhiều vai trò phức tạp (như admin, project owner, manager), việc cập nhật quyền hạn (roles) của người dùng có thể gặp khó khăn nếu dựa vào JWT.
  - **Ví dụ:**
    - Một admin thay đổi quyền của người dùng khác (ví dụ: xóa quyền quản trị của một nhân viên cấp dưới). Tuy nhiên, nếu JWT chưa được làm mới, người dùng đó vẫn giữ quyền cũ cho đến khi token hết hạn hoặc được cập nhật.

- **Hệ quả:**
  - Sự chậm trễ này gây ra rủi ro bảo mật hoặc xung đột trong hệ thống.
  - Không phù hợp với các ứng dụng yêu cầu phản ứng ngay lập tức khi thay đổi quyền.

---

#### **3. Tăng kích thước token theo thời gian**

- JWT có thể **phình to** khi thêm nhiều trường dữ liệu (claims) vào payload:
  - Mỗi lần thêm thông tin như vai trò (roles), quyền hạn (permissions) hoặc metadata, kích thước token sẽ tăng lên.
  - Trong các ứng dụng **stateless**, JWT được gửi đi kèm mọi yêu cầu, làm tăng lưu lượng dữ liệu.
    - **Ví dụ:** Ứng dụng doanh nghiệp như AWS hoặc Azure yêu cầu quyền hạn chi tiết trên từng tài nguyên. Việc lưu quá nhiều thông tin trong JWT có thể làm tăng băng thông và độ phức tạp.

---

#### **4. Dễ bị lộ thông tin nhạy cảm**

- JWT có thể được giải mã (**decode**) một cách dễ dàng vì payload chỉ được mã hóa Base64. Bất kỳ ai có token đều có thể đọc được nội dung.
  - **Rủi ro:**
    - Nếu JWT chứa thông tin nhạy cảm (như địa chỉ email, số điện thoại, hoặc dữ liệu cá nhân), thông tin đó có thể bị lộ.
    - Payload không được mã hóa, chỉ chữ ký (Signature) được bảo vệ để đảm bảo tính toàn vẹn.

- **Giải pháp:**
  - Không lưu thông tin nhạy cảm trong JWT.
  - Sử dụng HTTPS để bảo mật trong quá trình truyền tải token.

---

### **So sánh với Opaque Tokens**

**Opaque Tokens** được thiết kế khác biệt để giải quyết một số hạn chế của JWT:

1. **Không thể đọc được (opaque)**:
  - Opaque Tokens là chuỗi ký tự ngẫu nhiên, không mang thông tin có thể đọc được. Chỉ phía server (issuer) mới biết cách giải mã.
  - Không ai có thể đọc hoặc giải mã thông tin trong Opaque Tokens, tăng cường bảo mật.

2. **Lưu trữ thông tin trên server**:
  - Opaque Tokens không lưu thông tin người dùng hay quyền hạn bên trong token. Thay vào đó, token đóng vai trò như **khóa chính** (primary key) tham chiếu đến dữ liệu trong cơ sở dữ liệu.
  - Ví dụ: **Redis** là một lựa chọn lý tưởng để lưu trữ dữ liệu này, cho phép tra cứu nhanh với độ phức tạp **O(1)**.

3. **Thu hồi dễ dàng**:
  - Vì mọi thông tin được lưu trữ trên server, các thay đổi như cập nhật quyền hạn hoặc vô hiệu hóa người dùng có hiệu lực ngay lập tức.

4. **Tích hợp với Auth0**:
  - Auth0 cho phép sử dụng Opaque Tokens với endpoint `/userinfo` để truy vấn thông tin người dùng. Điều này giúp bạn không cần xác thực token trực tiếp mà để Auth0 xử lý.

---

### **Khi nào sử dụng JWT và Opaque Tokens?**

- **JWT:**
  - Phù hợp cho hệ thống phân tán, microservices.
  - Khi cần hiệu suất cao và không cần cập nhật quyền hạn ngay lập tức.
  - Ví dụ: Xác thực Single Sign-On (SSO), giao tiếp giữa các service.

- **Opaque Tokens:**
  - Phù hợp với hệ thống tập trung hoặc yêu cầu thu hồi token tức thời.
  - Ví dụ: Các ứng dụng doanh nghiệp với quản lý quyền hạn phức tạp.

---

=====
=====

## Stateful vs Stateless token

### **Stateful và Stateless trong bối cảnh thu hồi JWT Token**

Khi thảo luận về **stateful** và **stateless**, chúng ta đang nói về cách **server** xử lý trạng thái (**state**) liên quan đến **token** hoặc **phiên làm việc của người dùng**. Dưới đây là giải thích chi tiết ý nghĩa của hai khái niệm này trong bối cảnh JWT và Keycloak:

---

### **1. Stateless**

#### **Định nghĩa**
- Một hệ thống **stateless** không lưu trữ bất kỳ trạng thái (state) nào của người dùng trên **server**.
- Tất cả thông tin cần thiết để xác thực (authentication) và ủy quyền (authorization) được chứa bên trong **JWT token** mà client gửi lên server.

#### **Cách hoạt động**
- JWT token chứa tất cả các thông tin cần thiết, ví dụ: quyền hạn của người dùng, thời gian hết hạn, v.v.
- Server không cần tham chiếu đến database hay lưu bất kỳ trạng thái nào để xác thực token. Thay vào đó:
  - Server giải mã JWT token.
  - Kiểm tra chữ ký (signature) và thời gian hiệu lực (`exp`).
  - Quyết định cho phép hoặc từ chối yêu cầu.

#### **Ưu điểm của Stateless**
- **Hiệu suất cao**:
  - Server không cần truy vấn database hoặc lưu trạng thái phiên (session state).
  - Phù hợp với hệ thống phân tán (distributed systems) như microservices.
- **Đơn giản**:
  - Mỗi request được xử lý độc lập, không phụ thuộc vào các trạng thái trước đó.

#### **Nhược điểm của Stateless**
- **Không thể thu hồi token ngay lập tức**:
  - Vì JWT token tự chứa thông tin, server không thể biết token đã bị vô hiệu hóa hoặc thay đổi trạng thái (ví dụ: quyền hạn) trừ khi token hết hạn.
- **Khó quản lý quyền hạn**:
  - Nếu quyền hạn hoặc thông tin của người dùng thay đổi, bạn phải đợi token hiện tại hết hạn để những thay đổi này có hiệu lực.

---

### **2. Stateful**

#### **Định nghĩa**
- Một hệ thống **stateful** lưu trữ trạng thái (**state**) của người dùng trên **server**.
- Các thông tin trạng thái như phiên đăng nhập (session), token hợp lệ, quyền hạn, v.v. được lưu trong cơ sở dữ liệu hoặc bộ nhớ tạm (**cache**).

#### **Cách hoạt động**
- Khi client gửi JWT token lên, server không chỉ kiểm tra chữ ký và thời gian hiệu lực mà còn:
  - Truy vấn cơ sở dữ liệu hoặc cache để kiểm tra trạng thái của token hoặc phiên làm việc.
  - Ví dụ: kiểm tra xem token có nằm trong danh sách đen (blacklist) hay không.

#### **Ưu điểm của Stateful**
- **Thu hồi token ngay lập tức**:
  - Nếu token bị đánh cắp hoặc quyền của người dùng thay đổi, bạn có thể cập nhật trạng thái (state) trên server để vô hiệu hóa token ngay lập tức.
- **Quản lý quyền linh hoạt**:
  - Quyền hạn, trạng thái của người dùng có thể được cập nhật và có hiệu lực ngay lập tức.

#### **Nhược điểm của Stateful**
- **Hiệu suất thấp hơn**:
  - Server phải lưu trữ trạng thái và thực hiện các truy vấn đến database hoặc cache cho mỗi request.
- **Phức tạp hơn**:
  - Cần triển khai cơ chế lưu trữ trạng thái (state management) và đồng bộ trong hệ thống.

---

### **3. So sánh Stateful và Stateless**

| **Tiêu chí**                | **Stateless**                              | **Stateful**                              |
|-----------------------------|-------------------------------------------|------------------------------------------|
| **Lưu trạng thái trên server** | Không (dựa vào JWT token)                 | Có (lưu session, trạng thái token, v.v.) |
| **Truy vấn database**        | Không cần (trừ khi blacklist được thêm)    | Cần thiết để kiểm tra trạng thái         |
| **Tốc độ**                  | Nhanh hơn                                 | Chậm hơn (phụ thuộc vào database/cache)  |
| **Thu hồi token**           | Không thể thu hồi ngay lập tức            | Có thể thu hồi ngay lập tức              |
| **Ứng dụng**                | Hệ thống phân tán, microservices          | Hệ thống tập trung, yêu cầu bảo mật cao  |

---

### **4. Trong Keycloak**

#### **Stateless trong Keycloak**
- Keycloak sử dụng JWT token như một phần của hệ thống **stateless**:
  - Khi client gửi JWT token, Keycloak chỉ kiểm tra chữ ký và thời gian hiệu lực (`exp`) mà không cần truy vấn cơ sở dữ liệu.
  - Điều này giúp tăng tốc độ xử lý và phù hợp cho các hệ thống phân tán.

#### **Stateful trong Keycloak**
- Keycloak cũng hỗ trợ cơ chế **stateful** để quản lý trạng thái:
  - Khi bạn sử dụng **sessions** trong Keycloak, các trạng thái liên quan đến phiên đăng nhập của người dùng được lưu trong cơ sở dữ liệu.
  - Điều này cho phép bạn:
    - **Thu hồi token** ngay lập tức bằng cách xóa session.
    - Cập nhật quyền hạn và áp dụng thay đổi ngay lập tức.
  - Các endpoint liên quan:
    - **Logout all sessions**: Thu hồi tất cả các token.
    - **Token introspection**: Kiểm tra trạng thái của token.

---

### **Khi nào chọn Stateful hoặc Stateless?**

- **Sử dụng Stateless**:
  - Hệ thống phân tán hoặc microservices.
  - Yêu cầu hiệu suất cao và không cần thu hồi token ngay lập tức.

- **Sử dụng Stateful**:
  - Hệ thống tập trung hoặc yêu cầu bảo mật cao.
  - Cần quản lý quyền hạn và thu hồi token ngay lập tức.

---