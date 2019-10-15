Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111D3D8082
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfJOTo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:44:56 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:35562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727478AbfJOTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:44:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0F1A81804FAC2;
        Tue, 15 Oct 2019 19:44:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3874:4250:4321:5007:7903:10004:10400:11026:11232:11473:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:13869:14659:14721:21067:21080:21627:30005:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: burn23_6500a5bae7a21
X-Filterd-Recvd-Size: 1632
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Oct 2019 19:44:53 +0000 (UTC)
Message-ID: <5695bc78caf94d21b760960d4c1a34411cb4cb81.camel@perches.com>
Subject: Re: [PATCH] linux/bitmap.h: fix potential sign-extension overflow
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 12:44:52 -0700
In-Reply-To: <20191015184657.GA26541@embeddedor>
References: <20191015184657.GA26541@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 13:46 -0500, Gustavo A. R. Silva wrote:
> In expression 0xff << offset, left shifting by more than 31 bits has
> undefined behavior. Notice that the shift amount, *offset*, can be as
> much as 63.
> 
> Fix this by adding suffix ULL to integer 0xFF.
[]
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
[]
> @@ -520,7 +520,7 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>  	const size_t index = BIT_WORD(start);
>  	const unsigned long offset = start % BITS_PER_LONG;
>  
> -	map[index] &= ~(0xFF << offset);
> +	map[index] &= ~(0xFFULL << offset);

BITS_PER_LONG is 32 and 0xFFULL is 64 bit
when compiled for 32 bit arches.

This should just be 0xFFUL and not ULL.


