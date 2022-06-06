---
author: user
title: Groups and Roles
slug: groups-and-roles
id: 781
date: '2005-05-06 21:40:32'
layout: single
categories:
  - Identity
---

Rohan Pinto [posts on the subject of groups and roles](http://blogs.sun.com/roller/comments/rohanpinto/home/in_the_beginning_there_were). Following on from Rohan's excellent description, there is one more salient detail. Roles and Groups are implemented (at least in [Sun's Directory Server](http://www.sun.com/software/products/directory_srvr_ee/index.xml)) in very different ways:

*   A group contains a collection of member <acronym title="Distinguished Name">DN</acronym>s. Navigating from a group object to its members is very fast. Finding the groups to which a given object belongs requires a search. The classic use for a group is a mailing list. Given a list name, I need to find the members so I can forward the email to them.
*   By contrast, a member object contains a list of DNs representing the roles to which it belongs. Navigating from an object to its roles is very fast. Finding the members of a role requires a search. The classic use for a role is in (surprise, surprise!) role-based access control. Given a user, I need to find the roles so I can provide access to appropriate resources.

There is much more to it than that - [here is an excellent reference to groups and roles](http://docs.sun.com/source/817-7613/rolescos.html) in Sun's Directory Server - but the description above should help guide you in deciding between groups and roles for a particular application.