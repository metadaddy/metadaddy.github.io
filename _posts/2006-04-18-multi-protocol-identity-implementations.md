---
author: user
title: Multi-protocol Identity Implementations
slug: multi-protocol-identity-implementations
id: 676
date: '2006-04-18 15:51:10'
layout: single
categories:
  - Federation
---

Interesting to see the discussion over the past few days between [Phil Windley](http://www.windley.com/archives/2006/04/navigating_user.shtml) and [Johannes Ernst](http://netmesh.info/jernst/Comments/phil-windley-multiprotocol.html) on multi-protocol identity implementation. I've been through a couple of iterations of this myself, with last year's [Microsoft/Sun Web SSO specifications](http://blogs.sun.com/roller/page/superpat?entry=sun_microsoft_press_conference) and the [Burton Catalyst multi-protocol federation demo](http://blogs.sun.com/roller/page/superpat?entry=first_multi_protocol_federated_identity).

[![](images/MultiProtocolIdp.gif)](images/MultiProtocolIdp.gif) There is a complex dynamic between identity providers supporting many protocols to service a wide range of relying parties and the converse, relying parties supporting many protocols to allow users to authenticate at any one of a range of identity providers. In the B2C world, it seems likely that the role of identity provider will naturally gravitate towards the big guys - maintaining a secure identity infrastructure is expensive - scale provides natural economies. This would seem to indicate that identity providers will be able to dictate terms - "My way or the highway", but we haven't seen much evidence of that. On the contrary, identity providers seem to be the ones interested in multi-protocol support at their end - the [multi-protocol identity provider hub](images/MultiProtocolIdp.gif) model that we demonstrated with [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml ) at Catalyst.

The logic is that, once you have an infrastructure for storing identities and authenticating users, supporting 2, 3 or 4 protocols isn't much more difficult than supporting 1\. The relying party is in a different position - their core business is the service they are providing - horoscopes, online gaming, a blogging platform, whatever. The relying party wants to pick a protocol, implement it with identity provider #1 and add identity providers over time without a bunch of extra expense and complexity.

On the other hand, in the B2B arena, the dynamics may turn out to be the reverse, as relying parties (service providers) such as [401(k) providers](http://blogs.sun.com/roller/page/superpat?entry=federated_single_sign_on_shifts), health benefits providers and even [political action committees](http://blogs.sun.com/roller/page/superpat?entry=sun_eats_its_own_liberty) implement federated SSO to allow company employees to leverage their enterprise login to access external resources. Here, the relying party may take the driving seat, implementing a range of protocols as they implement federation with a range of their customers. Enterprises are deploying federation internally first, hooking up divisions, so when a service provider offers federated SSO the identity provider is likely to have already selected a technology.

Caveat - this is a rapidly evolving market (who would have foretold the explosion in user-centric identity?) and the above is based on the observations of one guy talking to a random bunch of enterprises and organizations. I'm perfectly prepared for a bunch of incoming links over the next few weeks/months/years explaining just how wrong I was ![](http://blogs.sun.com/roller/images/smileys/smile.gif)