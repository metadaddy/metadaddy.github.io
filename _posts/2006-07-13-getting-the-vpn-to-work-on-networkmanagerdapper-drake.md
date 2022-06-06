---
author: user
title: Getting the VPN to work on NetworkManager/Dapper Drake
slug: getting-the-vpn-to-work-on-networkmanagerdapper-drake
id: 641
date: '2006-07-13 20:56:12'
layout: single
categories:
  - General
---

[![](http://www.gnome.org/projects/NetworkManager/images/nm-logo.png){: .align-left}](http://www.gnome.org/projects/NetworkManager/) 

_UPDATE - September 15 - thanks to 'Ed', I have it all working. Please see the [comments](http://blogs.sun.com/superpat/entry/getting_the_vpn_to_work#comments) for the answer..._

_UPDATE - August 14 - the VPN package linked below doesn't seem to update resolv.conf, so I stopped using it and went back to vpnc from the command line. Please do leave a comment if you're able to get all this working properly!_

As [I've previously mentioned](i-see-your-breezy-badger-and-raise-you-a-dapper-drake), I'm running Ubuntu Dapper Drake on my laptop. Everything has been working just dandy since I recovered from my [hard disk crash](hard-drive-recovery-ubuntu-style), except for one minor annoyance: the version of [NetworkManager](http://www.gnome.org/projects/NetworkManager/) in Dapper Drake doesn't do VPN.

I've been using the command line vpnc to connect, which works ok, except that, when the DHCP lease expires, NetworkManager overwrites the VPN's version of /etc/resolv.conf, so I have to either keep a backup /etc/resolv.conf to copy back, or just restart the vpn.

<del>I finally got round to googling for an answer tonight and (on [this page](https://launchpad.net/distros/baltix/+bug/37110)) found a [VPN package for NetworkManager on Dapper](http://librarian.launchpad.net/2428420/network-manager-vpnc_0.5.99%2Bsvn20060403-0ubuntu1_i386.deb). It seems to work fine. The one niggle was that, after configuring the VPN connection in nm-applet, I had to restart NetworkManager, but that's a one-time thing.</del>

Roll on [Edgy Eft](https://wiki.ubuntu.com/EdgyEft)!