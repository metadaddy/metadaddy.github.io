---
author: user
title: Federated Provisioning - Liberty to the Rescue???
slug: federated-provisioning-liberty-to-the-rescue
id: 293
date: '2009-02-14 08:19:18'
layout: single
categories:
  - Identity
---

<span style="margin: 5px; float: right;">[![](images/libertylogo.jpg)](http://www.projectliberty.org/resource_center/specifications/)</span>

I thought I'd throw my hat into the ring of the current federated provisioning discussion ([Ian](http://www.tuesdaynight.org/2009/02/05/will-the-real-federated-provisioning-please-stand-up.html), [Nishant](http://blogs.oracle.com/talkingidentity/2009/02/the_thing_about_federated_prov.html), [Ian again](http://www.tuesdaynight.org/2009/01/07/down-with-federated-provisioning.html), [James](http://duckdown.blogspot.com/2009/02/federated-provisioning.html)) ...

Looking at the contentious #2 in [Nishant's post](http://blogs.oracle.com/talkingidentity/2009/02/the_thing_about_federated_prov.html), the [Liberty Alliance](http://projectliberty.org/) standardized one approach to this several years ago with [ID-WSF](http://www.projectliberty.org/resource_center/specifications/liberty_alliance_id_wsf_2_0_specifications_including_errata_v1_0_updates).

To recap the scenario:

> Suppose two companies, Acme and Omega enter into a federation agreement, whereby employees of Acme will be able to access a service at Omega using their Acme credentials. There are two scenarios here for federated provisioning.
> 
> [...]
> 
> Acme decides that they are not going to decide beforehand which employees are allowed to access Omegas service. Instead, a link to the service is available on Acmes intranet, and whenever a user decides to go to the service, they should be given an account. In this case, no pre-provisioning is taking place. Instead, the provisioning has to occur in real-time, when the user accesses the service via the intranet link for the very first time.
> 
> The idea here is that when Omegas federation server encounters the incoming SAML token for a new user, it would recognize that the user does not have a federated account, and send the SAML token to Omegas provisioning server. The provisioning server would create the account right then and there, and return the necessary result back to the federation server so that the federation server can proceed to grant the user access.

Now, in my Liberty-tinged version, when sending a new user to Omega, Acme includes a reference to their [Employee Profile (EP) service](http://www.projectliberty.org/resource_center/specifications/liberty_alliance_id_sis_1_0_specifications) - essentially the service's endpoint URL - in the SAML assertion. This endpoint reference serves as both a description of where to find the service and permission for Omega (when sent as part of the signed SAML assertion) to invoke that service.

On receiving the assertion, Omega send a signed request to the EP service, the request containing the SAML assertion it just received. Now, the EP service knows that Omega is entitled to access that employee's data, since it has a signed SAML assertion, issued by Acme itself, that says exactly that (via the presence of the EP endpoint reference). The EP can return exactly the data required (this will have been configured according to the underlying contract between Acme and Omega).

Finally, if desired, the EP can leave a marker in the employee's account that says 'account provisioned at Omega', so that Acme doesn't send the EP reference in every SAML assertion. Alternatively, Acme could deliberately send the EP reference every time. Or even reset the marker when the employee's account changes in a significant way (say, her purchasing limit is changed) so Omega can fetch the new employee data.

In scenarios where manual intervention is required on the Acme side, the EP service can return a response that says "Come back later", and the Omega service relay that to the user.

Of course, de-provisioning is a different kettle of fish, but the advantage of federated access to services is that, once the employee is gone from the Acme end, he has no way to access the Omega service anyway, so de-provisioning is a little less urgent than if the employee was logging in to Omega directly.

Like I said, ID-WSF has been around for years. Perhaps it hasn't had much adoption because businesses weren't encountering the problems that it solves. Seems like that might change now...