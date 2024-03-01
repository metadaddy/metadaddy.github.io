---
author: user
title: Sun Secure Global Desktop and OpenSSO Integration
slug: sun-secure-global-desktop-and-opensso-integration
id: 361
date: '2008-10-02 08:50:51'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://fr.sun.com/teleweb/ssgds/images/I1_sun_secure_global_desktop.jpg)](https://opensso.dev.java.net/files/documents/3676/112554/SecureGlobalDesktop-OpenSSO-Integration.pdf)</span>

Sun Solution Architect [Joachim Andres](http://blogs.sun.com/joachimandres/) (aided and abetted by [Paul Walker](http://blogs.sun.com/illgetmycoat/) and [Andy Hall](http://blogs.sun.com/fatbloke/)) has [just written up an integration [PDF]](https://opensso.dev.java.net/files/documents/3676/112554/SecureGlobalDesktop-OpenSSO-Integration.pdf) of [OpenSSO](http://opensso.org/) with [Sun Secure Global Desktop](http://www.sun.com/software/products/sgd/index.jsp). Secure Global Desktop (SGD for short) provides secure access to centralized Windows, UNIX/Linux, Mainframe and Midrange applications from a wide range of popular client devices, including Microsoft Windows PCs, Solaris OS Workstations, thin clients and more (can you tell I cut'n'pasted that from the product page? ![](http://blogs.sun.com/images/smileys/smile.gif)). One of the most interesting client interfaces to SGD is via a Web browser - [you can see it in the demo I recorded](https://archive.org/details/Redmonk-DemoOpenSSOGetsSaaSyFederatedIdentityAcrossTheFirewall360) with [Michael Coté](http://www.redmonk.com/cote/) of [Redmonk](http://www.redmonk.com/) - which brings it into OpenSSO's sphere of control.

This integration is a great example of the use of policy agents with existing applications - the policy agent sets the `REMOTE_USER` server variable and SGD is configured to pick that up rather than use its own login page. With that, and a tweak to SGD's logout logic to send the browser to OpenSSO's logout page, we have a very neat integration. [Check it out [PDF]](https://opensso.dev.java.net/files/documents/3676/112554/SecureGlobalDesktop-OpenSSO-Integration.pdf).