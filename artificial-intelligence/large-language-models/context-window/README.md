## Context Window
LLM không cho phép unlimited context window vì một số lý do quan trọng:

1. Giới hạn về phần cứng:
    - Bộ nhớ RAM và sức mạnh xử lý của GPU có hạn.
    - Xử lý quá nhiều dữ liệu cùng lúc có thể gây quá tải hệ thống.

2. Thời gian xử lý:
    - Context window càng lớn, thời gian để mô hình xử lý và đưa ra phản hồi càng lâu.
    - Điều này ảnh hưởng đến trải nghiệm người dùng, đặc biệt trong các ứng dụng thời gian thực.

3. Hiệu quả về mặt tính toán:
    - Xử lý một lượng lớn ngữ cảnh đòi hỏi nhiều phép tính hơn, làm tăng chi phí vận hành.

4. Vấn đề về kiến trúc mô hình:
   - Nhiều kiến trúc LLM được thiết kế để hoạt động tốt nhất với một độ dài đầu vào cố định.
   - Mở rộng vô hạn có thể làm giảm hiệu suất hoặc độ chính xác của mô hình.

5. Quá tải thông tin:
   - Quá nhiều ngữ cảnh có thể làm "nhiễu" thông tin quan trọng, ảnh hưởng đến chất lượng đầu ra.

6. Giới hạn trong dữ liệu huấn luyện:
   - Mô hình được huấn luyện trên các đoạn văn bản có độ dài nhất định, nên có thể không hoạt động tốt với ngữ cảnh quá dài.

7. Khả năng tổng quát hóa:
   - Giới hạn context window buộc mô hình phải học cách tổng quát hóa và trích xuất thông tin quan trọng, thay vì dựa vào việc ghi nhớ mọi thứ.

8. Khía cạnh nhận thức:
   - Có giả thuyết cho rằng giới hạn context giúp mô hình mô phỏng cách con người xử lý thông tin.
    - Con người cũng có giới hạn về lượng thông tin có thể xử lý cùng lúc.

Các nhà nghiên cứu đang tìm cách mở rộng context window một cách hiệu quả, nhưng vẫn cần cân nhắc giữa hiệu suất và tài nguyên cần thiết.