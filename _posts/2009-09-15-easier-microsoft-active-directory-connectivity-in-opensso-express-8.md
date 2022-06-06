---
author: user
title: Easier Microsoft Active Directory Connectivity in OpenSSO Express 8
slug: easier-microsoft-active-directory-connectivity-in-opensso-express-8
id: 250
date: '2009-09-15 14:06:53'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](images/ADConfig.png)](https://opensso.dev.java.net/public/use/index.html)</span> It's nice to see your RFE's implemented, and that's exactly what happened with [OpenSSO issue # 4053: _Active Directory configuration should use AD domain name rather than LDAP host/port_](https://opensso.dev.java.net/issues/show_bug.cgi?id=4053). I saw [Kohsuke](http://weblogs.java.net/blog/108)'s blog entry on [More Active Directory integration in Java](http://weblogs.java.net/blog/kohsuke/archive/2008/06/more_active_dir.html) a little while ago and realized that we could take exactly the same approach in [OpenSSO](http://opensso.org/) - prompt the admin for the Active Directory domain name rather than a host name and port number. As Kohsuke mentions, this has a number of advantages - every AD admin knows the domain name, while many would likely have to go look up an individual host name, not to mention the LDAP port number. Since we use the domain name to look up an individual AD controller via DNS, it also means that the admin doesn't need to update OpenSSO's configuration as AD controllers come and go - OpenSSO will always get a valid host name from DNS. So, when configuring OpenSSO Express 8, you can now just specify the AD domain name. As improvements go, this one is pretty small, but, as I think everyone agrees, the cumulative effect of all these little improvements in OpenSSO over the past two or three years has been HUGE...