Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF787E649
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfHAXOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 19:14:17 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:40226 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728834AbfHAXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:14:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3B420180A814E;
        Thu,  1 Aug 2019 23:14:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4362:5007:6119:7514:7875:7903:7904:10004:10400:10848:11026:11232:11473:11658:11914:12297:12438:12740:12760:12895:13095:13255:13439:14093:14096:14097:14181:14659:14721:14819:21063:21080:21324:21433:21451:21611:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: baby46_24fe664d8034b
X-Filterd-Recvd-Size: 3608
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 23:14:14 +0000 (UTC)
Message-ID: <c7601163ffde2b14df520ae230746e6b75ecc2ee.camel@perches.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Date:   Thu, 01 Aug 2019 16:14:12 -0700
In-Reply-To: <20190801230358.4193-2-rikard.falkeborn@gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 01:03 +0200, Rikard Falkeborn wrote:
> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
> 
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
> 
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
> 
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> of __builtin_constant_p().
> 
> If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
> problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
> to unsigned long.
> 
> Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
> on the arguments passed to them, neither of them evaluate the expression
> unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
> expected.
> 
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> compatible, disable the checks if the file is included in an asm file.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Changes in v2:
>   - Add comment about why inputs are not checked when used in asm file
>   - Use UL(0) instead of 0
>   - Extract mask creation in a separate macro to improve readability
>   - Use high and low instead of h and l (part of this was extracted to a
>     separate patch)
>   - Updated commit message
> 
> Joe Perches sent a series to fix the existing misuses of GENMASK() that
> needs to be merged before this to avoid build failures. Currently, 6 of
> the patches are not in Linus tree, and 2 are not in linux-next.

Thanks Rikard.

It wouldn't surprise me if this change finds more misuses
as the compiler will perform substitutions on #define
values where the search I did was just for decimal uses.

For instance, this new macro should build error on:

#define FOO	5
#define BAR	6

GENMASK(FOO, BAR)


