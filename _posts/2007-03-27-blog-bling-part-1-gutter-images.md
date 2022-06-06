---
author: user
title: Blog Bling - Part 1 - Gutter Images
slug: blog-bling-part-1-gutter-images
id: 552
date: '2007-03-27 13:11:52'
layout: single
categories:
  - General
---

As you can probably see ([click here](http://blogs.sun.com/superpat) if you're reading this via RSS, so you _can_ see), I have a whole bunch of customizations and widgets on my blog page. I often get email from folks asking 'how did you do that', so I thought a short series on my various tchotchkes might be in order.

I use a heavily modified version of [Apache Roller](http://rollerweblogger.org/)'s [Sotto](http://sotto.org/) theme. Some of my customizations are peculiar to the Sotto theme, others to Roller, while some will work on any web page. Your mileage will vary, so take from this what you will.

So... working down from the top of the page, the first customization you come across is the 'gutter' - that row of images near the top of the page. The standard Sotto gutter looks like this (from [Sandy's blog@sun](http://blogs.sun.com/sandycheng/)):

![](http://blog.superpat.com/StandardGutterImages.png)

While the standard images are quite decorative, they're not really me. I swapped them out for the following:

![](http://blog.superpat.com/GutterImages.png)

Customizing the images requires a little (but not much!) knowledge of CSS, so it's quite instructive to look at how it is done.

The standard Roller Weblog template for Sotto (Preferences/Templates/Weblog/Edit) contains the following:

```
<div id="gutter">
<span id="gutterimage1">&nbsp;</span>
<span id="gutterimage2">&nbsp;</span>
<span id="gutterimage3">&nbsp;</span>
<span class="floatSpacer"></span>
</div>

```

So, what's happening here? We have a `<div>` element with `id="gutter"`, three 'non-breaking spaces' (`&nbsp;`), each within a `<span>` element and another empty `<span>`.

Let's look in the [default Sotto CSS file](http://blogs.sun.com/themes/sotto/styles/default.css) to see what all those `id` attributes mean:

```
#gutter
{
border-top: 0.1em solid #ddd;
border-bottom: 0.1em solid #ddd;
/*background: #eee;*/
height: 52px;
background: #eee url(../images/bannerBackground.gif) repeat-x;
}
#gutterimage1
{
float: left;
margin: 0px;
width: 75px;
height: 50px;
border: 1px solid #ccc;
background: url(../images/daisy.jpg) no-repeat;
}
#gutterimage2
{
float: left;
margin: 0px;
width: 75px;
height: 50px;
border: 1px solid #ccc;
background: url(../images/clouds.jpg) no-repeat;
}
#gutterimage3
{
float: left;
margin: 0px;
width: 75px;
height: 50px;
border: 1px solid #ccc;
border-right: 2px solid #ccc;
background: url(../images/prairie.jpg) no-repeat;
}
/* Further down the file... */
.floatSpacer
{
clear: both;
overflow: hidden;
}

```

Now we can see what is happening. The `#gutter` [ID selector](http://www.w3.org/TR/REC-CSS2/selector.html#id-selectors) sets top and bottom borders, height and a background image for the gutter area as a while. The three `#gutterimage` ID selectors set the properties of the individual images: float to the left, no margin, width, height, border and background - ah ha - this is what we need to change to customize those images. The `floatSpacer` makes the gutter's borders work properly - [this page gives a good explanation](http://www.quirksmode.org/css/clearing.html) if you're interested in the technicalities.

To change the images, you have a couple of choices. Perhaps the simplest is to just define your own ID selectors and change the gutter image ID in the Weblog template itself, as [Robin](http://blogs.sun.com/racingsnake/) did:

```
<style>
<!--
#myimage1
{
float: left;
margin: 0px;
width: 75px;
height: 50px;
border: 1px solid #ccc;
background: url(/roller/resources/racingsnake/arch2-sm.jpg) no-repeat;
}
/* ...more images defined... */
-->
</style>
<div id="gutter">
<span id="myimage1">&nbsp;</span>
<span id="myimage2">&nbsp;</span>
<span id="myimage3">&nbsp;</span>
<span id="myimage4">&nbsp;</span>
<span class="floatSpacer"></span>
</div>

```

If you want to keep the same gutter height, you'll need to size your images accordingly and set the size in the CSS.

Since I had a number of other customizations in mind, I copied the Sotto default.css and changed the properties in place:

```
#gutterimage1
{
float: left;
margin: 0px;
width: 75px;
height: 50px;
border: 1px solid #ccc;
background: url(/roller/resources/superpat/SmallPat.jpg) no-repeat;
}

```

If you hover the mouse cursor over the images on my page, you'll notice that there is popup text for each one. I was lazy here - rather than figuring out how to do it in CSS, I just put a `title` attribute on each `<span>` element:

```
<div id="gutter">
<span id="gutterimage1" title="Me">&nbsp;</span>
<span id="gutterimage2" title="My beloved">&nbsp;</span>
<span id="gutterimage3" title="Rascal &#35;1 - Tom">&nbsp;</span>
<span id="gutterimage4" title="Rascal &#35;2 - Alex">&nbsp;</span>
<span id="gutterimage5" title="1996 Porsche Carrera 4 Cabriolet">&nbsp;</span>
<span class="floatSpacer"></span>
</div>

```

And that's all there is to it. Next time I'll look at the tag cloud - the group of links just below the gutter. Until then - happy blogging!