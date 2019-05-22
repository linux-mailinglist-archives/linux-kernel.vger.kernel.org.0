Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BB425DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfEVFef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 01:34:35 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:34670 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfEVFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:34:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 500BBC1DC8F;
        Wed, 22 May 2019 05:34:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2559:2563:2682:2685:2691:2693:2828:2859:2904:2906:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4362:5007:6119:7576:7875:7903:8957:8985:9010:9012:9025:9389:9545:10004:10026:10400:10848:10967:11232:11658:11914:12043:12294:12296:12555:12679:12740:12760:12895:12986:13095:13161:13229:13439:13868:13972:14093:14096:14097:14181:14659:14721:14989:21080:21324:21433:21451:21611:21627:21740:21811:30012:30041:30054:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: doll00_27cb72a1ea748
X-Filterd-Recvd-Size: 4246
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 05:34:33 +0000 (UTC)
Message-ID: <3731f4dbabe0b9cab7ab1cce43901668fd874b0c.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
From:   Joe Perches <joe@perches.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 22:34:24 -0700
In-Reply-To: <alpine.DEB.2.21.9999.1905212134310.23235@viisi.sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com>
         <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
         <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com>
         <20190521171422.c7ef965e39b27f6142788412@linux-foundation.org>
         <alpine.DEB.2.21.9999.1905212134310.23235@viisi.sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 21:47 -0700, Paul Walmsley wrote:
> On Tue, 21 May 2019, Andrew Morton wrote:
> 
> > On Sun, 19 May 2019 11:24:22 -0700 (PDT) Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > 
> > > On Sat, 18 May 2019, Joe Perches wrote:
> > > 
> > > > On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> > > > > The RISC-V architecture has a register named the "Supervisor Exception
> > > > > Program Counter", or "sepc".  This abbreviation triggers
> > > > > checkpatch.pl's misspelling detector, resulting in noise in the
> > > > > checkpatch output.  The risk that this noise could cause more useful
> > > > > warnings to be missed seems to outweigh the harm of an occasional
> > > > > misspelling of "spec".  Thus drop the "sepc" entry from the
> > > > > misspelling list.
> > > > 
> > > > I would agree if you first fixed the existing sepc/spec
> > > > and sepcific/specific typos.
> > > > 
> > > > arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
> > > > arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
> > > > drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
> > > > drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register
> > > > drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
> > > 
> > > Your agreement shouldn't be needed for the patch I sent.
> > 
> > I always find Joe's input to be very useful.
> > 
> > Here:
> > 
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
> > 
> > fix existing "sepc" instances, per Joe
> > 
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Thanks Andrew.  Sorry that you had to do it.
> 
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> 
> What troubled me about Joe's message is that it seems like poor kernel 
> developer precedent to block a fix for static analysis false positives to 
> fix comment spelling errors -- particularly considering that four out of 
> five of them were unrelated to the actual patch in question.  While 
> comment spelling fixes are worthwhile, I think we should make sure that 
> the "tail doesn't wag the dog" by prioritizing code fixes first.

I don't believe there is any tail wagging occurring here.

There is no code 'fix' in the original proposed patch.

It is, as described, effectively a subsystem specific
static analysis false positive avoidance patch.  And the
static analysis tool's false positive report is not active
by default.

Any scripts/spelling.txt change like a sepc removal could
be overridden by using checkpatch's --codespell option.

btw:

I don't generally add acked-by or reviewed-by to patches
as I rather agree with Ted's position on these headers.

https://lore.kernel.org/lkml/20190521171618.GD2591@mit.edu/

> I will try to do better next time,

Thanks.


