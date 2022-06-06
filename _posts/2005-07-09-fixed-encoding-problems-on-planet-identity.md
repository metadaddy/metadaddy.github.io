---
author: user
title: Fixed Encoding Problems on Planet Identity
slug: fixed-encoding-problems-on-planet-identity
id: 758
date: '2005-07-09 21:46:43'
layout: single
categories:
  - Identity
---

Regular readers of [Planet Identity](http://planetidentity.org) may have already noticed that I recently fixed an annoying problem with character encoding. The HTML content is UTF-8, but Apache was indicating in the HTTP header that it was ISO-8859-1\. This caused non-alphanumeric characters in many posts to appear as multiple 'garbage' characters. Telling Apache that the encoding is UTF-8 (by setting <tt>AddDefaultCharset utf-8</tt> in the relevant "VirtualHost" section of the Apache configuration file) fixed the problem - even [Tatsuo Kudo](http://blogs.sun.com/roller/page/tkudo)'s posts appear correctly, in Japanese (although I have to use [Google Language Tools](http://www.google.com/language_tools) to figure them out ![](http://blogs.sun.com/roller/images/smileys/smile.gif)).  
Thanks to [David Edmondson](http://www.dme.org) (proprietor of [Planet Sun](http://planetsun.org)) for the tip, and continued thanks to [Stephen Lau](http://whacked.net/blog/) for hosting Planet Identity.