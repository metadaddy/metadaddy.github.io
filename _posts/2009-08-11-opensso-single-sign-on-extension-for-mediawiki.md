---
author: user
title: OpenSSO Single Sign-on Extension for MediaWiki
slug: opensso-single-sign-on-extension-for-mediawiki
id: 257
date: '2009-08-11 13:36:49'
layout: single
categories:
  - OpenSSO
tags:
  - opensso mediawiki
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/Wiki.png)](https://opensso.dev.java.net/public/extensions/#authnproviders)</span>

Following the recent trio of [OpenSSO](http://opensso.org/) Extensions targeting PHP CMS applications (see my previous entries covering the extensions for [Drupal](http://blog.superpat.com/2009/07/25/opensso-single-sign-on-module-for-drupal/), [WordPress](http://blog.superpat.com/2009/07/27/opensso-single-sign-on-plugin-for-wordpress/) and [Joomla](http://blog.superpat.com/2009/08/01/opensso-single-sign-on-plugin-for-joomla/)), I decided to look at [MediaWiki](http://www.mediawiki.org/), the PHP application powering [Wikipedia](http://en.wikipedia.org/) and many other wikis across the web.

In common with the CMS apps, MediaWiki has a very pluggable architecture, making implementation of a single sign-on extension very straightforward, and I was able to get an initial implementation done in a few hours. The user interface is very like the WordPress plugin: just click on the regular 'log in' link to be sent to OpenSSO to authenticate; on returning to MediaWiki, the extension validates the OpenSSO cookie and uses it to retrieve the username from OpenSSO, setting up the MediaWiki session.

There is a [README](https://opensso.dev.java.net/source/browse/opensso/extensions/mediawikiextension/README.txt?view=markup) and [source code](https://opensso.dev.java.net/source/browse/opensso/extensions/mediawikiextension/) - [also available via CVS](https://opensso.dev.java.net/public/about/faqcenter/faqgetstart.html#checkout), and I've added the new provider plugin to the [list on the OpenSSO Extensions page](https://opensso.dev.java.net/public/extensions/#authnproviders). As always, note that none of these extensions are supported by Sun, and all should be considered 'proof of concept' quality - they likely need a bit more polish (and lots more testing!) before being deployed into production.

I think that about wraps up the PHP extension story for the time being - we now have plugins for the four most common PHP web apps. Do leave a comment if you think there is another we should cover.