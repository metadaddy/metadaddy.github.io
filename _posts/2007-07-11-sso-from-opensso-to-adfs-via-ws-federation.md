---
author: user
title: SSO from OpenSSO to ADFS via WS-Federation
slug: sso-from-opensso-to-adfs-via-ws-federation
id: 511
date: '2007-07-11 06:04:56'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](images/SSO_sm.png)](images/SSO.png)</span>

Not too many blog entries lately, as I've been [elbow-deep in code](http://www.ohloh.net/projects/3793/contributors/20563/commits) - Friday saw the first ever single sign-on from [OpenSSO](https://opensso.dev.java.net/) to Microsoft Active Directory Federation Services (ADFS) via WS-Federation (click on the screenshot for a closer look at the output of the ADFS test app). This is OpenSSO acting as an account partner (in ADFS terminology), or identity provider, to ADFS as a resource partner, or service provider. There is a lot of work still to do - single logout, account and attribute mapping, etc, but the core SSO protocol support is all there now.