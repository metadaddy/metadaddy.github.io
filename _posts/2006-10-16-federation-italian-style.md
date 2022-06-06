---
author: user
title: Federation - Italian Style
slug: federation-italian-style
id: 626
date: '2006-10-16 15:45:20'
layout: single
categories:
  - Federation
---

[<span style="margin: 10px; float: right;">![](images/auto.gif)</span>](http://sun.feedroom.com/?fr_story=fee7572ca1cfabb6d7f7a347a433ff54ecc7b81f)

Somehow, this passed me by back in March/April, but a presentation at Sun's [Customer Engineering Conference](http://www.zvents.com/events/show/310076) last month brought it back into focus - Italy's [Ministry of Transportation](http://www.infrastrutturetrasporti.it/) has deployed a new [Motorist Portal](http://www.ilportaledellautomobilista.it/), providing services such as online payment of vehicle registration fees and traffic tickets.

What's interesting here is that drivers log in to the Motorist Portal to view their driving record, vehicle registration etc, but make payments via another government agency, [Poste Italiane](http://www.poste.it/). The Motorist Portal acts as a [SAML](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security) identity provider, with [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) authenticating users and providing single sign-on to Poste Italiene's service provider for 40 million Italian drivers - possibly one of the biggest live SAML deployments in the world.

You can find out more in this [short SunTV presentation](http://sun.feedroom.com/?fr_story=fee7572ca1cfabb6d7f7a347a433ff54ecc7b81f) and the [Italian press release](http://it.sun.com/sunnews/press/2006/sunflash-27-03-06.html) ([English translation via Google](http://translate.google.com/translate?u=http%3A%2F%2Fit.sun.com%2Fsunnews%2Fpress%2F2006%2Fsunflash-27-03-06.html&langpair=it%7Cen&hl=en&ie=UTF8)).