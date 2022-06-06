---
author: user
title: OpenSSO Tab Sweep - Mar 27 2009
slug: opensso-tab-sweep-mar-27-2009
id: 283
date: '2009-03-27 16:51:47'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/images/logo.gif)](http://opensso.org/)</span>

As always, a bumper crop of [OpenSSO](http://opensso.org/) news from the last couple of weeks...

*   One piece of advice I often give to people wrestling with tricky issues relating to redirects and cookies is to download the [LiveHTTPHeaders](http://livehttpheaders.mozdev.org/) Firefox plugin, or its IE equivalent [ieHTTPHeaders](http://www.blunck.se/iehttpheaders/iehttpheaders.html). In [Troubleshooting OpenSSO with Firefox Add-Ons](http://developers.sun.com/identity/reference/techart/troubleshooting.html), [Jim Faut](http://blogs.sun.com/jimfaut/) and [Rick Palkovic](http://blogs.sun.com/rikart/) explain just how to use LiveHTTPHeaders _and_ [HackBar](https://addons.mozilla.org/en-US/firefox/addon/3899), which is a new one on me. Where LiveHTTPHeaders gives you detail on the HTTP requests and responses flying back and forth, HackBar lets you drill into the associated data, removing layers of URL and Base64 encoding from URL parameters and HTTP headers. Jim and Rick get right into the detail of the OpenSSO login process, using the tools to uncover what is really going on. A great read for anyone wanting to go under the covers of OpenSSO.
*   One that got away from me here on [Superpatterns](http://blog.superpat.com/), though Eduardo covered it at [The Aquarium](http://blogs.sun.com/theaquarium/) - [Sidharth Mishra](http://blogs.sun.com/sid/), OpenSSO Technical Product Manager and Ajay Sondhi, OpenSSO Deployment Engineering Manager, presented a webinar last week covering [OpenSSO - Overview, Stories and Roadmap](http://wikis.sun.com/display/TheAquarium/OpenSSO+-+Overview%2C+Stories+and+Roadmap) last week as part of [The Aquarium Channel](http://wikis.sun.com/display/TheAquarium/GlassFishDotTV). Ajay's section includes details of the [Verizon Wireless deployment I've mentioned before](http://blog.superpat.com/2009/02/18/verizon-wireless-on-improving-security-and-user-experience-with-sun-access-manager/), so this is well worth investigating if you're interested in ultra high-scale OpenSSO deployments.
*   We just got done with [CommunityOne East](http://developers.sun.com/events/communityone/2009/east/index.jsp), last week in New York City, [CommunityOne West](http://developers.sun.com/events/communityone/2009/west/index.jsp) will run alongside [JavaOne](http://java.sun.com/javaone/) in San Francisco in June, but did you know about [CommunityOne **North**](http://se.sun.com/sunnews/events/commmunityone/)? On April 15th, CommunityOne comes to the [Folketeatret](http://no.wikipedia.org/wiki/Folketeatret) in Oslo, Norway. Flying the flag for OpenSSO will be Jonathan Scudder, a consulting identity architect, with a session on Developing Secure Web Services for the Cloud. More details at the [Community One North Content Catalog](http://wikis.sun.com/display/CommunityOne/CommunityOneNorthAgenda) - Jonathan's session is at 13:00 in Breakout 1\.
*   While we're 'out in the community', [Qingfeng Zhang](http://qingfeng-syd.blogspot.com/), a Senior Java Developer at the [University of New South Wales](http://www.unsw.edu.au/), Australia, has posted a video showing how to [install and configure OpenSSO on Tomcat on Windows](http://qingfeng-syd.blogspot.com/2009/03/installation-opensso-enterprise-80-on.html). I know folks often stumble when deploying OpenSSO on Tomcat, since, compared to GlassFish, [there are a couple of additional steps required](http://docs.sun.com/app/docs/doc/820-3320/ggwyv?a=view). Qingfeng's video clearly shows how to get it done.
*   Back at Sun, [Metro](https://metro.dev.java.net/) supremo [Harold Carr](http://weblogs.java.net/blog/haroldcarr/) presented at the [Utah Java Users Group](http://www.ujug.org/web/) last week on Metro, [Jersey](https://jersey.dev.java.net/), [GlassFish](https://glassfish.dev.java.net/), [OpenESB](https://open-esb.dev.java.net/) and OpenSSO - a real whirlwind tour, particularly since he only had a 20 minute slot! Harold has [posted slides, plus Q&A and other notes from the session](http://weblogs.java.net/blog/haroldcarr/archive/2009/03/notesslides_fro_1.html).
*   Finally, [DocTeger](http://blogs.sun.com/docteger/) has rewritten Chapter 11 of the [Sun OpenSSO Enterprise 8.0 Technical Overview](http://docs.sun.com/app/docs/doc/820-3740): [Choosing a Federation Option](http://docs.sun.com/app/docs/doc/820-3740/adrcy?a=view). The new version is much clearer on the relative positions of the various federation protocols - use SAML 2.0 where possible, WS-Federation if you really need to integrate with ADFS, and SAML 1.1 or Liberty ID-FF only if you're connecting to partners with no SAML 2.0 capability. Great job, Michael!

That wraps things up for another week - I'm off to jump in the [Patmobile](http://blog.superpat.com/BlackC4Cab06.jpg) and brave [101](http://en.wikipedia.org/wiki/U.S._Route_101_in_California#San_Francisco_Bay_Area). See you next time!