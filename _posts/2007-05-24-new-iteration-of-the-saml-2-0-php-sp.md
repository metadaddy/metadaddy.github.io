---
author: user
title: New Iteration of the SAML 2.0 PHP SP
slug: new-iteration-of-the-saml-2-0-php-sp
id: 531
date: '2007-05-24 23:43:45'
layout: single
categories:
  - OpenSSO
---

[<span style="margin: 5px; float: right;">![](https://opensso.dev.java.net/public/extensions/openssoex.gif)</span>](https://opensso.dev.java.net/public/extensions/)

Many thanks to [Andreas Åkre Solberg](http://rnd.feide.no/) of the [FEIDE](http://feide.no/index.en.html) project for this [latest iteration](http://rnd.feide.no/2007/05/22/new-official-version-of-opensso-php-extension-lightbulb/) of the SAML 2.0 PHP service provider (SP) [OpenSSO Extension](https://opensso.dev.java.net/public/extensions/) (you might remember it as '[Lightbulb](http://blogs.sun.com/superpat/entry/switching_on_the_lightbulb)'). I spent Thursday afternoon running through some tests with the PHP SP and [OpenSSO](https://opensso.dev.java.net/) as the identity provider - apart from one very minor bug ([already fixed ![](http://blogs.sun.com/images/smileys/smile.gif)](https://opensso.dev.java.net/source/browse/opensso/extensions/saml2php/example-pat/logout.php?rev=1.2&r1=1.1&r2=1.2), it all works great!

Changes since the initial implementation:

*   Code restructured with SPIs for session handling and name mapping
*   Single logout listener
*   Support for transient identifiers
*   A new, simpler, sample
*   [Documentation!](https://opensso.dev.java.net/source/browse/*checkout*/opensso/extensions/saml2php/docs/opensso-php-userguide.html)
*   Several bugfixes

Grab the code via CVS from [opensso.dev.java.net](https://opensso.dev.java.net/) (it's in `opensso/extensions/saml2php/`). [Instructions for getting the code via CVS](https://opensso.dev.java.net/servlets/ProjectSource).