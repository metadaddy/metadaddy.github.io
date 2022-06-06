---
author: user
title: SAML Single Sign-on with Desktop Apps - Enabled by OAuth
slug: saml-single-sign-on-with-desktop-apps-enabled-by-oauth
id: 945
date: '2009-11-12 16:55:52'
layout: single
categories:
  - Federation
tags:
  - google
  - oauth
  - saml
---

<span style="margin: 10px; float: right;">![OAuth from Desktop App Diagram](images/InstalledOauthDiagramTN.png "InstalledOauthDiagramTN")</span> One question that repeatedly comes up in any discussion of web single-sign on is "How do I get my desktop apps to play?". Often, [_Enterprise_ Single Sign-on](http://en.wikipedia.org/wiki/Single_sign-on#Enterprise_Single_Sign-On) (ESSO) is the answer - deploying an agent to the client desktop to automatically populate the username/password popup for Outlook, or whatever desktop app you're working with. This has always felt a bit clunky to me, particularly since you need a credential store somewhere in the system, but it works well enough for the username/password case. The ESSO approach breaks, however, if you've moved to a federated identity model, perhaps outsourcing your email to [Google Apps](http://www.google.com/apps/) and using [SAML](http://saml.xml.org/) for single sign-on so that, instead of end users logging in to the email system directly, they authenticate to an identity provider (IdP) within your enterprise, which sends a SAML assertion (a signed XML document containing the user's identifier and possibly other information) to Google as part of the web single sign-on process. Now the problem becomes: how do you use a fat email client such as Outlook, when (by design) Google knows nothing about the end users' passwords? Last week at [Internet Identity Workshop 9](http://iiw.idcommons.net/Iiw9) at the [Computer History Museum](http://www.computerhistory.org/) in Mountain View, CA, Google presented an approach to this problem, leveraging [OAuth](http://oauth.net/) as the glue between the web SSO world of SAML and the desktop view of Outlook. Well, they would have presented it, if the wifi had been more reliable; as it was, the Google engineers explained their solution to me :-) It works like this:

1.  A Google plugin in Outlook intercepts the authentication process, obtains an (unauthorized) OAuth request token from Google's OAuth service provider (SP) endpoint and invokes the browser with a <span style="text-decoration: line-through;">SAML SP</span> Google Auth URL, including the request token as a query parameter.
2.  Google Auth invokes Google's SAML SP, which redirects to the user's enterprise IdP.
3.  The user authenticates to the enterprise IdP (in the browser via whatever mechanism has been configured - typically username/password).
4.  The enterprise IdP redirects to Google with a signed SAML assertion containing the user's Google identifier.
5.  Google returns a page for the user to give permission for Outlook to access their email; the user gives consent, submitting a form back to Google. This is the OAuth protocol step that authorizes the request token and permits an OAuth access token to be issued later.
6.  Browser shows "Success" page.
7.  Outlook plugin detects success (I guess it watches the window title), requests an OAuth access token from the Google OAuth SP (sending the, now authorized, request token), and uses the access token as the password in subsequent IMAP/SMTP/POP3 authentications with the Google mail server.

The OAuth consent page (step 5 above) seems a little clumsy, but, without it, if the user were already logged in to the enterprise identity provider, there would be no user interaction in the process, allowing a desktop app to obtain the OAuth tokens, and, thus, access to the user's email account, without the user's consent. Probably not a good thing :-) All of this is documented in the following articles at Google - many thanks to [Eric Sachs](http://eric.sachs.googlepages.com/) for pointing me to the links:

*   [OAuth for Installed Applications](http://code.google.com/apis/accounts/docs/OAuthForInstalledApps.html) - how to use OAuth to access Google Apps from a desktop app. The article doesn't explicitly call out SAML, but, if you have enabled SAML on your Google Apps deployment, it gets used between steps 4 and 5 in the flow documented there.
*   [UX research on Desktop Apps using federated login and/or OAuth](http://sites.google.com/site/oauthgoog/UXFedLogin/desktopapps) - an older article describing the approach taken by Google.

_Note - I updated the flow above in light of [more input from Eric at Google](http://blog.superpat.com/2009/11/12/saml-single-sign-on-with-desktop-apps-enabled-by-oauth/comment-page-1/#comment-804)._