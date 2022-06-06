---
author: user
title: Location and Authorization
slug: location-and-authorization
id: 771
date: '2005-06-06 11:17:08'
layout: single
categories:
  - Identity
---

[Dave Kearns](http://vquill.com/) recently [mused on the use of location in access control](http://vquill.com/2005/06/where-in-idm.html):

> I could see [the user's location] being used in a [graded authentication](http://www.networkworld.com/newsletters/dir/2002/01485965.html) scheme to reduce or deny access based on a possibly adverse location (e.g., someone trying to access a Pentagon database from Uzbekistan).

and [Kim Cameron](http://www.identityblog.com/) responded, [mapping this into his identity metasystem vision](http://www.identityblog.com/2005/06/05.html#a248):

> In the identity metasystem, the relying party could indicate in its policy that it requires several sets of identity claims- one indicating who the user is, and another indicating where the user is. The claims might come from different authorities (e.g. an enterprise and a trusted location provider). These would be implemented as two Security Token Services (claims transformers). Both sets of claims, taken together, would identify the user from the point of view of the relying party.

Now, first, I have to agree with Dave's [2002 article](http://www.networkworld.com/newsletters/dir/2002/01485965.html) - this does indeed seem more like authorization than authentication. Now to the question of geo-location... Liberty defined the ID-SIS [Geolocation Service](http://www.projectliberty.org/resources/specifications.php#ID-Geoloc) earlier this year. An access control system (like, say, [Sun Java System Access Manager](http://www.sun.com/software/products/access_mgr/index.xml)) can implement policy based on location (or any other attribute or 'claim'). So, an application (or, more likely, some agent protecting that app - in access control jargon a 'policy enforcement point' or PEP) can provide access to a given resource depending on policy constraints such as "Is the user within 100m of location X". When a user attempts to access the resource, the PEP sends a policy query for that constraint to the access control system's 'policy decision point' (PDP). The PDP queries the geolocation service for the user's current location and responds 'true' or 'false' to the PEP accordingly, which then grants or denies access to the resource as appropriate.  
The elegance of this approach is that only one component of the system (the PDP) need be trusted with the user's identity (this might also be possible in Kim's identity metasystem). The information available to other components around the network is limited to exactly what they need to know - i.e. does the user's identity meet a given constraint. And, of course, you could deploy such a system right now using products from [a number](http://www.nokia.com/nokia/0,,62629,00.html) [of vendors](http://www.ericsson.com/products/hp/Single_Sign_On__SSO__Digital_Identity_pa.shtml), since all of the above is defined by Liberty and is shipping today.