---
author: user
title: Quick Guide to Access Manager 7.0 Site Configuation
slug: quick-guide-to-access-manager-7-0-site-configuation
id: 659
date: '2006-05-24 15:04:58'
layout: single
categories:
  - Access Manager
---

[![](http://www.sun.com/software/images/products/I1_crosswalk.jpg){: .align-left}](http://www.sun.com/software/products/access_mgr/index.xml) This came across the internal [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) mailing list today. It's too good not to post. Many thanks to David, Beomsuk and Subash for compiling this.

### Overview

Site configuration in AM 7.0 provides a facility that lets Access Manager clients communicate with load-balanced Access Manager instances. While this was possible in Access Manager 6.x, site configuration provides several advantages:

*   Access Manager instance URLs are not held in state by Access Manager clients
*   Configuration is far easier and less error-prone than with Access Manager 6.x
*   Site configuration supports deployments with multiple load balancers, and with firewalls around each site, with no changes required to firewall configuration

### Access Manager 6.x Naming Table on Client Side

All Access Manager clients use a naming URL stored in the client configuration (usually AMAgent.properties) to retrieve a client-side naming table, which is held in state on the client. For 6.x clients, the client-side naming table holds the URLs of needed Access Manager services for each Access Manager instance. The URLs refer to the Access Manager instances. Thus, information about servers that are likely secured behind firewalls are held in client state, which is a potential security problem.

### Client to Access Manager Instance Access in AM 6.x

When a 6.x Access Manager client accesses an Access Manager instance on behalf of a user attempting to access a web app, it accesses the instance directly (assuming the user has a valid SSO token). Depending on the Access Manager service required, the client dynamically build the URL for the service based on the instance ID stored in the session token and the URLs in the naming service table. A load balancer fronting the Access Manager instances is ignored in this scenario.

This works fine as long as there is not a firewall in between the client and Access Manager instances. In this case, the client is not able to get through the firewall to the required URL on the Access Manager.

So in the scenario in which multiple Access Manager instances are fronted by a load balancer, with a firewall somewhere in the mix, it is necessary for the Access Manager client to go to the load balancer instead of directly to the Access Manager instance.

You can force an Access Manager client to do this either by setting up the /etc/hosts file so that all the FQDNs of the Access Manager instances point to the IP address of the load balancer, or by setting the com.iplanet.am. naming.ignoreNamingService property to true.

Therefore, each client has to have this property set, and whether the property should be set or not is dependent on the location of firewalls and load balancers in the topology.

### Access Manager 7.0 Naming Table on Client Side with Sites Defined on Access Manager

For 7.0 clients, if a site is defined in the platform service, the client-side naming table holds the URLs of needed Access Manager services for each Access Manager site. The URLs refer to the Access Manager sites - load balancers - and not instances. Thus, information about servers that are likely secured behind firewalls are not held in client state, eliminating the potential security problem from 6.x.

### Client to Access Manager Instance Access in AM 7.0 with Sites Defined on Access Manager

When a 7.0 Access Manager client accesses an Access Manager instance on behalf of a user attempting to access a web app, it accesses the Access Manager site (assuming the user has a valid SSO token). Depending on the Access Manager service required, the client dynamically builds the URL for the service based on the site ID stored in the session token and the URLs in the naming service table. Therefore, all requests go through a load balancer.

If there is not a firewall in between the client and Access Manager instances, it is not a problem, because the client should be able to get to the load balancer.

There is no need for any special configuration on the client to make this all work. As long as the nameing URL points to the load balancer, all is well.

### Multiple Site Support in 7.0

Consider the case where you have multiple sites. Suppose you have:

*   A Web Server in San Francisco with a protected URL
*   A Web Server in Tampa with a protected URL
*   An Access Manager site with a load balancer and multiple firewalled AM instances in San Francisco
*   An Access Manager site with a load balancer and multiple firewalled AM instances in Tampa

You want an end user who has authenticated with the San Francisco site to be able to access the protected URL in the Tampa without re-authenticating.

In 7.0, with sites configured in the Platform Service, an Access Manager instance in San Francisco is able to perform session validation on an Access Manager instance in Tampa by referencing the Tampa load balancer.

In 6.3, although enabling the com.iplanet.am. naming.ignoreNamingService property might let the San Francisco *agent* get to the Tampa load balancer, there is no way for an Access Manager instance in San Francisco to get to the Tampa load balancer for session validation. An Access Manager instance in San Francisco can only reference the Access Manager instances in Tampa defined in the platform service. So, if these instances are firewalled, the SFO AM instance cannot reach the Tampa instance.

Making a multiple site deployment work in 6.3 requires firewall configuration in ways that are likely to be unacceptable to users.

### If No Sites Are Defined in 7.0

Access Manager should work identically to how it worked in 6.x. You can define configurations with multiple instances in the platform service, configure the fqdnMap, and add realm DNS aliases as needed. But if there is a firewall behind the load balancer, the deployment will fail.

### Server-Side Configuration in Access Manager 7.0

To configure Access Manager 7.0 to support sites, you need only do the following:

*   Define the site and instance lists in the platform service
*   Add realm DNS aliases as required in the realm properties for the top-level realm

### Server-Side Configuration in Access Manager 6.x

To configure Access Manager 6.x to support multiple instances, do the following:

*   Define instances in the Platform Service
*   Define the fqdnMap property in the AMConfig.properties file
*   Add realm DNS aliases as required in the realm properties for the top-level realm
*   Configure clients as necessary, depending on firewall locations

### Summary

The 7.0 site configuration capability provides enhancements to Access Manager security and ease of configuration.