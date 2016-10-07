---
title: fedora-openvpn-client
tags:
- Fedora
- openvpn
categories: Programming
---

这里介绍在Fedora中如何设置OpenVPN客户端。

服务端新生成一个Key:

```Bash
cd easy-rsa
. vars
./build-key username
```

客户端:

In the following, replace MyClient with a descriptive vpn connection name.
Copy username.key, username.crt and ca.crt from server to /etc/openvpn/MyClient/.

```Bash
cp -ai /usr/share/doc/openvpn*/sample-config-files/client.conf /etc/openvpn/MyClient.conf
```

Edit /etc/openvpn/MyClient.conf appropriately to set your configuration (just like server configuration, port, compression,..) and key paths.

```Bash
ln -s /lib/systemd/system/openvpn@.service /etc/systemd/system/openvpn@MyClient.service
systemctl enable openvpn@MyClient.service
systemctl start openvpn@MyClient.service
```

check /var/log/messages if things didn't work as expected

Alternatively, on the client, after copying the keys onto the client machine, you can use NetworkManager to add a vpn connection. Make sure you have the NetworkManager-openvpn package installed. Then just add a new VPN connection.

Should also test automatic starting at boot up, with password protected key files and maybe even --auth-user-pass. OpenVPN supports systemd's password passing if build with --enable-systemd via ./configure
