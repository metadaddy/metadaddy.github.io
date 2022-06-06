---
author: user
title: Liberty on the Desktop
slug: liberty-on-the-desktop
id: 704
date: '2006-02-22 22:04:17'
layout: single
categories:
  - Federation
---

Fellow Sun architect [Hubert Le Van Gong](http://blogs.sun.com/roller/page/hubertsblog) has [put together a stellar demo](http://blogs.sun.com/roller/page/hubertsblog?entry=liberty_%C3%A0_la_infocard) that shows how the [Liberty](http://www.projectliberty.org/) protocols can be put to use in a 'user-centric' fashion:

![](http://blog.superpat.com/wp-content/uploads/2009/09/lotd.png)

Briefly, the demo shows a wine merchant site using a Java applet to gather identity data supporting a wine purchase - age, shipping address and payment details. In the demo, the user authenticates to a financial institution, which acts as identity provider, referencing attribute providers that actually manage the different (intersecting) sets of user data.

This brings us to a classic trade-off - Hubert's demo could equally have been implemented with identity and attribute providers running on the user's own machine - there is nothing in the Liberty protocols that constrains the location of these functions. Having your financial institution (or wireless operator or employer or...) be your provider allows you to leverage their infrastructure from wherever in the world you happen to be. On the other hand, having providers running locally on your own machine gives you more control over your data, but only from one machine. Pick the most appropriate model for your situation - the important thing is that you _have_ a choice.