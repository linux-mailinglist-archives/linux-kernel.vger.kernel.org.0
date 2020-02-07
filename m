Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE7155634
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 05:59:40 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:57265 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgBGK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:59:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 49042182CF666;
        Fri,  7 Feb 2020 10:59:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: unit22_19eb947281c49
X-Filterd-Recvd-Size: 1521
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Feb 2020 10:59:38 +0000 (UTC)
Message-ID: <fdcfd8548707e2d6c61fc9739bc91c6720673c81.camel@perches.com>
Subject: Re: [PATCH 2/2] riscv: adjust the indent
From:   Joe Perches <joe@perches.com>
To:     Zong Li <zong.li@sifive.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Feb 2020 02:58:25 -0800
In-Reply-To: <20200207095245.21955-3-zong.li@sifive.com>
References: <20200207095245.21955-1-zong.li@sifive.com>
         <20200207095245.21955-3-zong.li@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 17:52 +0800, Zong Li wrote:
> Adjust the indent to match Linux coding style.

trivia:

> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
[]
> @@ -86,7 +89,8 @@ void __init kasan_init(void)
>  	unsigned long i;
>  
>  	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
> -			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> +				    (void *)kasan_mem_to_shadow((void *)
> +								VMALLOC_END));

could also remove an unnecessary (void *) as kasan_mem_to_shadow
returns a void *

	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
				    kasan_mem_to_shadow((void *)VMALLOC_END));

