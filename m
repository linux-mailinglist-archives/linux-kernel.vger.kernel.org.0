Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245206B2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 02:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfGQAqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 20:46:40 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43370 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfGQAqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:46:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX58dOx_1563324395;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TX58dOx_1563324395)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 08:46:36 +0800
Subject: Re: [PATCH] ocfs2: remove set but not used variable 'last_hash'
To:     YueHaibing <yuehaibing@huawei.com>, mark@fasheh.com,
        jlbec@evilplan.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20190716132110.34836-1-yuehaibing@huawei.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5dc2a052-4d30-b047-2c4d-9131ac4f6485@linux.alibaba.com>
Date:   Wed, 17 Jul 2019 08:46:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716132110.34836-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/16 21:21, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/ocfs2/xattr.c: In function ocfs2_xattr_bucket_find:
> fs/ocfs2/xattr.c:3828:6: warning: variable last_hash set but not used [-Wunused-but-set-variable]
> 
> It's never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/xattr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 385f3aa..90c830e3 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -3825,7 +3825,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
>  	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
>  	int low_bucket = 0, bucket, high_bucket;
>  	struct ocfs2_xattr_bucket *search;
> -	u32 last_hash;
>  	u64 blkno, lower_blkno = 0;
>  
>  	search = ocfs2_xattr_bucket_new(inode);
> @@ -3869,8 +3868,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
>  		if (xh->xh_count)
>  			xe = &xh->xh_entries[le16_to_cpu(xh->xh_count) - 1];
>  
> -		last_hash = le32_to_cpu(xe->xe_name_hash);
> -
>  		/* record lower_blkno which may be the insert place. */
>  		lower_blkno = blkno;
>  
> 
