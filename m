Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4B13418C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgAHMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:23:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbgAHMXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:23:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C490AC9D5E052C803CA;
        Wed,  8 Jan 2020 20:23:18 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 Jan 2020
 20:23:16 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a way to turn off ipu bio cache
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200107020709.73568-1-jaegeuk@kernel.org>
 <afddac87-b7c5-f68c-4e55-3705be311cf6@huawei.com>
 <20200108120444.GC28331@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d5555fd8-736f-cc2f-1e57-d9ac01b3d012@huawei.com>
Date:   Wed, 8 Jan 2020 20:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200108120444.GC28331@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/8 20:04, Jaegeuk Kim wrote:
> On 01/08, Chao Yu wrote:
>> On 2020/1/7 10:07, Jaegeuk Kim wrote:
>>> Setting 0x40 in /sys/fs/f2fs/dev/ipu_policy gives a way to turn off
>>> bio cache, which is useufl to check whether block layer using hardware
>>> encryption engine merges IOs correctly.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  Documentation/filesystems/f2fs.txt | 1 +
>>>  fs/f2fs/segment.c                  | 2 +-
>>>  fs/f2fs/segment.h                  | 1 +
>>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
>>> index 41b5aa94b30f..cd93bcc34726 100644
>>> --- a/Documentation/filesystems/f2fs.txt
>>> +++ b/Documentation/filesystems/f2fs.txt
>>> @@ -335,6 +335,7 @@ Files in /sys/fs/f2fs/<devname>
>>>                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
>>>                                 0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
>>>                                 0x10: F2FS_IPU_FSYNC.
>>
>> . -> ,
> 
> Actually, we can't do it. I revised it a bit instead.

One more question, why skipping 0x20 bit position?

Thanks,

> 
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>> +			       0x40: F2FS_IPU_NOCACHE disables bio caches.
>>>  
>>>   min_ipu_util                 This parameter controls the threshold to trigger
>>>                                in-place-updates. The number indicates percentage
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index a9519532c029..311fe4937f6a 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3289,7 +3289,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>>>  
>>>  	stat_inc_inplace_blocks(fio->sbi);
>>>  
>>> -	if (fio->bio)
>>> +	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
>>>  		err = f2fs_merge_page_bio(fio);
>>>  	else
>>>  		err = f2fs_submit_page_bio(fio);
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index a1b3951367cd..02e620470eef 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -623,6 +623,7 @@ enum {
>>>  	F2FS_IPU_SSR_UTIL,
>>>  	F2FS_IPU_FSYNC,
>>>  	F2FS_IPU_ASYNC,
>>> +	F2FS_IPU_NOCACHE,
>>>  };
>>>  
>>>  static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
>>>
> .
> 
