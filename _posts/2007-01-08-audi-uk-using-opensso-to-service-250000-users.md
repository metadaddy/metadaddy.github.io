---
author: user
title: 'Audi UK using OpenSSO to service 250,000 users'
slug: audi-uk-using-opensso-to-service-250000-users
id: 585
date: '2007-01-08 17:19:31'
layout: single
categories:
  - OpenSSO
---

[<span style="float: right;">![](http://www.audi.co.uk/cms4imp_base/audi/images/logo_audi.gif)</span>](http://www.audi.co.uk/)

[Dave 'Wavy' Holroyd](http://david.holroyd.me.uk/) of [Good Technology](http://www.goodtechnology.com/) [reports on his production deployment of OpenSSO in the UK](https://opensso.dev.java.net/servlets/ReadMsg?list=dev&msgNo=121) today on [dev@opensso.dev.java.net](https://opensso.dev.java.net/servlets/ProjectMailingListList). With his kind permission. I'll just quote Dave here, lightly edited to turn his footnotes into hyperlinks:

> Ok, so, in mid 2006 [we](http://www.goodtechnology.com/) rebuilt the [Audi UK](http://www.audi.co.uk/) site to integrate with the Audi Global Content Management solution, and upgrade the previous, pre-J2EE technology platform. One of several features from the old site not included in the first delivery was the ability to log in to access special content and tools.
> 
> Having moved from a single-application model to a raft of independent webapps, that login functionality now requires a single sign-on solution. Also, given historical needs for integration with third-party systems and components, we wanted something based on well-thought-out Web Services, and a potential upgrade path to implement Federation.
> 
> Just before Christmas 2006, we deployed an OpenSSO system adapted with custom Authentication and Data Store plugins. These make use of the site's existing relational database containing the profiles of around a quarter of a million registered users.
> 
> We integrated login and registration functions directly into our application rather than using the generic OpenSSO user interface. This enables access to functions like '[ordering a postal brochure](http://myaudi.audi.co.uk/myaudi/startBrochureRequest.do?tmpl=%2Faudi%2Fuk%2Fen2%2Fbrochure_request.template.html)' by both authenticated and unauthenticated users, with the option for unauthenticated users to register toward the end of the process.

This is a great example of the kind of deployment that OpenSSO makes possible - Dave leveraged his visibility into the source code to create a solution customized to his needs, flagging some bugs in the process. [Good, good, good, good, good... Good Technology!](http://dustonthestylus.blogspot.com/2006/02/red-guitars-good-technology.html)