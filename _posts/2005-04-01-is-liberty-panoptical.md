---
author: user
title: Is Liberty Panoptical?
slug: is-liberty-panoptical
id: 787
date: '2005-04-01 14:39:35'
layout: single
categories:
  - Federation
---

[Dr Stefan Brands](http://www.anonequity.org/en3/members.bio.php?ID=41), of [Credentica](http://www.credentica.com/) and [McGill University](http://crypto.cs.mcgill.ca/), recently [asserted](http://www.idcorner.org/index.php?p=85) that Liberty is ' [panoptical](http://encyclopedia.laborlawtalk.com/panopticon)'. [I questioned the applicability of this description](http://www.idcorner.org/index.php?p=85#comment-98), and Stefan kindly [blogged an explanation](http://www.idcorner.org/index.php?p=86). Stefan makes a number of good points, and I'd like to respond to some of them here.

> Specifically, in Liberty Alliance the Identity Provider knows all the user aliases with the different service providers, and is involved in real time whenever the user connects with a service provider. As such, it knows exactly which user is talking with what service provider at what moment, can cross-profile all the actions of the user across the entire circle of trust.

It is true that the identity provider (IdP) knows all the user aliases, but the IdP need not necessarily be involved in _every_ user contact with a service provider (SP). The user can still authenticate at the SP independently of the IdP. The user's account still exists there, it has merely been linked to the account at the IdP. The benefit in convenience of single sign-on has a cost in privacy that the IdP knows you are visiting the SP.  
Further, the IdP has no idea what the user is doing at the SP - it merely knows that the user went there at a particular time.

> Which of the following two distributed identity architectures is more privacy-invasive and prone to identity theft? One in which each user uses a single identifier for all service providers that he or she interacts with; or one in which a new central party is created that doles out different aliases for users for use with different service providers, and that is involved in real time in all the interactions between users and service providers in order to reconcile between user aliases and their "real" identities.

In every use case and real-world implementation I have seen so far, the identity provider is an existing organization that already has the users' data - wireless operators, employers, airlines etc. No 'new central party' is required or proposed. There can and will be multiple circles of trust, not just one great identity provider in the sky.  

> There is no reason why the User should inherently have more trust in the Identity Provider than in individual service providers...

Well, the specs obviously do not mandate this, but the reality is that identity providers are and will be organizations that users necessarily trust to some extent. And that trust will have to be earned and maintained lest users take their business elsewhere.

> Ultimately, it all depends on who the user trusts with what.

I couldn't agree more. I trust my employer with a lot of my personal information, and I would be happy for Sun Microsystems to act as an identity provider when I, for instance, access my 401(k) account or my health benefits, since they are linked to my employment. However, there is no reason for Sun to be my identity provider outside a work context. Depending on the setting, I might choose my bank, my ISP or my wireless operator. Or I might choose to forego the convenience of single sign-on and just authenticate directly to [CatsInBomberJackets.com](http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=%22cats%20in%20bomber%20jackets%22&btnG=Google+Search).

> Indeed, a sceptic might argue that the only party that genuinely benefits from the use of SAML 2.0/Liberty Alliance "pseudonyms" is not the user, but the Identity Provider: by preventing service providers from all getting to know the user under the same unambiguous name, service providers cannot engage in any user-related data sharing other than by going through the Identity Provider.

Separate pseudonyms per service provider are not mandated by Liberty, although it does obviously allow them and they are attractive from the identity provider's point of view, for the reasons Stefan mentions.  
Liberty's Identity Web Services Framework (ID-WSF) does indeed allow service providers to exchange data directly. The identity provider is instrumental in allowing those services to find each other via the discovery service, but has no knowledge of the details of their interaction. For example, my airline (SP) can ask my employer (IdP) where my preferred car rental agency (another SP) is. My employer verifies with me that it is ok to share this information, and then the airline can interact directly with the car rental firm without the IdP being involved.

> Again, from the privacy perspective of the user it is not clear at all that forcing all data transfers to go through a central choke point (even if encrypted) is truly a privacy or even security improvement over allowing direct transfers between service providers; which, once more, ties into the fact that users have only make-believe power to decide which data transfers about them are enabled and which spheres of activity remain segmented.

I'm not sure why the user's power is make-believe. Assuming that the user trusts that the IdP will act on his instructions, the user can link and unlink accounts at will. And, as I mentioned above, if I don't want to use single sign-on into a given service provider, I can just login directly.

> ...the identity provider (whether its insiders or hackers and viruses that gain insider status) can arbitrarily deny access in real time to a user on a selective basis and can arbitrarily impersonate that user - across the entire circle of trust.

Ah - the most apocalyptic version of this point. The identity provider has no powers of denial of service _whatsoever_. The user is always free to just login directly to whichever service provider he likes, without the identity provider being in the loop at all.  
Further, we can assume some sort of trust agreement between the IdP and the SP. If the SP does not trust the IdP, then the SP should not simply open its vault upon reception of an authentication response from the IdP.  
As an aside, one interesting feature of Liberty and similar protocols that we are starting to see in the real-world is that users can access services at SPs without actually identifying themselves to the SP. For example, I could access a wireless horoscope service. The horoscope provider doesn't care who I am, just that I am a paying subscriber of my wireless operator (the IdP) and my birthday is July 7th, which information I have explicitly directed the IdP to share with the SP. Is my privacy enhanced or reduced here? Sure, the wireless operator knows that I visit the horoscope service every day, but it knows that anyway, since it is in a position to monitor all my wireless internet traffic. But in this instance, the horoscope provider has no idea who I am.  
Finally, the Liberty Alliance's [door is always open to new members](http://www.projectliberty.org/membership/index.php) - any organization or individual can directly represent their point of view in the working groups and sponsors' meetings.