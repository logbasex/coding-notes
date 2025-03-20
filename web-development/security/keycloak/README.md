# 🔥 **Chi Tiết & Sâu Sắc Hơn: Authorization trong Keycloak – Tư Duy Từng Bước Một**

> https://chatgpt.com/share/67db6e84-e8e8-800c-b817-93cde08c204c
> 
> **Mục tiêu của bài viết:** Giải thích từng bước hoạt động của Authorization trong Keycloak theo cách giúp bạn **hiểu cốt lõi**, **có thể tư duy lại**, và **biết cách triển khai thực tế**.

---

## 🚀 **Thứ Tự Chính Xác Của Authorization Trong Keycloak**

### 1️⃣ **Tài nguyên nào đang được bảo vệ? (Resource)**
### 2️⃣ **Hành động nào có thể được thực hiện? (Scope)**
### 3️⃣ **Khi nào Keycloak cho phép hoặc từ chối truy cập? (Policy)**
### 4️⃣ **Ai có quyền thực hiện hành động này? (Permission)**
### 5️⃣ **Làm sao kiểm tra quyền khi có yêu cầu? (Policy Enforcement & Decision Making)**

---

## 🟢 **1️⃣ Tài nguyên nào đang được bảo vệ? (Resource)**
### 🔹 **Tư duy nền tảng:**
> "Bạn không thể bảo vệ cái gì nếu chưa biết nó là gì."

Tài nguyên (**Resource**) chính là những đối tượng trong hệ thống mà ta cần kiểm soát quyền truy cập.

🔹 **Resource có thể là:**
- Một **endpoint API** → `/api/orders`
- Một **file** → `/files/secure.pdf`
- Một **giao diện người dùng** → `/dashboard`
- Một **bản ghi dữ liệu** → ID cụ thể trong database (`orderId = 123`)

### 🔹 **Cách thiết lập Resource trong Keycloak:**
1. **Vào Keycloak Admin Console** → **Clients** → Chọn `my-client`
2. **Vào tab Authorization** → **Resources** → **Create Resource**
3. **Định nghĩa Resource:**
    - **Name:** `Orders API`
    - **Type:** `API`
    - **URI:** `/api/orders/*`
    - **Owner:** `my-client`
4. **Nhấn Save**

🔹 **Vì sao Resource phải được tạo trước?**
- Nếu không có Resource, bạn không thể kiểm soát quyền truy cập.
- Nếu bạn không định nghĩa rõ đâu là "tài nguyên", hệ thống không thể phân biệt quyền truy cập khác nhau.

📌 **Ví dụ cụ thể:**

| **Resource** | **URI** | **Mô tả** |
|-------------|--------|----------|
| Orders API | `/api/orders/*` | API quản lý đơn hàng |
| Reports | `/api/reports/*` | API xuất báo cáo |
| Admin Dashboard | `/admin/*` | Trang quản trị hệ thống |

---

## 🟡 **2️⃣ Hành động nào có thể được thực hiện? (Scope)**
### 🔹 **Tư duy nền tảng:**
> "Bạn không thể gán quyền nếu chưa biết những hành động nào cần kiểm soát."

🔹 **Scope (Phạm vi quyền) là gì?**
- **Scope xác định các thao tác có thể thực hiện trên một Resource**.
- **Scope KHÔNG PHẢI là HTTP method (`GET`, `POST`, ...)**, mà bạn **tự định nghĩa**.

🔹 **Scope có thể là:**
- `read` → Đọc tài nguyên
- `write` → Ghi tài nguyên
- `delete` → Xóa tài nguyên
- `export` → Xuất dữ liệu

### 🔹 **Cách thiết lập Scope trong Keycloak**
1. **Vào Keycloak Admin Console** → **Clients** → `my-client`
2. **Vào tab Authorization** → **Scopes** → **Create Scope**
3. **Định nghĩa Scope:**
    - `read`
    - `write`
    - `delete`
4. **Gán Scope vào Resource**
    - Vào **Resources** → Chọn `Orders API`
    - Trong **Scopes**, chọn `read`, `write`, `delete`
    - **Save**

📌 **Ví dụ cụ thể:**

| **Resource** | **Scope** | **Mô tả** |
|-------------|----------|----------|
| Orders API | `read`, `write`, `delete` | Phân quyền đọc, ghi, xóa đơn hàng |
| Reports API | `view`, `export` | Phân quyền xem và xuất báo cáo |

