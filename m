Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC134191E92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 02:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYB0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 21:26:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbgCYB0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:26:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 29D1D445602345D482B4;
        Wed, 25 Mar 2020 09:26:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 25 Mar
 2020 09:26:06 +0800
Subject: Re: [PATCH] f2fs: remove redundant compress inode check
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200229104906.12061-1-yuchao0@huawei.com>
 <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
 <20200324154322.GB198420@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b0306fcf-27f2-20ab-9e5b-e54a924d4a61@huawei.com>
Date:   Wed, 25 Mar 2020 09:26:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200324154322.GB198420@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/24 23:43, Jaegeuk Kim wrote:
> On 03/24, Chao Yu wrote:
>> Jaegeuk,
>>
>> Missed to apply this patch?
>>
>> On 2020/2/29 18:49, Chao Yu wrote:
>>> due to f2fs_post_read_required() has did that.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/f2fs/f2fs.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index f4bcbbd5e9ed..882f9ad3445b 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>>>  		return true;
>>>  	if (f2fs_is_multi_device(sbi))
>>>  		return true;
>>> -	if (f2fs_compressed_file(inode))
>>> -		return true;
> 
> I thought that we can keep this to avoid any confusion when porting to old
> production kernel which uses ICE.

That old kernel w/ ICE doesn't have f2fs_post_read_required(), right?

I thought we backport features with order of the time fsverity/compression
feature was introduced, then f2fs_post_read_required() should be there
when we backport compression feature.

Thanks,

> 
>>>  	/*
>>>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>>>  	 * all IOs can be serialized by log-structured write.
>>>
> .
> 
