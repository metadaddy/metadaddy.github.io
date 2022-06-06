---
author: user
title: XACML and SAML - a Match Made in... 2005
slug: xacml-and-saml-a-match-made-in-2005
id: 290
date: '2009-02-27 17:00:14'
layout: single
categories:
  - Federation
---

<span style="margin: 5px; float: right;">[![](images/0227kearns01.jpg)](http://www.networkworld.com/newsletters/dir/index.html)</span>

Over at [NetworkWorld](http://www.networkworld.com/)'s [Security: Identity Management Alert](http://www.networkworld.com/newsletters/dir/index.html), [Dave Kearns](http://vquill.com/) weighs in on the ongoing federated provisioning debate with [Federated provisioning could exist](http://www.networkworld.com/newsletters/dir/2009/022309id2.html). While Dave is right to highlight the promise of the [Liberty Alliance](http://www.projectliberty.org/)'s [Identity Governance Framework](http://www.projectliberty.org/index.php/liberty/strategic_initiatives/identity_governance) (IGF), he is way off the mark regarding [XACML](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=xacml) and [SAML](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security). Dave writes:

> Some have suggested that XACML (eXtensible Access Control Markup Language) might be the answer. But it [...] suffers from the same problem as SPML (no interaction with SAML) [...]

This is patently not true! Four years ago, <a href-"http:="" www.oasis-open.org="" "="">OASIS</a> defined the interaction between XACML and SAML in [SAML 2.0 profile of XACML v2.0 [PDF]](http://docs.oasis-open.org/xacml/2.0/access_control-xacml-2.0-saml-profile-spec-os.pdf), part of the [XACML 2.0 specification set](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=xacml#XACML20). Since then, SAML/XACML has been implemented in a range of products, including [Sun OpenSSO Enterprise](http://www.sun.com/software/products/opensso_enterprise/index.xml), with interoperability between _seven_ vendors' products demonstrated at the [OASIS XACML Interop Demo](http://www.oasis-open.org/events/xacml-interop-2008/) (held at the RSA Conference, April 2008).

XACML and SAML, best buddies since February 2005 :-)