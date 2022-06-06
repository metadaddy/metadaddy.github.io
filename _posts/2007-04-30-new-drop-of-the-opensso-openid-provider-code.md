---
author: user
title: New Drop of the OpenSSO OpenID Provider Code
slug: new-drop-of-the-opensso-openid-provider-code
id: 542
date: '2007-04-30 12:19:20'
layout: single
categories:
  - OpenSSO
---

[<span style="margin: 5px; float: right;">![](https://opensso.dev.java.net/public/extensions/openssoex.gif)</span>](https://opensso.dev.java.net/public/extensions/openid/)

[Back in March](http://blogs.sun.com/superpat/entry/openid_on_opensso), Paul Bryan released the first version of the [OpenID Extension for OpenSSO](https://opensso.dev.java.net/public/extensions/openid/), implementing an [OpenID](http://openid.net/) Provider for [OpenSSO](https://opensso.dev.java.net/), Sun's open source single sign-on/access control/federation project. You might also recall that, [at the beginning of this month](http://blogs.sun.com/superpat/entry/ssocircle_latest_saml2_0_php), [SSOCircle](http://www.ssocircle.com/) put this into production, enabling OpenID Provider services on [their public identity provider](http://www.ssocircle.com/idp.shtml).

Last night, Paul announced the second drop of his OpenID provider on [OpenSSO's developer](https://opensso.dev.java.net/servlets/ProjectMailingListList) mailing list. For those of you not subscribed, here is the full text of his announcement:

> Hi all:  
> I have just checked-in the source to the OpenID provider 1.0 alpha2\. The following are excerpts from the README file:  
> 
> ### Introduction
> 
> The OpenID provider provides a complete OpenID Authentication 1.1 protocol compliant identity provider implementation, complete with full support for OpenID Simple Registration Extension 1.0.  
> 
> ### Features
> 
> This release includes the following enhancements over 1.0 alpha1:
> 
> *   Standalone web application as deployable WAR file
> *   OpenID message object model; supports future consumer implementation
> *   Trust management user interface (non-persistent trust decisions)
> *   Simple Registration Extension user interface
> *   On-the-fly l10n and i18n (English, French and German included)
> *   Full decoupling from authentication infrastructure through getUserPrincipal
> *   Integration with OpenSSO through servlet filter implementation
> *   Configurable OpenID identity regular expression pattern
> *   Configurable authentication provider principal mapping
> *   No more dependencies on OpenSSO internal classes
> 
> ### Roadmap
> 
> This is the second release in a planned series of releases. Version 1.0 alpha3 targets to include the following enhancements:
> 
> *   Persistent trust decisions (via pluggable persistence SPI)
> *   Persistent persona management and associated user interface
> *   Integration with other authentication infrastructures
> *   Response to errors through published openid.error mechanism
> *   Further refinement in preparation for OpenID 2.0 ratification
> *   Full supporting documentation
> *   Comprehensive logging
> 
> For more information, see:
> 
> *   [Full README.txt text](https://opensso.dev.java.net/source/browse/opensso/extensions/openid/provider/README.txt?view=markup)
> *   [File descriptions, to facilitate customization of user interface](https://opensso.dev.java.net/source/browse/opensso/extensions/openid/provider/doc/files.txt?view=markup)
> 
> As always, any comments and feedback will be most appreciated.  
> Paul C. Bryan  
> pbryan@dev.java.net

As soon as I get a chance, I need to go grab this and have a play...