---
author: user
title: OpenSSO Build 4.5
slug: opensso-build-4-5
id: 391
date: '2008-07-05 04:02:36'
layout: single
categories:
  - OpenSSO
tags:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/images/logo.gif)](http://opensso.org/)</span>

It's been a while since [Build 4](http://blogs.sun.com/superpat/entry/opensso_build_4) of [OpenSSO](http://opensso.org/), as we work towards an early access (EA) build of Sun Federated Access Manager 8.0, OpenSSO's commercial 'twin'. Our plan designates OpenSSO build 5 as the FAM 8.0 EA, but we still have some minor issues to iron out before we're ready for EA, hence the release of [OpenSSO 1.0 Build 4.5](https://opensso.dev.java.net/public/use/index.html#stableopensso).

Here are some of the new features in Build 4.5, compared to Build 4:

*   **The Fedlet** - quick and easy Federation for SP's, where you'd rather (slightly) modify your web app than deploy more infrastructure - [much more on the Fedlet in the Sun blogosphere](http://blogs.sun.com/main/tags/fedlet).
*   **Federation Validator** - test harness for checking single sign-on between a SAML 2.0 Identity Provider and Service Provider.
*   **SiteMinder Integration** - support for co-existence of OpenSSO and SiteMinder.

Many more enhancements are listed at the bottom of the [Build 4.5 release notes](http://download.java.net/general/opensso/stable/openssov1-build4.5/B45-ReleaseNotes.html). Watch the [OpenSSO blogosphere](http://planets.sun.com/OpenSSO/group/blogs/) for more details on these new features.

The more I work on OpenSSO, the more I realize the nuances of open source development. The fact that we released this 'interim' stable build between builds 4 and 5 is one example of this - the demand for build 4.5 has come from the OpenSSO community, [which is now MUCH larger than the FAM team within Sun](http://blogs.sun.com/superpat/entry/opensso_community_passes_700_members).