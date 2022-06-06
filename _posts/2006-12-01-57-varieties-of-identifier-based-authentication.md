---
author: user
title: 57 Varieties of Identifier-based Authentication
slug: 57-varieties-of-identifier-based-authentication
id: 601
date: '2006-12-01 12:33:29'
layout: single
categories:
  - Identity
---

<span style="margin: 5px; float: right;">![](http://www.heinz.com/images/fiftysevenlogo.gif)</span>

[Johannes](http://netmesh.info/jernst/) posts about the ongoing work on exploring the synergies between [SAML](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) and [OpenID](http://openid.net/) in an entry titled [Eve and Pat, SAML and OpenID](http://netmesh.info/jernst/Comments/eve-maler-identifiers2.html). It's worth reading to get an idea of just how things are coming together. One correction, though, Johannes - you give a table of identifier-based authentication flavours, but you left an important one out. Here is a fuller version:

*   with OpenID Authentication (which is light-weight, Diffie-Hellman key exchange-based)
*   with LID/GPG Authentication (which is light-weight, public key-based)
*   [with SAML 'Lightweight' (which is only a little bit heavier and uses a simple 'blob' signature)](http://identitymeme.org/archives/2006/10/26/latest-revisions-of-saml-lsso-and-simplesign-specs/)
*   with SAML (which is a bit heavier and uses XML Signatures)

Of course, the magic of Yadis makes this all very transparent to the user, but, I wonder, how do IdPs and SPs decide which flavour _they_ prefer?