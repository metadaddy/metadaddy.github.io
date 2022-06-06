---
author: user
title: SAML 2.0 HTTP-SimpleSign Support in OpenSSO SAML 2.0 PHP Extension
slug: saml-2-0-http-simplesign-support-in-opensso-saml-2-0-php-extension
id: 523
date: '2007-06-18 06:03:18'
layout: single
categories:
  - OpenSSO
---

[<span style="margin: 5px; float: right;">![](https://opensso.dev.java.net/public/extensions/openssoex.gif)</span>](https://opensso.dev.java.net/public/extensions/)

You might be aware of the [SAML 2.0 HTTP-SimpleSign binding](www.oasis-open.org/committees/download.php/22713/draft-sstc-saml-binding-simplesign-cd-01.pdf) from blog posts by [Jeff Hodges](http://identitymeme.org/archives/2007/02/02/latest-revision-of-saml-http-post-simplesign-binding-spec/) (co-author of the spec, with Scott Cantor) and [George Fletcher](http://practicalid.blogspot.com/2007/05/aol-supports-simple-federation-with.html). Put simply, HTTP-SimpleSign offers a simpler way to sign [SAML 2.0](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=security#samlv20) data, by simply signing the XML and other text data to be sent to the service provider verbatim, without any canonicalization. It works quite neatly, since the XML is base64 encoded and sent from the identity provider to the service provider via browser POST, so there are no intermediaries who might benignly munge it about and cause signature verification to fail.

George's report of AOL's HTTP-SimpleSign implementation prompted me to go add it to [OpenSSO's SAML 2.0/PHP Extension (formerly known as 'Lightbulb')](https://opensso.dev.java.net/public/extensions/). It took about an hour, all told, since the main difference from the traditional HTTP POST signature verification:

```
function checkXMLSignature($token) {
$objXMLSecDSig = new XMLSecurityDSig();
$objXMLSecDSig->idKeys[] = 'ID';
$objDSig = $objXMLSecDSig->locateSignature($token);
/* Must check certificate fingerprint now - validateReference removes it */
if ( ! validateCertFingerprint($token) )
{
throw new Exception("Fingerprint Validation Failed");
}
/* Canonicalize the signed info */
$objXMLSecDSig->canonicalizeSignedInfo();
$retVal = NULL;
if ($objDSig) {
$retVal = $objXMLSecDSig->validateReference();
}
if (! $retVal) {
throw new Exception("SAML Validation Failed");
}
$key = NULL;
$objKey = $objXMLSecDSig->locateKey();
if ($objKey) {
if ($objKeyInfo = XMLSecEnc::staticLocateKeyInfo($objKey, $objDSig)) {
/* Handle any additional key processing such as encrypted keys here */
}
}
if (empty($objKey)) {
throw new Exception("Error loading key to handle Signature");
}
return ($objXMLSecDSig->verify($objKey)==1);
}

```

is to just verify the signature directly on the SAML XML text and other parameters:

```
function checkSimpleSignature($params,$cert) {
$rawSignature = $params['Signature'];
$relayState = $params['RelayState'];
$sigAlg = $params['SigAlg'];
$samlResponse = base64_decode( $params['SAMLResponse'] );
$signature = base64_decode($rawSignature);
if (strcmp($sigAlg,XMLSecurityKey::RSA_SHA1) != 0) {
throw new Exception("Signature algorithm ".$sigAlg." is not supported");
}
if ( isset($params['RelayState'] ) ) {
$signedData = "SAMLResponse=".$samlResponse."&RelayState=".$relayState."&SigAlg=".$sigAlg;
} else {
$signedData = "SAMLResponse=".$samlResponse."&SigAlg=".$sigAlg;
}
return (openssl_verify($signedData, $signature, $cert) == 1);
}

```

The difference in complexity may not look substantial, due to the excellent XML Signature support from [Rob Richards](http://www.cdatazone.org/)' <a href"http:="" www.cdatazone.org="" index.php?="" archives="" 12-slides-from-phpworks-2006.html"="">XML Security library</a>, but it's a huge difference if you're implementing from scratch.

I've done some informal testing and everything seems to check out. If you are working with HTTP-SimpleSign on the IdP end, please do grab the SAML2.0/PHP code, check it against your implementation and report back.