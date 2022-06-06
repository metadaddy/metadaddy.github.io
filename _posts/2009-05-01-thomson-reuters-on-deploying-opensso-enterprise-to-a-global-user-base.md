---
author: user
title: Thomson Reuters on deploying OpenSSO Enterprise to a Global User Base
slug: thomson-reuters-on-deploying-opensso-enterprise-to-a-global-user-base
id: 277
date: '2009-05-01 15:13:17'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](images/tr-logo.jpg)](http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001)</span>

About a month ago, [Nick](http://blogs.sun.com/nickwooler/) [mentioned](http://blogs.sun.com/nickwooler/entry/opends_open_source_identity_architecture) a presentation that Chris Lucock, head of Enterprise Architecture desktop products for [Thomson Reuters](http://thomsonreuters.com/), had given at March's [Gartner Identity & Access Management Summit](http://www.gartner.com/it/page.jsp?id=749726) in London. The [video for this presentation has just gone online](http://channelsun.sun.com/video/programs/idm+buzz+tv/1631239600) and, like [the last Gartner video I blogged, by Damo Bashyam of Verizon Wireless](verizon-wireless-on-improving-security-and-user-experience-with-sun-access-manager), it's got some great information on a large scale real world deployment of [OpenSSO Enterprise](http://www.sun.com/software/products/opensso_enterprise/index.xml).

In the video, Chris explains how OpenSSO is on track to provide single sign-on across Thomson Reuters' Markets services to 330,000 users worldwide by the end of 2011\. In many ways it's a very different deployment to Verizon Wireless; 1% of the user base in terms of sheer numbers, but far more complex in terms of the services provided. One example: Thomson Reuters have implemented 'exclusive access', controlling the numbers of concurrent users of third party services (and thus Thomson Reuters' costs) by ensuring that each user only has a single session active at any time, for example, terminating a desktop session left open over lunch when a user logs in from their mobile phone. Another good one: single sign-on is provided across services delivered by the public internet and Thomson Reuters' private network, again allowing cost savings as streaming video can be more cheaply delivered via the internet while sensitive financial data is more tightly controlled.

There's much more in the video, including integrations with Siebel and the Reuters Messaging product, so spend a few minutes with Chris, [exploring OpenSSO at Thomson Reuters...](http://channelsun.sun.com/video/identity+management+at+verizon+wireless/10633172001)

<object id="flashObj" width="486" height="322" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,47,0"><param name="movie" value="http://c.brightcove.com/services/viewer/federated_f9/1640183659?isVid=1&amp;publisherID=1460825906"><param name="bgcolor" value="#FFFFFF"><param name="flashVars" value="videoId=20384015001&amp;playerID=1640183659&amp;domain=embed&amp;"><param name="base" value="http://admin.brightcove.com"><param name="seamlesstabbing" value="false"><param name="allowFullScreen" value="true"><param name="swLiveConnect" value="true"><param name="allowScriptAccess" value="always"><embed src="http://c.brightcove.com/services/viewer/federated_f9/1640183659?isVid=1&amp;publisherID=1460825906" bgcolor="#FFFFFF" flashvars="videoId=20384015001&amp;playerID=1640183659&amp;domain=embed&amp;" base="http://admin.brightcove.com" name="flashObj" width="486" height="322" seamlesstabbing="false" type="application/x-shockwave-flash" allowfullscreen="true" swliveconnect="true" allowscriptaccess="always" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"></object>