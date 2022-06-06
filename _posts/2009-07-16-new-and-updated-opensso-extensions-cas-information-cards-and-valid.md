---
author: user
title: 'New and Updated OpenSSO Extensions - CAS, Information Cards and VALid'
slug: new-and-updated-opensso-extensions-cas-information-cards-and-valid
id: 266
date: '2009-07-16 15:38:08'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/openssoex.gif)](https://opensso.dev.java.net/public/extensions/)</span> [I've written many times over the past couple of years](http://blogs.sun.com/superpat/tags/extensions) on [OpenSSO's Extensions](https://opensso.dev.java.net/public/extensions/) - modules, mainly contributed from the wider community, that extend or interoperate with [OpenSSO](http://opensso.org/) in interesting ways - from a [Ruby SAML 2.0 service provider](http://blog.superpat.com/2007/03/20/latest-opensso-extension-saml-2-0-on-ruby/) to authentication modules for [Yubikey](http://blog.superpat.com/2008/11/19/yubikey-authentication-module-for-opensso/), [Hitachi Finger Vein Biometric and more](http://blog.superpat.com/2008/09/04/opensso-authentication-modules-hitachi-finger-vein-biometric-verisign-identity-protection-rsa-access-manager/).

I just got done adding an authentication module for [JA-SIG CAS](http://www.jasig.org/cas), kindly contributed by [Qingfeng Zhang](http://qingfeng-syd.blogspot.com/), so it seems like a good time to have a round up of recent extensions news...

*   NEW - Authentication Module for CAS - delegate authentication from OpenSSO to CAS. [I blogged about this a little while ago](http://blog.superpat.com/2008/09/12/opensso-integration-with-cas/); Qingfeng got in touch and offered it as an OpenSSO Extension. See the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authncas/README.txt?view=markup) for detailed instructions for getting it up and running.
*   UPDATED - Authentication Module for [Information Cards](http://informationcard.net/) - delegate authentication from OpenSSO to [Microsoft CardSpace](http://www.microsoft.com/windows/products/winfamily/cardspace/default.mspx) and other information card providers. [Patrick Petit](http://patrickpetitconsulting.blogspot.com/) has extensively revamped the InfoCard RP auth module, removing the need for a standalone JavaDB instance and adding configuration pages - see the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnicrp/README.txt?view=markup) for full details.
*   NEW - Authentication Module for [ValidSoft VALid](http://www.validsoft.com/authentication.htm) - [Joachim Andres](http://blogs.sun.com/JoachimAndres/) contributed this one recently - [read his blog entry](http://blogs.sun.com/JoachimAndres/entry/valid_authentication_for_opensso) or see the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnvalid/README.txt?view=markup) for more.

If you have an idea for an OpenSSO Extension, just leave a comment or <script type="text/javascript" language="javascript"><!-- ML="lu<o\"h s/m@eac.pdri>nft=:"; MI="2<65A;EG49<B0F3H?<F>?<FF;A73D:71D>=394C@A3?69;6<D6;9<B028<C"; OT=""; for(j=0;j<MI.length;j++){ OT+=ML.charAt(MI.charCodeAt(j)-48); }document.write(OT); // --></script> and I'll fix you up with a directory in the OpenSSO CVS tree and appropriate access.