---
author: user
title: OpenSSO at CALGB
slug: opensso-at-calgb
id: 366
date: '2008-09-29 15:39:41'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/CALGB.png)](http://www.calgb.org/)</span>

The Cancer and Leukemia Group B ([CALGB](http://www.calgb.org/)) is a national clinical research group sponsored by the [National Cancer Institute](http://www.cancer.gov/), with its [Central Office](http://www.calgb.org/Public/about/centraloffice_role.php) headquartered at the [University of Chicago](http://www.uchicago.edu/) and its [Statistical Center](http://www.calgb.org/Public/about/statcenter_role.php) located at [Duke University](http://www.duke.edu/).

A couple of weeks ago, Robert Dale of CALGB contributed an [OpenSSO/Spring Security integration](http://blogs.sun.com/superpat/entry/opensso_spring_an_open_source) to the [OpenSSO project](http://opensso.org/). I asked him how CALGB were using OpenSSO, and he was good enough to send me this explanation and allow me to publish it.

> We're probably not too different than many places where we have many applications each using its own authentication mechanism from disparate data stores. The primary goal here is to unite all these applications to use the same authentication mechanism using a single data store, hence a single username and password. Because we deal with clinical data, HIPAA comes into play. So certain applications need specific restrictions, for instance having a session timeout in 15 minutes. Other applications - administrative, those for developers, IT staff - can be logged in all day long. Therefore our secondary goal is to place these policies across all the apps. We have our own authorization and audit system and won't be using those from OpenSSO.
> 
> We also have the case where we need to federate to other identity providers, such as [caBIG](https://cabig.nci.nih.gov/), so our users can seamlessly use the grid applications. But we also share data with labs and other facilities that develop their own applications and need to federate identities (and authorizations) to us either through user interaction and/or web services. And in one special case, we have an authentication module that authenticates users via webservice to [CTSU](http://www.ctsu.org/) where they don't yet have federated identities.

This is a great mini-case study of an OpenSSO deployment - internal SSO, federation, web services and a bit of customization on the side. It's great, too, to be able to support such vital research through OpenSSO - CALGB didn't have to ask or tell us about their OpenSSO deployment - they just got on and got it done, and were good enough to share their success story with us.

Have you deployed OpenSSO? Care to share your story? <script type="text/javascript" language="javascript"><!-- ML="h.ucn D<>!/alisrt\"efop:@m="; MI="7;50?BCIAH;=<@DFE;@1E;@@B?>D4G>2413DHA86?DE5HB5;45BH;=<97:;8"; OT=""; for(j=0;j<MI.length;j++){ OT+=ML.charAt(MI.charCodeAt(j)-48); }document.write(OT); // --></script>