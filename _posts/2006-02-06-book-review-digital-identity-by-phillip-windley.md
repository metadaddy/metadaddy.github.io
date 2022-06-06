---
author: user
title: Book Review - Digital Identity by Phillip Windley
slug: book-review-digital-identity-by-phillip-windley
id: 711
date: '2006-02-06 00:33:55'
layout: single
categories:
  - Identity
---

One of the upsides of transatlantic flight is that you get a chance to catch up on your reading. I'm in Rome this week for a [Liberty Alliance Project](http://www.projectliberty.org/) plenary meeting, so I had about 12 hours airtime to read _[Digital Identity](http://www.amazon.com/exec/obidos/ASIN/0596008783/superpatterns-20)_, by Phillip Windley. Windley [blogs on identity management](http://www.windley.com/), and the cover blurb tells us that he was CTO of iMall Inc., VP of product development for Excite@Home and CIO in Governor Michael Leavitt's administration in Utah. Windley is now an Associate Professor of Computer Science at Brigham Young University.

Windley writes authoritatively and lucidly on the 'big picture' issues of identity management, although the book is marred by numerous distracting typographical errors ('security breeches' – now where can I buy me some of those???).

[![](http://images.amazon.com/images/P/0596008783.01._AA240_SCLZZZZZZZ_.jpg)](http://www.amazon.com/exec/obidos/ASIN/0596008783/superpatterns-20)

_Digital Identity_'s 226 pages can be divided into two sections. The first 12 chapters present an overview of digital identity and identity management. This part of the book is somewhat of a mixed bag. Chapter 9, on 'Names and Directories' is as good an introduction to the topic as I have seen anywhere. Windley explains why naming is critical, what a directory is and, perhaps most importantly, why it is different from a general purpose relational database. He even covers aggregation of identity data into metadirectories and virtual directories, giving the reader an understanding of the trade offs inherent between the two approaches. Similarly, I was delighted to read chapter 12 on 'Federating Identity'. Starting from the 'Mirage of Centralized Efficiency', Windley uses an analogy to the evolution of the Visa credit card system to show how digital identity is evolving through four phases:

<table border="1" cellpadding="4" cellspacing="3" style="page-break-inside: avoid">

<tbody>

<tr valign="TOP">

<td>

No federation – the user has separate credentials for each organization.

</td>

<td>

Consumer has separate credit relationships with individual merchants.

</td>

</tr>

<tr valign="TOP">

<td>

Ad-hoc federation – organizations link with individual business partners to achieve specific goals.

</td>

<td>

Bank of America launches BankAmericard in 1958, acting as a clearinghouse for credit between its customers and participating merchants.

</td>

</tr>

<tr valign="TOP">

<td>

Hub-and-Spoke federation – archipelagos of ad-hoc federation coalesce into clusters around powerful central players – the hubs. Hubs dictate operating rules and technical standards; spokes are left at a disadvantage.

</td>

<td>

Bank of America franchises its card to other banks nationwide in 1966, but licensees grow dissatisfied as Bank of America sets the terms of the relationship and struggles under the technical and operational burdens of maintaining the system.

</td>

</tr>

<tr valign="TOP">

<td>

Identity Network – independent entities are formed with the sole purpose of federating identities. Member organizations fund the identity networks through subscription.

</td>

<td>

In 1970, Bank of America and its licensees form National BankAmericard, later known as Visa, creating a new network with shared governance, a common purpose and a new vision.

</td>

</tr>

</tbody>

</table>

Unfortunately, when it comes down to technical details, Windley is less sure-footed. Chapter 6 – 'Integrity, Non-Repudiation and Confidentiality' is very muddled on the topic of serializing digital certificates, claiming “The certificate, being a data structure, is binary data”, then going on to explain how the _Distinguished Encoding Rules (DER)_ allow certificates to be serialized into a string of octets. Well, binary data _is_ a string of octets. In fact, digital certificates in the X.509 standard are abstract data structures expressed using _Abstract Syntax Notation 1 (ASN.1)_. It is from this abstract representation that DER gives us an unambiguous binary encoding.

Similarly, in Chapter 11, Windley's otherwise excellent coverage of SAML is let down by his reference to '_SAML authentication assertions_', '_SAML attribute assertions_' and '_SAML authorization assertions_' as three distinct assertion types. In fact, there is only one kind of _SAML Assertion_, which may contain one or more _statements_. Each statement may be an _authentication statement_, an _attribute statement_ or an _authorization statement_, so, crucially, a SAML authority can tell you that Alice was authenticated with a smartcard, she is in the engineering department _and_ that she is allowed to read the file at <font face="monospaced">http://foo.com/bar</font> all in the same assertion. Windley then goes on to describe the web browser single sign-on use case of SAML in terms of the '_pull profile_' and '_push profile_'. These are nicely descriptive names, but would be confusing for a reader who then turned to the [SAML 1.1 Bindings and Profiles Specification](http://www.oasis-open.org/committees/download.php/3405/oasis-sstc-saml-bindings-1.1.pdf) and found the definition of the '_browser/artifact'_ and '_browser/POST'_ profiles (renamed to '_HTTP artifact'_ and _'HTTP POST'_ bindings in [SAML 2.0](http://www.oasis-open.org/committees/security/#samlv20)).

The following 8 chapters present Windley's approach to creating an 'identity management architecture' (IMA), which he describes as

> "[...] a coherent set of standards, policies, certifications and management activities [...] aimed at providing a context for implementing a digital identity infrastructure that meets the current goals and objectives of the business, and is capable of evolving to meet future goals and objectives."

Here, Windley writes from his experience as a CTO and CIO, presenting a realistic approach to creating an IMA with the emphasis on iterative processes – limiting the initial effort if necessary and using feedback to improve the architecture rather than trying to create the perfect architecture in one 'big bang'. Working from a foundation of establishing governance for identity management, Windley covers business modelling (what's out there, rather than what should be!), documenting processes, analyzing identity data, creating an interoperability framework, building a policy stack and, finally, creating the reference architecture for the enterprise and then individual systems. Along the way, we are introduced to an 'Identity Maturity Model' – uncomfortable reading if you recognize aspects of your organization's identity management practice in the 'ad hoc' Level 1\. Throughout, Windley focuses on building consensus throughout the organization on the business benefits of an IMA, rather than the imposition of rules from the IT department – a recipe for avoidance and non-compliance.

Overall, I would recommend this book to enterprise architects looking to build your own identity management architecture. If you can look past the typos, and refer to source material for the technical minutiae, you will find a valuable approach to deciding what 'best practice' for your organization, and moving towards it. A corrected second edition could become 'the' introductory text to identity management in the enterprise.