---
author: user
title: 'ADFS, WS-Federation and SAML in the enterprise'
slug: adfs-ws-federation-and-saml-in-the-enterprise
id: 722
date: '2005-12-09 10:42:48'
layout: single
categories:
  - Federation
---

[James McGovern](http://duckdown.blogspot.com/) left an interesting [comment](http://blogs.sun.com/roller/page/superpat?entry=update_on_ws_federation_saml#comment1) on my [previous entry](http://blogs.sun.com/roller/page/superpat?entry=update_on_ws_federation_saml) concerning WS-Federation and SAML 2.0\.

James says

> A customers perspective is slightly different than what you suggest in your posting. MS is doing the right things with WS-Federation. After all, if you consider that 99.9% of all Fortune enterprises and their B2B partners have AD installed, they would eliminate not only the need for SAML but for enterprises to buy yet another piece of software that really should be bundled with the OS in order to solve for problems across enterprises. Federated identity conversation is somewhat consumer focused. Would be great if participants could put on an enterprise lens when considering solutions....

Thanks for the comment, James. I think you're right, up to a point. Microsoft _is_ doing the right things, from the perspective of MS themselves and 'MS shops'. If you have a pure MS infrastructure, then WS-Federation and ADFS are great news. If you have a mixed environment, and some or all of your business partners have a mixed environment, then this is _good_ news, but it could have been so much better. After all, if MS had issues with the way SAML worked in their environment, they could have contributed to the SAML 2.0 process in OASIS and we would have had the 'grand convergence' of federation specs. But, for their own reasons, they chose not to engage there.

I spent Monday with one of our biggest enterprise customers. They have selected SAML 2.0 for web single sign-on across their various departments and divisions and with external partners. WS-Federation makes no sense for them as they have no MS SSO infrastructure - it's all Sun, IBM and Oracle (Oblix). In common with the 99.9% of Fortune enterprises you mention, they do have AD as a NOS directory, so ADFS support for WS-Federation rather than SAML just complicates their lives.

Leaving aside the question of whether federation technology _should_ be bundled with the OS, the fact is that Microsoft are only now beginning to fill the gaps in federation. They have chosen to do so using proprietary specifications (remember, WS-Federation is a _specification_, not a _standard_) rather than an existing open standard with wide adoption. It will be an interesting couple of years as enterprises make their choices. But again, choosing products using a common standard would have been so much better than having to bet on a spec.