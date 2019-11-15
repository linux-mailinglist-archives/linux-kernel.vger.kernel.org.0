Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25C0FE6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 16:13:27 -0500
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:45045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727414AbfKOVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:13:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4CEEF1800972C;
        Fri, 15 Nov 2019 21:13:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:4250:4321:5007:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12050:12295:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:13868:14659:14721:19904:19999:21080:21451:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sheet88_3ab5708df5b0a
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 21:13:23 +0000 (UTC)
Message-ID: <f15994ec5b9c311677064583ff968b3cf881d4ab.camel@perches.com>
Subject: Re: [PATCH] iommu/iova: silence warnings under memory pressure
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 13:13:03 -0800
In-Reply-To: <1573851046-32384-1-git-send-email-cai@lca.pw>
References: <1573851046-32384-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 15:50 -0500, Qian Cai wrote:
> When running heavy memory pressure workloads, this 5+ old system is
> throwing endless warnings below because disk IO is too slow to recover
> from swapping. Since the volume from alloc_iova_fast() could be large,
> once it calls printk(), it will trigger disk IO (writing to the log
> files) and pending softirqs which could cause a loop and no progress
> from memory reclaim for days.
[]
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
[]
> @@ -233,7 +233,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  
>  struct iova *alloc_iova_mem(void)
>  {
> -	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
> +	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
>  }
>  EXPORT_SYMBOL(alloc_iova_mem);

Is notification ever useful?

If so, maybe something like:

struct iova *alloc_iova_mem(void)
{
	void *mem = kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN)_

	WARN_RATELIMIT(!mem, "%s: unable to alloc cache\n", __func__);

	return mem;
}

or maybe use printk_deferred or prink_deferred_once

?


