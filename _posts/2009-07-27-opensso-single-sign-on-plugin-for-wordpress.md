---
author: user
title: OpenSSO Single Sign-on Plugin for WordPress
slug: opensso-single-sign-on-plugin-for-wordpress
id: 261
date: '2009-07-27 16:44:51'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/OpenSSOWordPress.png)](https://opensso.dev.java.net/public/extensions/#authnproviders)</span> Encouraged by [a comment on my post about the OpenSSO module for Drupal](http://blog.superpat.com/2009/07/25/opensso-single-sign-on-module-for-drupal/comment-page-1/#comment-28), and [ the amount of OpenSSO/Drupal buzz on Twitter](http://search.twitter.com/search?q=opensso+drupal), I decided to attack [WordPress](http://wordpress.org/) next. Although WordPress has a very different plugin model from Drupal, I was able to reuse much of the code from the Drupal module and get a basic single sign-on plugin working quite quickly. As with the Drupal module, there are certainly bugs in the WordPress plugin - in particular, I just noticed that, if you log in to OpenSSO as a user without a corresponding WordPress account, you can get into a redirect loop if you try to go to a protected page at WordPress. :-/ As usual, there is a [README](https://opensso.dev.java.net/source/browse/opensso/extensions/wordpressplugin/README.txt?view=markup) and [source code](https://opensso.dev.java.net/source/browse/opensso/extensions/wordpressplugin/opensso.php?view=markup) - [also available via CVS](https://opensso.dev.java.net/public/about/faqcenter/faqgetstart.html#checkout), and I've added the new provider plugin to the [list on the OpenSSO Extensions page](https://opensso.dev.java.net/public/extensions/#authnproviders). So... That's two thirds of the Drupal/Joomla/Wordpress [CMS](http://en.wikipedia.org/wiki/Content_Management_System) trifecta covered... A competent Joomla hacker should be able to take the Drupal/WordPress work and adapt it pretty easily... Anyone want to try [while I'm at Catalyst this week](http://blog.superpat.com/2009/07/14/coming-up-burton-catalyst-conference-2009-and-don-bowen-in-san-diego/)?