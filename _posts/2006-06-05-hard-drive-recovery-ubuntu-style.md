---
author: user
title: 'Hard Drive Recovery, Ubuntu-Style'
slug: hard-drive-recovery-ubuntu-style
id: 654
date: '2006-06-05 15:31:14'
layout: single
categories:
  - General
---

_CAUTION!!! Hard disk recovery is inherently fraught with peril. Every case is different. The actions I took may not work for you. Read all of the below before trying any individual action._

Thursday lunchtime I was just getting ready for an afternoon hacking on my latest pet project when I noticed that my laptop was running a bit slow. Make that _really_ slow. The hard disk light was constantly on. Hmm - kill a few processes that might have run amok, reading or writing the disk... No improvement.

OK - let's take a look in `/var/log` - the `messages` file often has a clue. Whah? This is what I see (x about 1000):

```
Jun  1 12:14:54 localhost kernel: [4351775.355000] hda: task_in_intr:
status=0x59 { DriveReady SeekComplete DataRequest Error }
Jun  1 12:14:54 localhost kernel: [4351775.355000] hda: task_in_intr:
error=0x01 { AddrMarkNotFound }, LBAsect=54067515, sector=54067515
Jun  1 12:14:54 localhost kernel: [4351775.355000] ide: failed opcode
was: unknown

```

Uh oh. This doesn't look so good. Google tells me that my hard disk probably has bad blocks. Luckily, you install Ubuntu (my choice of desktop OS) from a live CD... I boot from the live CD, run `badblocks` on `/dev/hda` and, sure enough, after a while, I have a list of > 100 bad blocks. I won't type the words I was muttering under my breath... This is a family blog.

