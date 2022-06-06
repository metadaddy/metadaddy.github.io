---
author: user
title: OpenID at Sun
slug: openid-at-sun
id: 538
date: '2007-05-07 09:01:59'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://www.sun.com/images/l2/l2_openid.gif)](http://developers.sun.com/identity/)</span>

Already lighting up the blogosphere this morning are posts from [Tatsuo](http://blogs.sun.com/tkudo/entry/sun_microsystems_announces_openid_program), [Gerry](http://beuchelt.blogdns.net:8080/OpenIDAtWork.aspx), [Rich](http://blogs.sun.com/sharps/entry/one_cool_thing_about_working) and [Scott](http://kveton.com/blog/2007/05/07/sun-announces-openid-support/) all about [Sun's new OpenID Provider](http://biz.yahoo.com/prnews/070507/sfm045.html?.v=92). Briefly, Sun is launching an [OpenID](http://openid.net/) Provider (OP) for all of its employees.

Why just employees? Well - there are [any number of sites that offer OpenIDs](http://openid.net/wiki/index.php/OpenIDServers), and anyone can start their own, but we wanted to try something different. With this service, we are exploring the use of OpenIDs in a _business_ context - what could it mean to have an OpenID that says you are an employee of Sun Microsystems (or, for that matter, any company)? We'll be learning over the next few weeks and months, and, of course, sharing the lessons with the wider community.

On the technical side, we are deploying the [OpenSSO Extension for OpenID](https://opensso.dev.java.net/public/extensions/openid/) on [OpenSSO](https://opensso.dev.java.net/). In case the bulbs aren't lighting yet... this means that anyone can grab those components, do a little tweaking round the edges, and roll this out for themselves. In fact, that's exactly what [SSOCircle](http://www.ssocircle.com/) has done, but in a non-enterprise context.