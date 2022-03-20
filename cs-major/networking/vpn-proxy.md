## Proxy vs VPN

https://www.digitalcitizen.life/when-use-proxy-and-when-use-vpn/

**Both VPN (Virtual Private Networks) and proxy servers are designed to keep you anonymous on the internet**. They can also help you access websites and services that are not available to everyone because of censorship or various restrictions. Proxies and VPNs each have their advantages and weaknesses, and some are better than others in certain situations

- ### Pros and cons of using proxy servers
  - #### Using a proxy server has the following advantages:

    - You are hiding your IP address from basic checks. If you want to see a sample of what information about you goes out to the world during such a basic check, visit this webpage: Lookup IP Address Location.
    - Using a proxy server means that you are also hiding your geographical location. The websites and services you access see the location of the proxy server that you are using instead.
    - Depending on how they are configured, proxy servers can improve your security by blocking malicious websites that distribute malware because they can check for malicious content before it is sent to your computer.
    - Proxy servers can be used to access geographically restricted internet services.
    - There are many public free proxy servers available on the internet, and some provide reliable services.
  - #### On the other hand, there are also some negative aspects that you should consider:

    - Proxy servers don't encrypt your internet traffic.
    - Neither your IP address nor your real location is hidden from more advanced detection techniques. You can get an example of how your location can be detected with the help of your browser and its location services here: W3C Browser Geolocation.
    - When using a proxy server, all your internet traffic goes through it. **That means that a malicious proxy server can see and control everything you do on the internet, compromising your privacy and security**.
    - Proxy servers usually monitor and log your activity when using them, which can identify you. This can be harmful in certain situations.
    - Although you're accessing a secured encrypted website or internet service, it can transfer unencrypted data to your computer if the proxy server was not configured correctly. In simple words, others can sniff your unencrypted information, which you probably don't want.
    - There are many public free proxy servers available on the internet, and many of them are unreliable. Some of the free proxy servers are even downright malicious.
 
- ### Pros and cons of VPNs
  - #### Using VPN brings many benefits:
    - All the network traffic between you and the VPN server is encrypted, so that makes it almost impossible for anyone to see what websites you visit or what services you use on the internet.
    - VPNs hide your real IP address. Websites and internet services can only see the VPN server's IP address.
    - VPNs hide your real geographical location. The internet thinks that your location is the location of the VPN server that you are using. 
    - Using a VPN server can help you bypass geographical restrictions. You can access content available only for some countries or regions if you connect to a VPN server from those regions.
    - Your network traffic can't be sniffed because it's all encrypted.
    - There are plenty of VPN providers that offer paid services, as well as free VPN servers.
  - #### Although VPNs have lots of advantages, there are also some not-so-positive features that you should consider:
    - VPN servers must encrypt all the internet traffic that goes through them, which **can take a toll on performance and speed**.
    - When you connect to a VPN server, every bit of data between you and the server is encrypted. However, that data is decrypted on the VPN server, so it knows what you do on the internet. VPN providers mustn't keep logs about your activity. Otherwise, the VPN provider knows how you are using its service. Those logs can also be used by other organizations that get authorized or unauthorized access to it.
    - **Trustworthy VPN services tend to have higher costs than what you'd pay for a good proxy**. All that encryption means that VPN servers must have powerful hardware to keep up with the demand.
    - **Many of the free VPNs aren't trustworthy and, in some cases, can even be dangerous.**


-  ![](images/proxy-vpn-compare.png)

## Proxy

https://www.digitalcitizen.life/simple-questions-what-proxy-server-why-would-you-use-one/

A proxy server is an intermediary waypoint between your computer or device and the internet. The proxy makes requests to websites, servers, and all kinds of internet services in your name.

For instance, if your web browser is configured to use a proxy server and you're trying to visit www.digitalcitizen.life, the request is not sent directly to our website. Instead, it goes to the proxy server. Once the proxy server receives your web browser's request, it forwards it to the server on which Digital Citizen is hosted. Then, our server responds and sends back the Digital Citizen homepage to the proxy server, which in turn sends it to your web browser.

![](images/proxy.png)

