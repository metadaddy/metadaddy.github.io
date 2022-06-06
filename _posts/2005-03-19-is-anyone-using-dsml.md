---
author: user
title: Is anyone using DSML?
slug: is-anyone-using-dsml
id: 795
date: '2005-03-19 11:08:21'
layout: single
categories:
  - Identity
---

Directory Services Markup Language (DSML) "bridges the world of directory services with the world of XML" (quote from [OASIS DSML page](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=dsml)). Effectively, it's an XML encoding of LDAP. Sun implemented it in Directory Server 5.2 way back in June 2003, in common with other directory server vendors ([Novell](http://developer.novell.com/dsml/), [Microsoft](http://www.microsoft.com/windows2000/server/evaluation/news/bulletins/dsml.asp)).  
The question is, is _anybody_ using it? I've never heard of a DSML client in production, and, in my unofficial popularity poll, Google shows [only 115,000 hits](http://www.google.com/search?hl=en&lr=&c2coff=1&q=dsml&btnG=Search) for DSML, compared to [over 7 million](http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=ldap&btnG=Google+Search) for LDAP.  
So - has anybody implemented DSML from the client side? And if not, why not?