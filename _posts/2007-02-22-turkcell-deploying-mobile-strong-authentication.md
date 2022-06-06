---
author: user
title: Turkcell Deploying Mobile Strong Authentication
slug: turkcell-deploying-mobile-strong-authentication
id: 568
date: '2007-02-22 13:51:15'
layout: single
categories:
  - Access Manager
---

[<span style="margin: 5px; float: right;">![](images/2005_06_29_20-34-10-948_n2.jpg)</span>](http://www.turkcell.com.tr/)

From [Orhan Alkan](http://blogs.sun.com/aorhan/) comes [this report](http://blogs.sun.com/aorhan/entry/using_digital_signature_as_strong) of [Turkcell](http://www.turkcell.com.tr/) deploying mobile strong authentication with [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/). Orhan and his colleagues in the Sun Turkey Professional Services team developed a [custom authentication module](http://docs.sun.com/app/docs/doc/819-2139/6n4et3e88?a=view#adugq) to handle the signature validation in Access Manager.

Orhan was kind enough to give me some more detail by email: the subscriber's private key is in the SIM, so it is portable across phones. Authenticated subscribers can access all of Turkcell's web-based customer applications including billing, enabling services such as international calls and roaming and changing rate plans, and even access their accounts at banks such as [Garanti](http://www.garanti.com.tr/), [Akbank](http://www.akbank.com.tr/) and [Isbankasi](http://www.isbank.com.tr/).

Recalling [an earlier entry on Turkcell's ID-WSF pilot](http://blogs.sun.com/superpat/entry/sun_turkcell_liberty_id_wsf) - they certainly seem to be in the vanguard of mobile operators when it comes to identity.