Because it's not your web browser that makes the direct request but the proxy server, **our website does not see your computer or device as a visitor. Instead, it sees the proxy server as a visitor.**

- ### What is a proxy server used for?
    The concept of the proxy server offers a surprisingly large number of advantages:

  - Control internet usage in corporate networks
  - Bandwidth savings for large networks
  - Improved speed
  - Privacy
  - Security
  - Bypass censorship

- ### Control internet usage using proxy servers
  - One of the most important reasons why proxies are widely used in corporate networks is that they provide control over what employees are accessing and using on the internet. For example, many companies ban certain websites so that employees do not access them during work hours. For example, they may ban adult websites, popular social networks or time-wasting websites like **9gag.com**.
  
  - Forcing employees to access the internet only through your company's proxy also means that you have detailed logs of all the websites and content that they accessed, when, and for how long. Detailed usage reports are available about each employee, and the company can quickly identify misbehaving users.


- ### Bandwidth savings and improved speed when using a proxy server
  - Another reason why companies use proxy servers is that it helps them save precious bandwidth. Proxy servers can compress traffic, cache files and web pages from the internet and even strip ads from websites before they reach your computer. It allows companies to save bandwidth, especially when they have hundreds or thousands of employees, accessing mostly the same popular websites (e.g., CNN, New York Times, Wikipedia, etc).

  - When a web page is accessed, a proxy server can store it and, when the next person requests it, it first checks if the page has changed. If it has not changed, it forwards the local copy without re-downloading the whole page. This both saves bandwidth for the company and makes the loading process faster for the next person that requests the same resource.
  
- ### Privacy benefits: hide your IP address, location, and other information


- [READ MORE](https://www.digitalcitizen.life/simple-questions-what-proxy-server-why-would-you-use-one/)



## VPN

https://www.digitalcitizen.life/simple-questions-what-vpn-what-does-it-do/

![](https://qph.fs.quoracdn.net/main-qimg-686b3ca00ab7a6db8a814f4b8dbd4dce.webp)

![](https://qph.fs.quoracdn.net/main-qimg-d2c88694590eafba813625a7ae8495de)

A Virtual Private Network or VPN is a secure network between your computer and a VPN server from the internet. All the network traffic through this connection is encrypted, so only your computer and the VPN server know what website or internet service you access and use.

For instance, if you use a VPN and try to visit www.digitalcitizen.life, the request is encrypted and sent to the VPN server. Once the VPN server receives your request, it decrypts it so that it knows what you want. In this case, it sends a load request to the server on which Digital Citizen is hosted. Our server responds by sending back the Digital Citizen homepage to the VPN server, which then encrypts it and sends it back to you

**Without VPN**
- ![](images/without-vpn.jpg)

**With VPN**
- ![](images/vpn.png)

**Because every bit of data is ENCRYPTED, nobody can see what websites you visit and what internet services you use**. That includes your government and your Internet Service Provider (ISP).


**The advantages of using a VPN**
Here is a list that summarizes all the information above, in an attempt to show you the benefits of using Virtual Private Networks:

- All the traffic between you and the VPN service you use is encrypted, so it is impossible for someone else other than your VPN provider to see what you do on the internet
- As long as you are connected to your VPN, you have access to the whole internet without censorship that might affect you otherwise
- You can access services and geographically restricted websites **if you use a VPN server that is located in a region where those services or websites are available.**
- The servers that you connect to on the internet cannot see your real IP address, just that of the VPN server
- You can surf the web, check your emails or send important information on public networks without the risk of someone else spying on you, other than your VPN provider


## Question
- [What does my ISP see when I'm on my VPN?](https://www.quora.com/What-does-my-ISP-see-when-Im-on-my-VPN)
  -   Assuming the connection between your device and the VPN server is encrypted (almost all of them are), they will see the IP address of the server you connected to at the VPN company, and **they will know how much data is flowing through the connection. The ISP will also know when and for how long you connected to the VPN.**
    However, they will have absolutely no clue what sites and services you are accessing. If they looked at the data flowing by, at the actual bytes themselves, the encryption ensures that all they’d see is a bunch of meaningless gibberish.
  Bear in mind that the VPN company itself will know what you connect to, which is why it’s important to pick one that clearly states they keep no logs.