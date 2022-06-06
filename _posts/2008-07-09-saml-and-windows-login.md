---
author: user
title: SAML and Windows Login
slug: saml-and-windows-login
id: 387
date: '2008-07-09 06:28:54'
layout: single
categories:
  - Federation
---

<span style="margin: 5px; float: right;">[![](http://images.cafepress.com/product/20273824_240x240_Front.jpg) ](http://duckdown.blogspot.com/2008/07/how-come-folks-only-use-saml-in-server.html)</span> 

[Interesting post](http://duckdown.blogspot.com/2008/07/how-come-folks-only-use-saml-in-server.html) from [James](http://duckdown.blogspot.com/) on the possibilities of Windows desktop systems being [SAML](http://www.oasis-open.org/committees/security/) identity providers (IdPs). Currently, a similar mechanism exists for desktop single sign-on from Windows (via [SPNEGO](http://msdn.microsoft.com/en-us/library/ms995329.aspx), using Kerberos tokens, which, by the way, [OpenSSO](http://opensso.org/) and [Access Manager](http://www.sun.com/software/products/access_mgr/) support directly, no IIS 'bounce' required), but this is limited to a single enterprise's AD infrastructure and can be pretty tricky to deploy. It's easy to imagine IE submitting SAML assertions to service providers at Internet scale in the way James describes. [Microsoft seem to be reconsidering the case for supporting SAML 2.0](http://www.networkworld.com/news/2008/030408-microsoft-directory-team-standards.html), so they may even be receptive to something like this.

Where James does get things twisted (to use one of his favorite expressions :-) ) is in imagining that Sun and Oracle have much influence on our friends in Redmond. Microsoft's paying customers have MUCH more clout than their competitors/partners. I'd suggest, James, that you band together with your peers at enterprises such as GM and Boeing, who I know, from their participation in [Concordia](http://projectconcordia.org/), have very similar desires. Heck, you could even roll up your sleeves and dive right in to Concordia - it's free, very enterprisey and Microsoft participate with open ears...