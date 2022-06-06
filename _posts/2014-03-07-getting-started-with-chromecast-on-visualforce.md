---
author: user
title: Getting Started with Chromecast on Visualforce
slug: getting-started-with-chromecast-on-visualforce
id: 1493
date: '2014-03-07 11:03:49'
layout: single
categories:
  - Toys
tags:
  - Chromecast
  - force.com
  - Visualforce
---

About a month ago, Google [released the Google Cast SDK](http://googledevelopers.blogspot.com/2014/02/ready-to-cast-chromecast-now-open-to.html), allowing developers to create apps that run on the [Chromecast](http://www.google.com/chromecast), a $35 digital media player. The primary use case of Chromecast is to stream media - movies, TV shows, music and the like - via wifi to your HDMI TV/monitor, but, looking at the SDK docs, it became apparent that the Chromecast is actually a miniature ('[system-on-chip](http://en.wikipedia.org/wiki/System_on_a_chip)') computer running [Chrome OS](http://en.wikipedia.org/wiki/Chrome_OS) (a Linux variant) and the Chrome browser. If it's running a browser, I wondered, could it load [Visualforce](http://wiki.developerforce.com/page/An_Introduction_to_Visualforce) pages from Salesforce and display, for example, a chart based on live data? If so, this would allow any HDMI-capable TV or monitor to be used as a dashboard at very low cost. When I was given a Chromecast by a colleague (thanks, [Sandeep](https://twitter.com/cloudysan)!) in return for alpha testing his app, I decided to find out! This first blog post explains how I ran a simple 'Hello World' sample on the Chromecast, loading the app from Visualforce. Next time, I'll show you how I pulled data from Salesforce via the REST API and showed it as a chart. [![Chromecast](images/Chromecast-300x225.jpg)](images/Chromecast.jpg) Chromecast setup was pretty straightforward - a matter of connecting the device to an HDMI input on my TV and a USB power source, downloading and running the Chromecast app, and following the prompts to complete setup. The Chromecast app locates the device on the local network using the [DIAL](http://en.wikipedia.org/wiki/DIscovery_And_Launch) protocol. Note that, since the app is communicating directly with the device, it won't work on wifi networks that enforce AP/Client Isolation (many offices and hotels). After installing the [Cast Extension for Chrome](https://chrome.google.com/webstore/detail/google-cast/boadgeojelhgndaghljhdicfkmllpafd) and verifying that the Chromecast could display content from YouTube, it was time to put the device into [development mode](https://developers.google.com/cast/docs/registration#RegisterDevice)! This actually proved to be pretty tricky - you need to enter the Chromecast's serial number into the Google Cast SDK Developer Console. Sounds straightforward, but the serial number is laser etched into the Chromecast's black plastic case in very small type indeed. I entered it incorrectly the first time round, and had to take a photo of the serial number and zoom in to see that the last character was an S and not an 8! [![Serial](images/Serial-241x300.png)](images/Serial.png) Another gotcha I encountered is that it's necessary to go into the Chromecast settings (in the Chromecast app) and enable **Send this Chromecast's serial number when checking for updates**. This information is on a [separate page](https://developers.google.com/cast/docs/developers#Get_started) from the device registration instructions, so it's easy to miss. Now my Chromecast showed up in the developer console, it was time to get an app running. Since the Chromecast has no input devices (keyboard, mouse, etc), a '[receiver app](https://developers.google.com/cast/docs/receiver_apps)' running in an HTML5 page on the device is controlled by a '[sender app](https://developers.google.com/cast/docs/sender_apps)' running on a 'second screen' such as a laptop, smartphone or tablet. The two apps are connected over the local network by a message bus exposed by the Google Cast SDK.

[![Diagram](images/Diagram.png)](https://developers.google.com/cast/)

Looking through [the samples](https://github.com/googlecast), [CastHelloText-chrome](https://github.com/googlecast/CastHelloText-chrome) looked like the simplest example of a [custom receiver](https://developers.google.com/cast/docs/custom_receiver). In the sample, the sender app, running on an HTML5 page in Chrome, allows you to enter a message ('Hello World' is traditional!) and sends it on the bus. The receiver app displays the message, and reflects it back to the sender, to demonstrate the bidrectional nature of the bus. It was straightforward to convert the vanilla HTML pages to Visualforce - the first change was to wrap the entire page in an tag and remove the `DOCTYPE`, since Visualforce will supply this when it renders the page.

```
<apex:page docType="html-5.0" applyHtmlTag="false" applyBodyTag="false"
           showHeader="false" sidebar="false" standardStylesheets="false"
           cache="false">
<!-- <!DOCTYPE html> -->
<html>
...rest of the page...
</html>
</apex:page>
```

Visualforce doesn't like HTML attributes with no value, so, in `chromehellotext`, I changed

```
<input id="input" type="text" size="30" onwebkitspeechchange="transcribe(this.value)" x-webkit-speech/>
```

to

```
<input id="input" type="text" size="30" onwebkitspeechchange="transcribe(this.value)" x-webkit-speech="true"/>
```

Adding the Visualforce pages to a Force.com Site made them public on the web. This is important - the Chromecast can only load public web pages - it has no way of authenticating to a server. You'll find out in the next blog post how I was able to access the Force.com REST API to securely retrieve content. Once I had a pair of public pages, I [registered my sample app](https://developers.google.com/cast/docs/registration#RegisterApp), entering the public URLs for my Visualforce pages, and pasted the resulting app ID into the `chromehellotext` page. Loading that page gave me a text control into which I could type a message. Hitting return to submit the message pops up the Cast device selector.

[![HelloSender](images/HelloSender.png)](images/HelloSender.png)

I selected my device from the list, and - 'BAM!' - my message popped up on the TV screen - success! [![HelloChromecast](images/HelloChromecast-300x225.jpg)](images/HelloChromecast.jpg) One very nice feature of the Chromecast is that it allows remote debugging in Chrome. You can find the device's IP address in the Chromecast app, say 192.168.1.123, and simply go to port 9222 at that address, in my example, http://192.168.1.123:9222/.

[![Debugger](images/Debugger.png)](images/Debugger.png)

You get the usual Chrome developer tools, right down to the ability to set breakpoints and inspect variables in JavaScript - marvelous!

[![Breakpoint](images/Breakpoint.png)](images/Breakpoint.png)

I've published the sample app, so you can try it out yourself. If you have a Chromecast, go to my [sender app page](https://patdevorg-developer-edition.na9.force.com/chromehellotext); you should be able to connect to your device and send a message. At this point, I had to do some thinking. The Chromecast, as I mentioned before, loads a page from a public web server. How could I show data on the page, preferably without making the data itself publicly available? [Read on to the next post!](http://blog.superpat.com/2014/03/21/display-any-visualforce-page-on-google-chromecast/) _Portions of this page are reproduced from work created and [shared by Google](https://developers.google.com/readme/policies/) and used according to terms described in the [Creative Commons 3.0 Attribution License](http://creativecommons.org/licenses/by/3.0/)._