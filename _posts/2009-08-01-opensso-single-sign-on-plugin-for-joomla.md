---
author: user
title: OpenSSO Single Sign-on Plugin for Joomla
slug: opensso-single-sign-on-plugin-for-joomla
id: 260
date: '2009-08-01 16:42:19'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](images/OpenSSOJoomla.png)](https://opensso.dev.java.net/public/extensions/#authnproviders)</span>

I was lucky enough to be able to spend some time at [Burton Catalyst](http://www.catalyst.burtongroup.com/Na09/) this last week with [Pamela Dingle](http://eternallyoptimistic.com/), looking at how to get started writing an [OpenSSO](http://opensso.org/) plugin for [Joomla](http://joomla.org) to complement the plugins I recently wrote for [Drupal](opensso-single-sign-on-module-for-drupal) and [Wordpress](opensso-single-sign-on-plugin-for-wordpress). Pamela, well known for her work on PHP [Information Card](http://en.wikipedia.org/wiki/Information_Card) plugins at [The Pamela Project](http://pamelaproject.com/), quickly pointed me in the right direction, and it didn't take me long after that to get something working - thanks, Pam!

<span style="margin: 5px; float: left;">![](http://blog.superpat.com/JoomlaLogin.png)</span> The Joomla plugin alters the standard process so that, on clicking the 'Login' button, users are redirected first to OpenSSO to authenticate, then back to Joomla for the plugin to retrieve the user's name from OpenSSO and create a session. I got a little bit more creative this time round; there's JavaScript to alter the Joomla login form - see the screen cap next to this paragraph.

As always, there is a [README](https://opensso.dev.java.net/source/browse/opensso/extensions/joomlaplugin/README.txt?view=markup) and [source code](https://opensso.dev.java.net/source/browse/opensso/extensions/joomlaplugin/opensso/) - [also available via CVS](https://opensso.dev.java.net/public/about/faqcenter/faqgetstart.html#checkout), and I've added the new provider plugin to the [list on the OpenSSO Extensions page](https://opensso.dev.java.net/public/extensions/#authnproviders). Note that none of these plugins are supported by Sun, and all should be considered 'proof of concept' quality - they likely need a bit more polish (and lots more testing!) before being deployed into production.

So, that's the Drupal/Wordpress/Joomla open source PHP [CMS](http://en.wikipedia.org/wiki/Content_Management_System) trifecta covered... I see Pam has a [MediaWiki](http://www.mediawiki.org/) plugin too - maybe I'll look at that next...