---
author: user
title: Federated Single Sign-On for Google Apps in OpenSSO
slug: federated-single-sign-on-for-google-apps-in-opensso
id: 331
date: '2008-11-12 22:32:59'
layout: single
categories:
  - OpenSSO
---

[![](images/GoogleSSO.png)](http://developers.sun.com/identity/reference/techart/google-apps.html){: .align-left}

Hot on the heels of the [OpenSSO Enterprise 8.0 release](http://blogs.sun.com/superpat/entry/opensso_enterprise_8_0_released) comes [Wajih Ahmed](http://blogs.sun.com/wahmed/) and [Marina Sum](http://weblogs.java.net/blog/marinasum/)'s article on configuring [Federated Single Sign-On for Google Apps in OpenSSO](http://developers.sun.com/identity/reference/techart/google-apps.html). With just a few minutes of work, you can be authenticating users in OpenSSO and giving them access to their accounts in [Google Apps](http://www.google.com/apps/intl/en/business/index.html), including Google Mail, Google Documents and Google Calendar. [Take a look at the demo we recorded with Michael Coté a few weeks ago](http://redmonk.com/tv/2008/09/29/demo-opensso-gets-saasy-federated-identity-across-the-firewall-with-google-and-salesforcecom/) to see the end result.

While this integration has been possible ever since we introduced SAML 2.0 support in Access Manager, it used to require a small amount of custom code to copy the user id into the SAML 2.0 NameID element. With [OpenSSO Enterprise 8.0](http://www.sun.com/software/products/opensso_enterprise/index.xml), it's now a simple matter of configuration in the administration console.

To illustrate the article, Wajih has captured the configuration process on video - [settle back and enjoy the show](http://developers.sun.com/identity/reference/techart/google-apps.html).