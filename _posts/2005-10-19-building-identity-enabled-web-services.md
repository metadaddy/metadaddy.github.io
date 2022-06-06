---
author: user
title: Building Identity-Enabled Web Services
slug: building-identity-enabled-web-services
id: 730
date: '2005-10-19 03:04:41'
layout: single
categories:
  - Federation
---

I recently coauthored a technical article on [Liberty ID-WSF](http://www.projectliberty.org/resources/specifications.php#ID-WSF_Specs), [JSR 196](http://www.jcp.org/en/jsr/detail?id=196) and [Sun Java Studio Enterprise](http://www.sun.com/software/products/jsenterprise/index.xml) entitled [_Building Identity-Enabled Web Services_](http://developers.sun.com/prodtech/identserver/reference/techart/id-enabled-ws.html). The article just went live at [developers.sun.com](http://developers.sun.com/) - here is a slightly adapted version of the intro:

Last October, the article [_Federated Identity: Single Sign-On Among Enterprises_](http://developers.sun.com/prodtech/identserver/reference/techart/federated.html) introduced identity federation as it relates to single sign-on (SSO) and demonstrated how Security Assertion Markup Language (SAML) and the Liberty Identity Federation Framework (ID-FF) offer standard mechanisms for crossdomain SSO. That article also briefly described the Liberty Alliance Project's Identity Web Service Framework (ID-WSF) and its capabilities for identity-enabling Web services.

At a [technical session at JavaOne 2005 in San Francisco](http://mediacast.sun.com/share/superpat/TS-3269.pdf), we delved into ID-WSF and the new developments in the Java Community Process and in Sun's products that enable you to efficiently build identity-enabled Web services. This article recaps the content of that session. Specifically, you'll learn the following:

*   How Liberty ID-WSF identity-enables Web services
*   How components that are based on the J2EE platform, such as JSR 196, insulate you from the mechanics of ID-WSF
*   How Sun Java Studio Enterprise will automate the creation of identity-enabled Web services