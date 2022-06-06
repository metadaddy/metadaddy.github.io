---
author: user
title: Yay - VMware Workstation 5.5.2 now includes VMware Tools for Solaris 10!
slug: yay-vmware-workstation-5-5-2-now-includes-vmware-tools-for-solaris-10
id: 628
date: '2006-10-06 16:55:58'
layout: single
categories:
  - General
---

[<span style="margin-bottom: 10px; margin-top: 10px; float: right;">![](http://www.vmware.com/img/logo_top.gif)</span>](http://www.vmware.com/)

I spend a lot of time in [VMware](http://www.vmware.com/) - it goes with the job - one VM running [Federation Manager](http://www.sun.com/software/products/federation_mgr/) on [Windows Server 2003 R2](http://www.microsoft.com/windowsserver2003/default.mspx), another running [OpenSSO](https://opensso.dev.java.net/) on [Solaris 10](http://www.sun.com/software/solaris/), with [Firefox](http://www.spreadfirefox.com/) on my [Ubuntu](http://www.ubuntu.com/) host machine testing [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) single sign-on between them.

For some time now ([as blogged here](http://blogs.sun.com/superpat/entry/links_for_2006_03_17)), I've been using the excellent, but unofficial, [VMware Tools for Solaris 10](http://wotho2.ethz.ch/vmware/tools/), by [Juergen Winkelmann](http://www.id.ethz.ch/people/allid_list/juergen/index) to synchronise the host and VM clocks and to let me switch between the host desktop and the VM window without needing to hit Ctrl-Alt all the time. This distro leveraged [lxrun](http://www.sun.com/software/linux/compatibility/lxrun/index.xml) to run the VMware Tools for Linux on Solaris 10\. It worked pretty well, but was somewhat limited - the mouse motion was pretty jumpy at the edge of the VM window and there was no support for shared folders (vmhgfs), the high speed network adapter (vmxnet) or memory management (vmmemctl).

I recently upgraded my [VMware Workstation](http://www.vmware.com/products/ws/) to 5.5.2 and what do I find, but an official VMware Tools for Solaris 10!!! Just select VM/Install VMware Tools (you might need to type 'eject' in a terminal at this point if you already have a cdrom image loaded), and VMware will mount a cdrom image with the tools package. Run vmware-install.pl - I just hit 'enter' for all the prompts, I think. Follow the onscreen instructions to switch from the default pcn0 network adapter to the shiny new vmxnet0 one, reboot and off you go!

The mouse motion is now perfect, networking is, apparently, faster, and you don't have to have the tools dialog up all the time. Nice one, VMware and thanks, Juergen, for filling the gap!