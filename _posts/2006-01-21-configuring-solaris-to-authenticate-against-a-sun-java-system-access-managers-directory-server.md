---
author: user
title: >-
  Configuring Solaris to Authenticate against a Sun Java System Access Manager's
  Directory Server
slug: >-
  configuring-solaris-to-authenticate-against-a-sun-java-system-access-managers-directory-server
id: 718
date: '2006-01-21 20:43:25'
layout: single
categories:
  - Access Manager
---

[Solaris](http://www.sun.com/software/solaris/) (and other *nix operating systems) can authenticate users against an LDAP compliant directory server, such as [Sun Java System Directory Server](http://www.sun.com/software/products/directory_srvr_ee/index.xml), for log in. [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) can also authenticate users against an LDAP directory server for web single sign-on, access control and federation. There is an issue in that, by default, Access Manager locks down its Directory Server instance, removing the capability to do anonymous LDAP search and read operations. Unfortunately, this removes the ability for Solaris to authenticate users.

[Jeff Nester](http://jnester.lunarpages.com/), a Senior Identity Management Specialist at [inSolutions](http://www.insolutions.net/) (Dig the retro [iPlanet favicon](http://www.insolutions.net/favicon.ico) at inSolutions.net, Jeff!) recently wrote a [paper explaining how to configure Directory Server and Access Manager so that Solaris and AM authentication co-exist](http://jnester.lunarpages.com/howtos/solaris/solarisLDAPAuth.html). This allows you to create a single directory entry that enables access to both Solaris and web applications protected by AM.

Useful stuff if you're trying to consolidate directories and keep passwords consistent across desktop login and web applications. Lots of other goodies at [Jeff's site](http://jnester.lunarpages.com/) too - must try the [tips for getting a video projector to work on a Toshiba Tecra M2 in Java Desktop System](http://jnester.lunarpages.com/howtos/linux/dualDisplay.html). If that works, I definitely owe you a beer, Jeff ![](http://blogs.sun.com/roller/images/smileys/smile.gif)