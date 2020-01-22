Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD71449B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 03:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAVCGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 21:06:18 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36040 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgAVCGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:06:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToJoNIc_1579658775;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToJoNIc_1579658775)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Jan 2020 10:06:16 +0800
Subject: Re: [PATCH v1] lib/test_bitmap: Make use of EXP2_IN_BITS
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20200121151847.75223-1-andriy.shevchenko@linux.intel.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <550c4e28-4826-dfef-9b8a-1d4290f52ff8@linux.alibaba.com>
Date:   Wed, 22 Jan 2020 10:06:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121151847.75223-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/1/21 ÏÂÎç11:18, Andy Shevchenko Ð´µÀ:
> The commit 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
> introduced some new test cases to the test_bitmap.c module. Among these
> it also introduced an (unused) definition. Let's make use of EXP2_IN_BITS.
> 
> Reported-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 61ed71c1daba..6b13150667f5 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -278,6 +278,8 @@ static void __init test_replace(void)
>  	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
>  	DECLARE_BITMAP(bmap, 1024);
>  
> +	BUILD_BUG_ON(EXP2_IN_BITS < nbits * 2);
> +
>  	bitmap_zero(bmap, 1024);
>  	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
>  	expect_eq_bitmap(bmap, exp3_0_1, nbits);
> 

It looks nice. :)

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
