---
author: user
title: Switching on the Lightbulb
slug: switching-on-the-lightbulb
id: 623
date: '2006-10-19 17:03:01'
layout: single
categories:
  - OpenSSO
---

Over the past few months I've had a side project - implementing a [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) service provider (SP) in [PHP](http://www.php.net/). I originally set out using [PHP/Java Bridge](http://php-java-bridge.sourceforge.net/) and got something working (I even [presented it](http://ios.windley.com/images/e/e7/IOSVan-Lightbulb-SAML2LAMP.pdf) [pdf] at [Identity Open Space in Vancouver](http://ios.windley.com/wiki/IOSVan)), but I was inspired by [Kim Cameron](http://www.identityblog.com/)'s [success in implementing InfoCard in PHP](http://www.identityblog.com/?page_id=430) to try a more direct approach.

[Rob Richard](http://www.cdatazone.org/)'s [XML Security implementation](http://www.cdatazone.org/index.php?/archives/12-Slides-from-PHPWorks-2006.html) provided the impetus I needed to get a 'pure' PHP SAML 2.0 SP working. Rob kindly allowed me to adopt the XML Security code into [OpenSSO](https://opensso.dev.java.net/) (note that the base XML security code is still, and will continue to be, available, in its original public domain form, at Rob's page) and I set forth hacking away.

Well - I'm [done with an initial version](https://opensso.dev.java.net/source/browse/opensso/lightbulb/php/direct/). SAML 2.0 POST profile works. There is no artifact profile, no single log out, no bells or whistles. It does verify the assertion signature (via PHP's integration with openssl) and checks that the certificate fingerprint matches what it expects from that identity provider.

There is some [general documentation on SAML-enabling PHP](https://opensso.dev.java.net/source/browse/*checkout*/opensso/lightbulb/docs/php/EnablingPhpSaml2.0.odt) [odt], and some [specific documentation on this code](https://opensso.dev.java.net/source/browse/*checkout*/opensso/lightbulb/docs/php/direct/Saml2.0SpPhp.odt) [odt]. I'll write a step-by-step guide to getting it up and running next...

_UPDATE_ - [some FAQs here](http://blogs.sun.com/superpat/entry/q_a_on_the_opensso).