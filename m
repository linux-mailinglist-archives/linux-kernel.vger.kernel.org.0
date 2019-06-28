Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EEF59161
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfF1Cka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:40:30 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:45887 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbfF1Ck3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:40:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 24ED36D83;
        Fri, 28 Jun 2019 02:40:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1605:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4043:4321:4605:5007:6117:6119:7903:9010:9012:9108:10004:10400:10848:10967:11232:11658:11914:12050:12297:12663:12740:12760:12895:13161:13229:13439:13618:14096:14097:14181:14659:14721:14819:21063:21080:21451:21627:21740:30012:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: jump91_5b258eb197f18
X-Filterd-Recvd-Size: 4127
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Jun 2019 02:40:26 +0000 (UTC)
Message-ID: <2f1c88882fde00beebb6066e9bd561287f5932c5.camel@perches.com>
Subject: Re: [tip:timers/core] hrtimer: Use a bullet for the returns bullet
 list
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, linux-tip-commits@vger.kernel.org,
        docutils-develop@lists.sourceforge.net
Date:   Thu, 27 Jun 2019 19:40:24 -0700
In-Reply-To: <20190627213930.0d28a072@coco.lan>
References: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
         <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
         <3740b16e5d0a3144e2d48af7cf56ae8020c3f9af.camel@perches.com>
         <20190627213930.0d28a072@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 21:39 -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 27 Jun 2019 15:08:59 -0700
> Joe Perches <joe@perches.com> escreveu:
[]
> > > hrtimer: Use a bullet for the returns bullet list
> > > 
> > > That gets rid of this warning:
> > > 
> > >    ./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.  
> > 
> > Doesn't this form occur multiple dozens of times in
> > kernel sources?
> > 
> > For instance:
> > 
> > $ git grep -B3 -A5 -P "^ \* Returns:?$" | \
> >   grep -P -A8 '\-\s+\*\s*@\w+:'
> 
> Yes, this is a common pattern, but not all patterns that match the above
> regex are broken.
> 
> > I think the warning is odd at best and docutils might
> > be updated or the warning ignored or suppressed.
> > 
> > > and displays nicely both at the source code and at the produced
> > > documentation.  
> 
> The warnings are painful - and they're the main reason why I wrote this
> change: - I wanted to avoid new warnings actually unrelated to my
> changes that were sometimes appearing while doing incremental
> "make htmldocs" on a big patchset that I've been rebasing almost every
> week over the last two months.
> 
> -
> 
> Yet, did you try to look how this pattern will appear at the html and pdf
> output?

No I did not.

I just would like to avoid changing perfectly intelligible
kernel-doc content into something less directly readable for
the sake of external output.

I don't use the externally generated formatted output docs.
I read and use the source when necessary.

Automatic creation of bulleted blocks from relatively
unformatted content is a hard problem.

I appreciate the work Mauro, I just would like to minimize
the necessary changes if possible.

The grep I did was trivial, I'm sure there are better tools
to isolate the kernel-doc bits where the Return: block
is emitted.


>  Something like this:
> 
> 	sound/soc/codecs/wm8960.c: * Returns:
> 	sound/soc/codecs/wm8960.c- *  -1, in case no sysclk frequency available found
> 	sound/soc/codecs/wm8960.c- * >=0, in case we could derive bclk and lrclk from sysclk using
> 	sound/soc/codecs/wm8960.c- *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers
> 
> 
> Will be displayed as:
> 
> 	**Returns:**
> 	  -1, in case no sysclk frequency available found **>=0, in case we could derive bclk and lrclk from sysclk using** (@sysclk_idx, @dac_idx, @bclk_idx) dividers
> (where **foo**) means that "foo" will be printed in bold.> 

That's a yuck from me.

> While it would likely be possible to improve kernel-doc to present better
> results, I'm afraid that it would be too complex for simple regex
> expressions, and hard to tune, as it would be a hint-based approach,
> and doing a natural language processing would be too much effort.

Yeah, tough problem.  I don't envy it.

cheers and g'luck...

