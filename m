Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3918EE48
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 03:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCWC7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 22:59:00 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:45076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgCWC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:59:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BCE4E1802926E;
        Mon, 23 Mar 2020 02:58:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2901:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7903:8603:10004:10400:10848:11026:11473:11658:11914:12295:12297:12740:12760:12895:13069:13138:13231:13311:13357:13439:14659:14721:21080:21451:21627:21796:30036:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: foot07_314bb36a3e01d
X-Filterd-Recvd-Size: 2428
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 02:58:58 +0000 (UTC)
Message-ID: <8d435607bd79f518bd9420d68894ddda521bac5a.camel@perches.com>
Subject: Re: [PATCH v4] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Sun, 22 Mar 2020 19:57:09 -0700
In-Reply-To: <20200323024109.60967-1-yuchao0@huawei.com>
References: <20200323024109.60967-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 10:41 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
[]
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
[]
> @@ -682,6 +682,47 @@ enum {
[]
> +/* used for f2fs_inode_info->flags */
> +enum {
[]
> +	FI_MAX,			/* max flag, never be used */
> +};
> +
> +/* f2fs_inode_info.flags array size */
> +#define FI_ARRAY_SIZE		(BITS_TO_LONGS(FI_MAX))

Perhaps FI_ARRAY_SIZE isn't necessary.

> +
>  struct f2fs_inode_info {
>  	struct inode vfs_inode;		/* serve a vfs inode */
>  	unsigned long i_flags;		/* keep an inode flags for ioctl */
> @@ -694,7 +735,7 @@ struct f2fs_inode_info {
>  	umode_t i_acl_mode;		/* keep file acl mode temporarily */
>  
>  	/* Use below internally in f2fs*/
> -	unsigned long flags;		/* use to pass per-file flags */
> +	unsigned long flags[FI_ARRAY_SIZE];	/* use to pass per-file flags */

and BITS_TO_LONGS should be used here.

> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
[]
> @@ -362,7 +363,8 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>  	if (S_ISREG(inode->i_mode))
>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
> -	fi->flags = 0;
> +	for (i = 0; i < FI_ARRAY_SIZE; i++)
> +		fi->flags[i] = 0;

And this could become

	bitmap_zero(fi->flags, BITS_TO_LONG(FI_MAX));

Is FI_ARRAY_SIZE used anywhere else?

