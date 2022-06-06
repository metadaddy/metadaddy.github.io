---
author: user
title: Reworked script to remount USB drives on SuSE 10.0
slug: reworked-script-to-remount-usb-drives-on-suse-10-0
id: 691
date: '2006-03-22 09:31:02'
layout: single
categories:
  - General
---

I realised that I could generalize [yesterday's 'remount' script](http://blogs.sun.com/roller/page/superpat?entry=usb_drives_in_jds_suse) to remount _all_ subfs filesystems. Here is the new version:

```
#! /bin/sh
# Look for any filesystems mounted as subfs, unmount them,
# then remount them manually
mount -t subfs \
| awk '{print "echo Remounting " $1 " on " $3 "; umount " $1 " && mount " $1 " " $3}' \
| sh

```

I'm sure you could use Perl for this instead of Awk, but my skillz are little more old skool ![](http://blogs.sun.com/roller/images/smileys/smile.gif)

I need hardly add that these shell scripts are totally unwarranted. Use them at your own risk. I or Sun cannot be held responsible if, after running either of these scripts, you lose data, money or friends.