---
author: user
title: Back after JavaOne 2009
slug: back-after-javaone-2009
id: 275
date: '2009-06-09 12:15:35'
layout: single
categories:
  - General
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/l2_2009_J1.gif)](http://java.sun.com/javaone/2009/articles/wrapup.jsp)</span>

Wow - is it really _over a month_ since [my last blog entry](http://blog.superpat.com/2009/05/07/the-fedlet-best-innovation-award-winner-at-the-european-identity-conference/)? I guess that's what happens when you get your head down into a project - in this case, building a demo for [CommunityOne West](http://developers.sun.com/events/communityone/2009/west/) and [JavaOne](http://java.sun.com/javaone/) 2009 to show off the latest [OpenSSO](http://opensso.org/) features.

The demo brought together a number of existing Java technologies - the [Java Persistence API](http://java.sun.com/developer/technicalArticles/J2EE/jpa/) (JPA), the [Jersey](https://jersey.dev.java.net/) implementation of [JAX-RS (aka JSR 311)](https://jsr311.dev.java.net/) on both the [client](http://blogs.sun.com/enterprisetechtips/entry/consuming_restful_web_services_with) and [server](http://blogs.sun.com/enterprisetechtips/entry/implementing_restful_web_services_in), and [JavaFX](http://www.javafx.com/) - with some new aspects of OpenSSO - fine-grained authorization (aka [entitlements](http://blogs.sun.com/raskin/entry/entitlements_pyramid_scheme)), [OAuth](http://oauth.net/) protocol support, and a JDBC data store. Briefly, the demo centered on a cellphone account management system delivered as a JavaFX rich Internet application ([RIA](http://en.wikipedia.org/wiki/Rich_Internet_application)) client and a (more or less) [RESTful](http://en.wikipedia.org/wiki/Representational_State_Transfer) web service back-end, communication between them secured by OAuth.

I'll be uploading source code for the demo client and server apps to the OpenSSO project in the next few days, as well as documenting how to bring up the demo environment. Watch this space for updates!