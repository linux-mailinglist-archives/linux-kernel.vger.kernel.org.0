Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4706E69F5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 23:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJ0Wr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 18:47:29 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:51510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727085AbfJ0Wr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:47:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4B0431802B56E;
        Sun, 27 Oct 2019 22:47:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2564:2682:2685:2692:2693:2828:2859:2892:2902:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4470:5007:6119:7903:8985:9025:10004:10400:10848:11232:11657:11658:11854:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13439:13972:14093:14097:14181:14659:14721:21080:21347:21365:21433:21451:21524:21627:21819:21939:30022:30051:30054:30079:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: nail45_410b47253ea55
X-Filterd-Recvd-Size: 3138
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Oct 2019 22:47:26 +0000 (UTC)
Message-ID: <92212e57d45f4410be654183f5dcb1e98d636ef2.camel@perches.com>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        zhanglin <zhang.lin16@zte.com.cn>
Date:   Sun, 27 Oct 2019 15:47:21 -0700
In-Reply-To: <alpine.DEB.2.21.1910270644590.3186@hadrien>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
         <alpine.DEB.2.21.1910270644590.3186@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-27 at 06:47 +0100, Julia Lawall wrote:
> 
> On Sat, 26 Oct 2019, Joe Perches wrote:
> 
> > Initialization is not guaranteed to zero padding bytes so
> > use an explicit memset instead to avoid leaking any kernel
> > content in any possible padding bytes.
> 
> Here is an extract of an email that I sent to Kees at one point that left
> me unsure about what should be done about these situations:
> 
> From Kees:
> 
>     The only way to correctly handle this is:
> 
>     memset(&instance, 0, sizeof(instance));
>     instance.one = 1;
> 
> From me:
> 
> Actually, this document:
> 
> https://wiki.sei.cmu.edu/confluence/display/c/DCL39-C.+Avoid+information+leakage+when+passing+a+structure+across+a+trust+boundary
> 
> says that memset is a "noncompliant solution".  They suggest declaring the
> structure as packed, as well as some other more unpleasant solutions.
> Their point is that 1 will be sitting in a register, and the assignment at
> least might copy the upper bytes of the register into the padding space.

It took me a minute to understand why, but it
is true and possible.

> Is the memset solution nevertheless what is always wanted in the kernel
> when there is padding?

I think yes as at least it makes it consistent.

From the link above, as I understand the __user
gcc extension here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c61f13eaa1ee17728c41370100d2d45c254ce76f

gcc does not clear padding from initialized structs
marked with __user.

Perhaps adding yet another attribute to struct definitions
and another gcc extension could help.

Perhaps add something like

	#define __uapi __attribute__((__uapi__))

and mark the struct definitions in include/uapi like:

struct ethtool_wolinfo {
	__u32	cmd;
	__u32	supported;
	__u32	wolopts;
	__u8	sopass[SOPASS_MAX];
} __uapi;

so that gcc could make sure any struct padding
is also zeroed if initialized.

Though that doesn't force the compiler to not
perform the possible register optimization shown
in the first document above.

