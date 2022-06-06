---
author: user
title: 'Roller Tip: #showNextPreviousControl()'
slug: roller-tip-shownextpreviouscontrol
id: 597
date: '2006-12-04 09:55:22'
layout: single
categories:
  - General
---

I noticed that, although there is a set of links at the top of my blog page to navigate by pages of content (that thing that says "**<< Prev | Main | Next >>**", or something similar), there isn't one at the bottom. It seems logical that, when you get to the bottom of a page of content, you'd want to go to the next without scrolling all the way up to the top of the page.

There used to be a macro, `#showNextPreviousLinks()`, that did this, but it now outputs just

```
<!--
showNextPreviousLinks() is no longer needed as next/prev links are
built-into the  macro.
-->

```

I guess `#showWeblogEntries()` is supposed to go in that double-space gap between 'the' and 'macro'. BTW - thanks to the Roller team for doing this and not just silencing the macro - quality code!

A bit of <del>googling</del> searching using the Google search engine, tells me that there is a shiny new macro, called by `#showWeblogEntries()` that does exactly what I want - `#showNextPreviousControl()`. Slip it in after `#showWeblogEntries()` and there they are - navigation links at the bottom of the page. Cool!