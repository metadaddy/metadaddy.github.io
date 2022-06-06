---
author: user
title: >-
  Did You Know That Federated Identity Deployments Are More Secure Than You
  Think?
slug: >-
  did-you-know-that-federated-identity-deployments-are-more-secure-than-you-think
id: 310
date: '2009-01-12 16:53:20'
layout: single
categories:
  - Federation
---

<span style="margin: 5px; float: right;">![](http://blog.superpat.com/wp-content/uploads/2009/09/padlock.jpg)</span>

[James McGovern](http://duckdown.blogspot.com/) asks the rhetorical question ["Did you know that many federated identity deployments are insecure?"](http://duckdown.blogspot.com/2009/01/did-you-know-that-many-federated.html). I'll leave James' criticisms of OpenID and Cardspace to the respective experts, as I'm really only on the periphery of those communities, but let's have a look at the insecurities he perceives in SAML-based federation...

James' main point on federation is:

> Many of the products will perform a lookup of the subject within a SAML assertion against an LDAP store [...] So, if salesforce.com is a SP and supports multiple customers of which Credit Suisse is one and the other is say Goldman Sachs. Salesforce.com would have a trust relationship with both of them but what would prevent a rogue Goldman Sachs employee from putting into their directory the subject (say email address) of a Credit Suisse employee and allowing it to be passed along?

There are multiple layers of protection against this kind of attack. The most obvious mitigation is the use of SAML 2.0 persistent identifiers. A persistent identifier is an opaque string (in practice, a long random sequence of characters, such as _ZG0OZ3JWP9yduIQ1zFJbVVGHlQ9M_ that is shared by exactly one identity provider and one service provider to identify a given user. Now, let's assume that our rogue Goldman Sachs employee manages to discover the persistent identifier of a Credit Suisse employee (difficult, since this value would only be shared between Salesforce.com and Credit Suisse). On receiving a SAML assertion from Goldman Sachs, Salesforce.com would look the user up with _(Goldman Sachs, ZG0OZ3JWP9yduIQ1zFJbVVGHlQ9M)_, which would not match _(Credit Suisse, ZG0OZ3JWP9yduIQ1zFJbVVGHlQ9M)_, so the assertion would be rejected. You can check out the [OpenSSO](http://opensso.org/) source code to see how this works - persistent IDs are scoped to the (identity provider, service provider) pair, so you MUST use the identity provider when resolving them, since there is no guarantee that two identity providers won't accidentally (or otherwise!) generate the same ID.

Can our rogue Goldman Sachs employee hack around with the assertion, to try to fool Salesforce.com and get access to the Credit Suisse data? Well... he can try... Even forging every field in the assertion, without the Credit Suisse signing key, he cannot impersonate a Credit Suisse employee, since, ultimately, the signing certificate will not match that on file for Credit Suisse. Of course, it's possible for an implementation bug to subvert all this careful specification work, as we saw with the [Google/SAML vulnerability discovered last year](http://www.ai-lab.it/armando/GoogleSSOVulnerability.html).

Now, anyone familiar with Salesforce.com's implementation will be quick to point out that they don't in fact use SAML 2.0 persistent ID's, instead giving you the option of 'Federation ID' or Salesforce username. The former is an arbitrary string that the admin can set in the user entry at Salesforce.com, so you could use this in the same way as a SAML 2.0 persistent ID. Let's focus on the latter - Salesforce username, which is often, in fact, the user's email address - James' use case!

Now, let's imagine our rogue Goldman hacker has set his email address to _someone@creditsuisse.com_. Well, the remainder of the assertion has Goldman Sachs all over it, so, assuming Salesforce.com are using the assertion issuer name when they look up the email address, our hacker is still denied entry. And remember, we can't forge the issuer name, since that will provoke a mismatch on the certificate. I clearly can't see inside Salesforce.com's SAML implementation to check that they do match on the assertion issuer, but I can tell you that OpenSSO does exactly this. Again, SAML provides the framework to federate safely, but it's down to you, the implementer, to get it right. And you can improve your chances of doing so by using an off-the-shelf implementation rather than rolling your own.

James' other point on federation:

> [...] federation products tend to be separate and distinct from web access management products. So, in this scenario the application wouldn't even have an opportunity to protect itself as the federation product would simply create a cookie and not pass context as to how this user was authenticated.

Speaking for OpenSSO, we do _not_ separate federation and web access management. You can assign an authentication level to SAML federation and use that in policy. Perhaps 'level 1' is SAML, 'level 2' is local username/password and 'level 3' is a hardware token; the 'order entry' app might specify level 2, while the 'payroll' app would specify that level 3 authentication is required. There are other ways of implementing this that spring to mind; segregating local and federated users into different domains for example, or testing some attribute in the user profile.

All good points from James, I have to say, illustrating the fact that, even if your wire protocol is secure, implementation issues can easily lead to vulnerabilities.