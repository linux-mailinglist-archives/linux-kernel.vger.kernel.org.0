Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545C3A5E31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 01:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfIBXe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 19:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfIBXe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:34:59 -0400
Received: from [192.168.0.102] (unknown [180.111.100.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7E2204EC;
        Mon,  2 Sep 2019 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567467297;
        bh=F9/9OqcGcQEtIqJp2H7jCpVfE3oPKJOonibTvF9TjfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vr1+k3iGVD46bLwn/jETtwy5lV4TZtL4Mpt9XVqsL2JZiaTIEK3zG6VKP1Jok2yJU
         RwT/ZeAvU7cQ42ZN3f7GvxXgvXR1SzQBfs7UQMaxSxBMtBZr4Avm1b/p+beTEgdpyb
         eacGXZpTyB2fnFJ3Ii/rCuYaMuzvo3OnvMLQbHeQ=
Subject: Re: [PATCH v4] f2fs: add bio cache for IPU
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190219081529.5106-1-yuchao0@huawei.com>
 <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
 <20190901071757.GA49907@jaegeuk-macbookpro.roam.corp.google.com>
 <024fe351-8e25-35cd-47a7-9755498c73f4@huawei.com>
 <20190902230449.GD71929@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <969f59f7-a171-f303-8a4a-ee1430036b27@kernel.org>
Date:   Tue, 3 Sep 2019 07:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902230449.GD71929@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-9-3 7:04, Jaegeuk Kim wrote:
> On 09/02, Chao Yu wrote:
>> On 2019/9/1 15:17, Jaegeuk Kim wrote:
>>> On 08/31, Chao Yu wrote:
>>>> On 2019/2/19 16:15, Chao Yu wrote:
>>>>> @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
>>>>>  	}
>>>>>  
>>>>>  	unlock_page(page);
>>>>> -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
>>>>> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
>>>>> +		f2fs_submit_ipu_bio(sbi, bio, page);
>>>>>  		f2fs_balance_fs(sbi, need_balance_fs);
>>>>> +	}
>>>>
>>>> Above bio submission was added to avoid below deadlock:
>>>>
>>>> - __write_data_page
>>>>  - f2fs_do_write_data_page
>>>>   - set_page_writeback        ---- set writeback flag
>>>>   - f2fs_inplace_write_data
>>>>  - f2fs_balance_fs
>>>>   - f2fs_gc
>>>>    - do_garbage_collect
>>>>     - gc_data_segment
>>>>      - move_data_page
>>>>       - f2fs_wait_on_page_writeback
>>>>        - wait_on_page_writeback  --- wait writeback
>>>>
>>>> However, it breaks the merge of IPU IOs, to solve this issue, it looks we need
>>>> to add global bio cache for such IPU merge case, then later
>>>> f2fs_wait_on_page_writeback can check whether writebacked page is cached or not,
>>>> and do the submission if necessary.
>>>>
>>>> Jaegeuk, any thoughts?
>>>
>>> How about calling f2fs_submit_ipu_bio() when we need to do GC in the same
>>> context?
>>
>> However it also could happen in race case:
>>
>> Thread A				Thread B
>> - __write_data_page (inode x, page y)
>>  - f2fs_do_write_data_page
>>   - set_page_writeback        ---- set writeback flag in page y
>>   - f2fs_inplace_write_data
>>  - f2fs_balance_fs
>> 					 - lock gc_mutex
>>  - lock gc_mutex
>> 					  - f2fs_gc
>> 					   - do_garbage_collect
>> 					    - gc_data_segment
>> 					     - move_data_page
>> 					      - f2fs_wait_on_page_writeback
>> 					       - wait_on_page_writeback  --- wait writeback of page y
>>
>> So it needs a global bio cache for merged IPU pages, how about adding a list to
>> link all ipu bios in struct f2fs_bio_info?
> 
> Hmm, I can't think of better solution than adding a list. In this case, blk_plug
> doesn't work well?

Only submitted bio will be taken care of plug, for our case, the bio is still
pending though, I guess plug won't help.

Thanks,

> 
>>
>> struct f2fs_bio_info {
>> 	....
>> 	struct list_head ipu_bio_list;	/* track all ipu bio */
>> 	spinlock_t ipu_bio_lock;	/* protect ipu bio list */
>> }
>>
>>>
>>>>
>>>> Thanks,
>>> .
>>>
