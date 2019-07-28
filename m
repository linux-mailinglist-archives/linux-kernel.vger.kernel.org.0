Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37178279
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfG1Xp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 19:45:27 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:38341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbfG1Xp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:45:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 84D8018224D81;
        Sun, 28 Jul 2019 23:45:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2915:3138:3139:3140:3141:3142:3353:3622:3865:3866:3868:3870:3872:3873:4321:5007:7903:9010:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12297:12438:12555:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21451:21627:21740:30054:30069:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: step72_4c54fc21e9006
X-Filterd-Recvd-Size: 2661
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Jul 2019 23:45:24 +0000 (UTC)
Message-ID: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Date:   Sun, 28 Jul 2019 16:45:22 -0700
In-Reply-To: <20190727195455.1558-1-rikard.falkeborn@gmail.com>
References: <c94a0a50c41c7530354b4a662ee945212424c8c7.camel@perches.com>
         <20190727195455.1558-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-27 at 21:54 +0200, Rikard Falkeborn wrote:
> Trimming CC-list.
> 
> > It'd can't be done as it's used in declarations
> > and included in asm files and it uses the UL()
> > macro.
> 
> Can the BUILD_BUG_ON_ZERO() macro be used instead? It works in
> declarations. I don't know if it works in asm-files, but the below
> changes builds an x86-64 allyesconfig without problems (after the rest
> of this series have been applied.

Maybe, fine by me if it works.

Perhaps you should submit this and let the build-bot
verify it.



> /Rikard
> 
> ---
>  include/linux/bits.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..52e747d27f87 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_BITS_H
>  #define __LINUX_BITS_H
>  
> +#include <linux/build_bug.h>
>  #include <linux/const.h>
>  #include <asm/bitsperlong.h>
>  
> @@ -19,11 +20,15 @@
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
>  #define GENMASK(h, l) \
> +	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__is_constexpr(h) && __is_constexpr(l), (l) > (h), 0)) + \
>  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> -	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> +	 (~UL(0) >> (BITS_PER_LONG - 1 - (h)))))
>  
>  #define GENMASK_ULL(h, l) \
> +	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__is_constexpr(h) && __is_constexpr(l), (l) > (h), 0)) + \
>  	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> -	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> +	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))))
>  
>  #endif	/* __LINUX_BITS_H */

