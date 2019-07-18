Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748446C514
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfGRCwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 22:52:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfGRCwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:52:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1425861DD87321735634;
        Thu, 18 Jul 2019 10:52:05 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 10:52:00 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to read source block before
 invalidating it
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190718013718.70335-1-jaegeuk@kernel.org>
 <8049131e-4200-83c8-516a-8fa03a238e29@huawei.com>
Message-ID: <c4c9cf7d-dfe7-09fa-1d62-ac6719cc623c@huawei.com>
Date:   Thu, 18 Jul 2019 10:51:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8049131e-4200-83c8-516a-8fa03a238e29@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/18 10:39, Chao Yu wrote:
> On 2019/7/18 9:37, Jaegeuk Kim wrote:
>> f2fs_allocate_data_block() invalidates old block address and enable new block
>> address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
>> give WARN due to reading invalid blocks.
>>
>> Let's make the order sanely back.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/gc.c | 57 ++++++++++++++++++++++++++++------------------------
>>  1 file changed, 31 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 6691f526fa40..35c5453ab874 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -740,6 +740,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  	block_t newaddr;
>>  	int err = 0;
>>  	bool lfs_mode = test_opt(fio.sbi, LFS);
>> +	bool submitted = false;
>>  
>>  	/* do not read out */
>>  	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
>> @@ -796,6 +797,20 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  	if (lfs_mode)
>>  		down_write(&fio.sbi->io_order_lock);
>>  
>> +	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
>> +			fio.old_blkaddr, false);
>> +	if (!mpage)
>> +		goto put_out;
> 
> Needs to release io_order_lock.
> 
>> +
>> +	if (!PageUptodate(mpage)) {
>> +		err = f2fs_submit_page_bio(&fio);

It will load ciphertext into fio.page, looks not correct.

Thanks,

>> +		if (err) {
>> +			f2fs_put_page(mpage, 1);
>> +			goto put_out;
> 
> Ditto.
> 
> Thanks,
> 
>> +		}
>> +		submitted = true;
>> +	}
>> +
>>  	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>>  					&sum, CURSEG_COLD_DATA, NULL, false);
>>  
>> @@ -803,44 +818,34 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
>>  	if (!fio.encrypted_page) {
>>  		err = -ENOMEM;
>> -		goto recover_block;
>> -	}
>> -
>> -	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
>> -					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
>> -	if (mpage) {
>> -		bool updated = false;
>> -
>> -		if (PageUptodate(mpage)) {
>> -			memcpy(page_address(fio.encrypted_page),
>> -					page_address(mpage), PAGE_SIZE);
>> -			updated = true;
>> -		}
>>  		f2fs_put_page(mpage, 1);
>> -		invalidate_mapping_pages(META_MAPPING(fio.sbi),
>> -					fio.old_blkaddr, fio.old_blkaddr);
>> -		if (updated)
>> -			goto write_page;
>> +		goto recover_block;
>>  	}
>>  
>> -	err = f2fs_submit_page_bio(&fio);
>> -	if (err)
>> -		goto put_page_out;
>> -
>> -	/* write page */
>> -	lock_page(fio.encrypted_page);
>> +	if (!submitted)
>> +		goto write_page;
>>  
>> -	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
>> +	/* read source block */
>> +	lock_page(mpage);
>> +	if (unlikely(mpage->mapping != META_MAPPING(fio.sbi))) {
>>  		err = -EIO;
>> +		f2fs_put_page(mpage, 1);
>>  		goto put_page_out;
>>  	}
>> -	if (unlikely(!PageUptodate(fio.encrypted_page))) {
>> +	if (unlikely(!PageUptodate(mpage))) {
>>  		err = -EIO;
>> +		f2fs_put_page(mpage, 1);
>>  		goto put_page_out;
>>  	}
>> -
>>  write_page:
>> +	/* write target block */
>>  	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
>> +	memcpy(page_address(fio.encrypted_page),
>> +				page_address(mpage), PAGE_SIZE);
>> +	f2fs_put_page(mpage, 1);
>> +	invalidate_mapping_pages(META_MAPPING(fio.sbi),
>> +				fio.old_blkaddr, fio.old_blkaddr);
>> +
>>  	set_page_dirty(fio.encrypted_page);
>>  	if (clear_page_dirty_for_io(fio.encrypted_page))
>>  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
