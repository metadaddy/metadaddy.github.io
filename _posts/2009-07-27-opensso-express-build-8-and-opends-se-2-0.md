---
author: user
title: OpenSSO Express Build 8 and OpenDS SE 2.0
slug: opensso-express-build-8-and-opends-se-2-0
id: 262
date: '2009-07-27 15:27:41'
layout: single
categories:
  - Identity
---

<span style="margin: 5px; float: right;">[![](images/express8.png)](http://www.sun.com/aboutsun/pr/2009-07/sunflash.20090727.1.xml)</span>

Flashing through the ether this morning was a [press release](http://www.sun.com/aboutsun/pr/2009-07/sunflash.20090727.1.xml) covering [OpenSSO](http://opensso.org/) Express 8 and [OpenDS](http://opends.org) [SE 2.0](http://wikis.sun.com/display/sunopends/Home). Since OpenDS SE 2.0 was released a week or two ago, my colleague [Ludo Poitou](http://blogs.sun.com/ludo/) has documented its arrival and some of its new features in a series of blog posts:

*   [OpenDS 2.0 is here!](http://blogs.sun.com/Ludo/entry/opends_2_0_is_here)

*   [New in OpenDS 2.0: Recurrent and Scheduled Tasks](http://blogs.sun.com/Ludo/entry/new_in_opends_2_0)

*   [New in OpenDS 2.0: Monitoring in the Control Panel](http://blogs.sun.com/Ludo/entry/new_in_opends_2_01)

*   [New in OpenDS 2.0: I18N Collation Matching Rules](http://blogs.sun.com/Ludo/entry/new_in_opends_2_02)

*   [Assured Replication: A New Feature of OpenDS 2.0](http://blogs.sun.com/Ludo/entry/assured_replication_a_new_feature)

*   [Configuring Replication Groups: A small but important new feature of OpenDS 2.0](http://blogs.sun.com/Ludo/entry/configuring_replication_groups_a_small)

*   [OpenDS 2.0 on Mac OS X with the latest JVM](http://blogs.sun.com/Ludo/entry/opends_2_0_on_mac)

Ludo calls out [assured replication](http://blogs.sun.com/Ludo/entry/assured_replication_a_new_feature), an extension to the existing loose consistency multi-master replication feature that brings tighter consistency of data between replicas, as the biggest innovation in OpenDS 2.0; I know it's making an impact because, the very next day after OpenDS 2.0 was released I was approached by an attendee at the [Community Leadership Summit](http://www.communityleadershipsummit.com/) singing its praises!

Over in [OpenSSO](http://opensso.org/)-land, we're putting the finishing touches to OpenSSO Express Build 8, due for release in a couple of weeks time. This release will include [our new Mobile One Time Password feature](http://blogs.sun.com/raskin/entry/roadmap_preview_1x_password_w), [the Fedlet for .Net](http://blogs.sun.com/raskin/entry/opensso_enterprise_fedlet_for_net) and a new task flow for enabling single sign-on to Salesforce.com and a whole host of other goodies, so watch this space for its availability!

So, what's an Express Build? [Well, as I mentioned when we released OpenSSO Express Build 7](http://blog.superpat.com/2009/04/16/out-now-opensso-express-build-7/), back in April, Express Builds are supported 'snapshots' of development between full '[OpenSSO Enterprise](http://www.sun.com/software/products/opensso_enterprise/index.xml)' releases, allowing customers to get support on new features without waiting months for the full release. The key difference between Express builds and Enterprise builds is that fixes to Express builds are rolled into the next Express build, along with new features, while Enterprise builds have 'bug fix only' service packs and hot patches available for paying customers. Obviously, Express builds aren't for everybody, but we're finding that they work well for a lot of folks. [There's lots more information and a FAQ at the OpenSSO wiki](http://wikis.sun.com/display/OpenSSO/Sun+OpenSSO+Express).