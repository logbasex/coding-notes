## [Purge sqs queue](https://docs.aws.amazon.com/cli/latest/reference/sqs/purge-queue.html)

```
aws sqs purge-queue --queue-url https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/MyNewQueue
```

## Send notif from SNS to SQS

- https://www.youtube.com/watch?v=VXsAgYoC1Jc

## Get accountId

```shell
sudo apt update
sudo apt install awscli
aws configure
aws sts get-caller-identity --query "Account" --output text
```

## Get queueUrl

```shell
Ex:

https://sqs.us-east-1.amazonaws.com/<aws account ID>/testQueue
```