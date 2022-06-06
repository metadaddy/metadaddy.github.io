---
author: user
title: Authorization with OpenSSO's Identity Services
slug: authorization-with-openssos-identity-services
id: 466
date: '2007-11-28 12:18:23'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://developers.sun.com/identity/reference/techart/images/idsvcs2_fig2_sm.jpg)](http://developers.sun.com/identity/reference/techart/id-svcs2.html)</span>

One new area of work in [OpenSSO](http://opensso.org/) is _Identity Services_, allowing a developer to easily write code to authenticate users, check if those users are authorized to access resources, retrieve those users' attributes etc. While all of this functionality has long been available in different forms, the new Identity Services work collects common identity tasks into an easy-to-use set of web services accessible via SOAP and REST. Now developers working in just about any language can join the identity party ![](http://blogs.sun.com/images/smileys/smile.gif)

Last month, [Aravindan](http://blogs.sun.com/aravind/) and [Marina](http://weblogs.java.net/blog/marinasum/) published a [Sun Developer Network](http://developers.sun.com/) article [showing how to use OpenSSO's identity services for authentication](http://developers.sun.com/identity/reference/techart/id-svcs.html). This month, Lakshman Abburi joins them to cover [authorization with identity services](http://developers.sun.com/identity/reference/techart/id-svcs2.html). The identity services client from part 1 is extended to check whether the authenticated user should be allowed access to a given resource, in this example, a URL. Although the article focuses on Java and [NetBeans](http://www.netbeans.org/), as I mention above, you can invoke identity services from just about anywhere. Go [read the](http://developers.sun.com/identity/reference/techart/id-svcs.html) [articles](http://developers.sun.com/identity/reference/techart/id-svcs2.html), have a play, and leave a comment [here](http://blogs.sun.com/superpat/entry/authorization_with_opensso_s_identity#comments) or [there](http://developers.sun.com/identity/reference/techart/id-svcs2.html#5) if you do something really cool.