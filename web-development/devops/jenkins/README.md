## Install

```shell
docker run -p 8080:8080 -p 50000:50000 --name jenkins-01 -v dbdata1:/var/jenkins_home jenkins/jenkins:lts
```

![devops-summarize](https://images.viblo.asia/1c718ad6-e26b-4785-b375-0bcbf901a084.png)

- Continuous Integration là chạy các bài test liên tục mỗi khi có sự tích hợp (có code mới),
- Continuous Delivery là tạo bản release sau quá trình chạy test, mục tiêu của Continuous Delivery là để đảm bảo chúng ta luôn có một releasable product
- Continuous Deployment là sau khi tạo được bản release rồi thì tiến hành tự động deploy luôn, chứ không như Continuous Delivery thì cần phải deploy một cách manual 


## Trigger jenkins via curl
```shell
CRUMB=`curl -s -u "ducanh:123456" 'https://ci.fruitful.io/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`

 curl -X POST --user "ducanh:123456" -H "Jenkins-Crumb:33c13aed5548ad43bf5e2eb276cf21af" "https://ci.fruitful.io/view/EKO/job/backend-eko-portal/buildWithParameters" --data-urlencode json='{"parameter": [{"name":"text", "value":"develop:test"}]}'
```

- https://varlogdiego.com/trigger-jenkins-jobs-via-api-and-curl

## Trigger build via Slack's slash command
```shell
https://api.slack.com/interactivity/slash-commands
```
