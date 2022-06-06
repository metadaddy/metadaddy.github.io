---
author: user
title: OpenSSO and ldapvi
slug: opensso-and-ldapvi
id: 329
date: '2008-11-25 11:03:37'
layout: single
categories:
  - OpenSSO
---

<div style="margin: 5px; float: right; border-style: solid; border-width: thin;">![](images/ldapvi3.png)</div>

**WARNING - guru level information in this blog entry. Don't try ANY of this unless you're CERTAIN you know what you're doing. Editing OpenSSO's configuration directly can easily lead to an unusable deployment. You have been warned!**

The [Suretec](http://blog.suretecsystems.com/) guys blogged about [ldapvi](http://www.lichteblau.com/ldapvi/) [the other day](http://blog.suretecsystems.com/archives/154-OpenLDAP-Quick-Tips-Use-ldapvi!.html), which prompted me to deploy ldapvi and point it at [OpenSSO](http://opensso.org/)'s embedded [OpenDS](http://opends.org/) instance.

Deploying ldapvi on a Mac is very simple, thanks to [MacPorts](http://www.macports.org/). Just do

    sudo port install ldapvi

Now you can point it at your OpenSSO deployment like so:

    ldapvi -d --host ldap://localhost:50389 -D "cn=Directory Manager" -w password

I get a screen like this: ![](images/ldapvi1.png)

One neat feature is that ldapvi transparently deals with the base64 encoded XML data in the directory - you can see it if you search for sunKeyValue:; `![](images/ldapvi2.png)`

 `Now you can do some serious configuration hacking, especially with vi's global search and replace! But remember, with great power comes great responsibility. Backup your configuration before you try anything, and restart OpenSSO after any change you make in the directory. OpenSSO caches its configuration, and it won't notice changes you make 'under the covers'.`