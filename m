Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC5F6AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 19:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKJSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 13:14:09 -0500
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:34071 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbfKJSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:14:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 088A3181D3417;
        Sun, 10 Nov 2019 18:14:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2691:2828:2895:2901:2918:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7903:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12295:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14877:21080:21451:21627:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: hope08_5dfd750254439
X-Filterd-Recvd-Size: 2710
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Nov 2019 18:14:05 +0000 (UTC)
Message-ID: <61e165241e4b98cd655ac79cd110f3f08e389838.camel@perches.com>
Subject: Re: [PATCH] lkdtm: Remove set but not used variable 'byte'
From:   Joe Perches <joe@perches.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, keescook@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Date:   Sun, 10 Nov 2019 10:13:50 -0800
In-Reply-To: <20191110092249.182210-1-zhengyongjun3@huawei.com>
References: <20191110092249.182210-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 17:22 +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_LEADING:
> drivers/misc/lkdtm/bugs.c:236:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_TRAILING:
> drivers/misc/lkdtm/bugs.c:250:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> 
> byte is never used, so remove it.

I believe "hulk robot" needs to be updated instead.

It seems a generically bad idea to elide as byte
is in fact used because it's volatile and the
compiler was forced to perform the access of *ptr.


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/misc/lkdtm/bugs.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 7284a22b1a09..fcd943725b66 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -249,12 +249,9 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
>  {
>  	const unsigned char *stack = task_stack_page(current);
>  	const unsigned char *ptr = stack - 1;
> -	volatile unsigned char byte;
>  
>  	pr_info("attempting bad read from page below current stack\n");
>  
> -	byte = *ptr;
> -
>  	pr_err("FAIL: accessed page before stack!\n");
>  }
>  
> @@ -263,12 +260,9 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
>  {
>  	const unsigned char *stack = task_stack_page(current);
>  	const unsigned char *ptr = stack + THREAD_SIZE;
> -	volatile unsigned char byte;
>  
>  	pr_info("attempting bad read from page above current stack\n");
>  
> -	byte = *ptr;
> -
>  	pr_err("FAIL: accessed page after stack!\n");
>  }
>  

