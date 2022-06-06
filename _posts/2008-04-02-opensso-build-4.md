---
author: user
title: OpenSSO Build 4
slug: opensso-build-4
id: 425
date: '2008-04-02 09:58:53'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/images/logo.gif)](https://opensso.dev.java.net/)</span>

It seems like only two minutes since [Build 3, back in February](http://blogs.sun.com/superpat/entry/opensso_build_3), but [OpenSSO](http://opensso.org) v1 [Build 4 was released today](https://opensso.dev.java.net/servlets/ReadMsg?list=users&msgNo=2674). Binaries are available at the [OpenSSO download page](https://opensso.dev.java.net/public/use/index.html), here are the [release notes](http://download.java.net/general/opensso/stable/openssov1-build4/B4-ReleaseNotes.html).

So, what have we been working on?

*   **New OpenSSO configurator** - let us know what you think about the new configuration UI ([mailing lists are here](https://opensso.dev.java.net/servlets/ProjectMailingListList)).
*   **WS-Trust Security Token Service** (STS) is available on [Glassfish](http://glassfish.org/), [Sun Application Server](http://www.sun.com/software/products/appsrvr/), [Sun Web Server](http://www.sun.com/software/products/web_srvr/), Geronimo, Tomcat and WebSphere - we've done a lot of trickery with classloaders to get this working across a wide range of containers. We're still working on support in Oracle Application Server, JBoss and WebLogic Server.
*   **Simplified STS client sample**
*   **Configuration and/or user store** replication across multiple OpenSSO instances where the embedded instance of [OpenDS](http://opends.org/) is in use.
*   Security/SSL related fixes
*   General bug fixes in all areas

[Here's a full list of the more than 200 fixes in build 4](https://opensso.dev.java.net/issues/buglist.cgi?Submit+query=Submit+query&component=opensso&issue_status=RESOLVED&issue_status=VERIFIED&issue_status=CLOSED&version=current&target_milestone=FAM-8.0-build-4&email1=&emailtype1=exact&emailassigned_to1=1&email2=&emailtype2=exact&emailreporter2=1&issueidtype=include&issue_id=&changedin=&votes=&chfieldfrom=&chfieldto=Now&chfieldvalue=&short_desc=&short_desc_type=fulltext&long_desc=&long_desc_type=fulltext&issue_file_loc=&issue_file_loc_type=fulltext&status_whiteboard=&status_whiteboard_type=fulltext&field0-0-0=noop&type0-0-0=noop&value0-0-0=&cmdtype=doit&newqueryname=&order=Reuse+same+sort+as+last+time). Go update your CVS or [grab the binaries](https://opensso.dev.java.net/public/use/index.html) now and see how it works for you - and please, read the [release notes](http://download.java.net/general/opensso/stable/openssov1-build4/B4-ReleaseNotes.html) for container-specific installation instructions - in particular if you're using Tomcat. There are some changes to Tomcat's cookie handling in releases 5.5.26 and 6.0.16 that cause problems for this build of OpenSSO.