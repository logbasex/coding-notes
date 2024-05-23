- [SỰ KHÁC BIỆT GIỮA SERVER-SIDE RENDERING VÀ CLIENT-SIDE RENDERING](https://toidicodedao.com/2018/09/11/su-khac-biet-giua-server-side-rendering-va-client-side-rendering/)
- [Render React Ở Phía Server](https://viblo.asia/p/render-react-o-phia-server-924lJOjY5PM)
- [JavaScript SEO: Server Side Rendering vs. Client Side Rendering](https://medium.com/@benjburkholder/javascript-seo-server-side-rendering-vs-client-side-rendering-bc06b8ca2383)

![](images/ssr.webp)

![](images/csr.webp)

![](images/js-render.webp)

====
====

## Client side thì trả về khung trước sau đó mới call API fill data vào đúng không

Đúng vậy, trong Client-Side Rendering (CSR), quá trình render nội dung trang web diễn ra trên trình duyệt của người dùng. Dưới đây là quy trình chi tiết của CSR và cách nó khác biệt so với Server-Side Rendering (SSR):

### Quy trình Client-Side Rendering (CSR)
1. **Yêu cầu ban đầu**: Khi người dùng truy cập một URL, trình duyệt gửi yêu cầu đến máy chủ.
2. **Phản hồi từ máy chủ**: Máy chủ gửi về một HTML cơ bản, thường chỉ chứa các thẻ `<head>` và một `<div>` trống hoặc một cấu trúc HTML tối giản cùng với các liên kết đến các file CSS và JavaScript.
3. **Tải JavaScript**: Trình duyệt tải và thực thi các file JavaScript được liên kết trong HTML. JavaScript thường bao gồm các thư viện và framework như React, Vue.js, hoặc Angular.
4. **Gửi yêu cầu API**: Sau khi JavaScript được tải và thực thi, nó sẽ gửi các yêu cầu API (thường là AJAX hoặc fetch) đến máy chủ để lấy dữ liệu cần thiết cho trang.
5. **Nhận dữ liệu và render**: Trình duyệt nhận dữ liệu từ các yêu cầu API và sử dụng JavaScript để render nội dung động vào trang web. Nội dung này được chèn vào DOM (Document Object Model) của trang.

### Ví dụ minh họa với React
Dưới đây là một ví dụ đơn giản về cách CSR hoạt động với React:

1. **HTML cơ bản (index.html)**:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>CSR Example</title>
   </head>
   <body>
       <div id="root"></div>
       <script src="bundle.js"></script> <!-- JavaScript bundle của React -->
   </body>
   </html>
   ```

2. **JavaScript (index.js)**:
   ```javascript
   import React, { useEffect, useState } from 'react';
   import ReactDOM from 'react-dom';

   function App() {
       const [data, setData] = useState(null);

       useEffect(() => {
           // Gửi yêu cầu API để lấy dữ liệu
           fetch('/api/data')
               .then(response => response.json())
               .then(data => setData(data));
       }, []);

       if (!data) {
           return <div>Loading...</div>;
       }

       return (
           <div>
               <h1>{data.title}</h1>
               <p>{data.message}</p>
           </div>
       );
   }

   ReactDOM.render(<App />, document.getElementById('root'));
   ```

### Lợi ích và hạn chế của CSR
**Lợi ích**:
- **Tương tác phong phú**: CSR cho phép xây dựng các ứng dụng web có tương tác phong phú và mượt mà, gần giống với ứng dụng di động.
- **Cập nhật nội dung động**: CSR rất hiệu quả trong việc cập nhật nội dung trang mà không cần tải lại toàn bộ trang.

**Hạn chế**:
- **Thời gian tải ban đầu chậm**: Do trình duyệt phải tải và thực thi JavaScript trước khi hiển thị nội dung, thời gian tải ban đầu có thể lâu hơn.
- **SEO**: Các công cụ tìm kiếm có thể gặp khó khăn trong việc lập chỉ mục nội dung được render bởi JavaScript, mặc dù điều này đã được cải thiện nhiều trong những năm gần đây.

### Kiểm tra CSR trong Network
Để kiểm tra quá trình CSR trong tab Network của Chrome DevTools:
1. **Mở Chrome DevTools**: Nhấn `Ctrl + Shift + I` hoặc `F12`.
2. **Đi đến tab Network**: Chọn tab "Network".
3. **Tải lại trang**: Tải lại trang web bạn đang kiểm tra.
4. **Kiểm tra yêu cầu JavaScript và API**: Bạn sẽ thấy yêu cầu đầu tiên là để tải HTML cơ bản. Sau đó là các yêu cầu tải JavaScript và các yêu cầu API để lấy dữ liệu.

Bằng cách này, bạn có thể thấy rõ cách CSR hoạt động và cách dữ liệu được lấy và chèn vào trang web.

====
====

## CSR vs SSR

Hiểu rõ sự khác biệt giữa Client-Side Rendering (CSR) và Server-Side Rendering (SSR) trong React có thể khá phức tạp nếu bạn mới bắt đầu. Hãy đi sâu vào từng ví dụ chi tiết, giải thích từng bước.

### Client-Side Rendering (CSR) với React

Trong CSR, toàn bộ quá trình render diễn ra trên trình duyệt sau khi tải trang. Dưới đây là một ví dụ đơn giản về cách thực hiện CSR trong React:

1. **index.html**:
   Đây là tệp HTML cơ bản được gửi từ máy chủ. Tệp này chứa một thẻ `<div>` với id là `root`, nơi React sẽ gắn kết ứng dụng của mình.

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>CSR Example</title>
   </head>
   <body>
       <div id="root"></div>
       <script src="bundle.js"></script> <!-- JavaScript bundle của React -->
   </body>
   </html>
   ```

2. **index.js**:
   Đây là tệp JavaScript chính của ứng dụng React. Nó chứa logic để lấy dữ liệu và render nội dung.

   ```javascript
   import React, { useEffect, useState } from 'react';
   import ReactDOM from 'react-dom';

   function App() {
       const [data, setData] = useState(null);

       // useEffect chạy sau khi component được render lần đầu tiên
       useEffect(() => {
           // Gửi yêu cầu API để lấy dữ liệu
           fetch('/api/data')
               .then(response => response.json())
               .then(data => setData(data));
       }, []);

       if (!data) {
           return <div>Loading...</div>;
       }

       return (
           <div>
               <h1>{data.title}</h1>
               <p>{data.message}</p>
           </div>
       );
   }

   ReactDOM.render(<App />, document.getElementById('root'));
   ```

### Server-Side Rendering (SSR) với React và Next.js

Trong SSR, quá trình render diễn ra trên máy chủ trước khi gửi HTML hoàn chỉnh về trình duyệt. Chúng ta sẽ sử dụng Next.js, một framework cho React hỗ trợ SSR tích hợp.

1. **pages/index.js**:
   Đây là tệp JavaScript chính của ứng dụng Next.js. Next.js sẽ tự động gọi hàm `getServerSideProps` để lấy dữ liệu trên máy chủ và render trang.

   ```javascript
   import React from 'react';

   const Home = ({ data }) => {
       return (
           <div>
               <h1>{data.title}</h1>
               <p>{data.message}</p>
           </div>
       );
   };

   // Hàm này chỉ chạy trên server-side
   export async function getServerSideProps() {
       // Lấy dữ liệu từ API hoặc nguồn dữ liệu khác
       const res = await fetch('https://api.example.com/data');
       const data = await res.json();

       // Trả về props cho component
       return { props: { data } };
   }

   export default Home;
   ```

### So sánh chi tiết:

#### Client-Side Rendering (CSR)

1. **Quá trình**:
    - Trình duyệt yêu cầu HTML từ máy chủ.
    - Máy chủ gửi HTML cơ bản với một thẻ `<div id="root">` và một liên kết đến file JavaScript (`bundle.js`).
    - Trình duyệt tải và thực thi file JavaScript này.
    - File JavaScript chứa mã React, bắt đầu render ứng dụng vào thẻ `<div id="root">`.
    - JavaScript gửi một yêu cầu API đến `/api/data` để lấy dữ liệu.
    - Khi dữ liệu được trả về, React sẽ cập nhật giao diện để hiển thị dữ liệu.

2. **Ví dụ mã nguồn**:
   ```html
   <!-- index.html -->
   <div id="root"></div>
   <script src="bundle.js"></script> <!-- JavaScript bundle của React -->
   ```

   ```javascript
   // index.js
   import React, { useEffect, useState } from 'react';
   import ReactDOM from 'react-dom';

   function App() {
       const [data, setData] = useState(null);

       useEffect(() => {
           fetch('/api/data')
               .then(response => response.json())
               .then(data => setData(data));
       }, []);

       if (!data) {
           return <div>Loading...</div>;
       }

       return (
           <div>
               <h1>{data.title}</h1>
               <p>{data.message}</p>
           </div>
       );
   }

   ReactDOM.render(<App />, document.getElementById('root'));
   ```

#### Server-Side Rendering (SSR) với Next.js

1. **Quá trình**:
    - Trình duyệt yêu cầu HTML từ máy chủ Next.js.
    - Máy chủ Next.js gọi hàm `getServerSideProps` để lấy dữ liệu từ API hoặc nguồn khác.
    - Máy chủ Next.js sử dụng dữ liệu này để render HTML hoàn chỉnh.
    - Máy chủ gửi HTML hoàn chỉnh về trình duyệt.
    - Trình duyệt hiển thị ngay nội dung đã render sẵn.

2. **Ví dụ mã nguồn**:
   ```javascript
   // pages/index.js
   import React from 'react';

   const Home = ({ data }) => {
       return (
           <div>
               <h1>{data.title}</h1>
               <p>{data.message}</p>
           </div>
       );
   };

   export async function getServerSideProps() {
       const res = await fetch('https://api.example.com/data');
       const data = await res.json();
       return { props: { data } };
   }

   export default Home;
   ```

### Sự khác biệt chính:

- **CSR**:
    - Dữ liệu được lấy và render trên trình duyệt.
    - Người dùng thấy trang "trống" hoặc trạng thái "loading" trước khi dữ liệu được tải về.
    - Tốt cho các ứng dụng cần nhiều tương tác người dùng sau khi tải trang.

- **SSR**:
    - Dữ liệu được lấy và render trên máy chủ.
    - Người dùng thấy nội dung đầy đủ ngay khi tải trang.
    - Tốt cho SEO và cải thiện tốc độ tải trang ban đầu.

### Minh họa dòng chảy dữ liệu:

#### CSR:
1. Trình duyệt yêu cầu HTML.
2. Máy chủ gửi HTML cơ bản với `div#root` và liên kết JavaScript.
3. Trình duyệt tải và thực thi JavaScript.
4. JavaScript gửi yêu cầu API để lấy dữ liệu.
5. Trình duyệt nhận dữ liệu và render nội dung.

#### SSR:
1. Trình duyệt yêu cầu HTML.
2. Máy chủ lấy dữ liệu và render HTML hoàn chỉnh.
3. Máy chủ gửi HTML đã render về trình duyệt.
4. Trình duyệt hiển thị nội dung ngay lập tức.

Hy vọng điều này giúp bạn hiểu rõ hơn về sự khác biệt giữa CSR và SSR trong React.

=======
=======

## CSR vs SSR

So sánh chi tiết giữa Client-Side Rendering (CSR) và Server-Side Rendering (SSR) sẽ giúp bạn hiểu rõ hơn về cách mỗi phương pháp hoạt động và khi nào nên sử dụng mỗi phương pháp. Dưới đây là bảng so sánh chi tiết giữa CSR và SSR:

| **Tiêu chí**                          | **Client-Side Rendering (CSR)**                                                   | **Server-Side Rendering (SSR)**                                                   |
|---------------------------------------|-----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| **Quy trình render**                  | Render trên trình duyệt sau khi trang đã tải                                      | Render trên máy chủ trước khi gửi HTML hoàn chỉnh về trình duyệt                   |
| **Hiệu suất tải trang ban đầu**       | Chậm hơn do phải tải và thực thi JavaScript trước khi hiển thị nội dung đầy đủ    | Nhanh hơn vì HTML đã được render sẵn trên máy chủ                                 |
| **Trải nghiệm người dùng ban đầu**    | Có thể thấy trang "trống" hoặc "loading" trong khi chờ dữ liệu                    | Thấy nội dung đầy đủ ngay khi tải trang                                           |
| **SEO**                               | Khó khăn hơn vì công cụ tìm kiếm phải chạy JavaScript để lập chỉ mục nội dung     | Tốt hơn vì nội dung đã được render sẵn, dễ lập chỉ mục hơn                        |
| **Tương tác người dùng**              | Tốt cho các ứng dụng có nhiều tương tác sau khi tải trang                         | Tốt cho các trang tĩnh hoặc trang có ít tương tác sau khi tải                     |
| **Tải trọng ban đầu**                 | JavaScript bundle lớn hơn vì chứa cả logic và mã render                           | HTML lớn hơn do đã chứa nội dung render sẵn                                       |
| **Phản hồi dữ liệu từ server**        | Gửi yêu cầu API từ trình duyệt sau khi trang đã tải                               | Gửi yêu cầu API từ máy chủ trước khi render HTML                                  |
| **Hiệu suất trên thiết bị yếu**       | Kém hơn trên thiết bị yếu do phải tải và thực thi nhiều JavaScript                | Tốt hơn trên thiết bị yếu vì trình duyệt chỉ cần hiển thị HTML đã render sẵn       |
| **Caching (bộ nhớ đệm)**              | Khó khăn hơn do dữ liệu được tải động trên trình duyệt                            | Dễ dàng hơn vì HTML đã render có thể được cache dễ dàng                           |
| **Khả năng phát triển**               | Phù hợp với các ứng dụng cần nhiều tương tác động và logic phía client             | Phù hợp với các trang tĩnh, trang nội dung hoặc trang có ít tương tác động        |
| **Thời gian phản hồi server**         | Phụ thuộc vào tốc độ mạng của người dùng và tải trọng của JavaScript              | Phụ thuộc vào tốc độ server và thời gian render HTML                              |

### Khi nào nên sử dụng CSR hay SSR?

#### Sử dụng CSR:
- Khi bạn cần nhiều tương tác người dùng sau khi tải trang.
- Khi tốc độ tải ban đầu không phải là vấn đề lớn.
- Khi bạn cần nhiều logic phức tạp trên client-side.

#### Sử dụng SSR:
- Khi bạn cần tối ưu hóa SEO.
- Khi bạn muốn cải thiện tốc độ tải trang ban đầu.
- Khi bạn có nhiều nội dung tĩnh hoặc ít tương tác người dùng sau khi tải trang.

Hy vọng rằng sự so sánh chi tiết này giúp bạn hiểu rõ hơn về sự khác biệt giữa CSR và SSR cũng như khi nào nên sử dụng mỗi phương pháp.

====
====

## SSR javascript

Trong quá trình Server-Side Rendering (SSR), máy chủ không chỉ chịu trách nhiệm lấy dữ liệu và render HTML, mà còn phải phục vụ các file tĩnh như JavaScript, CSS, hình ảnh, v.v. Để hiểu rõ hơn, chúng ta sẽ xem xét cách máy chủ xử lý và phục vụ các file JavaScript trong bối cảnh SSR.

### Quy trình chi tiết về việc lấy và phục vụ JavaScript file trong SSR:

1. **Build và Bundle**:
    - Trong quá trình phát triển và build ứng dụng, các file JavaScript được đóng gói (bundle) bằng các công cụ như Webpack hoặc Vite.
    - Các bundle này thường bao gồm toàn bộ mã JavaScript cần thiết để ứng dụng chạy trên cả server và client.

2. **Lưu trữ trên máy chủ**:
    - Sau khi build, các bundle JavaScript được lưu trữ trong một thư mục tĩnh trên máy chủ, thường là thư mục `public` hoặc `dist`.
    - Máy chủ sẽ được cấu hình để phục vụ các file trong thư mục này khi có yêu cầu từ trình duyệt.

3. **Sử dụng trong SSR**:
    - Khi máy chủ nhận được một yêu cầu từ trình duyệt, nó sẽ sử dụng các bundle JavaScript để render HTML.
    - Sau khi HTML được render, máy chủ sẽ gửi HTML này về trình duyệt, cùng với liên kết tới các file JavaScript cần thiết để trình duyệt có thể tải và thực thi chúng.

### Ví dụ minh họa với Next.js:

#### Cấu hình Next.js:
- Next.js tự động xử lý quá trình build và bundle JavaScript khi bạn chạy lệnh `next build`.
- Các file JavaScript này được lưu trữ và phục vụ từ thư mục `.next`.

**Cấu hình package.json**:
```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  }
}
```

#### Cấu hình server:
- Khi bạn chạy lệnh `next start`, Next.js sẽ khởi động một máy chủ để phục vụ ứng dụng của bạn.
- Máy chủ này sẽ phục vụ các file tĩnh từ thư mục `.next/static`.

### Ví dụ về cấu trúc thư mục sau khi build:
```
my-next-app/
├── .next/
│   ├── static/
│   │   ├── chunks/
│   │   └── ...
│   ├── server/
│   │   └── pages/
│   └── ...
├── pages/
│   ├── index.js
│   └── ...
├── public/
│   └── ...
├── next.config.js
└── package.json
```

### Quy trình chi tiết khi máy chủ xử lý yêu cầu:

1. **Build và bundle**:
    - Chạy `next build` để build và bundle toàn bộ mã JavaScript.
    - Các bundle này được lưu trữ trong thư mục `.next`.

2. **Máy chủ phục vụ yêu cầu**:
    - Khi nhận được yêu cầu từ trình duyệt, máy chủ Next.js sử dụng mã JavaScript trong `.next` để render HTML.
    - HTML này bao gồm các liên kết tới các file JavaScript cần thiết.

3. **Trình duyệt tải JavaScript**:
    - Sau khi nhận được HTML từ máy chủ, trình duyệt sẽ tải các file JavaScript từ các liên kết được cung cấp.
    - Các file này được phục vụ trực tiếp từ máy chủ Next.js từ thư mục `.next/static`.

### Tóm tắt:
- **Build và lưu trữ JavaScript**: Các file JavaScript được build và bundle trước, sau đó lưu trữ trên máy chủ trong các thư mục tĩnh như `.next/static`.
- **Render HTML trên server**: Máy chủ sử dụng các bundle này để render HTML và gửi về trình duyệt.
- **Phục vụ file tĩnh**: Máy chủ phục vụ các file JavaScript tĩnh khi có yêu cầu từ trình duyệt, đảm bảo rằng trình duyệt có thể tải và thực thi chúng để hoàn tất quá trình hydration và tương tác động.

Hy vọng rằng điều này giúp bạn hiểu rõ hơn về quy trình SSR và cách máy chủ xử lý việc phục vụ các file JavaScript.