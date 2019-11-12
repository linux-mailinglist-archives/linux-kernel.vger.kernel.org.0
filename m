Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E641BF867F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 02:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLBhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 20:37:45 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:36831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbfKLBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:37:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66AB6180A68C6;
        Tue, 12 Nov 2019 01:37:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7875:7903:10010:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:13869:14181:14659:14721:21080:21627:30005:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: duck48_6064df2d13208
X-Filterd-Recvd-Size: 2216
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 01:37:42 +0000 (UTC)
Message-ID: <24e38dd1be9e0f6e4520cb81f72e27b88dae4015.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Mon, 11 Nov 2019 17:37:26 -0800
In-Reply-To: <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
         <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
         <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
         <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
         <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 09:12 -0800, Linus Torvalds wrote:
> On Sun, Nov 10, 2019 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> > The !! logical usage is not particularly common in the kernel.
> > There seems to be only a couple/few dozen.
> 
> Your grep pattern is for the explicitly silly "turn a boolean to a
> boolean". That should certainly be rare.
> 
> But I meant it in a more general way - there's a lot of common use of
> "!!" for "turn this expression into a boolean". A trivial grep for
> that (didn't check how correct it was - there might be comments that
> are very excited too) implies that we have a fair amount of this
> pattern:
> 
>     $ git grep '[^!]!![^!]' -- '*.[ch]' | wc -l
>     7007

Likely the majority of those are bit comparison coercions to 0/1 like

	int val = !!(A & B)

> so the '!!' pattern itself isn't rare.

And likely these !! patterns are preferred to (A & B) != 0

I don't care much either way as either form, unlike !!(A == B),
is not redundant.


