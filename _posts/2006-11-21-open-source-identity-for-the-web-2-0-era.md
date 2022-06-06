---
author: user
title: Open Source Identity for the Web 2.0 Era
slug: open-source-identity-for-the-web-2-0-era
id: 604
date: '2006-11-21 14:44:53'
layout: single
categories:
  - OpenSSO
---

[<span style="margin-bottom: 10px; margin-top: 10px; float: right;">![](http://projectliberty.org/design/liberty/images/libertylogo.jpg)</span>](http://projectliberty.org/news_events/events/open_source_identity_for_the_web_2_0_era)

Regular readers might recall [I gave a presentation in Japan last month](http://blogs.sun.com/superpat/entry/liberty_alliance_day_tokyo_oct) titled 'Open Source Identity for the Web 2.0 Era'. The [Liberty Alliance](http://projectliberty.org/) folks liked it so much, they've asked me to repeat it as a webcast next Wednesday - 11/29/2006 - [details here](http://projectliberty.org/news_events/events/open_source_identity_for_the_web_2_0_era) (if you're interested, better sign up fast, places are limited!).

The presentation focuses on [OpenSSO](https://opensso.dev.java.net/) and [Project Lightbulb](http://blogs.sun.com/superpat/entry/switching_on_the_lightbulb) - the OpenSSO sub-project that implements a [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) service provider in straight [PHP](http://php.net) - no custom extensions required. I'm planning to SAML 2.0-enable a simple PHP application, live on-the-air, no safety net ![](http://blogs.sun.com/images/smileys/surprised.gif)

[Johannes](http://netmesh.info/jernst) has already picked up on the webcast announcement and [wonders what the Web 2.0 angle is](http://netmesh.info/jernst/Comments/pat-patterson-opensso-webcast.html). Let me explain...

Web 2.0 is a difficult term; it means something different to almost everyone you ask. Some focus on particular technologies - [Ajax](http://www.adaptivepath.com/publications/essays/archives/000385.php) (just pasted that link in - do you realize, that essay, that coined the term 'Ajax', is only 21 months old!) being the most common example. Others focus on particular companies - [Flickr](http://flickr.com), [YouTube](http://youtube.com), any number of social networking sites - or business models - for example, combining your users' individual efforts to create something bigger than the sum of their parts.

For me, 'Web 2.0' is simply a shorthand for 'the Web today is very different from the Web of 5 years ago'. It's a whole world of change wrapped into a somewhat glib phrase. The Tokyo Liberty Alliance Day took Web 2.0 as its theme - my angle on it with this presentation is that a large part of Web 2.0 is [participation](http://blogs.sun.com/superpat/entry/not_just_a_spectator_sport) - notably open source and lightweight languages - look at any 'Web 2.0 company' and you'll find lots of [LAMP](http://en.wikipedia.org/wiki/LAMP_(software_bundle)). It's this aspect that I focus on in 'Open Source Identity for the Web 2.0 Era' - bridging the gap between the enterprise/telco/square world of SAML 2.0 and the bloggy/scripty/hip world of PHP.

Having said all that, Johannes is spot on that "putting control in the hands of the end user — the essence of Web 2.0 — is not typically compatible with the way SAML projects tend to end up". There is much work to do in figuring out how the core of SAML 2.0 can be leveraged in wider settings than the typical (but no less important for that) enterprise/telco use cases. We're seeing some great thinking in this area from the likes of [Paul](http://connectid.blogspot.com/) and [Eve](http://www.xmlgrrl.com/blog/). I suspect that this will be a key topic of the upcoming [Internet Identity Workshop 2006b](http://www.windley.com/events/iiw2006b/announcement).