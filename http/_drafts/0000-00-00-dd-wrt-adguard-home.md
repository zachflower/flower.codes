---
layout: post
title: "dd-wrt + adguard home = :)"
date: 9999-01-01 12:00:00
---

Nighthawk R7000
- Worked great, but unfortunately dropped the internet every night at round 10pm

Installed dd-wrt
- Yay! We've got stability!

setup lan domain
- services tab > dhcp server section
- Used domain: lan & wan
- Lan domain: .lan

Setup adguard home on raspberry pi
- private dns servers: 192.168.1.1 (ip of router)

dd-wrt config
- force dns redirection (pipes all dns requests through the router)
- setup tab > network address server settings (dhcp) section
- enable force dns redirection

- set static ip for raspberry pi
- services tab > dhcp server section
- static leases
  - mac address,hostname,ip address,720 min lease expiration

- setup dnsmasq
- services tab > dnsmasq section
- Additional Dnsmasq Options
- dhcp-option=6,192.168.1.177 (ip of adguard home server)

3 weeks later

- Oh no! internet dropped again
- Rebooting helps
- dd-wrt has an app for that!
- Set router to reboot every sunday at 4am