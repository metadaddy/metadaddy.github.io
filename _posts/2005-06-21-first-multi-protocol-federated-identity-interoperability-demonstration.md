---
author: user
title: First Multi-Protocol Federated Identity Interoperability Demonstration
slug: first-multi-protocol-federated-identity-interoperability-demonstration
id: 762
date: '2005-06-21 17:14:54'
layout: single
categories:
  - Identity
---

The [Burton Group](http://www.burtongroup.com/) is [organizing a demonstration of multi-protocol federated identity](http://www.burtongroup.com/press/Releases/release.asp?releaseid=68) at its [Catalyst conference](http://www.burtongroup.com/catalyst/catna05/index.asp) in San Diego next month. We will be showing [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml ) acting as a multi-protocol identity provider hub. That is, Access Manager will be enabling single sign-on between a set of service providers, each of which will be supplied by a different vendor, supporting a different federation protocol:  
![](images/MultiProtocolIdp.gif)  
To keep things simple in the diagram, I haven't shown any back-channels between the identity provider and the service providers.  
So, no matter which provider the user visits first, he will be redirected to authenticate at the identity provider. Now the user can visit any of the service providers without further authentication, despite the fact that they are all using different federation protocols. Cool!