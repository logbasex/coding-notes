## [Architecture Characteristics: Thuật ngữ và giải thích](https://minhphien.com/architecture-characteristics-thuat-ngu-va-giai-thich/)

### Operational Architecture Characteristics – Đặc tính vận hành

**Availability**
- Hệ thống sẽ cần khả dụng trong bao lâu (nếu 24/7, cần thực hiện các bước để cho phép hệ thống hoạt động nhanh chóng trong trường hợp có bất kỳ sự cố nào).

**Continuity**
- Khả năng khôi phục sau biến cố/thảm họa.

**Performance** 
- Bao gồm stress test, peak analysis, phân tích tần suất sử dụng các chức năng, công suất yêu cầu và thời gian đáp ứng. Việc chấp nhận hiệu suất đôi khi đòi hỏi một bài tập riêng, mất hàng tháng để hoàn thành.

**Recoverability**
- Các yêu cầu về tính liên tục của doanh nghiệp (ví dụ: trong trường hợp xảy ra thảm họa, mức độ nhanh chóng hệ thống được yêu cầu trực tuyến trở lại như đạt được thế nào?). Điều này sẽ ảnh hưởng đến chiến lược sao lưu và các yêu cầu đối với phần cứng bị trùng lặp.

**Reliability/safety**
- Đánh giá xem hệ thống có an toàn khi fail không, hoặc nếu nó là nhiệm vụ quan trọng theo cách ảnh hưởng đến tính mạng hay không. Nếu không thành công, công ty có mất một khoản tiền lớn không?

**Robustness**
- Khả năng xử lý các điều kiện lỗi và ranh giới trong khi chạy nếu kết nối internet bị ngắt hoặc mất điện hoặc lỗi phần cứng.

**Scalability**
- Khả năng hệ thống thi hành và điều hành khi số lượng người dùng hoặc yêu cầu tăng lên. 

## Structural Architecture Characteristics – Đặc tính cấu trúc

## Cross-Cutting Architecture Characteristics – Đặc tính xuyên suốt các hệ thống
