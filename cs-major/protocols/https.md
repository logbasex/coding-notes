[Why do we need SSL and TLS if we have https?](https://www.quora.com/Why-do-we-need-SSL-and-TLS-if-we-have-https)

SSL/TLS is the underlying security technology behind the "S" in HTTPS. HTTPS is HTTP over TLS/SSL. Where a normal HTTP connection just uses a TCP/IP socket, HTTPS uses a TLS/SSL socket which wraps the HTTP connection in TLS/SSL.

## SSL (Secure Socket Layer)
Về cơ bản thì chỉ để đảm bảo việc 2 máy tính có thể giao tiếp với nhau mà không có bất cứ ai có thể xen vào và biết được nội dung cuộc trò chuyện.
Đảm bảo client gửi message đúng server và server response trả về đúng client. Đảm bảo nội dung tin nhắn được mã hóa mà
message gửi đi thì chỉ có server đọc được và message trả về chỉ có client đọc được.

- [How does HTTPS work? What's a CA? What's a self-signed Certificate?](https://www.youtube.com/watch?v=T4Df5_cojAs)
- [SSL/TLS handshake Protocol](https://www.youtube.com/watch?v=sEkw8ZcxtFk)
- [HTTPS và SSL/TLS - giải thích cho trẻ em 5 tuổi thế nào?](https://www.nextsec.vn/2021/05/https-va-ssl-tls-nhu-giai-thich-cho-tre-5-tuoi.html.html)
- https://twitter.com/logbasex/status/1576093683140636672

![image](https://user-images.githubusercontent.com/22516811/193396738-14877210-d38e-43c1-8a93-0e4d64b4a6d2.png)
![image](https://user-images.githubusercontent.com/22516811/193396779-4d974cf9-76d3-41bc-a8e7-7559b59b1580.png)
![image](https://user-images.githubusercontent.com/22516811/193396784-0e8d0c07-6b4d-4941-8212-748a96f74780.png)
![image](https://user-images.githubusercontent.com/22516811/193396789-b67b3dbe-1de3-46ab-82c7-4c3fea0de2d8.png)
![image](https://user-images.githubusercontent.com/22516811/193396794-50766946-8a0b-4c1e-bbc4-59e0684c158c.png)

## TLS (Transport Layer Security)

Transport Layer Security (TLS) is the successor protocol to SSL. TLS is an improved version of SSL. It works in much the same way as the SSL, using encryption to protect the transfer of data and information. The two terms are often used interchangeably in the industry although SSL is still widely used.

----------

https://www.quora.com/What-is-SSL-and-TLS-and-why-are-they-needed/answer/Robert-Love-1

Transport Layer Security (TLS) and its predecessor Secure Sockets Layer (SSL) are a family of cryptographic protocols that utilize X.509 certificates, public/private key encryption, and an exchanged symmetric key to,

- validate the identify of a server e.g. know that google.com really is Google
- encrypt the contents of communication between client and server e.g. prevent anyone from observing your communication with google.com
- verify the integrity of communication between client and server e.g. ensure that a message was not modified by an attacker
- verify the authenticity of communication between client and server e.g. ensure that a message from google.com came from Google

Many users believe encryption is the most important feature of TLS, but the verification of identity and prevention of man-in-the-middle (MITM) attacks are equally if not more important. Encryption isn't of use if you aren't talking to who you think you are, as an attacker could proxy between you and the server.



# Question

- [Why are SSL certificates an annual expense?](https://security.stackexchange.com/questions/157175/why-are-ssl-certificates-an-annual-expense)
    - **Domain-Validated (DV) Certificates**
        ![](https://i.stack.imgur.com/76Zeh.jpg)
      
    - **Extended Validation (EV) Certificates**
        ![](https://i.stack.imgur.com/IZGyP.png)

- [Why does an SSL certificate cost money?](https://www.quora.com/Why-does-an-SSL-certificate-cost-money)  
    - SSL/TLS Certificates offers two things, encryption as well as authentication. When it comes to encryption, any SSL certificate will work. You can even use the self-signed certificate which will be free of cost and it will offer encrypted communication between server and a client.

        The problem comes in that free self-signed certificates does not carry any authentication, any attacker can make their own certificate and can claim as the server you are trying to connect. Your browser will not be able to make any difference and will connect you to the attacker with an encrypted connection and the attacker could then attach to the real server and monitor all your communication.

        Presentation of a cert doesn't mean anything, it's the chain of trust associated with it that has meaning. **You don't know me, and if I gave you a certificate that said I'm xyz of www.google.com, you will not trust me simply on that. If I gave you a similar certificate that carried the trust of, say, Symantec, if you trust them then you would extend that trust to me**. Symantec isn't going to do that for free since they have administrative requirements like verifying domain ownership and identity information. The policies have to be administered and systems have to be run to handle dealing with lost keys. Relationships also have to be built with browser makers to get the root keys for the certificate authorities in to the applications. This all has costs and so those costs are passed on to those who buy SSL certificates from a Certificate Authority.

        In exchange for that cost, the CA verifies the identity of the organization and domain that they are issuing the certificate to. In short, you’re paying for the trust, not the actual encryption.
      

# TODO 
- https://security.stackexchange.com/questions/20803/how-does-ssl-tls-work
- https://www.reddit.com/r/explainlikeimfive/comments/jsq3m/eli5_what_are_online_security_certificates_ssl/
- https://stackoverflow.com/questions/40061263/what-is-ca-certificate-and-why-do-we-need-it
- http://www.steves-internet-guide.com/ssl-certificates-explained/
- https://viblo.asia/p/https-va-ssltls-nhu-giai-thich-cho-tre-5-tuoi-Eb85oeYOZ2G
- https://viblo.asia/p/nhan-dien-server-pha-ke-bang-ssl-pinning-6J3ZgWJEZmB
- https://viblo.asia/p/https-co-thuc-su-bao-mat-MJykjVoNkPB