So - back to Google. I manage to find information on [`dd_rescue`](http://www.garloff.de/kurt/linux/ddrescue/). Briefly, dd_rescue is like plain old *nix dd, except that it acts intelligently when it finds bad sectors. It reads the source with a big block size (fast!) while everything is OK and, when it hits an error, falls back to a small block size (slow) to try to get everything except for the bad block. Sounds like just what I need.

Adding the universe to `/etc/apt/sources.list` lets me apt-get install ddrescue and I'm away, thrilled that the Ubuntu live CD acts pretty much like a real installation. I have (had) three partitions on this 60GB disk - a 10GB NTFS primary partition, pre-installed and used about thrice in the past year, my 10GB Ubuntu root and my 37GB (go figure, the formatting gods stole 3GB from me) Ubuntu home. I run `dd_rescue`, creating images of each partition on my external USB drive which, fortunately, has ample space. dd_rescue retrieved the first two partitions quickly and without errors. Cool - I have my Ubuntu root - I don't have to redo the past couple of weeks of installation and configuration.

A quick trip to [Fry's](http://www.frys.com/) and I have a replacement HD. 80 GB instead of 60GB. It's useful to have a little wiggle room, and the extra 20GB was only $10+tax. Bargain.

I partition the new drive to match the old one (but with a bigger third partition for my Ubuntu home), put it in a spare USB caddy I had lying around, fire up Gnome Partition Editor and create new partitions to match the source drive - primary 10GB NTFS and two logical partitions in the extended partition - 10GB and the rest (some 56 or so). Google tells me that `dd if=/dev/hda of=/dev/sdb bs=446 count=1` transfers the master boot record (MBR) from drive to drive, so my new drive will boot just like the old one. _NOTE - this didn't actually work out - see below._

I quickly `dd` the NTFS and Ubuntu root partitions to the new drive and mount them. The NTFS drive looks fine. But - uh-oh - reiserfs complains about the Ubuntu root. More googling tells me that sometimes, the rounding that happens when you ask for a 10GB partition can vary depending on the drive geometry (or something, don't quote me on that). The safe thing to do is to create a target partition a bit bigger than the source. Now I'm glad I splurged the $10 for that 20GB wiggle room.

I leave NTFS as-is, delete the two other partitions and create two new partitions, this time 15GB and (approx) 50GB. `dd` the partition image, mount, and... cool! Ubuntu root is clean. Quick `reiserfsck` to double check. Yahoo - everything looks good. I can even use `resize_reiserfs` to expand my Ubuntu home to use all of its new partition.

Now for the biggie - my home partition. Luckily I took a full backup on 5/19, about 10 days ago, just before I moved from Suse 10.0 to Ubuntu Dapper, so it's not a total catastrophe if I get zilch back.

I run `dd_rescue` again and it just grinds to a halt after a couple of hours, still working, but plodding through the disk very slowly indeed. More googling tells me that there is a script called [`dd_rhelp`](http://www.kalysto.org/utilities/dd_rhelp/index.en.html) that wraps around dd_rescue to skip past errors and read more good stuff. The theory is that you want to get the good stuff off the disk asap. Sounds good to me. Off I go with `dd_rhelp`.

Well, after several more hours, `dd_rhelp` seems to be getting slower and slower as it figures out what to do next from its log of bad disk chunks. At this point, `dd_rhelp` had recovered most of the partition, but there were 233 'chunks' totalling 271MB of unrecovered data. Not necessarily all bad, just as-yet-untried. Yet more googling (what did we do before Google?) and, thanks to [this lucky find](http://www.toad.com/gnu/sysadmin/index.html#ddrescue), I find the supreme ultimate, the t'ai chi of disk rescuers, [GNU `ddrescue`](http://www.gnu.org/software/ddrescue/ddrescue.html) (no underscore this time).

GNU ddrescue takes a similar approach to dd_rhelp except that, being a C++ native code program, rather than a shell script, it is _much_ faster. I was a little apprehensive, I must admit, at the prospect of downloading and compiling a utility from source on a live CD system but, it worked! I had to apt-get install g++ and make, but everything worked just great (apart from installing ddrescue's info page. Not to sound churlish, but this is one of my pet peeves with GNU - why weren't man pages good enough - why did they have to go and re-invent that wheel?).

ddrescue's first pass through my drive took half the time that dd_rhelp had taken before I killed it and left 1091 'bad chunks' containing just 37MB of data. Pretty good - about 1/7 as much left to do, each chunk averaging about 34kB, compared to the 1165kB per chunk of dd_rhelp. Man - I wish I'd found [that page](http://www.toad.com/gnu/sysadmin/index.html#ddrescue) earlier. Thank you, [John Gilmore](http://www.toad.com/gnu/) (John was Sun employee #5, according to his [home page](http://www.toad.com/gnu/)).

A second pass of ddrescue 'splits' the previously found bad chunks, reclaiming any readable data and leaving bad sectors sized 4k. Another neat feature of ddrescue is that it keeps a log file, so you can stop it (ctrl-c) at any point, restart it later, and it will pick up where it left off. I decided to stop ddrescue after it had been working for about 24 hours and swap my disks around, so I could boot off my Ubuntu root in the new drive.

So, new drive in the laptop, old drive in the USB caddy - let's boot up. Uh-oh - GRUB seems to be having problems. All I see is the word GRUB scrolling up my screen. Back to the live CD, Google, and I find that the `dd bs=446 ...` trick I mentioned above is great for backing up your MBR, but useless for transferring an MBR from one drive to another, unless they are otherwise identical. The right command is `grub-install --root-directory=/mntpoint /dev/sda`, where /mntpoint is wherever you have the root partition currently mounted. I also had to comment out the home partition mount entry in `/etc/fstab` and create an empty home directory so I would be able to login to Ubuntu. Don't forget to change ownership on the home directory - otherwise you won't be able to get a regular desktop login.

So - reboot and... we're in. I have my Ubuntu root up and running with an empty home directory. That's fine. I restart the `ddrescue` job and it picks up where it left off, but it's really slow now. I'm not sure if this is due to moving the HD to a USB caddy or the drive is really just dying, but even after 12 more hours, it's only processed a few kB. There are approx 20MB left to process at this point. I decide that I'll take my chances... All I have to lose is a few documents written over the last few days, and most of them I can get from my IMAP Sent folder.

Again I use `dd` to copy the rescued image to its new home and run `reiserfsck --rebuild-tree` to fix up the file system. It complains like crazy, but gives me a consistent reiserfs that I can mount. Surprisingly, things look pretty good, but I know that there are 0x00's all over the data.I edit `/etc/fstab` to mount it as `/home` and reboot. I log in successfully, and everything looks cool. Now I delete anything tha t looks like transient data - it can be rebuilt easily - this includes Firefox and Beagle's caches. I also copy my Documents and download directories from my ~10 day-old backup, so I know that anything older than 5/19 is clean. Right now, I'm working on my laptop, pretty much where I was on Thursday lunchtime, but with 20GB additional disk space.

When I'm confident that I have everything worth getting from the old drive, I'll erase it using

```
#!/bin/bash
for n in `seq 7`
do
dd if=/dev/urandom of=/dev/sdb bs=1024k conv=notrunc,noerror;
done

```

This little script writes random garbage to the disk seven times over. After that, the disk will be ready to be thrown in the trash, purged of all usable data.

_06/07/2006 - UPDATE_ More advice from John Gilmore:

> When you want to erase your old drive, use GNU shred. It's part of the GNU coreutils package, so it's probably already installed on your LiveCD and your system. It does all the right data security erasure stuff. You can use it on files (on ext2 or ext3 -- probably not on a log-structured data system like reiserfs) or you can use it on an entire partition or an entire disk drive. The script that you gave, sucking gigabytes of data out of /dev/urandom, will be very slow.

So do yourself a favour and use [GNU shred](http://www.gnu.org/software/fileutils/doc/manual/html/fileutils.html#shred%20invocation) instead of /dev/urandom, m'kay?