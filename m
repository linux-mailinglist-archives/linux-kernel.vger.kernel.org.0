Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09496C7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 05:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbfGRDa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 23:30:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389907AbfGRDaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:30:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92BEC43EF11C6CF4ED03;
        Thu, 18 Jul 2019 11:30:23 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 11:30:19 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to read source block before
 invalidating it
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190718013718.70335-1-jaegeuk@kernel.org>
 <20190718031214.GA78336@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <19a25101-da74-de98-6ca4-a9fd9fa09ef2@huawei.com>
Date:   Thu, 18 Jul 2019 11:30:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190718031214.GA78336@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/18 11:12, Jaegeuk Kim wrote:
> f2fs_allocate_data_block() invalidates old block address and enable new block
> address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
> give WARN due to reading invalid blocks.
> 
> Let's make the order sanely back.

Hmm.. to avoid WARM, we may suffer one more memcpy, I suspect this can reduce
online resize or foreground gc ioctl performance...

Can we just relief to use DATA_GENERIC_ENHANCE_READ for this case...?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Except performance, I'm okay with this change.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
> v2:
> I was fixing the comments. :)
> 
>  fs/f2fs/gc.c | 70 +++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6691f526fa40..8974672db78f 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -796,6 +796,29 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  	if (lfs_mode)
>  		down_write(&fio.sbi->io_order_lock);
>  
> +	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
> +					fio.old_blkaddr, false);
> +	if (!mpage)
> +		goto up_out;
> +
> +	fio.encrypted_page = mpage;
> +
> +	/* read source block in mpage */
> +	if (!PageUptodate(mpage)) {
> +		err = f2fs_submit_page_bio(&fio);
> +		if (err) {
> +			f2fs_put_page(mpage, 1);
> +			goto up_out;
> +		}
> +		lock_page(mpage);
> +		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
> +						!PageUptodate(mpage))) {
> +			err = -EIO;
> +			f2fs_put_page(mpage, 1);
> +			goto up_out;
> +		}
> +	}
> +
>  	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>  					&sum, CURSEG_COLD_DATA, NULL, false);
>  
> @@ -803,44 +826,18 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
>  	if (!fio.encrypted_page) {
>  		err = -ENOMEM;
> -		goto recover_block;
> -	}
> -
> -	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
> -					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
> -	if (mpage) {
> -		bool updated = false;
> -
> -		if (PageUptodate(mpage)) {
> -			memcpy(page_address(fio.encrypted_page),
> -					page_address(mpage), PAGE_SIZE);
> -			updated = true;
> -		}
>  		f2fs_put_page(mpage, 1);
> -		invalidate_mapping_pages(META_MAPPING(fio.sbi),
> -					fio.old_blkaddr, fio.old_blkaddr);
> -		if (updated)
> -			goto write_page;
> -	}
> -
> -	err = f2fs_submit_page_bio(&fio);
> -	if (err)
> -		goto put_page_out;
> -
> -	/* write page */
> -	lock_page(fio.encrypted_page);
> -
> -	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
> -		err = -EIO;
> -		goto put_page_out;
> -	}
> -	if (unlikely(!PageUptodate(fio.encrypted_page))) {
> -		err = -EIO;
> -		goto put_page_out;
> +		goto recover_block;
>  	}
>  
> -write_page:
> +	/* write target block */
>  	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
> +	memcpy(page_address(fio.encrypted_page),
> +				page_address(mpage), PAGE_SIZE);
> +	f2fs_put_page(mpage, 1);
> +	invalidate_mapping_pages(META_MAPPING(fio.sbi),
> +				fio.old_blkaddr, fio.old_blkaddr);
> +
>  	set_page_dirty(fio.encrypted_page);
>  	if (clear_page_dirty_for_io(fio.encrypted_page))
>  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
> @@ -871,11 +868,12 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  put_page_out:
>  	f2fs_put_page(fio.encrypted_page, 1);
>  recover_block:
> -	if (lfs_mode)
> -		up_write(&fio.sbi->io_order_lock);
>  	if (err)
>  		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
>  								true, true);
> +up_out:
> +	if (lfs_mode)
> +		up_write(&fio.sbi->io_order_lock);
>  put_out:
>  	f2fs_put_dnode(&dn);
>  out:
> 
