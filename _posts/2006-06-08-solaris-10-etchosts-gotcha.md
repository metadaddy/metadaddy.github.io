---
author: user
title: Solaris 10 /etc/hosts gotcha
slug: solaris-10-etchosts-gotcha
id: 651
date: '2006-06-08 15:14:51'
layout: single
categories:
  - General
---

Often, when I'm setting up a test system or a demo, I'll use bogus fully qualified domain names (FQDNs), adding entries to /etc/hosts (which is nowadays a symbolic link to /etc/inet/hosts). Today, I was setting up federation; my identity provider (IdP) is at amdemo.example.com and my service provider (SP) is at fmdemo.partner.com. I set up the IdP, appending amdemo.example.com to the line in /etc/hosts that said 192.168.1.31 amdemo and all was well - I could browse to amdemo.example.com and see Access Manager.

On to the SP. I do the same thing, appending fmdemo.partner.com to the line in /etc/hosts that contains fmdemo, browsing to fmdemo.partner.com and... I get some site on the internet. Hmmm. Check /etc/nsswitch.conf - it tells me that it will check files (i.e. /etc/hosts) before DNS. Hmmm. If I comment out the nameserver from /etc/resolv.conf, I can browse to fmdemo.partner.com and see Federation Manager. Strange.

After much man page reading, the answer is... /etc/inet/ipnodes. It turns out that, even if you don't choose IPv6 support, Solaris 10 will read /etc/inet/ipnodes before /etc/hosts and, if there is no ipnodes value, then go to DNS. So, the answer is to copy the relevant line from /etc/hosts to /etc/inet/ipnodes. I do that and, hey presto, I can see Federation Manager at fmdemo.partner.com!

The key here is the comment in /etc/nsswitch.conf that says

```
# Note that IPv4 addresses are searched in all of the ipnodes databases
# before searching the hosts databases.

```

So, with these lines in /etc/nsswitch.conf:

```
hosts:      files dns
ipnodes:    files dns

```

The search order is: /etc/inet/ipnodes, DNS, /etc/inet/hosts then DNS again.

This has actually bitten me before. I'm blogging it this time to increase my chances of actually remembering it.