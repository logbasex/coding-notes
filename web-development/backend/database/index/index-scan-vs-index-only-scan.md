## Overview

1. Index Scan

Index scan là một phương pháp truy cập dữ liệu trong cơ sở dữ liệu sử dụng một index để tìm kiếm dữ liệu.

Cách hoạt động:
1. DBMS tìm kiếm trong cấu trúc index (thường là B-tree hoặc B+ tree) để xác định vị trí của dữ liệu cần tìm.
2. Sau khi tìm thấy trong index, DBMS sử dụng con trỏ hoặc địa chỉ trong index để truy cập vào bảng gốc.
3. DBMS đọc dữ liệu từ bảng gốc và trả về kết quả.

Ưu điểm:
- Nhanh hơn full table scan khi chỉ cần một phần nhỏ của bảng.
- Hiệu quả cho các truy vấn có tính chọn lọc cao.

Nhược điểm:
- Vẫn cần truy cập vào bảng gốc, có thể gây ra I/O bổ sung.
- Không hiệu quả nếu phải quét qua một phần lớn của index.

2. Index Only Scan

Index only scan là một phương pháp truy cập dữ liệu nâng cao hơn, trong đó tất cả thông tin cần thiết đã có sẵn trong index.

Cách hoạt động:
1. DBMS tìm kiếm trong cấu trúc index.
2. Tất cả dữ liệu cần thiết được đọc trực tiếp từ index.
3. DBMS trả về kết quả mà không cần truy cập vào bảng gốc.

Ưu điểm:
- Rất nhanh vì tránh được việc truy cập bảng gốc.
- Giảm I/O đĩa đáng kể.
- Đặc biệt hiệu quả cho các truy vấn thống kê hoặc tổng hợp.

Nhược điểm:
- Yêu cầu index phải chứa tất cả thông tin cần thiết (covering index).
- Có thể làm tăng kích thước của index.

So sánh chi tiết:

1. Hiệu suất:
    - Index scan: Tốc độ trung bình, phụ thuộc vào số lượng bản ghi cần truy cập trong bảng gốc.
    - Index only scan: Tốc độ rất nhanh, đặc biệt khi xử lý lượng lớn dữ liệu.

2. Sử dụng bộ nhớ:
    - Index scan: Sử dụng ít bộ nhớ hơn vì index thường nhỏ hơn.
    - Index only scan: Có thể sử dụng nhiều bộ nhớ hơn do index lớn hơn để chứa thêm thông tin.

3. Tính linh hoạt:
    - Index scan: Linh hoạt hơn, có thể sử dụng cho nhiều loại truy vấn khác nhau.
    - Index only scan: Ít linh hoạt hơn, chỉ hiệu quả khi index chứa đủ thông tin cần thiết.

4. Tác động đến việc cập nhật dữ liệu:
    - Index scan: Ảnh hưởng ít hơn đến hiệu suất cập nhật dữ liệu.
    - Index only scan: Có thể làm chậm quá trình cập nhật do index lớn hơn và phức tạp hơn.

5. Khả năng áp dụng:
    - Index scan: Có thể áp dụng cho hầu hết các trường hợp có index.
    - Index only scan: Chỉ áp dụng được khi có covering index phù hợp.

Để minh họa sự khác biệt, tôi sẽ tạo một ví dụ cụ thể:



```sql
-- Tạo bảng và dữ liệu mẫu
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Tạo index thông thường
CREATE INDEX idx_department ON employees(department);

-- Tạo covering index
CREATE INDEX idx_department_salary ON employees(department, salary);

-- Truy vấn sử dụng index scan
EXPLAIN ANALYZE
SELECT name, salary FROM employees WHERE department = 'IT';

-- Truy vấn sử dụng index only scan
EXPLAIN ANALYZE
SELECT department, salary FROM employees WHERE department = 'IT';

```

Trong ví dụ trên:
1. Truy vấn đầu tiên sẽ sử dụng index scan vì cần truy cập bảng gốc để lấy 'name'.
2. Truy vấn thứ hai có thể sử dụng index only scan vì tất cả thông tin cần thiết đều có trong covering index.

Khi chạy EXPLAIN ANALYZE, bạn sẽ thấy sự khác biệt về kế hoạch thực thi và hiệu suất giữa hai truy vấn.

Để tối ưu hóa việc sử dụng index only scan:
1. Thiết kế covering index phù hợp với các truy vấn thường xuyên sử dụng.
2. Cân nhắc giữa lợi ích của index only scan và chi phí duy trì index lớn hơn.
3. Sử dụng các công cụ phân tích truy vấn để xác định các cơ hội áp dụng index only scan.
4. Định kỳ đánh giá lại hiệu suất và điều chỉnh index nếu cần.