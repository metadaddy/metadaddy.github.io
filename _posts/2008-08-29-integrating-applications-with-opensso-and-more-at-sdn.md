---
author: user
title: Integrating Applications With OpenSSO and more at SDN
slug: integrating-applications-with-opensso-and-more-at-sdn
id: 383
date: '2008-08-29 15:04:32'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/app-integration-fig2.jpg)](http://developers.sun.com/identity/reference/techart/app-integration.html)</span>

What with vacation and work on [OpenSSO](http://opensso.org/), I've built up quite a backlog of blogworthy news. Now that I've got a couple of hours spare, it's time to take a look at what's been happening over at [Sun Developer Network's Identity pages](http://developers.sun.com/identity/)...

*   The 'Securing Applications With Identity Services' series continues with part 4: '[Single Sign-On and Logout](http://developers.sun.com/identity/reference/techart/id-svcs4.html)'. [Prashant](http://blogs.sun.com/pdblog/), [Aravindan](http://blogs.sun.com/aravind/) and [Marina](http://weblogs.java.net/blog/marinasum/) show how OpenSSO's REST-based identity services can be put to use in integrating a sample Java web application 'directly' with OpenSSO, without deploying a policy agent. This approach was used in [Prashant's integration of Liferay with OpenSSO](http://blogs.sun.com/pdblog/entry/opensso_and_liferay_integration), [which also works in WebSynergy](http://blogs.sun.com/identityfever/entry/opensso_and_websynergy). While the policy agent is a great solution for SSO-enabling existing web apps, the REST mechanism allows you to build OpenSSO support right into an app so it works 'out of the box' with no additional components.
*   In '[Integrating Applications With OpenSSO](http://developers.sun.com/identity/reference/techart/app-integration.html)', [Tatsuo](http://blogs.sun.com/tkudo/), Aravindan and Marina cover integration with OpenSSO via policy agents, reverse proxies, the client SDK, and identity services. There's a great worked example of integrating Ruby on Rails with OpenSSO, applying OpenSSO's identity services beyond the world of Java.
*   As if that wasn't enough, there have been a couple more articles in the 'From the Trenches at Sun Identity' series. In her fifth interview with OpenSSO folks, Marina (does she never sleep?) talks to OpenSSO senior product manager [Nick Wooler](http://blogs.sun.com/nickwooler/) on [Support for OpenSSO](http://developers.sun.com/identity/reference/techart/opensso-support.html), explaining how customers can now buy support for OpenSSO via [OpenSSO Express](http://wikis.sun.com/display/OpenSSO/Sun+OpenSSO+Express). Interview number six has the almost-as-ubiquitous-as-Marina Aravindan Ranganathan on [Identity Services for Securing Web Applications](http://developers.sun.com/identity/reference/techart/identity-services.html). Can you tell that identity services are a big focus for OpenSSO right now? ![](http://blogs.sun.com/images/smileys/wink.gif)

Lots to catch up with there! To stay current, you can subscribe to a feed of identity management goodness from Sun Developer Network - [just point your feed reader here](http://feeds.feedburner.com/IdentityManagementHeadlines).