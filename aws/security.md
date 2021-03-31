## aws access secret key

> AmazonSQSException: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. Consult the service documentation for details.

There is one post described this error occurred because his secret key has a forward slash (/).
I followed the hint and **regenerated my keys again until I get a secret key that doesn’t have a forward slash**. Bingo! it worked. It was that silly little forward slash that has wasted hours!!!

- https://medium.com/dtlpub/aws-sdk-credentials-and-forward-slash-52898ce538fe
- https://stackoverflow.com/questions/30518899/aws-s3-how-to-fix-the-request-signature-we-calculated-does-not-match-the-sign