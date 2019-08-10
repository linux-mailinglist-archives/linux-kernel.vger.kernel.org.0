Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B388CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfHJTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 15:32:08 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:41133 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbfHJTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:32:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 40B2E18029128;
        Sat, 10 Aug 2019 19:32:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2559:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3165:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7903:8660:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12698:12737:12740:12760:12895:13148:13230:13255:13439:14093:14097:14180:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: spark10_4c70ab692da2a
X-Filterd-Recvd-Size: 3006
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 19:32:05 +0000 (UTC)
Message-ID: <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Date:   Sat, 10 Aug 2019 12:32:03 -0700
In-Reply-To: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 15:11 -0700, Joe Perches wrote:
> A compilation -Wimplicit-fallthrough warning was enabled by
> commit a035d552a93b ("Makefile: Globally enable fall-through warning")
> 
> Even though clang 10.0.0 does not currently support this warning
> without a patch, clang currently does not support a value for this
> option.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=39382
> 
> The gcc default for this warning is 3 so removing the =3 has no
> effect for gcc and enables the warning for patched versions of clang.
> 
> Also remove the =3 from an existing use in a parisc Makefile:
> arch/parisc/math-emu/Makefile

Hey Linus,

What does it take for this sort of patch to be applied by you?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Makefile                      | 2 +-
>  arch/parisc/math-emu/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5ee6f6889869..a3985421fd29 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -845,7 +845,7 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  KBUILD_CFLAGS += -Wdeclaration-after-statement
>  
>  # Warn about unmarked fall-throughs in switch statement.
> -KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough=3,)
> +KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough,)
>  
>  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
>  KBUILD_CFLAGS += -Wvla
> diff --git a/arch/parisc/math-emu/Makefile b/arch/parisc/math-emu/Makefile
> index 55c1396580a4..3747a0cbd3b8 100644
> --- a/arch/parisc/math-emu/Makefile
> +++ b/arch/parisc/math-emu/Makefile
> @@ -18,4 +18,4 @@ obj-y	 := frnd.o driver.o decode_exc.o fpudispatch.o denormal.o \
>  # other very old or stripped-down PA-RISC CPUs -- not currently supported
>  
>  obj-$(CONFIG_MATH_EMULATION)	+= unimplemented-math-emulation.o
> -CFLAGS_REMOVE_fpudispatch.o	= -Wimplicit-fallthrough=3
> +CFLAGS_REMOVE_fpudispatch.o	= -Wimplicit-fallthrough
> 

