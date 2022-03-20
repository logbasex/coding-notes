- [Microservice database design](https://www.baeldung.com/cs/microservices-db-design)
- [Distributed transaction](https://viblo.asia/p/distributed-transaction-two-phase-commit-naQZRBemZvx)
- [Service Mesh](https://viblo.asia/p/service-mesh-la-gi-dong-vai-tro-nhu-the-nao-trong-microservices-architecture-djeZ1jr3lWz)
-----
## [Microservices: Những sai lầm và chiến lược chuyển đổi từ Monolith](https://200lab.io/blog/microservices-chien-luoc-chuyen-doi-tu-monolithic/)

### Vì sao cần chuyển đổi Microservices

Sẽ có vài câu chuyện rất quen thuộc trên công ty, à chính xác là ở team/bộ phận backend:

- Khi bạn muốn deploy service vì update một tính năng X -> X' nhưng team thì đang hì hục code hoặc debug tính năng A,B,C,D thì bạn sẽ phải đợi cho mọi thứ xong hết.
- Mỗi thành viên trong team (developer) đều nhìn thấy toàn bộ source code. Bạn muốn bảo mật hoặc giới hạn là không thể.
- Bạn muốn đổi stack backend, có thể là framework khác, hoặc đổi luôn ngôn ngữ thậm chí database. Mình tin là sếp bạn sẽ không dám mạo hiểm để đổi toàn bộ sourcecode lớn như thế.
- Mỗi ngôn ngữ và DB đều có thế mạnh riêng. Nhưng vì là monolith, bạn buộc phải follow theo stack từ rất lâu đời này.

--------
## Save for later
- https://www.youtube.com/watch?v=Ijs55IA8DIk
- http://thinkmicroservices.com/blog/2019/principles-of-isolation.html
- [Tight coupling microservice](https://medium.com/it-dead-inside/isolating-your-microservices-through-loose-coupling-48b710e28de6)