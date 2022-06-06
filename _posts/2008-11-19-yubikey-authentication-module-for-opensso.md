---
author: user
title: Yubikey Authentication Module for OpenSSO
slug: yubikey-authentication-module-for-opensso
id: 330
date: '2008-11-19 21:44:20'
layout: single
categories:
  - OpenSSO
---

<div style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/yubikey_keys.jpg)](https://opensso.dev.java.net/public/extensions/#authnmodules)</div>

I just committed a new [OpenSSO Extension](https://opensso.dev.java.net/public/extensions) - the [Yubikey](http://www.yubico.com/products/yubikey/) Authentication Module ([README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnyubikey/README.txt?view=markup), [source](https://opensso.dev.java.net/source/browse/opensso/extensions/authnyubikey/src/)). The authentication module prompts the user for their username and the one time password (OTP) from the Yubikey, calls the Yubikey authentication server to verify the OTP and authenticates the user (or not!) according to the response.

Many thanks to [Jeff Bounds](http://blogs.sun.com/bounds/) for inspiring me with his [VIP authentication module](http://blogs.sun.com/bounds/entry/verisign_identity_protection_and_opensso) and to Stina Ehrensvärd of [Yubico](http://www.yubico.com/) for supplying me with a Yubikey to get started.

If you have a Yubikey, grab the authentication module, deploy it (see the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnyubikey/README.txt?view=markup)) and let me know how you get on.