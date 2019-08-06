Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B661082981
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfHFCHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 22:07:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729921AbfHFCHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:07:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA81BC792E146B5D03D3;
        Tue,  6 Aug 2019 10:07:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 6 Aug 2019
 10:07:27 +0800
Subject: Re: [PATCH] Revert "f2fs: avoid out-of-range memory access"
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190802101548.96543-1-yuchao0@huawei.com>
 <20190806004215.GC98101@jaegeuk-macbookpro.roam.corp.google.com>
 <dd284020-77b0-1627-2fc2-bc51745adfd3@huawei.com>
 <20190806012839.GD1029@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5c449273-5cf7-bcc6-a396-584b933833c1@huawei.com>
Date:   Tue, 6 Aug 2019 10:07:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190806012839.GD1029@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/6 9:28, Jaegeuk Kim wrote:
> On 08/06, Chao Yu wrote:
>> On 2019/8/6 8:42, Jaegeuk Kim wrote:
>>> On 08/02, Chao Yu wrote:
>>>> As Pavel Machek reported:
>>>>
>>>> "We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
>>>> good idea to report it to the syslog and mark filesystem as "needing
>>>> fsck" if filesystem can do that."
>>>>
>>>> Still we need improve the original patch with:
>>>> - use unlikely keyword
>>>> - add message print
>>>> - return EUCLEAN
>>>>
>>>> However, after rethink this patch, I don't think we should add such
>>>> condition check here as below reasons:
>>>> - We have already checked the field in f2fs_sanity_check_ckpt(),
>>>> - If there is fs corrupt or security vulnerability, there is nothing
>>>> to guarantee the field is integrated after the check, unless we do
>>>> the check before each of its use, however no filesystem does that.
>>>> - We only have similar check for bitmap, which was added due to there
>>>> is bitmap corruption happened on f2fs' runtime in product.
>>>> - There are so many key fields in SB/CP/NAT did have such check
>>>> after f2fs_sanity_check_{sb,cp,..}.
>>>>
>>>> So I propose to revert this unneeded check.
>>>
>>> IIRC, this came from security vulnerability report which can access
>>
>> I don't think that's correct report, since we have checked validation of that
>> field during mount, if it can be ruined after that, any variables can't be trusted.
> 
> I assumed this was reproduced with a fuzzed image.

I expect f2fs_sanity_check_ckpt() should reject mounting such fuzzed image.

> I'll check it with Ocean.
> 
>>
>> Now we just check bitmaps at real-time, because we have encountered such bitmap
>> corruption in product.
>>
>> Thanks,
>>
>>> out-of-boundary memory region. Could you write another patch to address the
>>> above issues?
>>>
>>>>
>>>> This reverts commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/segment.c | 5 -----
>>>>  1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 9693fa4c8971..2eff9c008ae0 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -3492,11 +3492,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>>>>  		seg_i = CURSEG_I(sbi, i);
>>>>  		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
>>>>  		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
>>>> -		if (blk_off > ENTRIES_IN_SUM) {
>>>> -			f2fs_bug_on(sbi, 1);
>>>> -			f2fs_put_page(page, 1);
>>>> -			return -EFAULT;
>>>> -		}
>>>>  		seg_i->next_segno = segno;
>>>>  		reset_curseg(sbi, i, 0);
>>>>  		seg_i->alloc_type = ckpt->alloc_type[i];
>>>> -- 
>>>> 2.18.0.rc1
>>> .
>>>
> .
> 
