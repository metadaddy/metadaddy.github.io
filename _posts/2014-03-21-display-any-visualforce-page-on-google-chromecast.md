---
author: user
title: Display ANY Visualforce Page on Google Chromecast
slug: display-any-visualforce-page-on-google-chromecast
id: 1516
date: '2014-03-21 15:22:47'
layout: single
categories:
  - Uncategorized
tags:
  - Chromecast
  - force.com
  - Visualforce
---

[Last time](http://blog.superpat.com/2014/03/07/getting-started-with-chromecast-on-visualforce/), I described how I ran a simple 'Hello World' application, served from a Force.com Site, on the [Google Chromecast](http://www.google.com/chromecast), a $35 digital media player. In this blog entry, I'll show you how to show _any_ Visualforce page, not just a public page on a Force.com Site, on the Chromecast.

![IMG_1579](images/IMG_1579.jpg)

A quick recap... (Skip this paragraph if you've already read [the previous entry](http://blog.superpat.com/2014/03/07/getting-started-with-chromecast-on-visualforce/)). Chromecast is actually a tiny wifi-enabled Linux computer, running the Chrome browser, connected to a TV or monitor via HDMI. A 'receiver' app, written in HTML5, runs on the device, which has no input capability (mouse/keyboard), while a 'sender' app runs on a 'second screen' such as a laptop, smartphone, or tablet, the two apps communicating across the local wifi network via a message bus. The sender app typically allows the user to navigate content and control the media stream shown on the Chromecast (the 'first screen'). The [CastHelloText-chrome](https://github.com/googlecast/CastHelloText-chrome) sample allows the user to type a message in the sender app on the first screen, and displays it on the second screen via the receiver app. Given a working sample, the next question was, how to access data from the receiver app? The core problem is that the Chromecast can only load a public web page - it can't login to Force.com. The sender app runs on a desktop browser, smartphone or tablet, however, so perhaps it would be possible to login there, and send a session ID to the receiver app via the message bus? I worked through a few alternatives before I hit on the optimal solution:

### Load the Visualforce page via Frontdoor.jsp

Frontdoor.jsp, which has existed for some time, but has only been [formally documented and supported since the Winter '14 Salesforce release](http://docs.releasenotes.salesforce.com/en-us/winter14/release-notes/security_frontdoorjsp.htm), "gives users access to Salesforce from a custom Web interface, such as a remote access Force.com site or other API integration, using their existing session ID and the server URL". To authenticate users with frontdoor.jsp, you pass the server URL and session ID to frontdoor.jsp in this format: `https://instance.salesforce.com/secur/frontdoor.jsp?sid=_session_ID_&retURL=_optional_relative_url_to_open_` Sounds perfect! The only problem is that the session ID you pass to frontdoor.jsp must come from one of:

*   The access_token from an OAuth authentication (obtained with 'web' or 'full' scope)
*   The LoginResult returned from a SOAP API login() call
*   The Apex UserInfo.getSessionId()

The session ID from a Visualforce page or controller isn't going to cut it here. So, I reached for [Kevin O'Hara](https://twitter.com/kevino80)'s excellent [nforce](https://github.com/kevinohara80/nforce) and built a quick Node.js sender app that has the user authorize API access via OAuth (including web scope!), runs a query for the list of Visualforce Pages in the org and presents them as a drop-down list. You can choose a Visualforce Page, hit 'Send', and the sender app constructs the frontdoor URL with the OAuth access token and relative URL for the page and sends it to the receiver via the message bus.

![Screen Shot 2014-03-21 at 12.09.08 PM](images/Screen-Shot-2014-03-21-at-12.09.08-PM.png)

Note that, while you can indeed send any Visualforce page to the Chromecast for display, remember that the Chromecast doesn't have any capacity for user input, so tables and charts work best. I tried a couple of approaches for the receiver app; first I simply redirected to the frontdoor URL, but then I realized that it would be more useful to load the frontdoor URL into a full-page iframe. That way, the receiver app could stay running in the 'top' document, ready to receive a different URL, and periodically reloading the iframe so that the session doesn't time out. Here it is in action: <iframe src="//www.youtube.com/embed/0tWnaOYqUzM" height="360" width="480" allowfullscreen="" frameborder="0"></iframe>All of the code is in my [CastDemo project on GitHub](https://github.com/metadaddy-sfdc/CastDemo). Feel free to fork it, extend it, and let me know in the comments how it works out. When it came down to the code, this was a very straightforward integration; the vast majority of the work was thinking around the problem of how to have a device with no input capability authenticate and load a Visualforce page. Now that Frontdoor.jsp is documented and supported, it's an essential tool for the advanced Force.com developer. _POSTSCRIPT:_ Almost as soon as I hit 'publish' on this post, I realized I could push the app to [Heroku](http://heroku.com/), and allow _anyone_ with a Chromecast and API access to Salesforce to see their Visualforce Pages on TV. [Read the next installment here](http://blog.superpat.com/2014/03/25/visualforce-on-chromecast-as-a-service/).