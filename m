Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3E10BC47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfK0VSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 16:18:05 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:46544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733245AbfK0VMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:12:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C526452D3;
        Wed, 27 Nov 2019 21:11:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2693:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4361:4384:5007:6119:6248:7514:7903:8603:9025:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:13095:13439:14096:14097:14180:14181:14659:14721:21060:21080:21094:21221:21433:21451:21627:21939:21972:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: mint26_112ea289bab27
X-Filterd-Recvd-Size: 3449
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Nov 2019 21:11:57 +0000 (UTC)
Message-ID: <074cc723b3874f95b1b1ad89c1d2dcbae982deba.camel@perches.com>
Subject: Re: [PATCH] cpu: microcode: replace 0 with NULL
From:   Joe Perches <joe@perches.com>
To:     Jules Irenge <jbi.octave@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com
Date:   Wed, 27 Nov 2019 13:11:31 -0800
In-Reply-To: <alpine.LFD.2.21.1911261554100.156067@ninjahub.org>
References: <20191126002734.121905-1-jbi.octave@gmail.com>
         <20191126135330.GE31379@zn.tnic>
         <alpine.LFD.2.21.1911261554100.156067@ninjahub.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-26 at 16:03 +0000, Jules Irenge wrote:
> 
> On Tue, 26 Nov 2019, Borislav Petkov wrote:
> 
> > On Tue, Nov 26, 2019 at 12:27:34AM +0000, Jules Irenge wrote:
> > > Replace 0 with NULL to fix sparse tool  warning
> > >  warning: Using plain integer as NULL pointer
> > > 
> > > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > > ---
> > >  arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> > > index a0e52bd00ecc..4934aa7c94e7 100644
> > > --- a/arch/x86/kernel/cpu/microcode/amd.c
> > > +++ b/arch/x86/kernel/cpu/microcode/amd.c
> > > @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
> > >  static bool
> > >  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
> > >  {
> > > -	struct cont_desc desc = { 0 };
> > > +	struct cont_desc desc = { NULL };
> > 
> > So my gcc guy says that 0 and NULL are equivalent as designated
> > initializers in this case. And if you look at the resulting asm, it
> > doesn't change:
> > 
> > # arch/x86/kernel/cpu/microcode/amd.c:421: 	struct cont_desc desc = { 0 };
> > 	movq	$0, 8(%rsp)	#, desc
> > 	movq	$0, (%rsp)	#, desc
> > 	movq	$0, 16(%rsp)	#, desc
> > 	movq	$0, 24(%rsp)	#, desc
> > 
> > But what I'd prefer actually is, if you do them like this:
> > 
> > 			... = { 0,  };
> > 
> > because:
> > 
> > 1. It is clear that the memory for the struct is being cleared
> > 2. The following ones - the ones after "," are missing too, on purpose,
> >    because they're being cleared too.
> > 
> > Also pls add that explanation to the commit message.
> > 
> > Thx.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> > 
> Hi Boris,
> 
> Thanks for your reply and suggestion. 
> 
> I am learning patching with sparse trying to solve some problems that the 
> tool complains about.
> 
> Sometime the tool is not always right. If I take your suggestion that I 
> am about to do, sparse will however still complain.
> 
> so I will suggest my change to be discarded.
> 
> I will take another challenge.

This initializer should ether use named members with the appropriate
zeroing type or just use a blank {} so that regardless of type and
member order, the entire structure is zeroed.

	struct cont_desc desc = {};


