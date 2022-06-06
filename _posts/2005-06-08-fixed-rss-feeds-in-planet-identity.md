---
author: user
title: Fixed RSS feeds in Planet Identity
slug: fixed-rss-feeds-in-planet-identity
id: 770
date: '2005-06-08 08:49:46'
layout: single
categories:
  - Identity
---

[Planet Identity](http://planetidentity.org/)'s RSS feeds have been broken since I created it last week. The problem was that certain elements containing URIs were not being escaped properly - the parse would break on any '?'s and '&'s. I finally sat down this morning and spent 20 minutes googling for the answer - and it's really simple - you just edit the RSS feed templates and specify that URIs such as the link element and the url attribute of the source element should be HTML escaped and all is well.