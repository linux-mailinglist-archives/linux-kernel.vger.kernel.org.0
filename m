Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB51567AD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBHUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 15:18:37 -0500
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:43861 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727471AbgBHUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 15:18:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 675AE181D3026;
        Sat,  8 Feb 2020 20:18:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7514:8957:9025:9149:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21611:21627:21939:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sort14_109d5eb21af35
X-Filterd-Recvd-Size: 2794
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat,  8 Feb 2020 20:18:34 +0000 (UTC)
Message-ID: <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Sat, 08 Feb 2020 12:17:20 -0800
In-Reply-To: <20200208141052.48476-1-natechancellor@gmail.com>
References: <20200208141052.48476-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> of type 'const u8 *' (aka 'const unsigned char *') converts between
> pointers to integer
> types with different sign [-Wpointer-sign]
>                                   (char *) entropy, (char *) entropy,
>                                                     ^~~~~~~~~~~~~~~~
> ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> parameter 'src' here
>                             u8 *dest, const u8 *src, long src_len)
>                                                 ^
> 2 warnings generated.
> 
> Fix the cast to match what else is done in this function.
> 
> Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/862
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/s390/boot/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> index 5d12352545c5..5591243d673e 100644
> --- a/arch/s390/boot/kaslr.c
> +++ b/arch/s390/boot/kaslr.c
> @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
>  		*(unsigned long *) prng.parm_block ^= seed;
>  		for (i = 0; i < 16; i++) {
>  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> -				  (char *) entropy, (char *) entropy,
> +				  (u8 *) entropy, (u8 *) entropy,

Why not change the function to take void *?

static inline int cpacf_kmc(unsigned long func, void *param,
			    u8 *dest, const u8 *src, long src_len)

vs:

static inline int cpacf_kmc(unsigned long func, void *param,
			    void *dest, const void *src, long src_len)

and remove the casts?


