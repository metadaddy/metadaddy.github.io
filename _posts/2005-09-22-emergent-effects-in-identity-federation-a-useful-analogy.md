---
author: user
title: Emergent Effects in Identity Federation - a useful analogy
slug: emergent-effects-in-identity-federation-a-useful-analogy
id: 740
date: '2005-09-22 12:52:29'
layout: single
categories:
  - Federation
---

[Very interesting entry](http://www.dontpanic-ii.org/posiwid/2005/09/surveillance-2.html) at [POSIWID](http://www.dontpanic-ii.org/posiwid/blogger.html) (POSIWID = 'the purpose of the system is what it does') today about the effects of systems such as the [panopticon](http://encyclopedia.laborlawtalk.com/panopticon) and the [Liberty Alliance Project](http://www.projectliberty.org/). I think it's a little premature to look for the effects of identity federation on users' behaviour, but a very useful analogy for identity federation occurred to me this morning. I mentioned it in the [last entry](http://blogs.sun.com/roller/page/superpat?entry=what_is_federation), but I think it's worth expanding on it here...  
Online bill pay is widespread now. You can log in to your bank's website, set up bill payees and then setup one-time or recurring payments. This is very like identity federation:

<table>

<tbody>

<tr>

<td>Bank</td>

<td>Identity Provider</td>

</tr>

<tr>

<td>Online banking credentials</td>

<td>IdP credentials</td>

</tr>

<tr>

<td>Utility (e.g. cellphone co)</td>

<td>Service Provider</td>

</tr>

<tr>

<td>Utility account details</td>

<td>Name identifier - links SP account to IdP account</td>

</tr>

<tr>

<td>Bill payment</td>

<td>Single sign-on</td>

</tr>

</tbody>

</table>

Now, all of your payee account details are typically visible in the online banking system. If your bank account login is compromised, then the attacker gets _all_ your account numbers and can go and do bad things like cancel your phone service, assuming he has any additional credentials required (typically SSN). However, if an attacker (e.g. an insider at the phone company) learns one of your utility account credentials, the remainder are safe, as is your bank account. You trust your bank with all the account numbers - after all, they have all your money, anyway ![:-)](http://blogs.sun.com/roller/images/smileys/smile.gif ":-)") - and get the convenience of online bill pay.  
This is precisely analagous to identity federation as implemented in Liberty and SAML 2.0\. You (the principal) have an account at the Identity Provider (IdP), and associated accounts at some set of Service Providers (SPs). The IdP has a name identifier to each SP account - each of which is unique for a given principal, in the same way as your cellphone account number is different from your electricity account number. If you trust the IdP, then the convenience of single sign-on (SSO) makes it worthwhile to link IdP and SP accounts. In fact, in a way, identity federation is 'safer', since the name identifier has no meaning outside SSO. You can't use it to try to manually login to the SP, for example.  
Now, returning to the question of effects. What has been the effect of online bill pay? Well, I believe (and I have nothing to back this up, so don't ask!) that it is a classic technology adoption curve. You have your early adopters, who are quick to jump on any new technology in order to realise the benefits asap. Then you have the mass market, who will adopt when they see that the tech is working, and the early adopters have (usually unwittingly) worked the bugs out of the system. Finally, there are the skeptics, who are going to continue mailing checks, no matter what. So, an increasingly large number of people save money on stamps, and the banks save money by not processing paper checks.  
It will be useful to watch identity federation as it continues along the adoption curve... POSIWID is a useful lens through which to observe systems.