## IP (Internet Protocol)

## IPv4 (Internet Protocol version 4)

## IPv6 (Internet Protocol version 6)
![](https://qph.fs.quoracdn.net/main-qimg-c109ea9c822d9b11fb1dba9c23783cdc.webp)

## Private IP address

## NAT (Network Address Translation)

- ![](images/nat.png)

- ![](images/NAT-works.svg.png)

- [How NAT works - Animation videos](https://www.youtube.com/watch?v=FTUV0t6JaDA)

## DHCP (Dynamic Host Configuration Protocol)

## [Static IP and Dynamic IP](https://www.quora.com/Is-a-private-IP-address-also-a-static-IP-address)
- A `private IP address` is defined in [RFC 1918](https://tools.ietf.org/html/rfc1918) as an address in one of these ranges:
  
  - 10.0.0.0 - 10.255.255.255 (10/8 prefix)
  - 172.16.0.0 - 172.31.255.255 (172.16/12 prefix)
  - 192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
  
  **A `public’ IP address` is basically anything outside those ranges**.
  
- As stated elsewhere here, all public and private IP addresses can be dynamic or static; there is no connection between these two things. Public IP addresses are the ones you see across the internet. Private IP addresses are what you see inside of a home or corporate network. Routers can (and normally do) provide NAT (Network Address Translation) to allow devices with private IP addresses to share a single public IP address.
  
  Dynamic vs static is configured at the individual device (desktop, laptop, etc), not on the router.
  
  A router can (and usually does) provide DHCP service, which is how an IP address is obtained dynamically.
  
  A computer or other device on a network can be configured with a specific (i.e. static) IP address, or as a DHCP client.
  
  If it’s configured with a static IP address, it will check first if the address is in use, and if so, the network interface is disabled. This is why DHCP is normally used.
  
  If it’s configured as a DHCP client, it will broadcast a DHCP request on the network requesting an address, *but*, it will include in that request the IP address it last used, and if another device is not using it, it will get that same address.
  
  The DHCP server can include Address Reservation entries, which can be used to assign an IP address. *But*, depending on how the DHCP server is implemented, what I have seen is that when a device makes a DHCP request and includes the IP address it had before, that address is assigned even if there is a different Address Reservation for the device. This is only important if you are replacing a device (such as a file server) and you want the new device to have the same IP address as the old device.
  
  Note that Address Reservation is still part of DHCP (dynamic assignment), not static assignment.
  
## Public IP and Private IP
- **RFC 1918**: Private IP standard

- ![](https://i.pinimg.com/originals/51/5b/15/515b15c0d8d4c568b9e3749662d4a2a7.png)

## Default Gateway
- Default Gateway is a point of a Network, through which your network can communicate with Internet/Other Network.
  
  [Analogy](https://www.quora.com/What-is-a-default-gateway-What-purpose-does-it-serve):
  
  Consider your house as a your network and persons, living on that house as packets. (Usually, Packets on your network are way more than Person on house, But its just an Example :-) ).
  
  If any person needs to go out/another house (Internet/another Network), he/she has to pass through Main Door (Default Gateway). Same way, Packets, in your network need Default Gateway to go out/communicate to Internet/Other Network.
  
## NAT (Network Address Translation)  
