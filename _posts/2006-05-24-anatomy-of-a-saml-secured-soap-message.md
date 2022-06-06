---
author: user
title: Anatomy of a SAML-Secured SOAP Message
slug: anatomy-of-a-saml-secured-soap-message
id: 658
date: '2006-05-24 18:19:18'
layout: single
categories:
  - General
---

As promised, here is a dissection of the SOAP message from [yesterday's post on the AM 7.1 Beta Secure Web Services Tutorial](http://blog.superpat.com/2006/05/23/access-manager-7-1-beta-in-java-ee-toolsnetbeans-5-5-enterprise-pack/).

First, let's take another look at the secured message in its entirety:

```
<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns0="http://sun.com/stockquote.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <env:Header>
    <wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-01.xsd">
      <saml:Assertion xmlns:saml="urn:oasis:names:tc:SAML:1.0:assertion" AssertionID="s69f7e258e30da2b9b9f5799d4eb0c548782432bf" IssueInstant="2006-05-24T05:52:32Z" Issuer="patlinux" MajorVersion="1" MinorVersion="1">
        <saml:AuthenticationStatement AuthenticationInstant="2006-05-24T05:52:30Z" AuthenticationMethod="urn:com:sun:identity:Application">
          <saml:Subject>
            <saml:NameIdentifier>wsc</saml:NameIdentifier>
            <saml:SubjectConfirmation>
              <saml:ConfirmationMethod>urn:oasis:names:tc:SAML:1.0:cm:holder-of-key</saml:ConfirmationMethod>
              <KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
                <KeyName>CN=patlinux, OU=Sun Java System Application Server, O=Sun Microsystems, L=Santa Clara, ST=California, C=US</KeyName>
                <KeyValue>
                  <RSAKeyValue>
                    <Modulus>AIE1oq...</Modulus>
                    <Exponent>AQAB</Exponent>
                  </RSAKeyValue>
                </KeyValue>
              </KeyInfo>
            </saml:SubjectConfirmation>
          </saml:Subject>
        </saml:AuthenticationStatement>
        <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
          <SignedInfo>
            <CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
            <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
            <Reference URI="#s69f7e258e30da2b9b9f5799d4eb0c548782432bf">
              <Transforms>
                <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                <Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
              </Transforms>
              <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
              <DigestValue>zdCY/1iqOMUJq/RvxsaDPWM4+7c=</DigestValue>
            </Reference>
          </SignedInfo>
          <SignatureValue>ApcX/D...</SignatureValue>
          <KeyInfo>
            <X509Data>
              <X509Certificate>MIICmj...</X509Certificate>
            </X509Data>
          </KeyInfo>
        </Signature>
      </saml:Assertion>
      <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
        <SignedInfo>
          <CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
          <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
          <Reference URI="#se0ffabd98ecfdf194adc0c8ac8fb4edabf65cd3a">
            <Transforms>
              <Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
            </Transforms>
            <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
            <DigestValue>Sccy9a3A7Ps27f3pf9adkRWuGvU=</DigestValue>
          </Reference>
        </SignedInfo>
        <SignatureValue>aE9vKM...</SignatureValue>
        <KeyInfo>
          <SecurityTokenReference xmlns="http://schemas.xmlsoap.org/ws/2003/06/secext" wsu:Id="STR1">
            <KeyIdentifier ValueType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.0#SAMLAssertionID" wsu:Id="sbee70b80d8b330875655b8956d13ff5a4199ca1d">s69f7e258e30da2b9b9f5799d4eb0c548782432bf</KeyIdentifier>
          </SecurityTokenReference>
        </KeyInfo>
      </Signature>
    </wsse:Security>
  </env:Header>
  <env:Body wsu:Id="se0ffabd98ecfdf194adc0c8ac8fb4edabf65cd3a">
    <ns0:QuoteRequest>
      <Symbol>SUNW</Symbol>
    </ns0:QuoteRequest>
  </env:Body>
</env:Envelope>

```

It's pretty hard to see the wood from the trees here, particularly since there are two signatures in there. Here is a somewhat abstracted version:

![](http://blog.superpat.com/wp-content/uploads/2009/09/SAML-Assertion.png)

Working from the inside out:

*   The SAML `AuthenticationStatement` contains data from a SAML authority concerning a subject - that is, the person/service/device/whatever whose identity is in question here. In the `AuthenticationStatement` we can see a `Subject` element containing a `NameIdentifier` (which we could use to refer to this subject in future exchanges with this SAML authority) and a `SubjectConfirmation` element. The `ConfirmationMethod` element tells us how the assertion is bound to the subject. In this case, it is _Holder of Key_, indicating that the `SubjectConfirmation` also carries a public key. Assuming we trust the SAML authority, we can be confident that anything we receive that is signed with the corresponding private key came from the subject. You can clearly see an RSA public key, with its modulus and exponent, in the `KeyInfo` element.
*   Moving down, immediately after the `AuthenticationStatement` is a `Signature` (white in the diagram). This is an [_enveloped_](http://www.w3.org/TR/xmldsig-core/#def-SignatureEnveloped) signature over the parent `Assertion`. This signature binds the `Assertion` to the issuing SAML authority. It contains an X.509 certificate which we can use to verify the signature and decide if the assertion has come from a trusted SAML authority.
*   So, now we have an assertion that contains the public key of some subject known to a SAML authority. The next `Signature` element (blue in the diagram) is a [_detached_](http://www.w3.org/TR/xmldsig-core/#def-SignatureDetached) signature of the SOAP `Body`. This signature binds the `Body` (and its payload - the actual stock request that the recipient is going to process) to the subject. This `Signature` does not contain an X.509 certificate. Instead, it has a `KeyInfo` element that references the earlier `Assertion` - the recipient is to use the public key in the `Assertion` to verify the signature.

The recipient thus has all the pieces it needs to verify that

*   The message was not tampered with in transit
*   The body was signed by some subject identified by a SAML authority identified by an X.509 certificate.

In this entry I've covered the stock request as it appears on the wire. Next time round I'll look at how Access Manager 7.1's JSR 196 provider makes all this happen in the web container (App Server) with no code in the required in your web service consumer or producer.

### References

*   The [Web Services Interoperability Organization](http://www.ws-i.org/) (WS-I) [Basic Security Profile](http://www.ws-i.org/deliverables/workinggroup.aspx?wg=basicsecurity) (BSP) defines an interoperable structure of secure SOAP messages. The [SAML Token Profile](http://www.ws-i.org/Profiles/SAMLTokenProfile-1.0.html) defines the specifics as applied to SAML.
*   [Paul Madsen](http://connectid.blogspot.com/)'s [SAML 2: The Building Blocks of Federated Identity](http://www.xml.com/pub/a/2005/01/12/saml2.html) nicely covers some more of the background to SAML 2 and its components.
*   [The OASIS Security Services (SAML) TC page](http://www.oasis-open.org/committees/security/) is the authoritative source of the SAML 2.0 specifications.