---
author: user
title: 'Visualforce on Chromecast, as a Service!'
slug: visualforce-on-chromecast-as-a-service
id: 1534
date: '2014-03-25 16:54:31'
layout: single
categories:
  - Uncategorized
tags:
  - Chromecast
  - force.com
  - Visualforce
---

After writing [my last blog entry, on how to display any Visualforce Page on Google Chromecast](http://blog.superpat.com/2014/03/21/display-any-visualforce-page-on-google-chromecast/), it occured to me that I could run the app on Heroku. So, if you have a [Google Chromecast](http://www.google.com/chromecast), and a Salesforce login with API access enabled, you can try it out right now. Go to [https://vf-chromecast.herokuapp.com/](https://vf-chromecast.herokuapp.com/); you'll see this page: ![Visualforce on Chromecast](images/Screen-Shot-2014-03-25-at-4.30.42-PM-1024x793.png) Follow the instructions, log in, authorize the app to access your data, and you'll be able to select a Visualforce Page to 'cast' to your TV. [![Select a Visualforce Page](images/Screen-Shot-2014-03-25-at-4.32.32-PM-1024x793.png)](images/Screen-Shot-2014-03-25-at-4.32.32-PM.png) One new feature here - if you select a Visualforce Page that uses a standard controller, and is thus expecting a record ID as a parameter, you'll get the opportunity to select a record. For simplicity, I'm just showing the first 10 records returned by the database. [![Select a Record](images/Screen-Shot-2014-03-25-at-4.33.38-PM-1024x793.png)](images/Screen-Shot-2014-03-25-at-4.33.38-PM.png) Choose a record, hit send, and you'll see the page displayed by the Chromecast, in this case, it's a Mini Hack we ran a couple of Dreamforces ago: [![Success](images/IMG_1651-1024x768.jpg)](images/IMG_1651.jpg) As always, [the code is on GitHub](https://github.com/metadaddy-sfdc/CastDemo). Having done [Raspberry Pi](http://blogs.developerforce.com/developer-relations/2013/03/controlling-physical-devices-via-approval-processes-in-force-com.html), [Minecraft](http://blogs.developerforce.com/developer-relations/2014/01/visualizing-salesforce-data-in-minecraft.html), and now Chromecast, I'm looking for new ideas for interesting Salesforce integrations. Leave a comment if you think of one!