---

## 🔵 **3️⃣ Khi nào Keycloak cho phép hoặc từ chối truy cập? (Policy)**
### 🔹 **Tư duy nền tảng:**
> "Trước khi cấp quyền, ta phải xác định điều kiện nào để cấp phép."

🔹 **Policy là nơi định nghĩa điều kiện cấp quyền**, có thể dựa trên:
- **Role** (Role Policy)
- **Thời gian** (Time Policy)
- **IP** (IP Policy)
- **User Attributes** (User Policy)
- **Custom Logic** (JavaScript Policy)
- **Kết hợp nhiều điều kiện** (Aggregated Policy)

### 🔹 **Cách thiết lập Policy trong Keycloak**
1. **Vào Clients** → Chọn `my-client`
2. **Vào tab Authorization** → **Policies** → **Create Policy**
3. **Chọn loại Policy:**
    - Role Policy → Chỉ admin được phép (`admin-policy`)
    - Time Policy → Chỉ truy cập từ 9h - 17h (`working-hours-policy`)
    - IP Policy → Chỉ từ mạng nội bộ (`internal-ip-policy`)
    - JavaScript Policy → Email phải là `@company.com`

📌 **Ví dụ cụ thể:**

| **Policy** | **Điều kiện** | **Mô tả** |
|-----------|-------------|----------|
| Admin Policy | Role = `admin` | Chỉ admin được xóa đơn hàng |
| Working Hours Policy | 9:00 - 17:00 | Chỉ được truy cập giờ hành chính |
| Internal Network Policy | IP = `192.168.1.0/24` | Chỉ cho phép từ mạng nội bộ |

---

## 🟠 **4️⃣ Ai có quyền thực hiện hành động này? (Permission)**
### 🔹 **Tư duy nền tảng:**
> "Sau khi có điều kiện cấp quyền, ta cần gán quyền cho ai được phép làm gì."

🔹 **Permission xác định ai có quyền thực hiện Scope trên Resource.**
- **Permission có thể áp dụng cho Role, User, Group, hoặc Client.**
- **Một Permission có thể có nhiều Policy.**

### 🔹 **Cách thiết lập Permission trong Keycloak**
1. **Vào Clients** → Chọn `my-client`
2. **Vào tab Authorization** → **Permissions** → **Create Permission**
3. **Chọn Scope-Based Permission**
    - **Resource:** `Orders API`
    - **Scope:** `read`, `write`, `delete`
    - **Policies:** `Admin Policy`, `Working Hours Policy`
    - **Save**

📌 **Ví dụ cụ thể:**

| **Resource** | **Scope** | **Permission** | **Policy áp dụng** |
|-------------|----------|---------------|------------------|
| `/api/orders` | `read` | User Read Orders | User Policy |
| `/api/orders` | `delete` | Admin Delete Orders | Admin Policy + Working Hours Policy |

---

## 🔴 **5️⃣ Làm sao kiểm tra quyền khi có yêu cầu? (Policy Enforcement & Decision Making)**
### 🔹 **Tư duy nền tảng:**
> "Cuối cùng, hệ thống phải kiểm tra và quyết định có cấp quyền không."

🔹 **Khi có request, Keycloak kiểm tra:**
- **Access Token có hợp lệ không?**
- **Scope trong Token có phù hợp với Resource không?**
- **User có Role phù hợp không?**
- **Policy có cho phép không?**

📌 **Ví dụ kiểm tra bằng API:**
1️⃣ **Lấy Access Token**
```bash
curl -X POST "http://localhost:8080/realms/myrealm/protocol/openid-connect/token" \
-d "client_id=my-client" \
-d "grant_type=password" \
-d "username=user1" \
-d "password=123456"
```

2️⃣ **Gửi request đến API**
```bash
curl -X GET "http://localhost:8080/api/orders" \
-H "Authorization: Bearer <access_token>"
```
- Nếu có Scope `read` → ✅ **Cho phép**
- Nếu không có Scope `read` → ❌ **Từ chối**

---

## 🔥 **Kết Luận**
- **Authorization trong Keycloak diễn ra theo thứ tự logic và có thể tư duy lại dễ dàng.**
- **Làm theo đúng các bước trên giúp bạn hiểu cốt lõi và triển khai chính xác.**
- **Sử dụng Policy giúp kiểm soát quyền truy cập linh hoạt hơn Role-Based Access Control (RBAC).**