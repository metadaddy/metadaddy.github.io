---
author: user
title: InfoCard and Minimal Disclosure
slug: infocard-and-minimal-disclosure
id: 583
date: '2007-01-15 08:05:16'
layout: single
categories:
  - Identity
---

[I would have left this as a comment on [Kim's blog](http://www.identityblog.com/), but I don't have an InfoCard handy and I can't figure out how to register there for a good old username and password...]

[Kim Cameron](http://www.identityblog.com/) [replies to a question from Eric Schultz](http://www.identityblog.com/?p=651) with a description of how InfoCard (or is it CardSpace?) handles minimal disclosure, allowing the relying party to request only the information it needs. In Kim's example, the relying party requests four claims regarding the user via an OBJECT tag:

![](http://www.identityblog.com/wp-content/images/2007/01/object.jpg)

Then, according to Kim,

> If, next time, the relying party doesn’t want to receive these claims, it just doesn’t ask for them. If it has stored them, it should be able to retrieve them when necessary by using ”privatepersonalidentifier” as a handle. This identifier is just a random pairwise number meaningless to any other site, and so there is no identity risk in using it.

But, but, but... how does the relying party _know_ not to ask for givenname, surname and emailaddress the second (and subsequent) time round? It doesn't know that it's already collected those claims for that user, since it doesn't know who the user is yet...

If only there were some [specification [PDF]](http://www.projectliberty.org/liberty/content/download/1028/7146/file/liberty-idsis-pp-v1.1.pdf) (perhaps part of some sort of [framework](http://www.projectliberty.org/resource_center/specifications/liberty_alliance_id_wsf_1_1_specifications)) that, given a token from an authentication, allowed you to get the data you needed, [subject, of course, to the user's permission [another PDF]](http://www.projectliberty.org/liberty/content/download/1301/8268/file/liberty-idwsf-interaction-svc-v1.1.pdf) :-)