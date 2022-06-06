---
author: user
title: Federated Authorization
slug: federated-authorization
id: 594
date: '2006-12-08 11:18:08'
layout: single
categories:
  - Federation
---

[<span style="margin:10px;float:right;">![](images/SAML-XACML.png)</span>](http://docs.oasis-open.org/xacml/2.0/access_control-xacml-2.0-saml-profile-spec-os.pdf)

In a [comment to a previous blog entry here](http://blogs.sun.com/superpat/entry/yadis%2Fxri_identifier_resolution_with_saml#comment1), [James McGovern](http://duckdown.blogspot.com/) asks

> Does Federated Identity sometimes require Federated Authorization? If so, how come this isn't ever discussed. Maybe you could address in future blog entry...

There are two models here. In the first model, a given user has a profile (set of attributes) stored at an attribute provider (which may or may not be the same as that user's identity provider). The user goes to a service provider, the service provider receives a SAML 2.0 Assertion containing some set of attributes, and the service provider acts as both the policy decision point (PDP), deciding, on the basis of the user's identity (including the attributes), which resources the user may access, and the policy enforcement point (PEP), restricting the user's access appropriately. Here's a real example in the enterprise space...

[Sun has deployed federated single sign-on with BIPAC](http://blogs.sun.com/superpat/entry/sun_eats_its_own_liberty) - BIPAC is the [Business Industry Political Action Committee](http://bipac.org/) provides expert policy analysis, research and communications on campaigns and elections, and fosters business participation in the political process. Sun employees can access political information on the BIPAC website - who their elected representatives are, their voting record etc.

When I go to the BIPAC site, it redirects me to Sun, I log in with my Sun employee number and password and I'm redirected back to BIPAC with a SAML assertion containing a number of attributes - iirc, whether I'm a US citizen, whether I'm a member of a 'restricted class' of employees and my zip code. Note that the assertion does _not_ identify me personally - it only tells BIPAC that I am a Sun employee with these attributes. Now the BIPAC site can act as the PDP, deciding what I can access, based on those attributes, and as the PEP, constraining my access to the BIPAC site according to those decisions.

In the second model (which is what I think James means by 'federated authorization'), the service provider is still a policy enforcement point, but the policy decision point is elsewhere. In our BIPAC example, the BIPAC site would still redirect me to Sun for authentication, but need not receive any attributes in the SAML assertion - just a pseudonym (SAML Name Identifier) that it can use to refer to me; again, BIPAC doesn't know who I am - the pseudonym can be a one-time identifier - used in this interaction, but never re-used - so I can't be tracked across visits. Now the BIPAC site can make an authorization request of a PDP at Sun, including my pseudonym and a reference to the resource I want to access. The PDP evaluates policy, essentially doing the same thing as the BIPAC PDP did in the previous example, and returns a response to BIPAC that indicates whether access to the resource should be allowed or denied.

Having these two models allows us to factor out authorization and put it where it makes sense. It may well be that it is the service provider that is responsible for policy, based on information provided by an attribute provider (model 1), or, alternatively, the service provider may simply request an authorization decision from a PDP, without being party to the data underlying the decision (model 2).

In terms of specs, both [SAML](http://www.oasis-open.org/committees/security/) and [WS-Federation](http://www.ibm.com/developerworks/library/specification/ws-fed/) enable model 1 - passing attributes in assertions which are themselves carried in authentication responses. [XACML](http://www.oasis-open.org/committees/xacml/) is the basis for model 2, and is profiled for use with SAML by the [SAML 2.0 profile of XACML v2.0 [PDF]](http://docs.oasis-open.org/xacml/2.0/access_control-xacml-2.0-saml-profile-spec-os.pdf). I'm not aware of any commercial products that implement this specification today (perhaps that's why no vendors are talking about it?), but [OpenSSO](https://opensso.dev.java.net/) is a good place to go to talk about requirements and implementation - [you can sign up to the 'users' mailing list here](https://opensso.dev.java.net/servlets/ProjectMailingListList).

Does this answer your question, James?

_UPDATE_ - perspectives on this from

*   [Paul Madsen](http://connectid.blogspot.com/) - [Was this a script?](http://connectid.blogspot.com/2006/12/was-this-script.html)
*   [Conor Cahill](http://conorcahill.blogspot.com/) - [Federated Identity and Federated Authorization](http://conorcahill.blogspot.com/2006/12/federated-identity-and-federated.html)

And responses from [James](http://duckdown.blogspot.com/) -

*   [More Thoughts on Federated Authorization](http://duckdown.blogspot.com/2006/12/more-thoughts-on-federated.html)
*   [Consumer Perspectives on Federated Authorization...](http://duckdown.blogspot.com/2006/12/consumer-perspectives-on-federated.html)