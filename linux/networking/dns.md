## get current DNS server

```
grep "nameserver" /etc/resolv.conf

dig tecmint.com
```

## Change DNS server to Google
- https://www.my-private-network.co.uk/kbhome/how-to-set-google-dns-on-your-linux-computer-terminal/


## Medium was block, DNS server and ISP

- https://www.facebook.com/grokking.vietnam/posts/3916707021730570
    > khi thực hiện lệnh DNS thì gói tin không được mã hóa. do đó nhà mạng hoàn toàn có thể trace được. Việc đổi DNS đôi khi cũng không hiệu quả do nhà mạng đọc được field host từ gói tin query DNS. Vì vậy đã ra đời khái niệm DNS over HTTPS, mã hóa ngay từ bước gửi gói tin phân giải tên miền
    > 

    > Các cơ chế chặn trang trang web của ISP được gọi chung là DPI (deep packet inspection), thường nó là một rule được áp dụng ở link-layer level hay network level. Điểm yếu của các hệ thống DPI hiện tại là chúng được thiết kế cho speed > correctness, nên có rất nhiều những trường hợp có thể chạy đúng theo standard, nhưng DPI lại không thể phát hiện ra. Note that DPI thường được áp dụng trên các gói tin HTTP, HTTPS, và DNS.
Ở HTTP và DNS, do gói tin không được mã hóa, nên DPI chỉ có nhiệm vụ là scan trong gói tin đó có gì hay không thôi. Tuy nhiên, thay vì gửi "GET / HTTP/1.0\n Host: www.youtube.com", chúng ta có thể chia làm 2 packet nhỏ "GET / HTTP/1.0\n
Host: www.yo" và "utube.com" để gửi đi. Trong trường hợp đó DPI nhiều khả năng sẽ ko thể chặn được. Với DNS, DPI sẽ có 1 list những danh sách những trang web bị chặn, và cố tình return kết quả sai/ko có kết quả về. Tuy nhiên chúng ta vẫn có thể bypass được bằng cách sử dụng DNS khác / DNS over TLS / DNS over HTTPS.
Ở HTTPS, trước khi thực hiện secure connection, vẫn có giao thức SNI (server name indicator) để giúp nhận diện được trang web nào (trong trường hợp nhiều trang web được host chung tại 1 IP, nên SNI giúp tìm được đúng certificate để bắt đầu encryption). Tuy nhiên, do SNI không được mã hóa, nên nhà mạng hoàn toàn có thể sử dụng kỹ thuật DPI để chặn gói tin trên, dẫn tới việc connection tới một trang web HTTPS bị timeout. Chúng ta vẫn có thể bypass quá trình này bằng cách chia gói tin SNI làm nhiều phần như mình đã miêu tả trong phần HTTP ở trê
- https://toannn.com/job/2020/06/24/hanh-trinh-vao-trang-web-x.html?fbclid=IwAR28w_VWUTYX_WRXRuNcfNMiUwM10_1QoSafJfDArHTyodtgifj0DvT61eo
