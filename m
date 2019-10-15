Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3FD7A68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfJOPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 11:50:04 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:55419 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730152AbfJOPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:50:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A928710198225;
        Tue, 15 Oct 2019 15:50:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2197:2198:2199:2200:2201:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4470:4605:5007:6119:7903:9545:10004:10400:11232:11658:11914:12297:12663:12740:12760:12895:13095:13439:14096:14097:14180:14181:14659:14721:21060:21080:21221:21433:21627:21740:21741:30054:30060:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:32,LUA_SUMMARY:none
X-HE-Tag: dirt97_5789e28d63b2b
X-Filterd-Recvd-Size: 3469
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Oct 2019 15:50:01 +0000 (UTC)
Message-ID: <e09057e0eefb221549ef9686826e2d190ef36a9c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Oct 2019 08:50:00 -0700
In-Reply-To: <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
         <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
         <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
         <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 08:49 +0200, Geert Uytterhoeven wrote:
> Hi Joe,

Rehi Geert.

> On Mon, Oct 14, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2019-10-14 at 11:20 +0200, Geert Uytterhoeven wrote:
[]
> > > I gave your solution a try.
> > > It only enables the reset-on-next-patch feature when using stdin.
> > > Thanks to the printed subject, it's now obvious to which patch a
> > > message applies to.
> > > However, the output is significantly different than when passing
> > > a split patch series.  Can this be improved upon?
> > > 
> > > Note that the only reason I'm using stdin is that I use formail to split
> > > a bundle in individual patches.  Once checkpatch supports bundles (or
> > > mboxes) containing multiple patches, there's no longer a need for
> > > using formail, and the reset-on-next-patch feature should be
> > > enabled unconditionally.
> > 
> > Using your collection of little tools idea,
> > why not write a trivial script like:
> > 
> >         grep "^Subject:" $1
> >         checkpatch.pl $1
> > 
> > and use that as the command line for formail
> > instead of adding unnecessary complexity to
> > checkpatch?
> 
> That would be another possibility.
> 
> But given more maintainers are starting to apply patchwork bundles (cfr.
> the workflows discussions), it makes sense to make their lives easier.

But given this particular change only works for stdin, then this
patch splitting idea wouldn't generically work.

> This is also useful for maintainers who save all patches to apply into a
> single mbox, and run checkpatch+git-am on that.

Which also wouldn't generally work for checkpatch <mbox>

> Summarized: git-am handles multiple patches, checkpatch requires
> splitting.

I still think it's better to introduce YA script that disaggregates
aggregated patches/emails and feeds each individual patch to
checkpatch rather than making checkpatch learn how to disaggregate.

Using "git mailsplit" as part of some additional script could work.


