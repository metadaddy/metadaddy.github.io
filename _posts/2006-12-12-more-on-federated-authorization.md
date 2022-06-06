---
author: user
title: More on Federated Authorization
slug: more-on-federated-authorization
id: 591
date: '2006-12-12 11:02:42'
layout: single
categories:
  - Federation
---

[Conor](http://conorcahill.blogspot.com/2006/12/federated-identity-and-federated.html) and [Paul](http://connectid.blogspot.com/2006/12/was-this-script.html) both recently responded to [James'](http://duckdown.blogspot.com/) [questions on federated authorization](http://blogs.sun.com/superpat/entry/yadis%2Fxri_identifier_resolution_with_saml#comment1). Conor quite rightly pointed out that I managed to describe two common scenarios involving federation and authorization without explicitly answering the question - "Does Federated Identity sometimes require Federated Authorization?". As much as it pains me, I have to agree with Conor here - federated identity _per se_ does not require federated authorization - rather, the resource owner might require it. It all depends on the use case that you're implementing.

James also alerted me this morning to a [very interesting post from Shekhar Jha](http://identityaccessmanagement.blogspot.com/2006/12/federated-authorization-and.html). I'll have to take the time to read the [SecPAL paper](ftp://ftp.research.microsoft.com/pub/tr/TR-2006-120.pdf) properly, and, even then, there are [people far better qualified than me](http://research.sun.com/people/mybio.php?uid=74233) to comment on this, but it does look interesting - particularly the fact that there is a natural language-like, non-XML syntax.

Shekhar goes on to discuss relationships in the identity domain. I refer Shekhar to the excellent work done by Paul on the People Service - [FAQ](http://www.projectliberty.org/liberty/resource_center/faq/people_service__1), [white paper [PDF]](http://www.projectliberty.org/liberty/content/download/387/2720/file/Liberty_Federated_Social_Identity.pdf), [specification [PDF]](http://www.projectliberty.org/liberty/content/download/890/6246/file/liberty-idwsf-people-service-v1.0.pdf). This seems to map neatly onto what Shekhar is saying.