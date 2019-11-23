Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D54107C64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 21:16:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfKWCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:16:54 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 756A0ABE1A63E148FEE4;
        Sat, 23 Nov 2019 10:16:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 10:16:41 +0800
Subject: Re: [PATCH] tmpfs: use ida to get inode number
To:     Matthew Wilcox <willy@infradead.org>
CC:     Hugh Dickins <hughd@google.com>, <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
 <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
 <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
 <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
 <alpine.LSU.2.11.1911211125190.1697@eggly.anvils>
 <5423a199-eefb-0a02-6e86-1f6210939c11@huawei.com>
 <20191122221327.GW20752@bombadil.infradead.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <77f67d7a-4a93-4319-e6af-54daffcc37e2@huawei.com>
Date:   Sat, 23 Nov 2019 10:16:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191122221327.GW20752@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/23 6:13, Matthew Wilcox wrote:
> On Fri, Nov 22, 2019 at 09:23:30AM +0800, zhengbin (A) wrote:
>> On 2019/11/22 3:53, Hugh Dickins wrote:
>>> On Thu, 21 Nov 2019, zhengbin (A) wrote:
>>>> On 2019/11/21 12:52, Hugh Dickins wrote:
>>>>> Just a rushed FYI without looking at your patch or comments.
>>>>>
>>>>> Internally (in Google) we do rely on good tmpfs inode numbers more
>>>>> than on those of other get_next_ino() filesystems, and carry a patch
>>>>> to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
>>>>> number space for each superblock) - essentially,
>>>>>
>>>>> 	ino = sbinfo->next_ino++;
>>>>> 	/* Avoid 0 in the low 32 bits: might appear deleted */
>>>>> 	if (unlikely((unsigned int)ino == 0))
>>>>> 		ino = sbinfo->next_ino++;
>>>>>
>>>>> Which I think would be faster, and need less memory, than IDA.
>>>>> But whether that is of general interest, or of interest to you,
>>>>> depends upon how prevalent 32-bit executables built without
>>>>> __FILE_OFFSET_BITS=64 still are these days.
>>>> So how google think about this? inode number > 32-bit, but 32-bit executables
>>>> cat not handle this?
>>> Google is free to limit what executables are run on its machines,
>>> and how they are built, so little problem here.
>>>
>>> A general-purpose 32-bit Linux distribution does not have that freedom,
>>> does not want to limit what the user runs.  But I thought that by now
>>> they (and all serious users of 32-bit systems) were building their own
>>> executables with _FILE_OFFSET_BITS=64 (I was too generous with the
>>> underscores yesterday); and I thought that defined __USE_FILE_OFFSET64,
>>> and that typedef'd ino_t to be __ino64_t.  And the 32-bit kernel would
>>> have __ARCH_WANT_STAT64, which delivers st_ino as unsigned long long.
>>>
>>> So I thought that a modern, professional 32-bit executable would be
>>> dealing in 64-bit inode numbers anyway.  But I am not a system builder,
>>> so perhaps I'm being naive.  And of course some users may have to support
>>> some old userspace, or apps that assign inode numbers to "int" or "long"
>>> or whatever.  I have no insight into the extent of that problem.
>> So how to solve this problem?
>>
>> 1. tmpfs use ida or other data structure
>>
>> 2. tmpfs use 64-bit, each superblock a inode number space
>>
>> 3. do not do anything, If somebody hits this bug, let them solve for themselves
>>
>> 4. (last_ino change to 64-bit)get_next_ino -->other filesystems will be ok, but it was rejected before
> 5. Extend the sbitmap API to allow for growing the bitmap.  I had a
> look at doing that, and it looks hard.  There are a lot of things which
> are set up at initialisation and changing them mid-use seems tricky.
> Ccing Jens in case he has an opinion.
>
> 6. Creating a percpu IDA.  This doesn't seem too hard.  We need a percpu
> pointer to an IDA leaf (128 bytes), and a percpu integer which is the
> current base for this CPU.  At allocation time, find and set the first
> free bit in the leaf, and add on the current base.
>
> If the percpu leaf is full, set the XA_MARK_1 bit on the entry in
> the XArray.  Then look for any leaves which have both the XA_MARK_0
> and XA_MARK_1 bits set; if there is one, claim it by clearing the
> XA_MARK_1 bit.  If not, kzalloc a new one and find a free spot for it
> in the underlying XArray.
>
> Freeing an ID is simply ida_free().  That will involve changing the
> users of get_next_ino() to call put_ino(), or something.
>
> This should generally result in similar contention between threads as
> the current scheme -- accessing a shared resource every 1024 allocations.
> Maybe more often as we try to avoid leaving gaps in the data structure,
> or maybe less as we reuse IDs.
>
> (I've tried to explain what I want here, but appreciate it may be
> inscrutable.  I can try to explain more, or maybe I should just write
> the code myself)

I am trying to understand it, if you write the code, I am also very welcome.

By the way, percpu IDA is for reducing performance impact? This patch has 2.16%

performance degradation(Use perf to get the cost of ida_alloc_range)

>
> .
>

