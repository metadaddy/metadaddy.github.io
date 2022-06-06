---
author: user
title: More OpenSSO Goodness - Authentication Source and Demo
slug: more-opensso-goodness-authentication-source-and-demo
id: 712
date: '2006-02-03 14:23:10'
layout: single
categories:
  - OpenSSO
---

We hit another [OpenSSO](https://opensso.dev.java.net/) milestone earlier this week, opening up the Authentication Service ([announcement and instructions for getting it](https://opensso.dev.java.net/servlets/NewsItemView?newsItemID=3252)). A good place to start is probably the [Authentication Service Architecture document](https://opensso.dev.java.net/files/documents/3676/26172/auth_arch.pdf), but who ever reads the docs first? Download the source, build it, run the demo, think about how you can bend it to your needs.

Here's an exclusive snippet from an internal email from one of our QA engineers today (Hi Indira!). By the way, these are _really_ hard guys to impress...

> I have just validated the SSO token created by the opensso server using the demo app. It works just GREAT!! right now I have only good things to say
> 
> *   Compiled just in 49 secs on solaris 10 sparc
> *   Docs are pretty good
> *   Used 2 physical hosts
> *   Client and Server both are deployed on tomcat 5.5
> 
> Great work !!

If you haven't already got a java.net ID, here's a [handy link](https://www.dev.java.net/servlets/Join) to the registration page. If you already have an ID on java.net, you'll need to [join](https://opensso.dev.java.net/servlets/ProjectMembershipRequest) the project to post in the forums. (Thanks, [cmort](http://xmldap.blogspot.com/), for pointing out that this last constraint isn't entirely obvious on the site).