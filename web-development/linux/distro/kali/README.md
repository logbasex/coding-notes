## Virtual box
- https://www.kali.org/docs/virtualization/import-premade-virtualbox/

## Monitor mode
- In Kali Linux, Monitor Mode enables you to read all data packets, even if they do not send in this mode, and control traffic intercepted on wireless-only networks. Monitor Mode can capture all of these packets directed to their device and other networked devices.

### [How to check if you cards supports monitor mode](https://askubuntu.com/questions/829977/how-to-check-if-you-cards-supports-monitor-mode)
```shell
iw list | grep monitor
```

## [Why does one need a wireless card/adapter in order to hack a desktop running Kali Linux?](https://www.quora.com/Why-does-one-need-a-wireless-card-adapter-in-order-to-hack-a-desktop-running-Kali-Linux)

No you don't.

You will require an external wifi card “only if you are trying to perform Wifi attacks through a virtual machine”. That is if you have installed the Kali Linux in a VirtualBox or VMware or any other virtual machine.

So I would recommend you to dual boot your laptop with Kali Linux or create a Bootable USB of Kali Linux and run it live. By doing this you will be able to access your inbuilt WiFi card to perform Wifi attacks.

## [Hacking Wireless Networks around the Globe.(Practical WIFI Hacking)](https://systemweakness.com/hacking-wireless-networks-around-the-globe-practical-wifi-hacking-f8bdc36536b8)


## wifite

```shell
sudo apt install wifite

# bully https://github.com/aanarchyy/bully
sudo apt install bully

# pyrit
sudo apt-get install python3-scapy libssl-dev zlib1g-dev libpcap0.8-dev python2-dev

cd ~/Downloads
wget -c https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz
tar -xf v0.5.0.tar.gz
cd Pyrit-0.5.0
sed -i "s/COMPILE_AESNI/NO_COMPILE_AESNI/" cpyrit/_cpyrit_cpu.c
python2 setup.py build
sudo python2 setup.py install

# hashcat
sudo apt install hashcat

# hcxdumptool
sudo apt install hcxdumptool

# hcxpcapngtool
sudo apt install hcxtools

# macchanger
sudo apt install macchanger

# scripts
https://github.com/KatzeMau/wifite2-requirements/blob/master/wifite2.3.1-install.sh
```

### hacking tutorial
- https://systemweakness.com/hacking-wireless-networks-around-the-globe-practical-wifi-hacking-f8bdc36536b8
- https://www.hackers-arise.com/post/wi-fi-hacking-using-wifite-for-multiple-attack-strategies-against-wi-fi-ap-s