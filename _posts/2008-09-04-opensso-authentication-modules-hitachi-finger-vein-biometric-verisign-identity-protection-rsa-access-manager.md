---
author: user
title: >-
  OpenSSO Authentication Modules - Hitachi Finger Vein Biometric, Verisign
  Identity Protection, RSA Access Manager
slug: >-
  opensso-authentication-modules-hitachi-finger-vein-biometric-verisign-identity-protection-rsa-access-manager
id: 380
date: '2008-09-04 16:28:06'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](https://opensso.dev.java.net/public/extensions/openssoex.gif)](https://opensso.dev.java.net/public/extensions/index.html)</span>

I've [blogged before](http://blogs.sun.com/superpat/tags/opensso+extensions) on [OpenSSO Extensions](https://opensso.dev.java.net/public/extensions/index.html) - useful modules that do not fit into the [OpenSSO](http://opensso.org/) 'core'. Among the various categories of extension are 'authentication modules' - one of the most common customizations for OpenSSO and [Access Manager](http://www.sun.com/software/products/access_mgr/index.jsp). An authentication module supports a particular mechanism for collecting and verifying a user's credentials - [common mechanisms that are supported out-of-the-box](http://docs.sun.com/app/docs/doc/819-4670/6n6qardtu?a=view) include username/password against LDAP, client certificates (encompassing browser certs and smartcards) and Windows Desktop SSO (aka [SPNEGO](http://msdn.microsoft.com/en-us/library/ms995329.aspx), aka Kerberos).

Of course, technology refuses to stand still, and new authentication mechanisms are constantly being developed and deployed - new biometrics, hardware tokens, even whole new authentication protocols. Over the past few months, we've seen a clutch of new authentication modules in OpenSSO, so it's time to take a look at what's new...

*   The [**Hitachi Finger Vein Biometric**](www.hitachi.us/fingervein) module ([README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnhfvb/README.txt?view=markup)), developed by [Yasushi Iwakata](http://blogs.sun.com/iwakata/), interfaces with a infra-red based reader to use the unique patterns of veins in each user's finger as a credential. Yasushi recently left Sun, but continues as an external contributor to OpenSSO.
*   [Jeff Bounds](http://blogs.sun.com/bounds/) [blogged about his **Verisign Identity Protection** module](http://blogs.sun.com/bounds/entry/verisign_identity_protection_and_opensso) back in June. Since that blog entry, Jeff has uploaded the source as an OpenSSO Extension, so it's available to all; the [README](https://opensso.dev.java.net/source/browse/opensso/extensions/authnvip/README.txt?view=markup) and [Jeff's blog entry](http://blogs.sun.com/bounds/entry/verisign_identity_protection_and_opensso) have everything you need to get started.
*   Strictly speaking, [Wajih Ahmed](http://blogs.sun.com/wahmed/)'s [**RSA Access Manager** authentication module](http://blogs.sun.com/wahmed/entry/opensso_custom_auth_module_for) is located in the 'core' OpenSSO area, but it's an authentication module just the same. It allows you to integrate OpenSSO (or, of course, Access Manager) with, uh, [RSA Access Manager](http://www.rsa.com/node.aspx?id=1186) (formerly known as ClearTrust) for co-existence, either permanently or as an initial phase in a migration. Again, there's a [README](https://opensso.dev.java.net/source/browse/opensso/products/federation/openfm/integrations/cleartrust/README.txt?view=markup) to get you started.

So, three very different authentication modules. Maybe you have an idea for a fourth?