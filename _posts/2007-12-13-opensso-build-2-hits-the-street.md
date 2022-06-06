---
author: user
title: OpenSSO Build 2 Hits The Street!
slug: opensso-build-2-hits-the-street
id: 462
date: '2007-12-13 23:00:19'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/images/logo.gif)](https://opensso.dev.java.net/)</span>

[OpenSSO](http://opensso.org) v1 Build 2 hit the wire this morning ([CET](http://en.wikipedia.org/wiki/Central_European_Time)) - you can grab the binaries for OpenSSO itself and the new agents (see below) at the [OpenSSO download page](https://opensso.dev.java.net/public/use/index.html).

[Here's a full list of fixes in build 2](https://opensso.dev.java.net/issues/buglist.cgi?Submit+query=Submit+query&component=opensso&issue_status=RESOLVED&resolution=FIXED&version=current&target_milestone=FAM-8.0-build-2&email1=&emailtype1=exact&emailassigned_to1=1&email2=&emailtype2=exact&emailreporter2=1&issueidtype=include&issue_id=&changedin=&votes=&chfieldfrom=&chfieldto=Now&chfieldvalue=&short_desc=&short_desc_type=fulltext&long_desc=&long_desc_type=fulltext&issue_file_loc=&issue_file_loc_type=fulltext&status_whiteboard=&status_whiteboard_type=fulltext&field0-0-0=noop&type0-0-0=noop&value0-0-0=&cmdtype=doit&order=Issue+Number), but the two highlights are:

*   [Issue 1093](https://opensso.dev.java.net/issues/show_bug.cgi?id=1093): Server configuration is now consolidated into the directory-based configuration system and exposed via the admin console and CLI - previously, several configuration parameters were set in the AMConfig.properties file. AMConfig.properties now contains the minimum information required to start OpenSSO.
*   [Issue 1099](https://opensso.dev.java.net/issues/show_bug.cgi?id=1099), [issue 1103](https://opensso.dev.java.net/issues/show_bug.cgi?id=1103): configuration for Java EE and web agents respectively is also now consolidated into the central configuration system. Previously, all agent configuration was via a properties file on the local file system - now all configuration can be centrally stored and managed via the admin console.

So... [go grab the new bits](https://opensso.dev.java.net/public/use/index.html) and work through [Michael](http://blogs.sun.com/docteger/)'s [quick install guide](http://blogs.sun.com/docteger/entry/installing_opensso_buld_2). Think of it as an early Christmas present ![](http://blogs.sun.com/images/smileys/smile.gif)