---
author: user
title: Raspberry Pi fix for HDMI to DVI cable issue
slug: raspberry-pi-fix-for-hdmi-to-dvi-cable-issue
id: 1389
date: '2012-06-08 11:10:01'
layout: single
categories:
  - Uncategorized
tags:
  - raspberrypi
---

My [!["RPiText"](http://blog.superpat.com/wp-content/uploads/2012/06/RPiText-300x225.jpg "Raspberry Pi in text mode")](http://blog.superpat.com/wp-content/uploads/2012/06/RPiText.jpg) After a little exploration from the command line, `startx` brought up the GUI. [!["RPiX"](http://blog.superpat.com/wp-content/uploads/2012/06/RPiX-300x225.jpg "Raspberry Pi running X")](http://blog.superpat.com/wp-content/uploads/2012/06/RPiX.jpg) As well as the composite video output, the Raspberry Pi supports HDMI. My monitor (a Viewsonic VX2235WM-3) has VGA and DVI inputs, so I ordered the [AmazonBasics HDMI to DVI Cable](http://www.amazon.com/gp/product/B001TH7T2U/ref=as_li_ss_tl?ie=UTF8&tag=superpatterns-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=B001TH7T2U)![](http://www.assoc-amazon.com/e/ir?t=superpatterns-20&l=as2&o=1&a=B001TH7T2U). Connecting up to my monitor, I was disappointed to see no video signal whatsover - the monitor wasn't seeing the Raspberry Pi at all. Googling around, I discovered that [you can set various configuration options that are read before the Raspberry Pi even boots](http://elinux.org/RPi_config.txt). With a little experimentation, I found that setting

```
hdmi_force_hotplug=1
```

in config.txt solves the problem - I see video output from the moment I power up the Raspberry Pi! This makes sense - the description of `hdmi_force_hotplug` is "Use HDMI mode even if no HDMI monitor is detected" - I'm guessing the cable is not signalling the presence of a monitor to the Raspberry Pi, so it decides that it doesn't need to send HDMI output. Watch this space for more Raspberry Pi fun!