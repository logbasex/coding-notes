## Presign URL
- https://viblo.asia/p/upload-file-nhu-the-nao-cho-dung-1VgZv6y9ZAw
- https://viblo.asia/p/use-presigned-url-to-secure-only-some-files-inside-a-public-s3-bucket-GrLZDk8nKk0

## Billing

Cost management
- https://console.aws.amazon.com/cost-reports/home#/dashboard
- https://aws.amazon.com/vi/blogs/mt/using-aws-cost-explorer-to-analyze-data-transfer-costs/
- https://chaudharypulkit93.medium.com/how-i-debugged-huge-data-transfer-costs-on-aws-498608297aa4

- report: https://console.aws.amazon.com/billing/home#/reports/usage


## Monitor S3

- https://docs.aws.amazon.com/AmazonS3/latest/userguide/LoggingWebsiteTraffic.html
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/monitoring-overview.html

Data transfer
- https://stackoverflow.com/questions/61050583/reducing-aws-data-transfer-cost-for-aws-s3-files

Enable access logging
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html

Query log
- https://aws.amazon.com/vi/premiumsupport/knowledge-center/analyze-logs-athena/

Monitor with quicksight
- https://aws.amazon.com/vi/blogs/aws-cost-management/cost-allocation-blog-series-4-visualize-data-transfer-costs-with-cost-and-usage-reports-athena-and-quicksight/
1GB = 2^30 bytes


## AWS Athena
- https://aws.amazon.com/vi/blogs/big-data/analyzing-data-in-s3-using-amazon-athena/

## How to identify storage class aws s3
https://stackoverflow.com/questions/36348785/how-to-identify-the-storage-class-in-amazon-s3

## Access policy
```json
{
    "Version": "2012-10-17",
    "Id": "S3-Console-Auto-Gen-Policy-1618637692128",
    "Statement": [
        {
            "Sid": "S3PolicyStmt-DO-NOT-MODIFY-1618637691480",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::logbasex.github.io/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control",
                    "aws:SourceAccount": "463468827709"
                },
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:s3:::logbasex.github.io"
                }
            }
        }
    ]
}
```