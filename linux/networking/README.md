## dhcp

## 

- 1 ten mien co the anh xa nhieu ip
- 1 ip co the anh xa nhieu ten mien (n:n mapping)
- godaddy phai query len database cua cuc quan ly ten mien de xem tien mien co ton tai hay khong
- so luong ten mien khong gioi han
- ip address phai mua
- amazon quan li 100m dia chi ip va cho thue lai.


- dia chi ip: 32 bit, gồm host(host id) và network (network id)
- https://www.tutorialspoint.com/ipv4/ipv4_address_classes.htm
- tat ca nhung ip(hostId) trong 1 networkId deu co the ket noi voi nhau
- class A max 128 hostId (128 nguoi toi da trong 1 network)


- whitelist and blacklist configure
- Deep packet inspection
- ISP: internet service provider

- subnet mask: 255.255.255.0
- ip: 192.168.1.180
- bitwise (subnetmark & ip(first 24 bit)) -> networkId

- ip port

## Get Wi-Fi interface device names
```shell script
iw dev
iw dev | awk '$1=="Interface"{print $2}'

sudo lshw -c network -businfo
```

## PCI (Peripheral Component Interconnect)

- [How PCI work](https://computer.howstuffworks.com/pci.htm)
- https://www.oreilly.com/library/view/linux-device-drivers/0596005903/ch12.html

## Loopback interface

```shell script
ip a | grep lo
```