---
author: user
title: OpenSolaris 2009.06 as a domU guest on Xen 3.4/openSUSE 11.2
slug: opensolaris-2009-06-as-a-domu-guest-on-xen-3-4opensuse-11-2
id: 998
date: '2010-02-27 11:15:39'
layout: single
categories:
  - Virtualization
tags:
  - opensolaris
  - opensuse
  - xen
---

[![OpenSolaris Logo](http://blog.superpat.com/wp-content/uploads/2010/02/opensolaris_logo_trans.png "opensolaris_logo_trans"){: .align-left}](http://blog.superpat.com/wp-content/uploads/2010/02/opensolaris_logo_trans.png)I recently trawled the web figuring out how to install a [paravirtualized](http://en.wikipedia.org/wiki/Paravirtualization) OpenSolaris 2009.06 on Xen. No one place had all the story, so I'm blogging this. I found a lot of the information spread across many other blog entries; some I figured out on my own. Thanks to all the giants on whose shoulders I am now standing:

*   [Setup OpenSolaris 1002-127 PV DomU at Xen 3.4.2 & Libvirt 0.7.1-15 (2.6.31.6 pvops) on top of F12 per John Levon](http://blogs.sun.com/mrj/entry/installing_opensolaris_on)
*   [Installing OpenSolaris on Xen](http://blogs.sun.com/mrj/entry/installing_opensolaris_on)
*   [OpenSolaris 2008.11 guest domain on a Linux dom0](http://blogs.sun.com/levon/entry/opensolaris_2008_11_guest_domain)

The procedure:

1.  [Download OpenSolaris 2009.06 ISO](http://dlc.sun.com/osol/opensolaris/2009/06/osol-0906-x86.iso)
2.  Mount the ISO somewhere

    ```
pat-m6400:~ # mount -o loop,ro /vm/opensolaris/osol-0906-x86.iso /mnt
```

3.  Copy the kernel and rootfs somewhere convenient

    ```
pat-m6400:~ # cp /mnt/platform/i86xpv/kernel/amd64/unix /vm/opensolaris
    pat-m6400:~ # cp /mnt/boot/amd64/x86.microroot /vm/opensolaris
```

4.  Create a disk image for your root filesystem

    ```
pat-m6400:~ # dd if=/dev/zero of=/vm/opensolaris/root.img bs=1G count=1010+0 records out
    10+0 records in
    10+0 records out
    10737418240 bytes (11 GB) copied, 127.888 s, 84.0 MB/s
```

5.  Create a Xen config file (let's call it `/vm/opensolaris/opensolaris-install.cfg`) with the following content:

    ```
name = "opensolaris"
    vcpus = 1
    memory = 1024
    kernel = "/vm/opensolaris/opensolaris/unix"
    ramdisk = "/vm/opensolaris/x86.microroot"
    extra = "/platform/i86xpv/kernel/amd64/unix -B console=ttya"
    disk = ['file:/vm/opensolaris/osol-0906-x86.iso,6:cdrom,r', 'file:/vm/opensolaris/root.img,0,w']
    vif = ['bridge=br0']
    on_shutdown = "destroy"
    on_reboot = "destroy"
    on_crash = "destroy"
```

6.  Now start your VM:

    ```
pat-m6400:~ # xm create -c /vm/opensolaris/opensolaris-install.cfg
```

7.  You should see something like:

    ```
Using config file "./opensolaris-install.cfg".
    Started domain opensolaris (id=21)

    v3.4.1_19718_04-2.1 chgset '19718'
    SunOS Release 5.11 Version snv_111b 64-bit
    Copyright 1983-2009 Sun Microsystems, Inc.  All rights reserved.
    Use is subject to license terms.
    Hostname: opensolaris
    Remounting root read/write
    Probing for device nodes ...
    Preparing live image for use
    Done mounting Live image
    USB keyboard
    1\. Albanian                      23\. Lithuanian
    2\. Belarusian                    24\. Latvian
    3\. Belgian                       25\. Macedonian
    4\. Brazilian                     26\. Malta_UK
    5\. Bulgarian                     27\. Malta_US
    6\. Canadian-Bilingual            28\. Norwegian
    7\. Croatian                      29\. Polish
    8\. Czech                         30\. Portuguese
    9\. Danish                        31\. Russian
    10\. Dutch                         32\. Serbia-And-Montenegro
    11\. Finnish                       33\. Slovenian
    12\. French                        34\. Slovakian
    13\. French-Canadian               35\. Spanish
    14\. Hungarian                     36\. Swedish
    15\. German                        37\. Swiss-French
    16\. Greek                         38\. Swiss-German
    17\. Icelandic                     39\. Traditional-Chinese
    18\. Italian                       40\. TurkishQ
    19\. Japanese-type6                41\. TurkishF
    20\. Japanese                      42\. UK-English
    21\. Korean                        43\. US-English
    22\. Latin-American
    To select the keyboard layout, enter a number [default 43]:
```

8.  Press enter to select the default...

    ```
1\. Arabic
    2\. Chinese - Simplified
    3\. Chinese - Traditional
    4\. Czech
    5\. Dutch
    6\. English
    7\. French
    8\. German
    9\. Greek
    10\. Hebrew
    11\. Hungarian
    12\. Indonesian
    13\. Italian
    14\. Japanese
    15\. Korean
    16\. Polish
    17\. Portuguese - Brazil
    18\. Russian
    19\. Slovak
    20\. Spanish
    21\. Swedish
    To select desktop language, enter a number [default is 6]:
```

9.  Press enter again...

    ```
User selected: English
    Configuring devices.
    Mounting cdroms
    Reading ZFS config: done.

    opensolaris console login:
```

10.  Now login with jack/jack

    ```
opensolaris console login: jack
    Password:
    Sun Microsystems Inc.   SunOS 5.11      snv_111b        November 2008
    jack@opensolaris:~$
    
```

11.  And su with the password opensolaris

    ```
jack@opensolaris:~$ su
    Password:
    Feb  5 20:29:29 opensolaris su: 'su root' succeeded for jack on /dev/console
```

12.  Now do `ifconfig -a` to discover your IP address. You might have to try a few times since it seems to take a minute or two to get an IP:

    ```
jack@opensolaris:~# ifconfig -a
    lo0: flags=2001000849 mtu 8232 index 1
    inet 127.0.0.1 netmask ff000000
    xnf0: flags=1004843 mtu 1500 index 2
    inet 192.168.69.124 netmask ffffff00 broadcast 192.168.69.255
    ether 0:16:3e:79:d:ba
    lo0: flags=2002000849 mtu 8252 index 1
    inet6 ::1/128
    xnf0: flags=2000841 mtu 1500 index 2
    inet6 fe80::216:3eff:fe79:dba/10
    ether 0:16:3e:79:d:ba
```

13.  Now go to a dom0 shell and find the domain id:

    ```
pat-m6400:~ # domid=`xm domid opensolaris`
    pat-m6400:~ # echo $domid
    21
    
```

14.  Use `xenstore-read` to find the vnc port and password:

    ```
pat-m6400:~ # xenstore-read /local/domain/$domid/guest/vnc/port
    5900
    pat-m6400:~ # xenstore-read /local/domain/$domid/guest/vnc/passwd
    5PaJpX6n
    
```

    Supposedly you can also discover the IP address this way, but I've never seen it:

    ```
pat-m6400:~ # xenstore-read /local/domain/$domid/ipaddr/0
    xenstore-read: couldn't read path /local/domain/21/ipaddr/0
```

15.  Now you can VNC to the OpenSolaris installer - use the port and password you just discovered. Note the double colon (::) to use port number rather than display number

    ```
pat-m6400:~ # vncviewer 192.168.69.124::5900
    Connected to RFB server, using protocol version 3.8
    Performing standard VNC authentication
    Password:
    Authentication successful
    [...]
```

16.  You should see the OpenSolaris installer - hurrah! Go through the install process, click 'restart' and the domain should shutdown.
17.  Once it is down (you can check with xm list), create another config file - `opensolaris.cfg`

    ```
name = "opensolaris"
    vcpus = 1
    memory = 1024
    bootloader = "/usr/bin/pygrub"
    disk = ['file:/vm/opensolaris/root.img,0,w']
    vif = ['bridge=br0']
    on_shutdown = "destroy"
    on_reboot = "destroy"
    on_crash = "destroy"
```

18.  Now you can create the VM again using the new config

    ```
xm create -c /vm/opensolaris/opensolaris.cfg
```

19.  If all is well, you should now be the proud owner of an OpenSolaris domU :-)
20.  Now, log in as the user you specified in the install, su - to root and find the IP address.

    ```
pat@opensolaris:~$ su -
    Password:
    root@opensolaris:~# ifconfig xnf0
    xnf0: flags=1004843 mtu 1500 index 2
    inet 192.168.69.128 netmask ffffff00 broadcast 192.168.69.255
    ether 0:16:3e:5d:6:60
```

That's the basic install done. You have a couple of options at this point depending on whether you want to be able to VNC in for the full OpenSolaris desktop experience, and whether you want a static IP address. For the OpenSolaris desktop:

1.  Set X11-server to listen to the tcp port

    ```
root@opensolaris:~# svccfg -s x11-server
    svc:/application/x11/x11-server> setprop options/tcp_listen = boolean: true
    svc:/application/x11/x11-server> quit
```

2.  I disabled idletimeout on the VNC server, so that I don't lose the desktop over my lunch break!

    ```
root@opensolaris:~# svccfg -s xvnc-inetd
    svc:/application/x11/xvnc-inetd> setprop inetd_start/exec = astring: "/usr/X11/bin/Xvnc -inetd -query localhost -once securitytypes=none -IdleTimeout 0"
    svc:/application/x11/xvnc-inetd> quit
```

3.  Enable XDMCP for GDM

    ```
root@opensolaris:~# printf '[xdmcp]\nEnable=true\n' >>/etc/X11/gdm/custom.conf
    root@opensolaris:~# svcadm restart gdm
```

4.  Make sure GDM runs on startup

    ```
root@opensolaris:~# svcadm enable -s gdm
```

5.  Turn on xvnc-inetd services

    ```
root@opensolaris:~# svcadm enable xvnc-inetd
```

6.  Now just connect from dom0:

    ```
pat-m6400:~ # vncviewer 192.168.69.128
    
```

    And you should be in GNOME desktop wonderland :-)
7.  If you want to continue to use DHCP, on subsequent boots, just run nmap on dom0 to find your IP address:

    ```
pat-m6400:~ # nmap -sP 192.168.69.0/24
```

    ```
Starting Nmap 5.00 ( http://nmap.org ) at 2010-02-05 23:15 PST
    Host 192.168.69.1 is up (0.00056s latency).
    [...]
    Host 192.168.69.128 is up (0.0017s latency).
    Nmap done: 256 IP addresses (9 hosts up) scanned in 2.48 seconds
```

As an alternative to getting a VNC session, you can do

```
ssh -X 182.168.69.128
```

(or whatever) and then (at the OpenSolaris prompt) you can do

```
pat@opensolaris:~$ some-gui-program &
```

to have the program run on the dom0 desktop. Cool :-) To configure OpenSolaris to use a static IP address:

```
root@opensolaris:~# svcadm disable network/physical:nwam
root@opensolaris:~# svcadm enable  network/physical:default
root@opensolaris:~# ifconfig xnf0 down
root@opensolaris:~# ifconfig xnf0 192.168.69.25 netmask 255.255.255.0
root@opensolaris:~# ifconfig xnf0 up
root@opensolaris:~# route add default 192.168.69.1
root@opensolaris:~# echo 192.168.69.25 netmask 255.255.255.0 > /etc/hostname.xnf0
root@opensolaris:~# echo 192.168.69.1 > /etc/defaultrouter

```

So there you have it - OpenSolaris 2009.06 happily running as a Xen domU. If you have any comments/corrections, please post them and I'll update this entry as appropriate.

<div id="_mcePaste" style="overflow: hidden; position: absolute; left: -10000px; top: 249px; width: 1px; height: 1px;">Create a Xen config file (let's call it /vm/opensolaris/opensolaris-install.cfg) with the following content:</div>