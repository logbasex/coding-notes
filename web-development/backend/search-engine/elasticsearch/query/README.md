## References
- [Một số query phổ biến trong Elasticsearch](https://viblo.asia/p/mot-so-query-pho-bien-trong-elasticsearch-XL6lAPDJZek)

=====
=====

## Overview

> Ngoài term query thì những với những câu query khác, analyzer sẽ được apply nên giá trị trả về sẽ phụ thuộc vào cách mà analyzer được set up cho field đó (có thể không giống bảng ở dưới).

| Query Name | Chức năng                                                                                                                                                                                                       | Query mẫu | Matching Text                                                                     | Not Matching Text                                                                                               |
| --- |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| --- |-----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| match | \- Matches nếu 1 term trong query đó match<br> \- Càng nhiều term match thì score của document đó sẽ lớn<br> \- Query search sẽ được apply analyzer config cho field search đó hoặc để mặc định (nếu không set) | cat dog | \- cat and dog<br> \- The blue cat \- The cat is blue<br> \- The dog is white<br> | \- The blue<br> \- The white                                                                                    |
| phrase\_match | \- Chỉ matches nếu các term match có cùng thứ tự và liên tiếp nhau | cat dog | \- cat dog are green<br> \- green and cat dogs<br>                                | \- dog cat are green<br> \- cat and dog are green                                                               |
| prefix | Nó tương tự như `pharse_match` query nhưng nó sẽ match chính xác term | FR VN | \- FR VN2017<br> \- FR VN-2017<br>                                                | \- FRVN2017<br> \- FRVN-2017                                                                                    |
| term | \- Query trên truy vấn mình truyền vào, analyzer sẽ không được apply | dog | \- this is a dog                                                                  | \- there are many dogs here<br> \- Dog is green                                                                 |
| multi\_match | \- apply match query trên nhiều field khác nhau | \- field1: dog \- field2: cat | match với field1 chứa dog hoặc field2 chứa cat | \- Nếu cả 2 fields không chứa bất cứ từ liên quan đến dog và cat |
| bool | Applies nhiều queries khác nhau | must: {field1: dog}, must\_not: {field2: cat} | match với document với field1 chứa dog và field2 không chứa cat                   | Nếu document có field1 chứa dog và field2 chứa cat<br> \- hoặc field2 chứa cat<br> \-hoặc field1 không chứa dog |
