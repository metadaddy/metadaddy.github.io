---
author: user
title: Demonstration of Identity Web Services
slug: demonstration-of-identity-web-services
id: 725
date: '2005-11-20 22:13:05'
layout: single
categories:
  - Identity
---

Following on from my [recent posting](http://blogs.sun.com/roller/page/superpat?entry=federation_manager_demonstation) of a [Federation Manager](http://www.sun.com/software/products/federation_mgr/index.xml ) demo showing [Liberty](http://www.projectliberty.org) [ID-FF](http://www.projectliberty.org/resources/specifications.php#box1) federated single sign-on, here is a demo of [Access Manager](http://www.sun.com/software/products/access_mgr/index.xml) and Federation Manager I showed at a Liberty 'eGovernment Forum' in Dublin back in April.

This demo shows an employee of the 'Department of Health and Children' logging into the department's portal, visiting another government department, the 'Stationery Office', to obtain an official report, and having the Stationery Office query their 'home' department for a mailing address via the Liberty Identity Web Services Framework ([ID-WSF](http://www.projectliberty.org/resources/specifications.php#box2a)).

This is a very simple demo, but it demonstrates some key aspects of Liberty ID-WSF:

*   'Bootstrap' from federated web single sign-on (ID-FF) to web services (ID-WSF).
*   Use of the [Discovery Service](http://www.projectliberty.org/specs/liberty-idwsf-disco-svc-v1.2.pdf) to locate a web service for a given user. (This takes place 'under the covers' - the bootstrap provides the service provider, in this example the Stationery Office, with the location of the Discovery Service and a credential to use on behalf of the employee. The service provider queries the Discovery Service for the location of the Personal Profile service).
*   Use of the [Personal Profile Service](http://www.projectliberty.org/specs/liberty-idsis-pp-v1.1.pdf) to retrieve a user's profile attributes.
*   Use of the RedirectRequest protocol (specified in the [Liberty ID-WSF Interaction Service Specification](http://www.projectliberty.org/specs/liberty-idwsf-interaction-svc-v1.1.pdf)) to allow the employee's 'home' department to prompt for confirmation that address information is to be released to the Stationery Office.

Just click the screenshot below to view the demo...

<table align="" border="0" cellpadding="5" width="500">

<tbody>

<tr>

<td align="center">[![](images/eGov_slide001.jpg)  
<span align="center">**Click to view Flash presentation**</span>](images/AccessManagerLibertyeGovDemoNew_viewlet_swf.html) </td>

</tr>

</tbody>

</table>

_UPDATED 11/21/2005 - corrected Interaction Service to RedirectRequest protocol - see comments_