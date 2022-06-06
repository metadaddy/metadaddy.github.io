---
author: user
title: Swekey Authentication Module for OpenSSO
slug: swekey-authentication-module-for-opensso
id: 288
date: '2009-03-03 15:17:34'
layout: single
categories:
  - OpenSSO
---

<div style="margin: 5px; float: right;">[![](images/swekey_s.png)](https://opensso.dev.java.net/public/extensions/#authnmodules)</div>

I just finished another [OpenSSO Extension](https://opensso.dev.java.net/public/extensions) - this time, an authentication module for the [Swekey](http://www.swekey.com/) authentication key ([README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnswekey/README.txt?view=markup), [source](https://opensso.dev.java.net/source/browse/opensso/extensions/authnswekey/src/)). The authentication module prompts the user for their username and uses the Swekey to generate a one-time password, which is validated against the Swekey authentication server.

It's interesting to contrast the Swekey with the [Yubikey](http://www.yubico.com/products/yubikey/), which I [covered here a few months ago](http://blog.superpat.com/2008/11/19/yubikey-authentication-module-for-opensso/). Where the Yubikey emulates a USB keyboard, requiring no special client software, the Swekey requires a driver. On the other hand, where the Swekey is invoked automatically by a browser plugin, requiring no user intervention apart from inserting the device into a USB port, the Yubikey requires the user to press its button and, potentially, ensure that the cursor is in the correct input field. One thing they do now have in common, though: they both work with [OpenSSO](http://opensso.org/) :-)

So, if you have a Swekey, grab the authentication module, deploy it (see the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnswekey/README.txt?view=markup)) and let me know how you get on.