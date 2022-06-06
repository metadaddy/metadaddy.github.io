---
author: user
title: 'Location, Location, Location'
slug: location-location-location
id: 767
date: '2005-06-11 21:23:43'
layout: single
categories:
  - Identity
---

Location as an attribute - sorry, 'claim', - of identity has been [buzzing](http://vquill.com/2005/06/where-in-idm.html) [around](http://www.identityblog.com/2005/06/05.html#a248) [the identity](http://www.ldap.com/1/commentary/wahl/20050606_01.shtml) [blogosphere](http://blogs.sun.com/roller/page/superpat/20050606#location_and_authorization) [these past few days](http://blogs.sun.com/roller/page/tkudo/20050609#location_based_identity_provisioning). This comment by [Bob Blakley](http://www.almaden.ibm.com/institute/bio/index.shtml?blakley) (I'm guessing this is the right Bob Blakley - somebody _please_ correct me if I'm wrong!) on [Kim Cameron's Identity Blog](http://www.identityblog.com/) is particularly interesting:

> The ISO 10181-3 Access Control framework was very clear about this, so there's really no need to be unclear. 10181-3 divided authorization attributes into categories: (1) subject attributes, (2) target attributes, (3) request attributes, (4) context attributes. The POLICY took all these attributes into account when making a decision. Identity claims are subject attributes. Location claims, because they are not unique to a subject and because a subject's location may change (and because the protocols carrying requests usually do not natively support location) are context attributes. Trying to make location an identity (=subject) attribute will greatly complicate the storage and management of identity information, with no gain in functionality over what is already gained by treating location (properly) as a context attribute. Time, as you point out, Mark, is also a context attribute, as is "client device capability".

It struck me tonight that the answer to the question of whether location is a subject attribute or a context attribute is (as usual) "it depends". In applications where a policy requires that a subject's location meet some criterion to gain access to a resource, location is indeed a context attribute. However, it isn't quite that simple.  
Consider a simple weather service for cellphone users. The user sends the word 'forecast' as an SMS message to the service. The service responds with an SMS message containing the day's forecast (and probably also an ad targeted at your current location). As far as the weather service is concerned, your only identity is your location. It doesn't care who you really are, or even if you are the same you that requested a forecast from a different location yesterday. I would contend that, in this context, location _is_ a subject attribute.  

**UPDATE:** See [comments](http://blogs.sun.com/roller/comments/superpat?anchor=location_location_location) - [Alan Nichols](http://holyhippie.livejournal.com/) clears this up with the concept of the anonymous user.