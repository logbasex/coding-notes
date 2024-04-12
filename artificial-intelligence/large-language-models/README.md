## 1\. Large Language Model (LLM) có nghĩa là gì?

Một mô hình ngôn ngữ lớn (LLM) là một loại mô hình học máy có khả năng thực hiện nhiều nhiệm vụ xử lý ngôn ngữ tự nhiên (Natural Laguage Processing ) như tạo và phân loại văn bản, trả lời câu hỏi trong một cuộc đối thoại, và dịch văn bản từ một ngôn ngữ sang ngôn ngữ khác. Từ "Lớn" dùng  chỉ số lượng giá trị (tham số) mà mô hình ngôn ngữ có thể thay đổi tự động khi nó học. Một số LLM thành công nhất có hàng trăm tỷ tham số.

LLM được huấn luyện với lượng dữ liệu khổng lồ, sử dụng phương pháp học tự giám sát (self-supervised learning) để dự đoán token - bạn có thể hiểu đơn giản nó là từ, cụm từ, địa điểm, ... tiếp theo trong một câu, dựa trên ngữ cảnh xung quanh. Quá trình này được lặp đi lặp lại cho đến khi mô hình đạt được một mức độ chính xác chấp nhận được.

Khi một LLM đã được huấn luyện, nó có thể được điều chỉnh chuyên biệt cho một loạt các nhiệm vụ NLP, bao gồm:

-   Xây dựng trò chuyện với chatbot như ChatGPT.
-   Tạo văn bản cho mô tả sản phẩm, bài đăng trên blog và bài báo.
-   Trả lời các câu hỏi thường gặp (FAQs) và điều hướng các yêu cầu của khách hàng đến người hoặc bộ phận phù hợp nhất: hầu hết các doanh nghiệp lớn rất quan tâm đến vấn đề này, nhằm cắt giảm số lượng nhân sự cũng như là thời gian hỗ trợ khách hàng.
-   Phân tích/Phân loại phản hồi của khách hàng từ email, bài đăng trên mạng xã hội và đánh giá sản phẩm: phân loại phàn nàn hay góp ý của khách hàng với sản phẩm của mình đã không còn là vấn đề xa lạ với hâù hết các doanh nghiệp, việt tóm tắt và phân loại chúng không phải là một vấn đề dễ dàng, hiện tại nhờ LLM chúng ta đã có thể không cần phải làm các công việc này bằng tay, mất khá nhiều thời gian và công sức.
-   Dịch nội dung kinh doanh sang các ngôn ngữ khác nhau.

## 2\. Cách Huấn Luyện Các Mô Hình Ngôn Ngữ Lớn

Hầu hết các LLM được huấn luyện trước trên một tập dữ liệu lớn, đa dạng và có mục đích tổng quát (bạn có thể hiểu là nó bao gồm tất cả các khía cạnh của cuộc sống, không chuyên biệt cho bất cứ ngành nghề nào như kinh tế, công nghệ , ...).

Mục đích của việc huấn luyện trước là để mô hình học các tính năng cao cấp - high-level features (bạn có thể hiểu đơn giản nó là học các giá trị cốt lõi trước) , sau đó nó sẽ được chuyển sang giai đoạn tinh chỉnh cho các nhiệm vụ cụ thể.

Quá trình huấn luyện của một mô hình ngôn ngữ lớn bao gồm:

1.  Tiền xử lý dữ liệu văn bản để chuyển đổi nó thành biểu diễn số có thể được đưa vào mô hình (chuyển đổi kí tự sang dạng số là bước làm bắt buộc )
2.  Gán các giá trị ngẫu nhiên vào các tham số của mô hình.
3.  Đưa biểu diễn số của dữ liệu văn bản vào mô hình.
4.  Sử dụng hàm mất mát (loss function) để đo lường sự khác biệt giữa các đầu ra của mô hình và từ tiếp theo (next word)  thực tế trong một câu, hiểu đơn giản là mô hình sẽ che lại các từ thực tế có trong các đoạn văn bản đầu vào và dự đoán nó, sau khi dự đoán xong nó sẽ so sánh với thực tế những từ đã bị che trước đó xem có ổn hay không. Khi quá trình dự đoán này được lặp đi lặp lại sẽ giúp chúng tạo ra được nguyên cả một đoạn văn bản (autoregressive generation)
5.  Tối ưu hóa các tham số của mô hình để giảm thiểu mất mát, tức là kết quả dự đoán phải càng ngày càng đúng thì mới được xem là càng tối ưu.
6.  Lặp lại quá trình cho đến khi các đầu ra của mô hình đạt đến một mức độ chính xác chấp nhận được.

## 3\. Cách Hoạt Động Của Các Mô Hình Ngôn Ngữ Lớn Như Thế Nào?

Bạn có thắc mắc làm sao để một LLM trả lời câu hỏi, hay đưa ra một gợi ý khi bạn tương tác với nó không, việc này sẽ bắt đầu giống như quá trình mà LLM được huấn luyện.

Các từ trong đoạn chat/câu hỏi của bạn được chuyển đổi thành các token (từ, cụm từ) và sau đó là biểu diễn vector bằng số để máy có thể hiểu được. Chuỗi các vector sau đó được truyền qua mạng nơ-ron của mô hình, bao gồm các lớp (layer) mà mỗi layer đều đóng góp vào việc mô hình có thể hiểu về  mối quan hệ và ngữ cảnh giữa các token.

Cuối cùng, mô hình tạo ra một phân phối xác suất trên toàn bộ từ vựng (vocabulary) của nó cho token tiếp theo trong chuỗi. Token có xác suất cao nhất thường được chọn làm token tiếp theo trong chuỗi.

Token được chọn sau đó được thêm vào đoạn văn bản ban đầu bạn nhập vào, quá trình dự đoán từ tiếp theo này sẽ tiếp tục lặp lại: chuỗi mới lại được truyền qua mạng, và một token khác được dự đoán, gắn thêm vào chuỗi ban đầu. Cho đến khi một điều kiện dừng xảy ra, như đạt đến độ dài tối đa hoặc gặp phải một token kết thúc cụ thể.

Cuối cùng, chuỗi các token đã dự đoán được chuyển đổi (hoặc "hồi mã hóa") trở lại thành một chuỗi văn bản mà con người có thể hiểu được.

Ví dụ : Nên ăn gì vào buổi sáng nhỉ ? Các bước để LLM tạo ra một câu trả lời như sau:

1.  Nên ăn gì vào buổi sáng nhỉ ? Bạn
2.  Nên ăn gì vào buổi sáng nhỉ ? Bạn có
3.  Nên ăn gì vào buổi sáng nhỉ ? Bạn có nhiều
4.  ... Cứ như vậy cho tới khi đạt được điều kiện dừng

## 4\. Kết luận

Mong rằng bài giải thích trên đã giúp các bạn Developer hiểu qua về LLM, chúc các bạn có thể áp dụng thành công vào công việc.

Một số các mô hình Large Language Model thông dụng hiện nay:

1.  GPT-3 (Generative Pretrained Transformer 3) – developed by OpenAI.
2.  LLaMA 2 - developed by Facebook Meta
3.  Gemini - developed by Google
