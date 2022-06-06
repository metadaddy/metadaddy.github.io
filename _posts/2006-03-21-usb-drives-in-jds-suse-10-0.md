---
author: user
title: USB Drives in JDS / SuSE 10.0
slug: usb-drives-in-jds-suse-10-0
id: 692
date: '2006-03-21 10:09:06'
layout: single
categories:
  - General
---

_UPDATE: [See the following entry](http://blogs.sun.com/roller/page/superpat?entry=reworked_script_to_remount_usb) for an updated script and, perhaps more importantly, a disclaimer for these scripts._

As you can probably figure out from my [del.icio.us links](http://del.icio.us/superpat), I recently moved my laptop from JDS to SuSE 10.0\. JDS worked great, but the kernel is a bit long in the tooth now, and doesn't recognize the [SpeedStep](http://support.intel.com/support/processors/mobile/pentiumiii/sb/CS-007509.htm) function in my Tecra M2\. Anyway - one thing I'd noticed in both JDS and SuSe 10.0 is that USB 2.0 drives mount 'automagically' when you plug them in via [submount](http://sourceforge.net/projects/submount/). I'm not sure how well this works with other file systems, but with Reiser it's a nightmare. What seems to happen is that, when there are no files open, the drive is quietly unmounted, just in case you're going to pull the cable out. When you next try to access the drive (e.g. `ls /media/usbdisk`) the drive is quietly remounted. With reiserfs, this takes a while - over 10 seconds for my WD 250MB drive - which is _very_ frustrating.

There are various solution posted, which require [some low-level tinkering](http://en.opensuse.org/SDB:Mounting_to_Static_Mount_Points), and are specific to the exact version of JDS/SuSE you're using, but I discovered one easy way to fix the problem that doesn't mess with any configuration... I created an 'rmount' script in my bin directory:

```
#! /bin/sh
# You may need to run this as root!
# You could pass these in as parameters, I guess, but then
# you'd be just as well running the umount and mount
# commands manually :-)
DEVICE=/dev/sda1
MOUNTPOINT=/media/usbdisk
FSTYPE=reiserfs
echo -n "Before: "
mount | grep $DEVICE
echo "Remounting $DEVICE on $MOUNTPOINT as $FSTYPE"
umount $DEVICE && mount -t $FSTYPE $DEVICE $MOUNTPOINT
echo -n "After:  "
mount | grep $DEVICE

```

Just change the device, mountpoint etc to match your configuration. Now, when you connect your drive just close the Konqueror/Nautilus window that pops up and run the rmount command. Likely you'll need to run the script as root to be able to do the mounting/unmounting. Here's the output on my system:

```
linux:~> sudo rmount
Before: /dev/sda1 on /media/usbdisk type subfs (rw,nosuid,nodev,fs=reiserfs)
Remounting /dev/sda1 on /media/usbdisk
After:  /dev/sda1 on /media/usbdisk type reiserfs (rw)

```

Job's a good 'un! ![](http://blogs.sun.com/roller/images/smileys/smile.gif) Just remember to unmount the drive before you disconnect it now! Oh - and, apparently, [submount/subfs is gone in SuSE 10.1](http://lists.opensuse.org/archive/opensuse-announce/2006-Jan/0004.html), so we'll just have to see how well things work in the future...