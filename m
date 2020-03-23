Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF818EDCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 03:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCWCCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 22:02:49 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:44760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726954AbgCWCCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:02:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A55B2837F24F;
        Mon, 23 Mar 2020 02:02:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2828:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7903:10004:10400:11026:11232:11473:11658:11914:12043:12295:12297:12438:12740:12760:12895:13069:13138:13231:13311:13357:13439:14659:14721:21080:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cakes39_8cd2320f7ba51
X-Filterd-Recvd-Size: 2290
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 02:02:47 +0000 (UTC)
Message-ID: <ed37a2a18060f71accb202c05724c0b66d0aa9f7.camel@perches.com>
Subject: Re: [PATCH v3] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Sun, 22 Mar 2020 19:00:58 -0700
In-Reply-To: <20200323012519.41536-1-yuchao0@huawei.com>
References: <20200323012519.41536-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 09:25 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
[]
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
[]
> @@ -2586,22 +2590,28 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>  	}
>  }
>  
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	test_and_set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);

I believe this should just use

	test_and_set_bit(flag, F2FS_I(inode)->flags);

>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>  {
> -	return test_bit(flag, &F2FS_I(inode)->flags);
> +	return test_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

here too.

	test_bit(flag, F2FS_I(inode)->flags);

>  static inline void clear_inode_flag(struct inode *inode, int flag)
>  {
> -	if (test_bit(flag, &F2FS_I(inode)->flags))
> -		clear_bit(flag, &F2FS_I(inode)->flags);
> +	test_and_clear_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

and here.

I also don't know why these functions are used at all.


