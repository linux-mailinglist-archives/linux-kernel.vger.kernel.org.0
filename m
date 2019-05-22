Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930BE25E35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfEVGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 02:34:27 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:41314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728367AbfEVGe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:34:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3C2AE181D3419;
        Wed, 22 May 2019 06:34:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2525:2553:2560:2564:2682:2685:2691:2731:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3165:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4419:5007:6117:6119:7901:7903:8700:9025:10004:10400:10450:10455:10848:11232:11658:11914:12043:12050:12555:12740:12760:12895:13161:13229:13439:14096:14097:14181:14659:14721:19904:19999:21080:21220:21433:21627:21740:30034:30054:30060:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1006,LUA_SUMMARY:none
X-HE-Tag: cart68_7d607343ca553
X-Filterd-Recvd-Size: 3505
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 06:34:21 +0000 (UTC)
Message-ID: <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Date:   Tue, 21 May 2019 23:34:19 -0700
In-Reply-To: <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
References: <20190521133257.GA21471@kroah.com>
         <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 13:32 +0900, Masahiro Yamada wrote:
> On Tue, May 21, 2019 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
[]
> >  - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
> >     tools can determine the license text in the file itself.  Where this
> >     happens, the license text is removed, in order to cut down on the
> >     700+ different ways we have in the kernel today, in a quest to get
> >     rid of all of these.
[]
> I have been wondering for a while
> which version of spdx tags I should use in my work.
> 
> I know the 'GPL-2.0' tag is already deprecated.
> (https://spdx.org/licenses/GPL-2.0.html)
> 
> But, I saw negative reaction to this:
> https://lore.kernel.org/patchwork/patch/975394/
> 
> Nor "-only" / "-or-later" are documented in
> Documentation/process/license-rules.rst
> 
> In this patch series, Thomas used 'GPL-2.0-only' and 'GPL-2.0-or-later'
> instead of 'GPL-2.0' and 'GPL-2.0+'.
> 
> Now, we have a great number of users of spdx v3 tags.
> $ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
> 4135
> So, what I understood is:
> 
>   For newly added tags, '*-only' and '*-or-later' are preferred.
> 
> (But, we do not convert existing spdx v2 tags globally.)
> 
> 
> "
> Joe's patch was not merged, but at least
> Documentation/process/license-rules.rst
> should be updated in my opinion.
> 
> (Perhaps, checkpatch.pl can suggest newer tags in case
> patch submitters do not even know that deprecation.)

I'd still prefer the kernel use of a single SPDX style.

I don't know why the -only and -or-later forms were
used for this patch, but I like it.

I believe the -only and -or-later are more intelligible
as a trivial reading of

	SPDX-License-Identifier: GPL-2.0

would generally mean to me the original
GPL-2.0 license without the elision of the
(or at your option, any later version) bits

whereas

	SPDX-License-Identifier: GPL-2.0-only

seems fairly descriptive.

Is it agreed that the GPL-<v>-only and GPL-<v>-or-later
forms should be preferred for new SPDX identifiers?

If so, I'll submit a checkpatch patch.

I could also wire up a patch to checkpatch and docs to
remove the /* */
requirement for .h files and prefer
the generic // form for both .c and
.h files as the
current minimum tooling versions now all allow //
comments
.


