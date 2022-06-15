- [NanoId vs UUID](https://blog.bitsrc.io/why-is-nanoid-replacing-uuid-1b5100e62ed2)

![image](https://user-images.githubusercontent.com/22516811/171254587-5cd49965-e9ea-4de4-8922-583d72ff9439.png)

https://towardsdatascience.com/ace-the-system-design-interview-distributed-id-generator-c65c6b568027

![https://www.digitalocean.com/community/tutorials/understanding-database-sharding](https://user-images.githubusercontent.com/22516811/171255931-666347f4-56c5-4fdb-a6c4-ffb27199ee1c.png)

![image](https://user-images.githubusercontent.com/22516811/171255971-a558f6f1-5d20-437d-a636-f13f4939bb87.png)

## Replica set and Sharded cluster
- Replica set: **Read heavy**
- Sharded cluster: **Write/Read and write heavy**
- https://dba.stackexchange.com/a/53705/202602
- https://stackoverflow.com/a/11571916/10393067

## UUID
- [UUID can have your own format, **you can split it in 4 numbers and each one of them represent something else, for example if you group the users from 20 websites, the first number can represent the application**](https://coder.today/tech/2017-10-04_software-engineerfrom-monolith-to-cloud-auto-increment-to-uuid/)
- [UUID cho cach mang cong nghiep 4.0](https://kipalog.com/posts/UUID-cho-cach-mang-4-0)

### [Sharding là gì? – Cách Instagram tạo ID trong database của họ bằng Sharding](https://topdev.vn/blog/sharding-la-gi/)
Đối với những hệ thống nhỏ chỉ cần 1 Database thì chắc chẳng mấy ai quan tâm đến việc tạo ra ID cho bản ghi. Vì dùng auto increment trong MySQL là có thể làm được rồi, chẳng cần phải làm gì thêm.

Thế nhưng với dữ liệu càng ngày càng to ra thì hệ thống chỉ có 1 database duy nhất có thể sẽ không thể đáp ứng được. Bởi vì traffic đang tập trung hết vào database đó.

Để giải quyết bài toán đó thì người ta đã tách database ra thành nhiều database khác nhau, và mỗi database đó sẽ chứa 1 phần dữ liệu. Ví dụ db01 chứa thông tin user từ 1 đến 1000, db02 chứa thông tin user từ 1001 đến 2000 chẳng hạn. Và khi query sẽ tìm xem user thuộc database nào và thực hiện truy vấn.

Tuyển dụng database vị trí lương cao, hấp dẫn

Và kĩ thuật này người ta gọi là sharding.

Thế nhưng có vấn đề xảy ra ở đây là làm thế nào sinh ra ID cho user mà không bị trùng lặp giữa các database đó? Dùng auto increment mặc định của database có giải quyết được không? Làm thế nào để từ 2 ID có thể phán đoán cái nào được sinh ra trước, cái nào được sinh ra sau?
