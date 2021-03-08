## Install

```shell
docker run -p 8080:8080 -p 50000:50000 --name jenkins-01 -v dbdata1:/var/jenkins_home jenkins/jenkins:lts
```

![devops-summarize](https://images.viblo.asia/1c718ad6-e26b-4785-b375-0bcbf901a084.png)

- Continuous Integration là chạy các bài test liên tục mỗi khi có sự tích hợp (có code mới),
- Continuous Delivery là tạo bản release sau quá trình chạy test, mục tiêu của Continuous Delivery là để đảm bảo chúng ta luôn có một releasable product
- Continuous Deployment là sau khi tạo được bản release rồi thì tiến hành tự động deploy luôn, chứ không như Continuous Delivery thì cần phải deploy một cách manual 
