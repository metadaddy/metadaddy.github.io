---
author: user
title: OpenSSO Halloween Tab Sweep
slug: opensso-halloween-tab-sweep
id: 338
date: '2008-10-31 15:21:21'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/OpenSSOLogoHalloween200x58.png)](http://opensso.org/)</span>

I wish I could say there were spooky goings on this week in [OpenSSO](http://opensso.org/), but you'll have to settle for more adoption news and some fun stuff with OpenSSO and [Amazon EC2](http://aws.amazon.com/ec2/)...

*   First up this week, on the [OpenSSO Users mailing list](https://opensso.dev.java.net/servlets/ProjectMailingListList), we had [an interesting email from Romanov Vladimir](http://markmail.org/message/ahafp5jdpihrbvy6), of the R&D department of Russian telecommunications operator [Scartel](http://www.scartel-starlab.ru/), saying that they are using OpenSSO as the authentication mechanism for their new [Yota](http://www.yota.ru/en/info/index.php) [WiMax](http://en.wikipedia.org/wiki/Wimax) network. We're looking forward to hearing more as they move Yota from test mode into production.
*   Staying in Eastern Europe, I noticed the work going on at the [Budapest University of Technology and Economics (BME)](http://portal.bme.hu/langs/en/default.aspx), where they are also using OpenSSO for authentication - [a nice diagram and some information on the architecture](http://kirdev.sch.bme.hu/trac/vip/wiki/NagyvonaluArchitektura); unfortunately, [Google Translate](http://translate.google.com/) doesn't yet stretch to Hungarian, although Adam Lantos of HME (a regular participant on the mailing list) says he'll send some information in English soon.
*   Finally, [Mike Hortobagyi](http://www.horto.ca/), up in Canada, [writes today about an experiment I ran last night](http://www.horto.ca/?p=13), deploying OpenSSO onto [GlassFish](http://glassfish.org/)+[OpenSolaris](http://opensolaris.org/) at Amazon EC2\. Logically, it all _should_ work ok, but it's great to try something like this and see it actually running up in the cloud. It took me less than 45 minutes to get OpenSSO and the [Fedlet](http://blogs.sun.com/raskin/entry/the_fedlet_has_arrived_check) running, including uploading the OpenSSO WAR file to the EC2 instance. I'll leave the instance up for a few days so you can go play - [try out the Fedlet](http://ec2-75-101-218-17.compute-1.amazonaws.com:8585/fedlet) (click the link to login, username **demo**, password **changeit**), or even the [federation validator](http://ec2-75-101-218-17.compute-1.amazonaws.com:8585/opensso/validatorMain.jsp?realm=/&cot=cot1&idp=http://ec2-75-101-218-17.compute-1.amazonaws.com:8585/opensso(/idp)&sp=http://ec2-75-101-218-17.compute-1.amazonaws.com:8585/fedlet) (same username/password). _NOTE_ - it's a little confusing, since I gave OpenSSO and the Fedlet the same hostname, but they are independent web applications, with no shared state. You can see all the gory SAML details (WoooOOOooo! Spooky!) in the Fedlet page after you login. [Go give it a try](http://ec2-75-101-218-17.compute-1.amazonaws.com:8585/fedlet); if you get a host not found, or page not found, error, I've likely taken the instance down... I can't keep paying $0.10 per hour forever, you know! ;-)

So, there you go - I managed to squeeze in a spooky reference in the end... Happy Halloween, everyone!