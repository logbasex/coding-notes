# Local Storage
[Tại sao Local Storage không an toàn và bạn không nên dùng nó để lưu trữ data nhạy cảm?](https://topdev.vn/blog/tai-sao-khong-nen-luu-tru-data-user-tren-local-storage/)
    ![](https://res.cloudinary.com/practicaldev/image/fetch/s--hCUkqN8R--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/wpj8oyxs3qhog709aa24.png)

Có một vấn đề: hầu hết những thứ xấu về local storage đều không quá quan trọng. Bạn vẫn có thể dùng nó nhưng app sẽ chậm hơn một chút và nhiều phiền toái cho dev. Nhưng vấn đề bảo mật thì khác. Model bảo mật của local storage rất rất quan trọng để biết và nó hoàn toàn ảnh hưởng đến trang web của bạn theo nhiều cách khác nhau.

Còn vấn đề của local storage đó nó không an toàn! Hoàn toàn không. Mọi người đều dùng local storage để store thông tin nhạy cảm như session data, user detail và tất cả những thứ bạn không muốn post công khai trên Facebook.


Local storage không được design như một cơ chế storage an toàn trên browser. Nó được design để store các string đơn giản mà dev có thể dùng để build các app single page phức tạp hơn một chút. Vậy thôi.

### Thứ nguy hiểm nhất trên thế giới là gì? JavaScript!
Hãy thử nghĩ xem: khi bạn store thông tin nhạy cảm lên local storage, bạn cũng đang làm một trong những việc liều lĩnh nhất thế giới là store thông tin lên công cụ tệ nhất mọi thời đại. Nếu bị tấn công cross-site scripting (XSS) thì sao? Tôi sẽ không kể lê thê hết về XSS đâu, nhưng tóm tắt là như thế này:

Nếu một attacker có thể run JavaScript trên wesite của bạn, họ có thể retrive mọi data bạn đã lưu trong local storage và gửi nó đi các domain khác của chúng. Nó có nghĩa là bất kì thứ gì nhạy cảm bạn có đều sẽ được công khai.

Bây giờ, có thể bạn sẽ nghĩ “Vậy thì sao? Website của tôi rất an toàn. Không một ai có thể run JavaScript trên website của tôi được.”

Nếu website của bạn thật sự an toàn và không kẻ nào có thể làm vậy thì căn bản là bạn an toàn nhưng thực tế thì nó rất khó trở nên như vậy. Nếu website của bạn chứa bất kì code JavaScript bên thứ ba nào gồm source ngoài domain:

- Links đến bootstrap
- Links đến jQuery
- Links đến Vue, React, Angular, etc.
- Links đến ad network code bất kì
- Links đến Google Analytics
- Links đến tracking code bất kì
Ví dụ website của bạn có nhúng script tag dưới đây:

```
<script src="https://awesomejslibrary.com/minified.js"></script>
```
Trong trưởng hợp này, nếu awesomejslibrary.com bị hack và script minified.js bị thay đổi:

Loop mọi data trong local storage
Gửi nó qua API được build để thu thập info bị mất
… thì lúc đó bạn tiêu rồi. Lúc này kẻ attack đã có thể xài bất cứ gì bạn có trong local storage và bạn chả bao giờ phát hiện được. Nhưng trên thực tế, chuyện này cũng khá hiếm.

Với nhiều công ty, team marketing trực tiếp quản lý public website dùng các WYSIWYG editors và tools khác nhau. Bạn có chắc là không có phần nào trên site của bạn không dùng JavaScript bên thứ ba không? Dám cá là không.

Lời cảnh báo và giảm risk về bảo mật: làm ơn đừng store cái gì lên local storage cả.

PSA: Đừng store các JSON Web Tokens trên Local Storage
Stick Figure with Stop Sign
Ngoài khuyên bạn tránh xa local storage, tôi nghĩ cũng nên nói về JSON Web Tokens (JWT). Một trong những vấn đề bảo mật tôi thấy là có những người store JWTs (session data) trên local storage. Nhiều người không nhận ra rằng JWTs cũng giống hệt như username và password.

Nếu attacker lấy được bản copy của JWT, chúng có thể gửi request đi trên danh nghĩa của bạn và bạn sẽ không biết được. Hãy xem nó như thông tin credit card của mình hoặc password: đừng lưu trữ nó trên local storage.

Có rất nhiều tutorial, video Youtube, và cả các lớp programming tại trường đại học và coding boot camp dạy cho các dev để store JWT trên local storgae như một cơ chế mặc định. Điều này rất không đúng. Nếu bạn nghe ai đó nói bạn như vậy, tránh xa ngay. Thế thì chẳng lẽ không dùng local storage nữa à? Vậy data user tui muốn lưu thì có cách nào thay thế không man?

### [Dùng gì để lưu trữ data thay thế local storage?](https://topdev.vn/blog/dung-gi-de-luu-tru-data-thay-the-local-storage/)