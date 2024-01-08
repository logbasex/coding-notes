## Refenrences
- https://200lab.io/blog/database-la-gi
- 

-----
-----

Cuộc sống số hiện tại đem đến cho chúng ta rất nhiều tiện ích, cùng với đó là bùng nổ lưu trữ dữ liệu với nhiều định dạng khác nhau: có cấu trúc, bán cấu trúc hoặc không có cấu trúc. Cùng với đó là nhu cầu về lưu trữ và xử lý dữ liệu ngày càng lớn, do vậy đã có rất nhiều loại database được sinh ra để phục vụ cho những mục đích khác nhau.

Cơ sở dữ liệu (Database) là nơi mà thông tin được tổ chức và tiếp cận một cách thông minh và hiệu quả. Đối với những người làm việc trong lĩnh vực công nghệ thông tin, cơ sở dữ liệu không chỉ là một khái niệm mà nó là một tài nguyên quan trọng không thể thiếu trong công việc hàng ngày.

Trong khuôn khổ viết này, chúng tôi sẽ khám phá về cơ sở dữ liệu - một khái niệm mà bạn có thể đã nghe nhắc tới nhưng chưa tìm hiểu kỹ. Ngoài ra, bạn có thể tìm hiểu thêm về ứng dụng của Database trong các sản phẩm mà chúng ta dùng hàng ngày.

## **1. Cơ Sở Dữ Liệu là gì?**

