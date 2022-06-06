---
author: user
title: ActivIdentity 4TRESS Authentication Module for OpenSSO/Access Manager
slug: actividentity-4tress-authentication-module-for-openssoaccess-manager
id: 448
date: '2008-02-08 11:07:48'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blogs.sun.com/theaquarium/resource/ai_logo.gif)](http://developers.sun.com/identity/reference/techart/4tress.html)</span>

[Marina Sum](http://weblogs.java.net/blog/marinasum/) (who must be just about the busiest tech author at [Sun Developer Network](http://developers.sun.com/) these days!) has [co-written an article](http://developers.sun.com/identity/reference/techart/4tress.html) with Michelle Cope, of Sun's ISV Engineering team, on integrating [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/) with [ActivIdentity 4TRESS Authentication Server](http://www.actividentity.com/products/4tress_auth_server__home.php).

The article shows how you can use Access Manager's [session upgrade](http://docs.sun.com/app/docs/doc/819-4670/6n6qardud?a=view) feature to protect particularly sensitive resources with the [one-time password](http://en.wikipedia.org/wiki/One-time_password) (OTP) authentication schemes in 4TRESS.

What is particularly interesting about this integration is that the [complete source code is available](https://opensso.dev.java.net/source/browse/opensso/extensions/authn4tress) as an [OpenSSO Extension](https://opensso.dev.java.net/public/extensions/); if you already have ActivIdentity 4TRESS, you can [read the article](http://developers.sun.com/identity/reference/techart/4tress.html), download the source, build the authentication module and deploy it into Access Manager or [OpenSSO](https://opensso.dev.java.net/). If you don't have 4TRESS, then [call the good people at ActivIdentity](http://www.actividentity.com/en/contact/index.php), and tell them Pat sent you ![](http://blogs.sun.com/images/smileys/wink.gif)