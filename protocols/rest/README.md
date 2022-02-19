## Overview
![https://www.altexsoft.com/blog/rest-api-design/](../images/restapi-in-action.png)

![https://200lab.io/blog/rest-api-la-gi-cach-thiet-ke-rest-api/](../images/REpresentational-State-Transfer.jpg)

![](../images/api-architectural-styles.png)

## Example
- Field trả về sử dụng gạch dưới

![https://www.altexsoft.com/blog/rest-api-design/](../images/Twilio-rest-api.png)


## Design
- https://viblo.asia/p/mot-so-luu-y-khi-xay-dung-api-djeZ1VaJlWz
- https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api

## Hisotry
- https://www.reddit.com/r/explainlikeimfive/comments/5u2c64/eli5_what_is_the_difference_between_rest_and_soap/

## HATEOAS (Hypermedia As The Engine Of Application State)
- https://gpcoder.com/5946-gioi-thieu-hateoas/

## [Reducing bandwidth and number of requests on REST APIs](https://itnext.io/reducing-bandwidth-and-number-of-requests-on-rest-apis-ec418b5fd82a)
Vấn đề của rest api là không thể chỉ định những trường mình muốn lấy, đôi khi là phải lấy hết mặc dù chỉ cần 1 vài trường

To define the data we would like to receive, we need to write a schema spec in JSON or YAML. I’ll be using JSON, because the resulting base64 is smaller (even smaller if minified first).

```
{
    "spec": {
        "_": ["id", "name"]
    }
}
```

This schema is then encoded as a base64 or base64Url string and passed through in the X-Schema-Map header. I’ll be using base64Url, again, because the resulting string is smaller (doesn’t require the = padding at the end).

```
GET /users
X-Schema-Map: eyJzcGVjIjp7Il8iOlsiaWQiLCJuYW1lIl19fQ
```

```
[{
    "id": 10, 
    "name": "John Doe"
},
{
    "id": 10, 
   "name": "John Doe"
}]
```

## [Validate Json Schema](https://www.linkedin.com/pulse/validate-rest-api-using-json-schema-sunil-kapil/)
- Đôi khi việc validate json request từ client hay json response từ server là cần thiết (chúng ta sẽ biết ngay được những field gì còn thiếu thay vì trả về mã lỗi từng field)

## [Bean Validation](https://stackoverflow.com/questions/61614879/is-is-recommended-to-use-json-schema-validation-in-the-place-of-bean-validation)

For example, if there is case where a class which has 3 attributes (say, A,B and C) and a constraint is required that is either A occurs or B & C occurs but not both, then it is not really possible to put a constraint in JSON schema directly, it has to be handled through design of the schema (similarly in XML, actually it is more complicated with XML).

On the other hand in Bean Validation a custom validator can be written to handle this situation quite easily.