---
author: user
title: OpenID @ Work - Architecture
slug: openid-work-architecture
id: 525
date: '2007-06-15 07:26:17'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](images/SunOpenID.png)](http://blogs.sun.com/hubertsblog/entry/openid_sun_architecture)</span>

As you might already know, [OpenID.sun.com](http://openid.sun.com/) has been live for a few days now. I have my shiny new OpenID ([http://openid.sun.com/metadaddy](http://openid.sun.com/metadaddy)) and have already used it to log in to the [Project Concordia](http://projectconcordia.org/) wiki and add myself to the [list of participants](http://projectconcordia.org/index.php/Main_Page#Participants). Everything seems to be working as it should.

It's a fitting time, then, to start explaining how we deployed OpenID, and [Hubert](http://blogs.sun.com/hubertsblog/) has started doing exactly that with this blog entry on the [architecture of OpenID.sun.com](http://blogs.sun.com/hubertsblog/entry/openid_sun_architecture). As you can see from Hubert's description, the OpenID deployment is based on [OpenSSO](https://opensso.dev.java.net/) and its [OpenID extension](https://opensso.dev.java.net/public/extensions/openid/), so any interested party can go grab the source and try it out for themselves. In fact, [some already have](http://www.ssocircle.com/).