---
author: user
title: Recently Asked Questions on OpenSSO
slug: recently-asked-questions-on-opensso
id: 629
date: '2006-09-21 10:37:47'
layout: single
categories:
  - OpenSSO
---

[<span style="margin-bottom: 10px; margin-top: 10px; float: right;">![](https://opensso.dev.java.net/images/logo.gif)</span>](https://opensso.dev.java.net/)

[OpenSSO](https://opensso.dev.java.net/) is really taking off now - the number of participants continues to grow daily, we've had some really interesting discussions on the [IRC channel](http://blogs.sun.com/superpat/entry/irc_channel_for_opensso), and [folks around the world are writing their own how-to guides](https://opensso.dev.java.net/public/about/articles/index.html).

A couple of related questions have arisen recently: "How, exactly, are [OpenSSO](https://opensso.dev.java.net/), [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) and [Federation Manager](http://www.sun.com/software/products/federation_mgr/index.xml) related?" and "Can I get support on OpenSSO?". These questions are _almost_ answered in the [OpenSSO FAQ](https://opensso.dev.java.net/public/about/faqcenter/faqoverview.html) - I'll provide full answers here and push them into the FAQ for future reference.

<a name="Q1"></a>**Q1: How, exactly, are OpenSSO, Access Manager and Federation Manager related?**

OpenSSO is based on the Access Manager 7.0 codebase. There are some changes - for example, Access Manager contains some third party source code which we cannot redistribute - but we have worked to minimize these. The next versions of Federation Manager and Access Manager will be built from the OpenSSO source - just like [Sun Java System Application Server](http://www.sun.com/software/products/appsrvr/index.xml) is built from the [Glassfish](https://glassfish.dev.java.net/) source. When we are happy that OpenSSO contains the features we want to release in the next AM/FM product release, we will branch the code and stabilise the release branch - all in public. New feature development can continue on the trunk, and fixes in the release branch will be copied to the trunk.

<a name="Q2"></a>**Q2: Can I get support on OpenSSO?**

The short answer is "No." Sun will support Access Manager and Federation Manager, which will, as noted above, be built from the OpenSSO source. However, we [never say never](http://imdb.com/title/tt0086006/). If there is sufficient demand, we will consider other support offerings.

The best place for follow-up discussion on these topics is the OpenSSO users mailing list ([click here](https://opensso.dev.java.net/servlets/ProjectMailingListList), login and scroll down to the users@opensso.dev.java.net to subscribe), but feel free to leave [comments here](http://blogs.sun.com/superpat/entry/recently_asked_questions_on_opensso#comments) also.

<a name="Q3"></a>**Q3: Is opensso exactly same as Sun AM 7.1 from end user perspective? Can I use all Sun AM 7.1 beta docs for OpenSSO? If there are differences, what are they?** (Added 12/8/2006)

Right now (Dec 8 2006), there are some deltas between AM 7.1 and OpenSSO. Due to schedules and logistics, work on AM 7.1 and OpenSSO proceeded in parallel. We are porting all AM 7.1 features and fixes to OpenSSO right now. For the most part, you can use AM 7.1 beta docs, but there are some differences:

*   [Policy Agent 2.2 for Web Services](http://docs.sun.com/app/docs/doc/819-6717). To be added to OpenSSO.
*   [Java Management Extensions](http://java.sun.com/javase/technologies/core/mntr-mgmt/javamanagement/) (JMX) support. To be added to OpenSSO.
*   There is no federation console in the Open Federation build of OpenSSO, although all federation features are present and configurable from the command line. We are migrating the entire console from [JATO](http://developers.sun.com/sw/tech/appserver/framework/index.html) (Sun's previous, proprietary web application framework) to [JavaServer Faces](http://java.sun.com/javaee/javaserverfaces/) (JSF) - the federation console will be the first to move over.
*   Numerous minor bug fixes and RFEs. To be added to OpenSSO.