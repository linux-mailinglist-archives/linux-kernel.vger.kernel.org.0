Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C0104AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfKUGqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 01:46:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKUGqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:46:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73A6C2041FC65341FC57;
        Thu, 21 Nov 2019 14:46:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 21 Nov 2019
 14:45:02 +0800
Subject: Re: [PATCH] tmpfs: use ida to get inode number
To:     Hugh Dickins <hughd@google.com>
CC:     Matthew Wilcox <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
 <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
 <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
Date:   Thu, 21 Nov 2019 14:45:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/21 12:52, Hugh Dickins wrote:
> On Thu, 21 Nov 2019, zhengbin (A) wrote:
>> On 2019/11/20 23:45, Matthew Wilcox wrote:
>>> On Wed, Nov 20, 2019 at 10:23:18PM +0800, zhengbin wrote:
>>>> I have tried to change last_ino type to unsigned long, while this was
>>>> rejected, see details on https://patchwork.kernel.org/patch/11023915.
>>> Did you end up trying sbitmap?
>> Maybe sbitmap is not a good solution, max_inodes of tmpfs are controlled by mount options--nrinodes,
>>
>> which can be modified by remountfs(bigger or smaller), as the comment of function sbitmap_resize says:
>>
>>  * Doesn't reallocate anything. It's up to the caller to ensure that the new
>>  * depth doesn't exceed the depth that the sb was initialized with.
>>
>> We can modify this to meet the growing requirements, there will still be questions as follows:
>>
>> 1. tmpfs is a ram filesystem, we need to allocate sbitmap memory for sbinfo->max_inodes(while this maybe huge)
>>
>> 2.If remountfs changes  max_inode, we have to deal with it, while this may take a long time
>>
>> (bigger: we need to free the old sbitmap memory, allocate new memory, copy the old sbitmap to new sbitmap
>>
>> smaller: How do we deal with it?ie: we use sb->map[inode number/8] to find the sbitmap, we need to change the exist
>>
>> inode numbers?while this maybe used by userspace application.)
>>
>>> What I think is fundamentally wrong with this patch is that you've found a
>>> problem in get_next_ino() and decided to use a different scheme for this
>>> one filesystem, leaving every other filesystem which uses get_next_ino()
>>> facing the same problem.
>>>
>>> That could be acceptable if you explained why tmpfs is fundamentally
>>> different from all the other filesystems that use get_next_ino(), but
>>> you haven't (and I don't think there is such a difference.  eg pipes,
>>> autofs and ipc mqueue could all have the same problem.
>> tmpfs is same with all the other filesystems that use get_next_ino(), but we need to solve this problem one by one.
>>
>> If tmpfs is ok, we can modify the other filesystems too. Besides, I do not  recommend all file systems share the same
>>
>> global variable, for performance impact consideration.
>>
>>> There are some other problems I noticed, but they're not worth bringing
>>> up until this fundamental design choice is justified.
>> Agree, thanks.
> Just a rushed FYI without looking at your patch or comments.
>
> Internally (in Google) we do rely on good tmpfs inode numbers more
> than on those of other get_next_ino() filesystems, and carry a patch
> to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
> number space for each superblock) - essentially,
>
> 	ino = sbinfo->next_ino++;
> 	/* Avoid 0 in the low 32 bits: might appear deleted */
> 	if (unlikely((unsigned int)ino == 0))
> 		ino = sbinfo->next_ino++;
>
> Which I think would be faster, and need less memory, than IDA.
> But whether that is of general interest, or of interest to you,
> depends upon how prevalent 32-bit executables built without
> __FILE_OFFSET_BITS=64 still are these days.

So how google think about this? inode number > 32-bit, but 32-bit executables

cat not handle this? "separate inode number space for each superblock" can reduce the

probability, but still can not solve it.

>
> Hugh

