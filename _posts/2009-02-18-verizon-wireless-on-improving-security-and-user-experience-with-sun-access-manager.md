---
author: user
title: >-
  Verizon Wireless on Improving Security and User Experience with Sun Access
  Manager
slug: >-
  verizon-wireless-on-improving-security-and-user-experience-with-sun-access-manager
id: 292
date: '2009-02-18 14:58:19'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/vzw_logo_1024.gif)](http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001)</span>

Last November, at the [Gartner Identity and Access Management Summit 2008](http://www.gartner.com/it/page.jsp?id=633107) in Orlando, FL, Damo Bashyam of [Verizon Wireless](http://www.verizonwireless.com/) (VZW) gave a presentation titled 'Simplify Identity Management to Improve Security and Online Customer Experience'; [Daniel](http://blogs.sun.com/raskin/) just pinged me to say that [this presentation is now online](http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001), along with [the associated slides](http://blogs.sun.com/raskin/resource/Verizon_OpenSSO_Gartner_Preso_Nov08.pdf), and what a presentation it is!

If you're looking for marketecture, then move on; if you want to know how the largest wireless telecommunications network in the United States is using Access Manager (the old name for [OpenSSO Enterprise](http://www.sun.com/software/products/opensso_enterprise/)) in a high-scale, high-availability deployment, then it's all here, in just 23 minutes. Some of the numbers are staggering: over 40,000,000 users, 1,000,000 logins per day, peaking at 4,000 logins per minute. VZW deployed Access Manager into two data centers, with [session failover](http://docs.sun.com/app/docs/doc/820-3320/ghbqf?a=view) within each data center and [multi-master replication](http://docs.sun.com/app/docs/doc/820-2765/aalfp?l=en&a=view) between six [Sun Directory Server](http://www.sun.com/software/products/directory_srvr_ee/) instances.

The [preso](http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001) and [slides](http://blogs.sun.com/raskin/resource/Verizon_OpenSSO_Gartner_Preso_Nov08.pdf) detail all this and the business benefits to VZW - for me, given my focus on federation, one highlight was the fact that they have extended single sign-on to 25 third-party application service providers (ASPs), 12 of them in a single night with just 4 hours (planned) downtime for the cutover. Another interesting aspect is that this is a Sun stack, top-to-bottom, so VZW have just one throat to choke in the event of an issue, with no intra-vendor finger pointing. Damo describes it as a partnership - one that has brought real and lasting benefits for both partners.

So... go download the [slides](http://blogs.sun.com/raskin/resource/Verizon_OpenSSO_Gartner_Preso_Nov08.pdf), make yourself a [nice cup of tea](http://www.yorkshiretea.co.uk/), and spend a few minutes watching the preso:

<embed src="http://c.brightcove.com/services/viewer/federated_f9/1640183659?isVid=1&amp;publisherID=1460825906" bgcolor="#FFFFFF" flashvars="videoId=10633172001&amp;linkBaseURL=http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001&amp;playerID=1640183659&amp;domain=embed&amp;" base="http://admin.brightcove.com" name="flashObj" width="486" height="322" seamlesstabbing="false" type="application/x-shockwave-flash" allowfullscreen="true" swliveconnect="true" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">