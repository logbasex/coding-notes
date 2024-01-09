## References
- [What is the TCP 3-Way Handshake and Why Backend Engineers should understand it](https://www.youtube.com/watch?v=bW_BILl7n0Y)

## Explain TCP 3-Way Handshake for 1 year backend dev
Certainly! Explaining the TCP three-way handshake in a simplified manner for someone with one year of backend development experience involves breaking it down into its fundamental steps and understanding its purpose. Here's a concise explanation:

**TCP (Transmission Control Protocol) Three-Way Handshake:**

1. **Purpose:**
    - The TCP three-way handshake is a method used by TCP/IP networks to establish a reliable connection between a client and a server. It's essential for ensuring that both the client and server are ready to communicate and that they agree on the parameters of the data transfer.

2. **Step 1: SYN (Synchronize)**
    - The process begins when the client wants to establish a connection with a server. The client sends a SYN (synchronize) packet to the server. This packet includes a sequence number (let’s call it X), which is essentially a starting point for the data that the client will send.

3. **Step 2: SYN-ACK (Synchronize-Acknowledgment)**
    - Upon receiving the SYN packet, the server acknowledges it by sending back a SYN-ACK packet. This packet contains two important pieces of information: the server's own sequence number (let’s say Y) and an acknowledgment number. The acknowledgment number is the client’s sequence number incremented by one (X+1). This increment indicates that the server is ready to receive data starting from the next number in the sequence.

4. **Step 3: ACK (Acknowledgment)**
    - The client responds to the server's SYN-ACK with an ACK (acknowledgment) packet. This ACK packet includes the acknowledgment number, which is the server’s sequence number incremented by one (Y+1). This acknowledges that the client is ready to receive data starting from that number in the server’s sequence.

5. **Connection Established:**
    - Once this exchange is complete, both the client and the server have acknowledged each other's sequence numbers, and the connection is established. This allows for reliable, ordered, and error-checked transmission of data.

**Why It's Important for Backend Developers:**

- **Reliability and Sequence Control:**
    - Understanding the TCP three-way handshake is crucial for backend developers because it lays the foundation for reliable data transfer over networks. It ensures that data is received in order and without errors, which is vital for applications that require consistency and accuracy (like financial transactions, data retrieval, etc.).

- **Debugging Network Issues:**
    - Knowing how this process works can help you troubleshoot and debug network communication issues in your applications, such as connection timeouts, data transmission errors, or issues with data ordering.

- **Performance Considerations:**
    - Understanding the handshake process also helps in making decisions related to performance optimization. For instance, establishing a TCP connection is a process that consumes time and resources. Keeping a connection open for multiple requests (persistent connections) versus opening new connections for each request (non-persistent connections) can have significant implications on the performance of your application.

- **Security Aspects:**
    - From a security standpoint, being aware of how TCP connections are established can help in understanding and mitigating certain types of network attacks, such as SYN flood attacks.

In summary, as a backend developer, understanding the TCP three-way handshake is valuable for building reliable and efficient applications, troubleshooting network-related issues, and making informed decisions about network communication in your applications.

## Why we need 3-way handshake, not 2-way handshake?
The TCP three-way handshake is essential for establishing a reliable connection in the TCP/IP protocol. Here's why a three-way, rather than a two-way handshake, is necessary:

1. **Establishing Connection State on Both Ends:**
    - A key objective of the handshake is to synchronize the connection state between the client and the server. In a two-way handshake, there's no guarantee that the receiver of the final acknowledgment (the server in a typical SYN, ACK sequence) has its initial message (SYN) received by the initiating party (the client). The three-way handshake ensures that both parties are aware that the other has received their initial synchronization signal and is ready to communicate.

2. **Sequence Numbers Synchronization:**
    - TCP is a reliable protocol that guarantees the delivery of packets in the order they were sent. This is achieved using sequence numbers. The three-way handshake is crucial for establishing these initial sequence numbers. It ensures that both the client and the server agree on the starting sequence numbers, thereby setting the stage for ordered and reliable data transfer.

3. **Resource Allocation:**
    - Before actual data transmission, it's necessary for both the client and the server to allocate buffers and other resources for handling the data transfer. The three-way handshake allows both sides to prepare for data transmission before it begins, ensuring that they are both ready to handle incoming data.

4. **Preventing Duplicate Connections:**
    - The handshake process helps in preventing the creation of duplicate or stale connections. Suppose a client sends a SYN packet but it's delayed, and the client retries the connection with a new SYN packet. If only a two-way handshake were used, the server might establish two separate connections when the delayed SYN finally arrives. The three-way handshake ensures that only one valid connection is established, as the final ACK by the client confirms the connection is active.

5. **Security Reasons:**
    - The handshake mechanism also has security benefits. It helps mitigate certain types of denial-of-service (DoS) attacks, such as SYN flood attacks. In such attacks, an attacker sends numerous SYN packets but never completes the handshake with an ACK. The three-way handshake ensures that the server does not allocate significant resources until it is sure that the client intends to establish a valid connection.

6. **Error Detection:**
    - The additional step in the handshake allows for early detection of errors and communication issues. If any part of the handshake fails, both the client and server can detect this failure and avoid sending data over an unreliable or non-existent connection.

In summary, the three-way handshake is a fundamental part of establishing a reliable and efficient TCP connection. It ensures synchronization of sequence numbers, allocation of resources, prevention of duplicate connections, adds a layer of security, and facilitates error detection. This process lays the groundwork for the robust and reliable data transmission that TCP is known for.

## [Install Wireshark](https://askubuntu.com/questions/700712/how-to-install-wireshark)

```
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark
sudo wireshark
```

## Capture 3-way handshake

Site: https://test.cms.fandelo.com/favorites

![image](https://gist.github.com/assets/22516811/93e30221-ea76-47da-b6bf-3bf8058ec4a9)

![image](https://gist.github.com/assets/22516811/bd491ed7-ebe4-46c7-8f2e-6dcedee7d73c)

#### Filter
```
ip.addr == 14.162.145.58 and not udp and not arp and not snmp and not icmp and not ssl
```

#### References
- [Using Wireshark to capture a 3 way handshake with TCP](https://www.youtube.com/watch?v=4dSaAMZsPvw)