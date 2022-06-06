---
author: user
title: What is Federation?
slug: what-is-federation
id: 741
date: '2005-09-22 10:25:02'
layout: single
categories:
  - Federation
---

[Rohan Pinto](http://blogs.sun.com/roller/page/rohanpinto) has posted an entry today entitled '[DE-Federated Identity Access (DEAF)](http://blogs.sun.com/roller/page/rohanpinto?entry=de_federated_identity_access_deaf)'. This is an interesting post, but Rohan picks up a misconception from Wikipedia, and perpetuates it. I'll step through Rohan's post here: (sorry, Rohan - I copied and pasted text, so I don't have all your links and markup here)

> Identity Management, and Identity Federation has been the buzzword in this space for a while now. According to the definition of "Federated Identity" on wikipedia, it has two general meanings:
> 
> *   The virtual reunion, or assembled identity of a person's user information (or principal), stored across multiple distinct identity management systems. Data is joined together by use of the common token, usually the user name.
> *   The process of a user's authentication across multiple IT systems or even organisations.

Wikipedia is just wrong here. Data need _not_ be "joined together by use of the common token, usually the user name." In fact, the prevailing model for identity federation (SAML 2.0/Liberty ID-FF) explicitly deprecates such a mechanism.  
Instead, accounts are linked via pseudonyms. The Identity Provider (IdP) assigns a unique 'name identifier' to each Service Provider (SP) account (effectively a foreign key). So, the system can navigate from a user's IdP account to that user's SP account and vice versa. However, the system cannot navigate directly from one SP account to another SP account. Neither is there any concept of a 'master identifier'.  
Rohan continues

> now, this is great when the Legal Entity has a unique "identity" on each of the disparate systems. But when the Legal Entity who has a identity on a system is provided access to a partner site or system, there is absolutely no "Federation" possible if the Legal Entity has no identity on the partner site or system.

Liberty (and SAML 2.0) defines the concept of one-time federation (I previously blogged about it [here](http://blogs.sun.com/roller/page/superpat?entry=one_time_federation)). A principal need not have an account at an SP. Instead, the principal can single sign-on (SSO) to the SP, identified only by the SAML assertion passed from the IdP to the SP in the SSO process - a one-time name identifier is used. Now the principal can access resources at the SP according to the information in the SAML assertion - which can include attribute-value pairs such as 'membership=gold'. If/when the principal re-visits the SP, a new one-time name identifier is user, so no correlation can be made between visits (leaving aside the possibility of cookies from the SP, of course).  
Alternatively, if appropriate, the SSO con proceed in the normal manner with a persistent name identifier, and the SP can dynamically create an account.

> I was involved in a brainstorming session related to shibboleth with a few technical folks from a university. What came up was the need to allow students from one university to access resources from another university. The folks I was interacting with were "sold" on the idea of federation, but lacked complete understanding of how federation really worked.  
> Here were my concerns:
> 
> *   The user needed to have a unique identity on either systems.
> *   The user needs to explicitly "federate" his identity. (If he does have a unique identity on each system)

Liberty/SAML do not explicitly define an offline 'batch' or 'bulk' federation mechanism, but one is possible, if you have an existing correlation between accounts - you can do the name identifier assignment and linking in a script for those accounts which you're 100% confident you have a correlation, and let the remaining principals create their own account link.

> *   If the users identity gets stolen, well, we have a much bigger issue.

Well - yes - if the user's IdP identity is stolen, then all of the SP accounts are vulnerable. However, if the user's SP identity is stolen, that cannot be leveraged into a wider compromise. An analogous situation exists for online banking with bill pay. You need to set up your account numbers for each payee - cellphone, [leccy](http://www.twochapstalking.com/dictarchive/000317.html), etc in your bank account's online bill pay system. Now, if someone steals a utility account - say your cellphone - your bank account and other utilities are safe. However, if someone steals your bank account identity, then all your other accounts are at risk, since online bill pay typically allows you to see the account details for each payee.

> (I thought) What the university really needed was implicit Federation. Whereby when a user who has authenticated himself at one university, when provided access to resources in another, should be granted access even thought the user does not have a unique identity at the other.

This is precisely what Shibboleth does, and what Liberty and SAML 2.0 can do with one-time federation.

> Here‘s an example:
> 
> 1.  University1 and University2 belong to a “defined” Circle of Trust.
> 2.  Student at University1 authenticates at University1\.
> 3.  Student tries to access resources at University2\.
> 4.  University2 Requests University1 to assert the validity of the user session.
> 5.  University1 Asserts that the user is “A“ authenticated user, but does not actually reveal the users “handle“ or “identity” in any form
> 6.  University2 grants the user access by just knowing that the user is a "authenticated" user at University1, without even knowing who the user actually is. (University2 provides just generic content to the user)

Yup - so far, this is all supported, out-of-the-box, by [Sun Java System Federation Manager](http://www.sun.com/software/products/federation_mgr/index.xml), [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml), and most other Liberty/SAML 2.0 compliant products.

> 7.  User tries to personalize his “content“ or University2 needs to provide the User “specific” content based on role the student has at University1
>     *   University2 would need to prompt the user for "permissions" to derive his "role" from UnIversity1
>     *   User grants permissions by using a digital signature of some sort.
>     *   University2 uses that digital signature to request University1 for the Users roles
>     *   University1 verifies that the digital signature matches that of the Authenticated User and grants University2 the users roles and/or "identity/alias".
>     *   University2 provisions a local "identity/alias" and associates it with the "role" as asserted by University1
> 8.  University2 can now allow the user to "personalize "content" or provide the user "content" as necessary.

This is the dynamic account creation I mentioned above. IIRC, you can get most of this working by simply configuring dynamic account creation in Access Manager - users who successfully authenticate have a new account created in the SP.

> I believe that with this aproach, even though a student has no "identity" on one system or university (University2 in the example I used) he/She still gets to experience the "magic" of "federation".

Right - and that's why the designers of Liberty built it into the system ![:-)](http://blogs.sun.com/roller/images/smileys/smile.gif ":-)")

> On second thoughts, If I apply this to the examples widely used in “federation”, where a airliner and a car rental company are in a circle of trust, well, I am sure that the car rental company would love to receive a new unidentified user from a “partner airline” and dynamically provision the user and sell him a pr oduct !!! it‘s all about making money in the bargain right ? or is it just making the user experience more enjoyable and easy ?  
> I believe that we‘d be kidding ourselves if we say that it‘s ONLY about “user experience“  
> Now: The user providing his/her “digital signature” to the car rental company is another story altogether.. ![;-)](http://blogs.sun.com/roller/images/smileys/wink.gif ";-)")

Heh - some assembly required...

> Comment Away Please...

Consider this a comment ![:-)](http://blogs.sun.com/roller/images/smileys/smile.gif ":-)")