![Cơ Sở Dữ Liệu là gì](https://statics.cdn.200lab.io/2023/09/image-37.png)

Database và DBMS

### **1.1. Giới thiệu về Cơ Sở Dữ Liệu - Database**

**Cơ sở dữ liệu hay Database** là tập hợp dữ liệu có tổ chức được lưu trữ và truy xuất trên thiết bị điện tử thông qua việc sử dụng **hệ quản trị cơ sở dữ liệu (DBMS)**

> In computing, a **database** is an organized collection of data (also known as a data store) stored and accessed electronically through the use of a database management system - [Wikipedia](https://en.wikipedia.org/wiki/Database?ref=200lab.io)

Những database nhỏ có thể được lưu trữ trên hệ thống tệp tin của một máy tính, trong khi những database lớn có thể được lưu trữ trên các cụm máy tính hoặc trên môi trường cloud.

### **1.2. Lịch sử phát triển của Database**

![Cơ Sở Dữ Liệu là gì](https://statics.cdn.200lab.io/2023/09/image-21.png)

Lịch sử phát triển của database

**Những năm 1950 (1950s):** Thời điểm này, các máy tính vẫn sử dụng băng từ để lưu trữ thông tin, dữ liệu lúc này được tổ chức thành các tệp tin để lưu trữ và truy xuất thông tin.

**Những năm 1960 (1960s):** Hệ thống quản lý cơ sở dữ liệu phân cấp **(hierarchical database management system)** được ra đời. Các hệ thống này lưu trữ dữ liệu dưới dạng cây, trong đó, mỗi bản ghi có thể có nhiều bản ghi con. Điều này giúp cải thiện khả năng truy cập và quản lý dữ liệu so với các hệ thống quản lý cơ sở dữ liệu dựa trên tệp.

Một số hệ thống quản lý cơ sở dữ liệu phân cấp nổi tiếng trong giai đoạn này bao gồm: IDS (Integrated Data Store) của Charles Bachman hay CODASYL (Conference on Data Systems Language) của CODASYL.

**Những năm 1970 (1970s):** Bắt đầu xuất hiện khái niệm về mô hình dữ liệu dạng quan hệ (**Relational Model**) qua một số bài báo của **Edgar F. Codd**. Qua đó, tác giả đã đưa ra những khái niệm đầu tiên về cơ sở dữ liệu quan hệ mà chúng ta vẫn dùng ngày nay như bảng, cột, dòng, thực thể, thuộc tính...

**Cuối những năm 1970 (Late 1970s):** Bản tiêu chuẩn của ngôn ngữ truy vấn dữ liệu (**[Structured Query Language - SQL](https://200lab.io/blog/sql-la-gi/)**) được giới thiệu và sử dụng. SQL cung cấp [bộ cú pháp](https://200lab.io/blog/sql-cheat-sheet-danh-cho-nguoi-moi/) đầy đủ và tiện lợi cho người dùng dễ dàng tương tác với dữ liệu của mình.

**Năm 1998:** NoSQL ra đời với kỳ vọng có thể xử lý được những dạng dữ liệu không có cấu trúc hoặc bán cấu trúc và có tốc độ xử lý nhanh hơn. Khi nhắc đến NoSQL, chúng ta có thể hiểu theo một trong hai nghĩa là không dùng SQL (**No SQL systems** ) hoặc không chỉ là (**Not only SQL**)

Mặc dù trải qua thời gian phát triển lâu dài, nhìn chung đến thời điểm hiện tại, có thể phân thành hai nhánh chính của database là SQL và NoSQL, mỗi nhánh lớn này đều có những điểm riêng để có thể tối ưu cho những bài toán khác nhau. Tuy nhiên, khi nhìn vào một database thì chúng ta đều có thể thấy được 5 cấu phần chung nhất và sẽ được giới thiệu ở phần tiếp theo.

## **2. DBMS là gì? Tìm hiểu Hệ Quản Trị Cơ Sở Dữ Liệu**

### **2.1. Giới thiệu về DBMS**

**DBMS (Database management system)** hay hệ quản trị cơ sở dữ liệu là phần mềm tương tác với người dùng cuối, ứng dụng và chính cơ sở dữ liệu để thu thập và phân tích dữ liệu.

> A **database management system** (**DBMS**) is the software that interacts with end users, applications, and the database itself to capture and analyze the data - Wikipedia

Hay nói các khác, **DBMS** chính là công cụ để chúng ta và cả những phần mềm khác có thể sử dụng database một cách hiệu quả và đơn giản hơn.

### **2.2. Sự khác nhau giữa Cơ Sở Dữ Liệu và Hệ Quản Trị Cơ Sở Dữ Liệu (DBMS)**

| Tiêu chí | Database | DBMS |
| --- | --- | --- |
| Định nghĩa | Một database là một tập hợp có tổ chức của dữ liệu về một hay nhiều đối tượng nào đó | DBMS là một tập hợp các chương trình máy tính giúp bạn tạo, quản lý và vận hành database |
| Lưu trữ | Ngoài máy tính, thì database có thể được lưu trữ trên ổ cứng, hay thậm chí trên giấy | DBMS, mọi bản ghi đều được lưu trữ trên máy tính |
| Truy vấn thông tin | Sự truy vấn thông tin từ database có thể được thực hiện một cách thủ công qua các câu lệnh hay sử dụng các ngôn ngữ lập trình (Golang, Java, PHP ...) | Chúng ta chỉ có thể truy vấn thông tin trong DBMS qua ngôn ngữ truy vấn mà DBMS đó cung cấp |
| Sao lưu và khôi phục | Databases không đảm bảo việc rằng dữ liệu sẽ vẫn sẵn sàng nếu có sự cố phát sinh | DBMS đảm bảo việc dữ liệu sẽ vẫn còn đó và sẵn sàng phục vụ nếu có phát sinh sinh |

### **2.3. Các thành phần của Hệ Quản Trị Cơ Sở Dữ Liệu**

![Cơ Sở Dữ Liệu là gì](https://statics.cdn.200lab.io/2023/09/image-38.png)

Các thành phần của DBMS

#### **2.3.1. Interface Language or API**

Để có thể giao tiếp với database, các DBMS đều có tích hợp trong mình những công cụ để người sử dụng hay các phần mềm khác có thể tương tác được, chúng được gọi là **Interface Language hay API**. Nhìn chung các DBMS thường cung cấp các 5 loại ngôn ngữ tương tác sau:

-   **Data Definition Language (DDL):** Ngôn ngữ đặc tả dữ liệu, giúp chúng ta định nghĩa cấu trúc của database, bao gồm các phép toán chính thêm, sửa, xoá và thay đổi cấu trúc dữ liệu của database.
-   **Data Manipulation Language (DML):** Ngôn ngữ thao tác với dữ liệu, giúp chúng ta tương tác để thay đổi dữ liệu trong database như thêm, sửa, xoá dữ liệu.
-   **Data Control Language (DCL):** Ngôn ngữ điều khiển dữ liệu,bao gồm các câu lệnh như GRANT, REVOKE với mục đích chính để xử lý phân quyền truy vấn hay thao tác với dữ liệu hay quản lý các quyền khác trong database.
-   **Data Query Language (DQL):** Ngôn ngữ truy vấn dữ liệu, giúp chúng ta có thể truy vấn được dữ liệu trên một hoặc nhiều cấu trúc khác nhau trong database.
-   **Transaction Control Language (TCL):** Ngôn ngữ điều khiển giao dịch, do trong quá trình thực thi một câu lệnh nào đó, database cần trải qua nhiề bước, ở mỗi bước đều có thể gặp lỗi, vì vậy, chúng ta cần có TCL để có thể nhận biết cũng như xử lý các lỗi đó trong quá trình thực thi của database.

#### **2.3.2. Query Processor**

Đây có thể coi là bộ não của DBMS bởi nó sẽ tiếp nhận các yêu cầu từ bên ngoài, xử lý các yêu cầu đó rồi trả về kết quả. Tuỳ thuộc vào các DBMS khác nhau, quá trình xử lý câu lệnh trong Query Processor cũng có thể khác nhau. Nhưng nhìn chung, khi tiếp nhận một câu lệnh, các DBMS sẽ xử lý qua các bước như trong ảnh dưới đây:

![database là gì](https://statics.cdn.200lab.io/2023/09/image-22.png)

Các bước xử lý trong Query Processor của DBMS

#### **2.3.3. Storage**

Lưu trữ dữ liệu là tác vụ bắt buộc, không thể thiếu của bất kỳ database nào. Và để có thể tối ưu cho từng quá trình, dữ liệu trên database của bạn có thể được lưu trữ trên ổ cứng gắn ngay trên máy tính, trên RAM trên cùng một máy tính, hay thậm trí là trên ổ cứng của một máy tính khác. Mỗi nơi lưu trữ này đều có sự đánh đổi về tốc độ truy cập với dung lượng mà nơi lưu trữ đó đem lại.

#### **2.3.4. Indexes**

Nếu database chỉ đơn thuần lưu trữ dữ liệu và thực hiện tìm kiếm một cách tuần tự khi truy vấn, thì quá trình tìm kiếm sẽ rất lâu. Vì vậy trong các DBMS thường có khu vực riêng giành cho việc phân loại và sắp xếp, đánh dấu dữ liệu từ trước để đến khi truy vấn, chúng ta có được kết quả nhanh hơn. Khu vực này gọi là **Indexes** của DBMS.

#### **2.3.5. Metadata**

Để có thể quản lý được dữ liệu thì chúng ta cần thông tin về những dữ liệu được lưu trữ đó, những thông tin đó được gọi là **metadata**. Metatdata giúp chúng ta tổ chức, tìm kiếm và hiểu về dữ liệu đang được lưu trữ. Ví dụ khi chúng ta chụp một bức ảnh bằng điện thoại, thì bản thân bức ảnh đó là data, còn metadata là các thông tin về bức ảnh đó như tên, định dạng, kích thước, ngày giờ chụp...

Một ví dụ khác là khi làm việc với **Relational databases**, chúng ta không những truy vấn ra được dữ liệu cần thiết, mà còn có thể lấy được những thông tin khác về dữ liệu đang hiển thị như các bảng, các cột, kiểu dữ liệu từng cột, các ràng buộc ... tương ứng với dữ liệu đang được hiển thị.

## **3. Các mô hình Cơ Sở Dữ Liệu thông dụng & ứng dụng**

### **3.1. Relational Database (RDBMS) và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-48.png)

Relational Databases

Hệ quản trị cơ sở dữ liệu quan hệ (**RDBMS**) là một dạng DBMS sử dụng  **relational database.** Relational database là tập hợp của các thông tin được tổ chức với các quan hệ được định nghĩa từ trước với định dạng bảng, cột và dòng.

**Relational model** tổ chức dữ liệu thành một hoặc nhiều bảng. Mỗi bảng bao gồm các cột, mỗi cột có thể coi là một thuộc tính mà bảng đó mong muốn thể hiện ý nghĩa. Trong bảng, còn có các dòng, mỗi dòng chứa giá trị ứng với từng cột đã định nghĩa trước đó, mỗi dòng có thể có một định danh duy nhất (**primary key**) để phân biệt các dòng trong cùng một bảng.

Giữa các bảng có thể tồn tại các mối quan hệ dưới dạng logic giúp cho chúng ta hình dung và mô tả được sự phụ thuộc về mặt dữ liệu của nghiệp vụ mà hệ thống cần đáp ứng. Mỗi dòng trong bảng có thể được sử dụng để thiết lập một khoá ngoại (**foreign key**) với các bảng khác để thể hiện sự tham chiếu đến nhau giữa các dòng dữ liệu.

RDBMS thường được dùng cho các ứng dụng có lượng giao dịch lớn và cần độ tin cậy cao như các ứng dụng về tài chính, ngân hàng. Có thể kể đến một số cái tên nổi tiếng như IBM, Oracle, [MySQL](https://200lab.io/blog/mysql-la-gi/), Postgres, [Microsoft SQL Server](https://200lab.io/blog/sql-server-la-gi/). Những RDBMS này được sử dụng bởi rất nhiều những công ty nổi tiếng và hoạt động trong nhiều ngành nghề khác nhau trên thế giới như:

-   **Postgres** được sử dụng nhiều bởi các công ty công nghê, ví dụ Skype \- Một ứng dụng nhắn tin, gọi điện phổ biến trên thế giới với hơn 300 triệu người dùng hàng tháng. [Skype sử dụng Postgres](https://wiki.postgresql.org/images/2/28/Moskva_DB_Tools.v3.pdf?ref=200lab.io) được sử dụng để lưu trữ thông tin về người dùng, các đoạn tin nhắn, dữ liệu hội thoại, ...
-   **IBM, Oracle** là hai RDBMS được ưa thích sử dụng trong các lĩnh vực ngân hàng, tài chính và bán lẻ trên toàn thế giới như Mizuho Bank, một ngân hàng tại Nhật Bản với hơn 5 nghìn nhân viên và doanh thu lên đến hơn  18 tỷ $.
-   **MySQL** được sử dụng nhiều bởi các công ty công nghệ như Github, Booking.com, Netflix...
-   **Microsoft SQL Server** lại được sử dụng nhiều trong các công ty hoạt động trong lĩnh vực sản xuất, ngân hàng, tài chính, và cả công nghệ. Trang Stackoverflow mà chúng ta hay truy cập cũng sử dụng **Microsoft SQL Server.**
-   **SQL lite:** Với sự đơn giản và gọn nhẹ của mình, [SQL Lite](https://200lab.io/blog/su-dung-sqlite-trong-flutter/) có thể được sử dụng trên các thiết bị máy khách như điện thoại di động hay trình duyệt.

### **3.2. Columnar Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-49.png)

Cách lưu trữ dữ liệu theo dòng và theo cột trong DBMS

Trong khi **relational database** được tối ưu cho việc lưu trữ dữ liệu dưới dạng các dòng - tức dữ liệu của cùng một dòng sẽ được lưu trữ gần nhau trong ổ cứng, việc này giúp tối ưu hoá cho các ứng dụng liên quan nhiều tới giao dịch. Thì **Columnar Database** lại lưu dữ liệu theo từng cột, việc này làm tăng quá trình lưu trữ và lấy dữ liệu của từng cột trong database đặc biệt trong các ứng dụng nặng về phân tích.

Hãy tưởng tượng khi chúng ta thực hiện một câu lệnh truy vấn có điều kiện WHERE trên 1 cột nào đó thì với **relational database**, nó phải tải lên tất cả các cột trong một dòng rồi tìm tới cột cần xác định điều kiện. Trong khi đó với **Columnar Database** thì DBMS chỉ cần tải lên đúng dữ liệu của 1 cột đó và thực hiện việc lọc.

Đó là một ví dụ đơn giản về việc Columnar Databases tối ưu hơn do giảm thiểu được đáng kể lượng dữ liệu đi từ ổ cứng đến CPU, từ đó giảm được thời gian xử lý khi thực thi truy vấn. Ngoài ra còn nhiều đặc điểm khác mà khi chúng ta áp dụng sẽ thấy Columnar Databases có ưu thế hơn nhiều so với relational database.

Columnar Databases được sử dụng nhiều cho các ứng dụng liên quan tới phân tích, thống kê với lượng dữ liệu lớn. Một số database được sử dụng rộng rãi là Google Cloud BigQuery, Amazon redshift, Snowflake, ClickHouse...

-   **Google Cloud BigQuery** được các công ty lớn như Paypal, Twitter, Airbus sử dụng.
-   **Amazon redshift** được Nasdaq sử dụng  để có thể đáp ứng lượng giao dịch lên đến [70 tỷ bản ghi mỗi ngày](https://aws.amazon.com/vi/solutions/case-studies/nasdaq-case-study/?ref=200lab.io)
-   **Snowflake** được sử dụng bởi Cardinal Health, Inc., một tổ chức sức khoẻ tại Mỹ với 46500 nhân viên và hơn 181.36 tỷ $ doanh thu
-   **Clickhouse** được Cloudflare sử dụng để có thể xử lý tới [6 triệu request/s](https://blog.cloudflare.com/http-analytics-for-6m-requests-per-second-using-clickhouse/?ref=200lab.io).

### **3.3. Key-Value Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-50.png)

Dữ liệu trong Key-Value Database

**Key-Value Database** là một loại trong NoSQL database sử dụng phương thức đơn giản là key-value để lưu trữ dữ liệu, ở đó, dữ liệu được lưu trữ dưới dạng tập hợp của một cặp key-value. Mỗi key có một giá trị xác định duy nhất trên toàn bộ datbase, từ đó có thể lấy được value dựa theo key .

Do đặc tính tổ chức đơn giản nên **Key-Value Database** có thể dễ dàng phân mảnh và lưu trữ trên nhiều máy tính khác nhau, giúp cho việc mở rộng theo chiều ngang được thực hiện một cách dễ dàng và đáng tin cậy.

Key-Value Database được sử dụng nhiều trong các ứng dụng cần tốc độ truy xuất dữ liệu nhanh như lưu trữ phiên làm việc của người dùng trong môi trường phân tán, hay làm **cache** để truy xuất thông tin nhanh hơn. Một số Key-Value Database được sử dụng nhiều hiện nay như Amazon DynamoDB, Redis ...

-   Amazon DynamoDB được sử dụng bởi Samsung Cloud, Zoom, Snap Chat, Dropbox, Netflix...
-   Redis được sử dụng bởi Twitter, GitHub, StackOverflow...

### **3.4. Wide-column Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-51.png)

Dữ liệu trong Wide-column Database

**Wide-column database (WCD)** là một loại database NoSQL lưu trữ dữ liệu theo cột. Mỗi cột có thể chứa một loại dữ liệu khác nhau, và số lượng cột trong mỗi hàng có thể thay đổi. Điều này làm cho WCDs phù hợp để lưu trữ lượng lớn dữ liệu với nhiều loại dữ liệu khác nhau.

**_WCDs có một số lợi thế so với các loại database liệu khác, bao gồm:_**

-   **Khả năng mở rộng:** WCDs có thể được mở rộng theo chiều ngang để xử lý lượng lớn dữ liệu.
-   **Tính linh hoạt:** WCDs có thể lưu trữ dữ liệu với các kiểu và cấu trúc khác nhau.
-   **Hiệu suất cao:** WCDs có thể xử lý hiệu quả các truy vấn quét lượng lớn dữ liệu.

**_Tuy nhiên, WCDs cũng có một số hạn chế, bao gồm:_**

-   **Độ phức tạp:** WCDs có thể phức tạp hơn để quản lý so với các loại database khác.
-   **Tính nhất quán thấp:** WCDs có thể không đảm bảo tính nhất quán mạnh mẽ, điều này có thể là một vấn đề đối với một số ứng dụng đòi hỏi tính nhất quán cao về dữ liệu.

Nhìn chung, WCDs là một công cụ mạnh mẽ để lưu trữ và truy vấn lượng lớn dữ liệu. Chúng phù hợp với các ứng dụng yêu cầu khả năng mở rộng, linh hoạt và hiệu suất cao mà lại không yêu cầu lớn về tính nhất quán của dữ liệu.

WCD đang được sử dụng cho một số lĩnh vực như: Phân tích thời gian thực, Datawarehouse, học máy, IoT, Game ... Một số sản phẩm nổi tiếng như Apache Cassandra, HBase, Google Bigtable, Scylladb.

Tháng 3, năm 2023, trong [một bài viết](https://discord.com/blog/how-discord-stores-trillions-of-messages?ref=200lab.io), Discord nói rằng họ đã chuyển dữ liệu của hàng tỷ tin nhắn trên nền tảng của mình từ **Cassandra** sang **Scylla**. Kết quả là từ việc sử dụng 177 node cho **Cassandra,** Discord chỉ cần sử dụng 72 node cho **Scylla,** và dung lượng mỗi node khi dùng **Scylla** là 9TB so với 4TB của **Cassandra.**

### **3.5. Document Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-54.png)

Dữ liệu trong Document Database


**Document database** là một loại database NoSQL lưu trữ dữ liệu dưới dạng tài liệu (**document**). Mỗi tài liệu có thể chứa nhiều trường dữ liệu và được lưu trữ dưới dạng **JSON hoặc BSON hoặc XML** . Các trường có thể có các loại dữ liệu khác nhau, chẳng hạn như số, chuỗi, mảng, và đối tượng.

Document database được thiết kế để lưu trữ dữ liệu bán cấu trúc (dữ liệu không có cấu trúc cố định ). Điều này làm cho chúng phù hợp để lưu trữ dữ liệu từ các nguồn khác nhau, chẳng hạn như dữ liệu từ ứng dụng web, dữ liệu từ cảm biến, và dữ liệu từ hệ thống phân tán ...

**_Document database có nhiều điểm mạnh:_**

-   **Document model:** Mô hình tài liệu là phổ biến, trực quan và cho phép phát triển phần mềm nhanh chóng.
-   **Flexible schema:** Schema linh hoạt cho phép mô hình dữ liệu thay đổi khi yêu cầu của ứng dụng thay đổi.
-   **Rich APIs and query languages:** Document database có API và ngôn ngữ truy vấn phong phú cho phép nhà phát triển dễ dàng tương tác với dữ liệu của họ.
-   **Distributed and resilient:** Document database có thể dễ dàng mở rộng theo chiều ngang và có khả năng chịu tải và phục hồi nhanh sau sự cố.

Document database được sử dụng nhiều trong các ứng dụng về quản lý nội dung trang web, Gaming, E-commerce và bán lẻ, Logging and monitoring ... Với một số cái tên nổi bật như MongoDB, Couchbase, CouchDB ...MongoDB được tin dùng bởi nhà mạng Verizon, Adobe.

### **3.6. Graph Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-55.png)

Dữ liệu trong Graph Database

**Graph database** là một loại database NoSQL lưu trữ dữ liệu dưới dạng đồ thị. Đồ thị là một cấu trúc dữ liệu bao gồm các đỉnh (nút) được kết nối với nhau bằng các cạnh. Mỗi đỉnh có thể đại diện cho một thực thể, chẳng hạn như một người, một địa điểm, hoặc một sản phẩm. Mỗi cạnh có thể đại diện cho một mối quan hệ giữa hai thực thể, chẳng hạn như bạn bè, hàng xóm, hoặc mua bán.

Graph database được thiết kế để lưu trữ dữ liệu có nhiều mối quan hệ phức tạp. Điều này làm cho chúng phù hợp để lưu trữ dữ liệu từ các lĩnh vực như mạng xã hội, tài nguyên mạng, và phân tích dữ liệu, hệ thống gợi ý ...

Một số Graph database được ưa chuộng như Neo4j, ArangoDB, GraphDB...

EBay và ATPCO sử dụng Neo4j để phục vụ cho các ứng dụng về gợi ý tìm kiếm, quảng cáo, điều phối logistics ...

### **3.7. Vector Database và ứng dụng**

![database là gì](https://statics.cdn.200lab.io/2023/09/image-56.png)

Dữ liệu trong Vector Database

**Vector database** là một loại cơ sở NoSQL lưu trữ dữ liệu dưới dạng vector đa chiều. Vector là một đối tượng trong toán học được mô tả bởi một điểm và chiều cao của điểm đó trong không gian, mỗi chiều của vector có thể đại diện cho một thuộc tính khác nhau của dữ liệu.

Dữ liệu đầu vào cho vector database có thể là văn bản, hình ảnh, âm thanh, video ..., tuy nhiên trước khi được lưu trữ, chúng cần phải trải qua quá trình biến đổi (transformation).

Ưu điểm lớn nhất mà vector database đem lại chính là việc chúng có thể giúp chúng ta tìm kiếm gần đúng một cách nhanh chóng trên các loại dữ liệu khác nhau như:

-   Tìm kiếm ảnh mà gần giống nhất với một bức ảnh đã có dựa trên nội dung hay màu sắc, phong cách của bức ảnh đó.
-   Tìm kiếm các tài liệu gần giống nhất với các tài liệu được đưa vào dựa trên chủ đề, hay quan điểm của tài liệu đầu vào.
-   Tìm kiếm các sản phẩm gần nhất với sản phẩm sẵn có dựa trên các tính năng hay đánh giá về sản phẩm đó.

Ứng dụng của Vector Database là rất lơn, nhất là trong lĩnh vực về xử lý ngôn ngữ tự nhiên (**Natural Language Processing - NLP**), thị giác máy tính (**Computer Vision**), hệ thống gợi ý (**Recommendation Systems**).

Một số Vector Database thông dụng như: **Chroma, Pinecone, Weaviate**... Tuy nhiên, nững database này còn khá mới mẻ và đang trong thời gian hoàn thiện nên chúng ta sẽ ít thấy được sự hiện diện của chúng trong các sản phẩm thương mại đã có trên thị trường hiện nay.

## **4. Kết luận về Cơ Sở Dữ Liệu**

Cơ Sở Dữ Liệu là thành phần đóng vai trò quan trọng trong các ứng dụng trực tuyến ngày nay. Với những kiến trúc sư, việc hiểu biết về nguyên lý chung của các Cơ Sở Dữ Liệu và hiểu về đặc tính của từng loại Cơ Sở Dữ Liệu là yếu tố quan trọng giúp cho việc lựa chọn được loại Database phù hợp với dự án đang phát triển.

Với nhu cầu ngày càng cao về việc lưu trữ và xử lý dữ liệu, các Cơ Sở Dữ Liệu cũng ngày càng được phát triển và hoàn thiện hơn mỗi ngày. Từ những Cơ Sở Dữ Liệu đã được phát triển hàng chục năm trước đến nay vẫn còn được tiếp tục nâng cấp, cho tới những loại Cơ Sở Dữ Liệu mới được thử nghiệm trong vài năm gần đây.

