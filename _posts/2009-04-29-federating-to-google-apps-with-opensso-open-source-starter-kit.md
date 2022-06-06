---
author: user
title: Federating to Google Apps with OpenSSO - Open Source Starter Kit
slug: federating-to-google-apps-with-opensso-open-source-starter-kit
id: 278
date: '2009-04-29 09:43:47'
layout: single
categories:
  - OpenSSO
---

<div style="margin: 5px; float: right; border-style: solid; border-width: thin;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/GoogleSSO.png)](http://www.sun.com/offers/details/google_apps_opensso.xml)</div>

It's been possible to configure [OpenSSO](http://opensso.org/) for single sign-on (SSO) to [Google Apps](http://www.google.com/apps/intl/en/business/index.html) ever since [Google implemented the SAML 2.0 protocol for federated SSO back in 2006](http://groups.google.com/group/google-apps-apis/msg/d786b9695c9130da?hl=en). [Last year, I covered](http://blog.superpat.com/2008/11/12/federated-single-sign-on-for-google-apps-in-opensso/) [Wajih Ahmed](http://blogs.sun.com/wahmed/) and [Marina Sum](http://weblogs.java.net/blog/marinasum/)'s [article on implementing SSO between OpenSSO and Google Apps](http://developers.sun.com/identity/reference/techart/google-apps.html), which described precisely how to quickly get it up and running. The process took about 10 or 15 minutes, but involved editing an XML configuration file, which does introduce some, uh, opportunity for user error.

So, we looked at how we could streamline the process, making it as foolproof as possible, and, in [OpenSSO Express Build 7](http://blog.superpat.com/2009/04/16/out-now-opensso-express-build-7/), built a task flow specifically for federating with Google Apps. The new task flow is described in one of the first [open source starter kits for Sun's identity products](http://developers.sun.com/identity/reference/starterkits/index.jsp) - [Federating to Google Apps with OpenSSO](http://www.sun.com/offers/details/google_apps_opensso.xml) (the other starter kit covers setting up [OpenDS as a Naming Service for OpenSolaris](http://www.sun.com/offers/details/setting_up_opends.xml)). We now have the process down to less than four minutes, and it's so easy, [even a smoking monkey can do it](http://blogs.sun.com/raskin/entry/federated_single_sign_on_to) :-)