---
author: user
title: Q&A on the OpenSSO SAML 2.0 PHP work
slug: qa-on-the-opensso-saml-2-0-php-work
id: 622
date: '2006-10-20 10:01:07'
layout: single
categories:
  - OpenSSO
---

[Yesterday I announced the first drop of my SAML 2.0 PHP code](http://blogs.sun.com/superpat/entry/switching_on_the_lightbulb). I've had a few questions since then - here they are, with answers:

*   Q: Can I contribute to this?  
    A: Of course! This was the whole point of releasing this code as open source. I know a little about SAML 2.0, but I'm no PHP expert. I'd welcome PHP folks to take a look and suggest/make improvements. See the [OpenSSO governance](https://opensso.dev.java.net/public/about/governance/index.html) for more information on contributing.
*   Q: Is this 'pure' PHP?  
    A: That depends on your definition of 'pure'. No custom modules are required. It does use openssl, mysql, dom and xml, but support for these is pretty standard. The default PHP5 in my Ubuntu 6.06 had everything I needed.

Please do leave comments with any further questions - I'll update this entry with the answers.