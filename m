Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F318842F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 05:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfHGDhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 23:37:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727420AbfHGDhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:37:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CB201ACE2B478DE5047;
        Wed,  7 Aug 2019 11:37:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019
 11:37:08 +0800
Subject: Re: [PATCH v2] f2fs: Fix indefinite loop in f2fs_gc()
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1565090396-7263-1-git-send-email-stummala@codeaurora.org>
 <8766875c-1e35-22dc-48d2-45b6776e4f38@huawei.com>
 <20190807032458.GI8289@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <28512520-d8fe-839f-67ab-45f89f12968d@huawei.com>
Date:   Wed, 7 Aug 2019 11:37:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190807032458.GI8289@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019/8/7 11:24, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Wed, Aug 07, 2019 at 10:04:16AM +0800, Chao Yu wrote:
>> Hi Sahitya,
>>
>> On 2019/8/6 19:19, Sahitya Tummala wrote:
>>> Policy - Foreground GC, LFS and greedy GC mode.
>>>
>>> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
>>> enough free segements to proceed and thus it keeps calling gc_more
>>> for the same victim segment.  This can happen if the selected victim
>>> segment could not be GC'd due to failed blkaddr validity check i.e.
>>> is_alive() returns false for the blocks set in current validity map.
>>>
>>> Fix this by keeping track of such invalid segments and skip those
>>> segments for selection in get_victim_by_default() to avoid endless
>>> GC loop under such error scenarios.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>> v2: fix as per Chao's suggestion to handle this error case
>>>
>>>  fs/f2fs/gc.c      | 15 ++++++++++++++-
>>>  fs/f2fs/segment.c |  5 +++++
>>>  fs/f2fs/segment.h |  3 +++
>>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 8974672..321a78a 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -382,6 +382,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>>  			nsearched++;
>>>  		}
>>>  
>>> +		/*
>>> +		 * skip selecting the invalid segno (that is failed due to block
>>> +		 * validity check failed during GC) to avoid endless GC loop in
>>> +		 * such cases.
>>> +		 */
>>> +		if (test_bit(segno, sm->invalid_segmap))
>>> +			goto next;
>>> +
>>>  		secno = GET_SEC_FROM_SEG(sbi, segno);
>>>  
>>>  		if (sec_usage_check(sbi, secno))
>>> @@ -975,6 +983,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>  	int off;
>>>  	int phase = 0;
>>>  	int submitted = 0;
>>> +	struct sit_info *sit_i = SIT_I(sbi);
>>>  
>>>  	start_addr = START_BLOCK(sbi, segno);
>>>  
>>> @@ -1008,8 +1017,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>  		}
>>>  
>>>  		/* Get an inode by ino with checking validity */
>>> -		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
>>> +		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs)) {
>>> +			if (!test_and_set_bit(segno, sit_i->invalid_segmap))
>>> +				f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
>>> +						start_addr + off, segno);
>>
>> Oh, there is some normal cases in is_alive(), such as f2fs_get_node_page() or
>> f2fs_get_node_info() failure due to no memory, we should bypass such cases. I
> 
> Oh, yes, I have missed this point.
> 
>> guess something like this:
>>
>> if (source_blkaddr != blkaddr) {
>> 	if (unlikely(check_valid_map(sbi, segno, off))) {
> 
> check_valid_map() is validated before is_alive(). So I think this check again
> may not be needed. What do you think?

> race in between is_alive() and update_sit_entry()

There will be a race case:

gc_data_segment			f2fs_truncate_data_blocks_range
check_valid_map
				f2fs_invalidate_blocks
				update_sit_entry
				f2fs_test_and_clear_bit(, se->cur_valid_map);
				unlock_page(node_page)
is_alive
lock_page(node_page)
blkaddr should be NULL and not equal to source_blkaddr, I think this is a normal
case, right?

Thanks,

> 
>> 		if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
>> 			f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
>> 				start_addr + off, segno);
>> 			set_sbi_flag(sbi, SBI_NEED_FSCK);
>> 		}
>> 	}
>> 	return false;
>> }
>>
>> I think this will be safe to call check_valid_map(), because there should be no
>> race in between is_alive() and update_sit_entry() from all paths due to node
>> page lock dependence.
>>
>> One more concern is should we use this under CONFIG_F2FS_CHECK_FS? If there is
>> actually such a bug can cause data inconsistency, we'd better find the root
>> cause in debug version.
>>
> 
> Yes, I agree with you. I will include this under CONFIG_F2FS_CHECK_FS.
> 
> Thanks,
> 
>> Thanks,
>>
>>>  			continue;
>>> +		}
>>>  
>>>  		if (phase == 2) {
>>>  			f2fs_ra_node_page(sbi, dni.ino);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index a661ac3..d45a1d3 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -4017,6 +4017,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>>>  		return -ENOMEM;
>>>  #endif
>>>  
>>> +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
>>> +	if (!sit_i->invalid_segmap)
>>> +		return -ENOMEM;
>>> +
>>>  	/* init SIT information */
>>>  	sit_i->s_ops = &default_salloc_ops;
>>>  
>>> @@ -4518,6 +4522,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
>>>  #ifdef CONFIG_F2FS_CHECK_FS
>>>  	kvfree(sit_i->sit_bitmap_mir);
>>>  #endif
>>> +	kvfree(sit_i->invalid_segmap);
>>>  	kvfree(sit_i);
>>>  }
>>>  
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index b746028..bc5dbe8 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -246,6 +246,9 @@ struct sit_info {
>>>  	unsigned long long min_mtime;		/* min. modification time */
>>>  	unsigned long long max_mtime;		/* max. modification time */
>>>  
>>> +	/* list of segments to be ignored by GC in case of errors */
>>> +	unsigned long *invalid_segmap;
>>> +
>>>  	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
>>>  };
>>>  
>>>
> 
