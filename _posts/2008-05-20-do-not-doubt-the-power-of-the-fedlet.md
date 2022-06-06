---
author: user
title: Do Not Doubt The Power of The Fedlet!
slug: do-not-doubt-the-power-of-the-fedlet
id: 401
date: '2008-05-20 08:37:23'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blogs.sun.com/raskin/resource/Daniel_images/Piglet_Teaser.jpg) ](http://opensso.org/)</span> 

The inimitable [Paul Madsen](http://connectid.blogspot.com/) [writes on the Fedlet today](http://connectid.blogspot.com/2008/05/sun-fedlet.html), wondering

> Would the fedlet, once deployed by an SP, be reusable with other IDPs (than the one that created it initially) and thereby be considered a quick and easy way to SAML enable an SP? I bet not.

On the contrary, my dear Madsen, it could indeed be reused with other IdPs. The Fedlet is configured via SAML 2.0 metadata, saved to a directory on disk. The very first time you visit the Fedlet's deployment URI, it offers to save configuration to disk:

[![](http://blog.superpat.com/FedletConfig.png)](http://blog.superpat.com/FedletConfig.png) 

At this point, as explained on the screen, you can expand the Fedlet WAR manually and copy the files yourself, or let the Fedlet do it for you. In either case, you can edit the SAML 2.0 metadata to use **any** SAML 2.0 identity provider (or _providers_). OpenSSO even includes an 'unconfigured' Fedlet for doing this all completely manually.

So, yes, the Fedlet **is** a quick and easy way to SAML enable an SP!

_UPDATE (5/22/08)_ - [Paul. Says. It. Was. All. Down. To. Misplaced. Punctuation.](http://connectid.blogspot.com/2008/05/for-want-of-punctuation.html)