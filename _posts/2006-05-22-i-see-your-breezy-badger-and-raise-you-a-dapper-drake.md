---
author: user
title: I see your Breezy Badger and raise you a Dapper Drake
slug: i-see-your-breezy-badger-and-raise-you-a-dapper-drake
id: 664
date: '2006-05-22 22:36:53'
layout: single
categories:
  - General
---

![](http://blog.superpat.com/wp-content/uploads/2009/09/UbuntuLogoSmall.png){: .align-left} Inspired by [Mark Shuttleworth](https://wiki.ubuntu.com/MarkShuttleworth) on stage last week at JavaOne, and [Eric](http://blogs.sun.com/roller/page/cericleach)'s recent [blog entry](http://blogs.sun.com/roller/page/cericleach?entry=java_one_blog_number_10) (partly) on installing [Ubuntu](http://www.ubuntu.com), I spent a few hours last weekend installing [Dapper Drake](https://wiki.ubuntu.com/DapperDrake), the latest, greatest (currently beta) Ubuntu release.

There are more tips and tricks on installing Ubuntu on the [Ubuntu Wiki](https://wiki.ubuntu.com/) than I could ever hope to cover here, so I'll just give my first impressions...

*   Installing from the Live CD - pretty painless. It's at this point that I start to Google for Ubuntu's lack of a root password. Cool - pretty much matches the way I work - never login as root, but keep root capability at arm's length via sudo.
*   Login and... what's this? An icon in the menu bar up top advising me of updated packages. 370-odd updated packages. OK - I'll grab those. After all, it's the weekend... Plenty of other stuff I can do for a while.
*   Now we have an up-to-date system. Time to install a few apps. [Firefox](http://www.mozilla.com/firefox/) and [GAIM](http://gaim.sourceforge.net/) are already there, so I just copy in `.firefox` and `.gaim` from my backed up Suse home directory. So far so good - I see all my bookmarks and log into all my IM accounts.
*   I prefer [Thunderbird](http://www.mozilla.com/thunderbird/) to Ubuntu's default [Evolution](http://www.gnome.org/projects/evolution/), so I use Applications - Add/Remove to grab it. Cool - it just works. Copy over `.thunderbird` and... I can't see my accounts or email folders. Hmmm. `ls -latr`. Oh - `.mozilla-thunderbird`. OK - I can live with that, a quick `mv` and I can see my email.
*   Ooh - [NetworkManager](http://www.gnome.org/projects/NetworkManager/) - grab that, for definite. And... it just works. Cool! No VPN support in the Ubunutu version, though. Building NetworkManager from CVS could be pretty hairy - I know that Ubuntu tweaks the standard build. I'll live with [vpnc](http://packages.ubuntu.com/dapper/net/vpnc) for now.
*   I _love_ [Synergy](http://synergy2.sourceforge.net/) - the open source keyboard/mouse switcher. At the time I installed Dapper, the Synaptic Package Manager was listing some 1.2.x version, rather than the current 1.3.1, so I build Synergy from source. A quick Google, `apt-get install build-essential` and a few other bits and pieces and I'm away - sharing my mouse and keyboard between my home system and my laptop. I just checked, and Synaptic is reporting 1.3.1, Let's `make uninstall` and grab the official one... Done.
*   [Skype](http://www.skype.com) - grab the `.deb` from the Linux download page, copy in .Skype and we're done.
*   _UPDATE:_ For [VMware](http://www.vmware.com), Google tells me I need the correct headers for my kernel... `sudo apt-get install linux-headers-`uname -r`` then `sudo ./vmware-install.pl`. I found the IP addresses I was using for vmnet1 and vmnet8 in my old (backed up) `/etc/vmware/` directory. Copy over `.vmware` for my favourites and the license file and... it works!

More as I discover interesting stuff... See you later ![](http://blogs.sun.com/roller/images/smileys/smile.gif)