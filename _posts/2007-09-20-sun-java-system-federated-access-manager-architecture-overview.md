---
author: user
title: Sun Java System Federated Access Manager Architecture Overview
slug: sun-java-system-federated-access-manager-architecture-overview
id: 490
date: '2007-09-20 23:00:41'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right; border-style: solid; border-width: 1px; border-color: silver">[![](http://wikis.sun.com/download/attachments/6456057/overallarch.JPG)](http://wikis.sun.com/display/openssoFAM/FAM+Architecture+Overview)</span>

The eagle eyed amongst you might have [noticed](http://rnd.feide.no/2007/08/09/saml-20-php-idp-interoperability-testing/) [references](https://opensso.dev.java.net/public/use/index.html) to something called Sun Java System Federated Access Manager 8.0\. Simply stated, we are bringing together the [Access Manager](http://www.sun.com/software/products/access_mgr/) and [Federation Manager](http://www.sun.com/software/products/federation_mgr/) products in the next version, together with some exciting new features. I'll leave it to [Daniel](http://blogs.sun.com/raskin/) to bring you the full product roadmap story, but I will stress this important point: <span style="font-weight: 800">FAM 8.0 will be</span> [<span style="font-weight: 800">OpenSSO</span>](http://opensso.dev.java.net/); that is, the commercial product will be built from, and identical to, OpenSSO, in exactly the same way that [Sun Java System Application Server 9.1](http://www.sun.com/software/products/appsrvr/appsrvr9_1.xml) is built from, and identical to, [Glassfish](https://glassfish.dev.java.net/) v2\.

As part of this process, fellow architect and occasional blogger [Rajeev Angal](http://blogs.sun.com/rangal/) has writted an excellent overview of the [OpenSSO/Federated Access Manager architecture](http://wikis.sun.com/display/openssoFAM/FAM+Architecture+Overview) on the new [Federated Access Manager wiki](http://wikis.sun.com/display/openssoFAM/Home).

The architecture document moves from a 30,000 ft 'elevator pitch' (now there's an interesting mixed metaphor!) to detail the various FAM services, extension points and dependencies. Absolutely required reading for anyone working with OpenSSO, Access Manager and Federation Manager or looking forward to the upcoming Federated Access Manager - [OpenSSO/Federated Access Manager architecture](http://wikis.sun.com/display/openssoFAM/FAM+Architecture+Overview)