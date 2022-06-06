---
author: user
title: 'Sun and Microsoft Interoperate for Web Authentication, Part 1'
slug: sun-and-microsoft-interoperate-for-web-authentication-part-1
id: 596
date: '2006-12-04 15:37:40'
layout: single
categories:
  - Access Manager
---

In between all the talk of federation, PHP and web services, we sometimes lose sight of the fact that bread-and-butter single sign-on and access control still has huge value in improving both security and the user experience. Over at the [Sun Developer Network](http://developers.sun.com/), [Marina Sum](http://weblogs.java.net/blog/marinasum/) and I just published an article - [Sun and Microsoft Interoperate for Web Authentication, Part 1](http://developers.sun.com/prodtech/identserver/reference/techart/interoperability.html) - focusing on how [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/) and its policy agents integrate with Microsoft IIS to provide both single sign-on and access control - right down to Windows ACLs on files on disk.

As the article mentions, some functionality (specifically, the basic authentication plugin - from the 'Configuration of the Policy Agent for HTTP Basic Authentication' heading to the end - sorry, there is no handy name anchor in there to link to) will be released in AM Policy Agent for IIS 2.2-Hotpatch6 sometime in the next few weeks. I'll post here as soon as this is available; at that point you will be able to work through the entire article. In the meantime, much of it works with the [current policy agent](http://www.sun.com/download/products.xml?id=435d57bd), so you can get started straight away.