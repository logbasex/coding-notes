## Summary

Khi thêm thư viện **dropbox.sign** sử dụng java8 vào ứng dụng Spring Boot 3 sử dụng Java 21 thì compile thành công và khi run lại lỗi.

Bởi vì có những vấn đề sau:
- Thư viện java8 có sử dụng **javax** package.
- Thư viện java21 đã remove **javax** package và thay bằng **jakarta** package.
- Tại thời điểm compile thì chỉ check method call như **a.b.c.Config.load()** được gọi trong Spring Boot có tồn tại trong thư viện (classpath) => Nghĩa là trong package **a.b.c** có chứa file **Config.java** và trong file này có chứa method **load()**.
- Tại thời điểm runtime thì khi gọi đến **Config.load()**, JVM mới tiến hành load class này và những class liên quan để thực thi thì throw ra lỗi **NoClassDefFoundError** vì Spring Boot 3 không dùng **javax** package.