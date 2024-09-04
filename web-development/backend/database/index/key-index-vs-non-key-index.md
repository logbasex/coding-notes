Trong cơ sở dữ liệu, **key index** và **non-key index** là hai loại chỉ mục (index) giúp tối ưu hóa truy vấn, nhưng chúng phục vụ những mục đích khác nhau.

### 1. **Key Index (Chỉ mục khóa)**
- **Key index** là chỉ mục được tạo trên một hoặc nhiều cột mà những cột đó là khóa chính (*primary key*) hoặc khóa duy nhất (*unique key*) trong bảng.
- Chức năng chính của **key index** là đảm bảo tính duy nhất cho các giá trị trong cột (hoặc các cột kết hợp) và tăng tốc độ truy vấn khi tìm kiếm hoặc lọc dữ liệu theo cột khóa.
- Ví dụ: Khi bạn có một bảng với cột "ID" là khóa chính, chỉ mục sẽ được tự động tạo trên cột này. Mỗi giá trị trong "ID" phải là duy nhất và không thể có giá trị trùng lặp.

### 2. **Non-Key Index (Chỉ mục không khóa)**
- **Non-key index** là chỉ mục được tạo trên các cột không phải là khóa chính hoặc khóa duy nhất. Chỉ mục này không đảm bảo tính duy nhất của các giá trị trong cột.
- **Non-key index** thường được sử dụng để tối ưu hóa các truy vấn tìm kiếm hoặc lọc dữ liệu, nhưng không nhất thiết phải đảm bảo rằng các giá trị trong cột được chỉ mục là duy nhất.
- Ví dụ: Bạn có thể tạo một chỉ mục trên cột "Tên" hoặc "Ngày sinh" để tăng tốc độ truy vấn, nhưng các giá trị trong cột này có thể bị trùng lặp.

### So sánh:
- **Key index** đảm bảo tính duy nhất và thường được sử dụng để xác định một hàng trong bảng, trong khi **non-key index** chỉ tối ưu hóa việc truy xuất dữ liệu mà không đảm bảo giá trị duy nhất.
- **Key index** bắt buộc phải có trên các cột khóa chính và khóa duy nhất, còn **non-key index** được tạo trên các cột không phải là khóa để tăng hiệu suất truy vấn.

Cả hai loại chỉ mục đều quan trọng trong việc cải thiện hiệu suất truy vấn, nhưng việc chọn loại chỉ mục phù hợp phụ thuộc vào mục đích cụ thể của dữ liệu và các loại truy vấn mà bạn muốn tối ưu hóa.

=====
=====

Việc phân biệt giữa **key index** và **non-key index** là rất quan trọng vì chúng có những vai trò và tác động khác nhau đến hiệu suất và tính toàn vẹn của dữ liệu trong cơ sở dữ liệu. Dưới đây là các lý do chính cần phân biệt hai loại chỉ mục này:

### 1. **Đảm bảo tính toàn vẹn của dữ liệu**
- **Key index** (ví dụ: chỉ mục trên khóa chính) đảm bảo rằng các giá trị trong cột được chỉ mục phải là **duy nhất** và không thể có giá trị trùng lặp. Điều này rất quan trọng để đảm bảo rằng bảng không chứa các hàng dữ liệu lặp lại, giữ tính toàn vẹn của dữ liệu.
- **Non-key index** không đảm bảo tính duy nhất, chỉ giúp tối ưu hóa truy vấn. Do đó, nếu bạn muốn duy trì tính toàn vẹn của dữ liệu bằng cách ngăn dữ liệu trùng lặp, bạn cần hiểu rõ rằng **chỉ mục khóa** là cần thiết.

### 2. **Hiệu suất truy vấn**
- **Key index** có thể tăng tốc độ truy vấn dựa trên các trường khóa chính hoặc khóa duy nhất. Các truy vấn như tìm kiếm một hàng dựa trên ID (khóa chính) sẽ nhanh hơn đáng kể nhờ chỉ mục này.
- **Non-key index** có thể được sử dụng để tăng tốc các truy vấn lọc dữ liệu dựa trên các cột không phải là khóa, ví dụ như các truy vấn liên quan đến tìm kiếm tên hoặc ngày sinh. Tuy nhiên, chỉ số này không đảm bảo tính duy nhất và chỉ tối ưu hóa truy xuất dữ liệu.

### 3. **Quy hoạch tài nguyên hệ thống**
- **Key index** thường được ưu tiên tạo khi bạn cần bảo vệ tính toàn vẹn dữ liệu và truy xuất nhanh dựa trên khóa chính. Nhưng nó chiếm thêm tài nguyên hệ thống để duy trì sự duy nhất của dữ liệu.
- **Non-key index** được tạo ra để cải thiện hiệu suất truy vấn, nhưng chúng có thể tiêu tốn nhiều không gian lưu trữ và tài nguyên CPU. Cần phân biệt để tránh việc tạo ra quá nhiều chỉ mục không cần thiết làm giảm hiệu suất tổng thể.

### 4. **Sự tối ưu hóa truy vấn**
- Khi bạn hiểu sự khác biệt giữa **key index** và **non-key index**, bạn có thể chọn loại chỉ mục phù hợp dựa trên yêu cầu của từng truy vấn. Nếu bạn cần bảo đảm tính duy nhất và thường xuyên truy xuất theo khóa chính, **key index** là cần thiết. Nếu bạn chỉ cần tối ưu hóa truy vấn lọc mà không yêu cầu giá trị duy nhất, **non-key index** sẽ phù hợp hơn.

### 5. **Ảnh hưởng đến thao tác thêm, cập nhật dữ liệu**
- **Key index** có thể làm cho thao tác **INSERT** hoặc **UPDATE** chậm hơn, do cơ sở dữ liệu phải kiểm tra tính duy nhất của giá trị. Do đó, cần hiểu đúng loại chỉ mục đang sử dụng để tối ưu hóa tốc độ cập nhật.
- **Non-key index** không cần kiểm tra tính duy nhất nên thường ít ảnh hưởng đến thao tác ghi, nhưng lại cần tài nguyên để quản lý chỉ mục và cải thiện tốc độ truy vấn.

Việc phân biệt rõ ràng hai loại chỉ mục này sẽ giúp bạn đưa ra quyết định đúng đắn khi thiết kế cơ sở dữ liệu, từ đó tối ưu hóa hiệu suất, đảm bảo tính toàn vẹn dữ liệu và sử dụng tài nguyên hệ thống hợp lý.