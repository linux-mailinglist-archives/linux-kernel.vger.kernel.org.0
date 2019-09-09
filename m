Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B195EAD43F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 09:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbfIIHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 03:54:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfIIHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:54:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2CD8AFDD2F6759334CCE;
        Mon,  9 Sep 2019 15:54:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 15:54:37 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <20190909012532.20454-2-jaegeuk@kernel.org>
 <f446ff29-38a5-61fd-4056-b4067b01c630@huawei.com>
 <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5a473076-14b8-768a-62ac-f686e850d5a6@huawei.com>
Date:   Mon, 9 Sep 2019 15:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/9 15:30, Jaegeuk Kim wrote:
> On 09/09, Chao Yu wrote:
>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
>>> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
>>> get commited pages but atomic_file being still set like:
>>>
>>> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
>>>
>>> If GC selects this block, we can get an infinite loop like this:
>>>
>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
>>>
>>> In that moment, we can observe:
>>>
>>> [Before]
>>> Try to move 5084219 blocks (BG: 384508)
>>>   - data blocks : 4962373 (274483)
>>>   - node blocks : 121846 (110025)
>>> Skipped : atomic write 4534686 (10)
>>>
>>> [After]
>>> Try to move 5088973 blocks (BG: 384508)
>>>   - data blocks : 4967127 (274483)
>>>   - node blocks : 121846 (110025)
>>> Skipped : atomic write 4539440 (10)
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/file.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 7ae2f3bd8c2f..68b6da734e5f 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>  			goto err_out;
>>>  
>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>>> -		if (!ret) {
>>> -			clear_inode_flag(inode, FI_ATOMIC_FILE);
>>> -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
>>> -			stat_dec_atomic_write(inode);
>>> -		}
>>> +
>>> +		/* doesn't need to check error */
>>> +		clear_inode_flag(inode, FI_ATOMIC_FILE);
>>> +		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
>>> +		stat_dec_atomic_write(inode);
>>
>> If there are still valid atomic write pages linked in .inmem_pages, it may cause
>> memory leak when we just clear FI_ATOMIC_FILE flag.
> 
> f2fs_commit_inmem_pages() should have flushed them.

Oh, we failed to flush its nodes.

However we won't clear such info if we failed to flush inmen pages, it looks
inconsistent.

Any interface needed to drop inmem pages or clear ATOMIC_FILE flag in that two
error path? I'm not very clear how sqlite handle such error.

Thanks,

> 
>>
>> So my question is why below logic didn't handle such condition well?
>>
>> f2fs_gc()
>>
>> 	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>> 		if (skipped_round <= MAX_SKIP_GC_COUNT ||
>> 					skipped_round * 2 < round) {
>> 			segno = NULL_SEGNO;
>> 			goto gc_more;
>> 		}
>>
>> 		if (first_skipped < last_skipped &&
>> 				(last_skipped - first_skipped) >
>> 						sbi->skipped_gc_rwsem) {
>> 			f2fs_drop_inmem_pages_all(sbi, true);
> 
> This is doing nothing, since f2fs_commit_inmem_pages() removed the inode
> from inmem list.
> 
>> 			segno = NULL_SEGNO;
>> 			goto gc_more;
>> 		}
>> 		if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
>> 			ret = f2fs_write_checkpoint(sbi, &cpc);
>> 	}
>>
>>>  	} else {
>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>>>  	}
>>>
> .
> 
