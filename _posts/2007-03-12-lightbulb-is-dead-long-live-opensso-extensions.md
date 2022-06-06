---
author: user
title: Lightbulb is Dead; Long Live OpenSSO Extensions!
slug: lightbulb-is-dead-long-live-opensso-extensions
id: 557
date: '2007-03-12 09:15:24'
layout: single
categories:
  - OpenSSO
---

[<span style="margin: 5px; float: right;">![](https://opensso.dev.java.net/public/extensions/openssoex.gif)</span>](https://opensso.dev.java.net/public/extensions/)

Last October, [we released the first SAML 2.0 implementation in PHP](http://blogs.sun.com/superpat/entry/switching_on_the_lightbulb), codenamed 'Project Lightbulb' (because Lightbulb fits into LAMP) and a sub-project of [OpenSSO](https://opensso.dev.java.net/). In the few months since then, other folks have [proposed](https://opensso.dev.java.net/servlets/ReadMsg?list=dev&msgNo=207) [similar](https://opensso.dev.java.net/servlets/ReadMsg?list=dev&msgNo=210) [extensions](https://opensso.dev.java.net/servlets/ReadMsg?list=dev&msgNo=209) to OpenSSO, and the 'Lightbulb' name has looked increasingly anachronistic, particularly since the core OpenSSO project has _always_ fully supported LAMP with its [Apache HTTP Server and Tomcat policy agents](https://opensso.dev.java.net/public/agents.html).

Today, we launch [OpenSSO Extensions](https://opensso.dev.java.net/public/extensions/), OpenSSO's code incubator, with three initial modules:

*   The [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20)/PHP relying party formerly known as Project Lightbulb
*   An [OpenID](http://openid.net/) Identity Provider for OpenSSO, contributed by long-time OpenSSO committer, [Paul Bryan](http://pbryan.net/)
*   A PHP Client SDK for OpenSSO, contributed by [Francesco Chicchiriccò](http://chicchiricco.freezope.org/)

So - what is an OpenSSO Extension? Well, it's any piece of code that either

*   extends OpenSSO to provide new functionality, for example, the OpenID identity provider, or
*   interfaces with OpenSSO, extending other systems, such as the PHP Client SDK and SAML 2.0 relying party.

If you have an idea for extending OpenSSO in an interesting way, then [click here to participate!](https://opensso.dev.java.net/servlets/ProjectMembershipRequest)