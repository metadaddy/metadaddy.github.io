---
author: user
title: 'OpenSSO and EJBCA: Use Case'
slug: opensso-and-ejbca-use-case
id: 314
date: '2009-01-06 09:09:16'
layout: single
categories:
  - OpenSSO
---

<span style="margin: 5px; float: right;">[![](http://blog.superpat.com/wp-content/uploads/2009/09/ejbca.png)](http://blog.asyd.net/2009/01/opensso-and-ejbca-use-case/)</span>

[Bruno Bonfils](http://blog.asyd.net/), aka asyd, longtime denizen of [#opensso](http://wikis.sun.com/display/OpenSSO/OpenSSO+IRC+Channel), has [put together a VMware instance](http://blog.asyd.net/2009/01/opensso-and-ejbca-use-case/) with [OpenSSO](http://opensso.org/) and [EJBCA](http://www.ejbca.org/). In Bruno's words:

> The image was made to demonstrate an application protected by opensso. The application is divided in three parts, the first one is available for everyone (non authenticated users). The second part, the **secure area**, is available only for users authenticated in OpenSSO, and members of group _employee_. And finally, only users authenticated by certificates and member of group _employee_ can access to the **very secure area**.

Watch for a series of articles at [Sun Developer Network](http://developers.sun.com/identity/) ([feed](http://feeds.feedburner.com/IdentityManagementHeadlines)) describing the integration in more depth; in the meantime, you can go [download the instance and have a play](http://blog.asyd.net/2009/01/opensso-and-ejbca-use-case/) - instructions are included...