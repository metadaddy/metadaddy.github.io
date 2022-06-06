---
author: user
title: Batch File to Delete Duplicate MP3s
slug: batch-file-to-delete-duplicate-mp3s
id: 374
date: '2008-09-15 07:51:37'
layout: single
categories:
  - General
---

Sharing this since it was pretty useful to me...

I noticed recently that I had a huge amount of duplicate files in my MP3 library. I think what had happened was that, on an iTunes upgrade, I'd rebuilt my iTunes index with iTunes set to 'Copy files to library'. The result was thousands of files with names like "01 I Can't Explain 1.mp3", where iTunes had copied "01 I Can't Explain.mp3" into the same directory, but had to rename the file.

So... What to do... Well, after seeing that the duplicate files were bit-for-bit identical to the original, but for the " 1" at the end of the filename, I realized I could write a simple batch file (my home PC runs Windows XP), that would find the duplicates, compare them with the originals to check that they were actually identical, then delete them:

    @echo off
    for /r "f:\my music\" %%I in (*.mp3) do (
    if exist "%%~dpnI 1.mp3" (
    echo Testing "%%~dpnI.mp3" against "%%~dpnI 1.mp3"
    fc "%%~dpnI.mp3" "%%~dpnI 1.mp3" > nul
    if not errorlevel 1 (
    echo Match! Deleting "%%~dpnI 1.mp3"
    del "%%~dpnI 1.mp3"
    ) else (
    echo Found a non-match! "%%~dpnI.mp3" "%%~dpnI 1.mp3"
    )
    )
    )

To be honest, it took me about an hour to figure out the right syntax for everything. I did try to neaten things up by assigning the `"%%~dpnI 1.mp3"` thing to a variable `dupe`, but gave up when I discovered that, in batch file land, variables are assigned when the line is read, not when it is executed (see [this useful article for more explanation](http://www.robvanderwoude.com/ntset.html)). To smarten up my batch file, not only did I have to use a strange `!dupe!` syntax ('delayed variable expansion'), but I had to run it with `cmd /v:on /c deldupes`. In the end, I decided not to bother.

I hate batch files.