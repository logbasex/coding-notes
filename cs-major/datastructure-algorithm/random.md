## [Random vs Secure Random](https://viblo.asia/p/code-sach-code-de-phat-trien-lap-trinh-vien-da-biet-ve-code-an-toan-chua-phan-2-924lJ2rWlPM)

- [Random vs Secure Random numbers in Java](https://www.geeksforgeeks.org/random-vs-secure-random-numbers-java/)

Vấn đề về việc sử dụng bộ sinh số ngẫu nhiên không an toàn thường được nhắc đến với ngôn ngữ lập trình Java. Java chung cấp 2 thư viện sinh số ngẫu nhiên là java.util.Random và java.security.SecureRandom

Cả 2 thư viện trên đều có khả năng sinh số ngẫu nhiên, nhưng java.security.SecureRandom được coi là True Random (Random Number Genarator - RNG) còn java.util.Random không được đánh giá cao, được coi là Pseudo Random - giả ngẫu nhiên (Pseudo Random Number Genarator - PRNG).

Theo mình hiểu thì có thể xác định tính ngẫu nhiên của bộ sinh số bằng cách đánh giá 2 yếu tố:

- Thuật toán sinh ngẫu nhiên
- Thuật toán lấy seed

Về thuật toán sinh ngẫu nhiên thì mình không giỏi thuật toán để có thể đưa ra nhận xét. Còn về seed thì mình có biết 1 chút. **Seed là 1 tham số mà từ seed này thì thuật toán sinh ngẫu nhiên có thể sinh ra dãy số ngẫu nhiên. Với các seed giống nhau thì dãy số ngẫu nhiên được sinh ra sẽ giống hệt nhau về cả giá trị từng phần tử và thứ tự của chúng.**

Các thuật toán RNG được khuyến nghị dùng trong các sản phẩm yêu cầu độ bảo mật cao không chỉ do có thuật toán sinh tốt, **mà cách thuật toán lấy seed cũng được phức tạp hóa để đảm bảo giá trị seed là ngẫu nhiên và không tồn tại 2 seed trùng nhau.**


## [Linear Congruential Generator (LCG) - Phương pháp đồng dư tuyến tính](https://en.wikipedia.org/wiki/Linear_congruential_generator)

Phương pháp này được Lehmer đề xuất, và nó là một dãy số có dạng


> [Xn+1 = (a*Xn + c) mod m](https://www.youtube.com/watch?v=PtEivGPxwAI)
> 
> Số random tiếp theo dựa trên số trước tương tự số fibonacci F = Fn-1 + Fn-2

Trong đó:
-  "Xn" là số thứ n của dãy số, nếu n = 0 thì X0 là giá trị khởi đầu (seed number)
-  "Xn+1" là số thứ n+1 của dãy số
-  a là hệ số nhân (multiplier)
-  c là số gia (increment)
- m là số lấy phần dư (modulus)

Nếu như chọn sai các hệ số, có thể dẫn đến tình tạng dãy số bị lặp lại hoặc xoay vòng theo chu kỳ, khiến cho tính chất ngẫu nhiên cần có không được thỏa mãn.

[Ví dụ,  ta có seed = 8, m = 1024, a = 2, c = 4, áp dụng vào dãy số, trên, ta sẽ có kết quả là 8, 20, 44, 92, 188, 380, 764, 508, 1020, 1020,1020, ....1020,... và số 1020 bị lặp lại mãi mãi.](https://www.facebook.com/10IFs/posts/1267154646658630/)

Phương pháp Linear congruential generator có đặc điểm là nhanh, tiết kiệm bộ nhớ, nhưng mức độ chính xác "ngẫu nhiên" không cao.

Chính vì chỉ tạo ra một cách "giả" để tạo số ngẫu nhiên, nên trong nhiều trường hợp sử dụng thực tế, xác suất các số được sinh ra là không hề giống nhau, ví dụ như khi chơi video game, xác suất ngẫu nhiên để thực hiện thành công thao tác chỉ là 17%, nhưng ta lại có thể lặp lại điều đó liên tục 6-7 lần liên tục, hay khi thực hiện thao tác khi đồng hồ chỉ số giây lẻ có khả năng thành công cao hơn so với giây chẵn, mặc dù xác suất là cố định trong mọi thời điểm.

> Vấn đề của thuật toán này là biết được seed thì sẽ đoán được số tiếp theo, không thỏa mãn [Next-bit test](https://en.wikipedia.org/wiki/Next-bit_test)


## [Cryptographically-secure pseudorandom number generator- CSPRNG](https://en.wikipedia.org/wiki/Cryptographically-secure_pseudorandom_number_generator)

- https://www.baeldung.com/java-secure-random
- https://cryptobook.nakov.com/secure-random-generators/secure-random-generators-csprng
- https://metebalci.com/blog/everything-about-javas-securerandom/
- https://www.doanquan.com/secure-random-number-generators-prng/
- https://www.java-tv.com/2013/01/21/java-secure-random-number-generation/


