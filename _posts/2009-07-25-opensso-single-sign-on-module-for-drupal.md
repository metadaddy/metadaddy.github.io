---
author: user
title: OpenSSO Single Sign-on Module for Drupal
slug: opensso-single-sign-on-module-for-drupal
id: 263
date: '2009-07-25 18:16:17'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/OpenSSODrupal.png)](https://opensso.dev.java.net/public/extensions/#authnproviders)</span> [Drupal](http://drupal.org/) is one of the leading open source content management systems - some would say _the_ leading open source CMS. We've had a few requests over the years for [OpenSSO](http://opensso.org/)/Drupal integration, but no one has hitherto stepped forward. Finding myself with a few spare hours over the last few days, I decided to investigate. It turns out that, thanks to Drupal's extensibility through [modules](http://drupal.org/project/Modules) and [OpenSSO's identity services](http://developers.sun.com/identity/reference/techart/id-svcs.html), it's pretty straightforward to get something working. So I did. There is now an OpenSSO module for Drupal [ [README](http://java.net/projects/opensso/sources/svn/content/trunk/extensions/drupalmodule/README.txt) \| [Source](http://java.net/projects/opensso/sources/svn/show/trunk/extensions/drupalmodule) - [also available via Subversion](http://java.net/projects/opensso/sources/svn/show)]. I'm no expert in either PHP or Drupal, so there may well be bugs, but it seems to work well, checking for the OpenSSO cookie when users attempt to access Drupal, redirecting them to OpenSSO to authenticate if necessary, and retrieving a Drupal username from the user's OpenSSO profile before setting up the user's Drupal session. If there's sufficient demand, I'll look at going through the process to contribute this to Drupal under GPL, until then, it's available under [CDDL](http://www.sun.com/cddl/cddl.html) as an [OpenSSO Extension](https://opensso.dev.java.net/public/extensions/).