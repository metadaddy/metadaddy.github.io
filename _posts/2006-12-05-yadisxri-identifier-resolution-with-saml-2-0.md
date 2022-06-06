---
author: user
title: YADIS/XRI Identifier Resolution with SAML 2.0
slug: yadisxri-identifier-resolution-with-saml-2-0
id: 595
date: '2006-12-05 16:16:12'
layout: single
categories:
  - Identity
---

This week at [Internet Identity Workshop 2006b](http://iiw.windley.com/wiki/Workshop2006b) I've been demonstrating some work I've been doing to combine [YADIS](http://yadis.org/)/[XRI](http://www.oasis-open.org/committees/xri/) Identifier Resolution (as in [OpenID](http://openid.net/)) with [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) Web Browser SSO Profile. The user experience is:

1.  I go to a service provider (relying party)
2.  I enter my identifier (URL or [i-name](http://www.xdi.org/i-names-explained.html))
3.  I authenticate at my identity provider
4.  I can access services at the service provider

The magic takes place between steps 2 and 3: the service provider resolves the user's identifier, which might be a URL or an i-name, to the location of a SAML 2.0 identity provider. The service provider can now do vanilla SAML 2.0 with the identity provider. The easiest way to see what's going on is via a demo, so, here you go:

<table align="" border="0" cellpadding="5" width="500">

<tbody>

<tr>

<td align="center">[![](images/mylinks.png)  
<span align="center">**Click to view Flash presentation**</span>](images/OpenIDStyleSAML_viewlet_swf.html) </td>

</tr>

</tbody>

</table>

By the way - the service provider is implemented on top of [Project Lightbulb](https://lightbulb.dev.java.net/). I need to do some tidying first, but I'll put the YADIS/XRI code there soon.

_UPDATE_ - coverage of this demo at IIW2006b:

*   [Lightbulb: Bringing SAML to PHP](http://www.windley.com/archives/2006/12/lightbulb_bringing_saml_to_php.shtml)
*   [Internet Identity Workshop demonstrations steal the show](http://blogs.zdnet.com/BTL/?p=4095) - nice pic on this one. Left-to-right we have [Doc Searls](http://doc.weblogs.com/), my good self, Shin Adachi and [JP Rangaswami](http://www.confusedofcalcutta.com/).