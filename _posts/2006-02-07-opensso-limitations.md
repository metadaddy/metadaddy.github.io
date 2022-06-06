---
author: user
title: OpenSSO Limitations?
slug: opensso-limitations
id: 710
date: '2006-02-07 04:43:39'
layout: single
categories:
  - OpenSSO
---

'[Marty](http://blogs.opml.org/marty/)' (I'm guessing this is Marty Heyman of [Symas](http://www.symas.com/)) has posted an [entry regarding OpenSSO](http://blogs.opml.org/marty/2006/02/03). I can't see a way to post comments or respond in any way on Marty's blog, so I'll do so here. Marty says

> [...] [OpenSSO](https://opensso.dev.java.net/) ... from the same blog ... Web SSO, Of Course. You knew that.It's a centrally controlled service that creates and mainains a verifiable user session and creates an audit trail. Applications use the central service to verify that the user is in session and to report audit events [from the [architecture](https://opensso.dev.java.net/files/documents/3676/19701/architecture.pdf) document).
> 
> Let's see, you have to modify every app to use the service, like that's going to happen, and you're going to introduce another single point of failure server.

If you read a little more of the linked architecture document, you will discover that OpenSSO uses agents to SSO enable web containers. The agent is essentially a filter that refers to the central service to determine the user's identity and whether she should be given access to the requested resource. Section 4 of the [architecture](https://www.dev.java.net/files/documents/3676/19701/architecture.pdf) describes this in the context of OpenSSO. The reference to 'applications' as well as agents recognizes that _any_ application accessed via HTTP can participate in SSO. So yes, if you have a custom HTTP app, you'll have to do some enabling. If your app runs in a web container you just have to deploy and configure an agent. Access Manager (OpenSSO's 'parent product') provides [agents for a huge variety of containers](http://www.sun.com/download/index.jsp?cat=Identity%20Management&tab=3&subcat=Access%20Manager). We will be releasing the code for a couple of agents into OpenSSO in March.

Marty goes on to say

> Under _Limited scope of SSO_ we find "web applications that are hosted on servers that do not reside in the domain of OpenSSO services deployment will not be able to participate in SSO" .... a small and probably disqualifying limitation. Children and their toys.

I would hardly describe OpenSSO as a toy - it is based on [Sun's Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml). OpenSSO provides SSO across systems in a single domain, so you could SSO across www.example.com, www.subdomain.example.com, hr.example.com etc. This limitation is a consequence of the cookie-based implementation that OpenSSO uses - cookies only work within a single internet domain. To cross domains to, say, www.partner.com, you need [federation](http://blogs.sun.com/roller/page/superpat?entry=what_is_federation). Federation capability is not currently in the OpenSSO roadmap.