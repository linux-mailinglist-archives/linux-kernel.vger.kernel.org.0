Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13C193BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgCZJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:35:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbgCZJfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:35:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7644EDB1CEFD789CD5B1;
        Thu, 26 Mar 2020 17:35:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 26 Mar
 2020 17:35:04 +0800
Subject: Re: [PATCH RFC] f2fs: don't inline compressed inode
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200325092754.63411-1-yuchao0@huawei.com>
 <20200325155806.GC65658@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <87d715d0-a5c4-7b54-95bb-9b627d163271@huawei.com>
Date:   Thu, 26 Mar 2020 17:35:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200325155806.GC65658@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/25 23:58, Jaegeuk Kim wrote:
> On 03/25, Chao Yu wrote:
>> f2fs_may_inline_data() only check compressed flag on current inode
>> rather than on parent inode, however at this time compressed flag
>> has not been inherited yet.
> 
> When write() or other allocation happens, it'll be reset.

Yeah, all tests are fine w/o this RFC patch, anyway, will let you know if
I find something incompatible.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>
>> Jaegeuk,
>>
>> I'm not sure about this, whether inline_data flag can be compatible with
>> compress flag, thoughts?
>>
>>  fs/f2fs/namei.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index f54119da2217..3807d1b4c4bc 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -86,7 +86,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>>  	if (test_opt(sbi, INLINE_XATTR))
>>  		set_inode_flag(inode, FI_INLINE_XATTR);
>>  
>> -	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>> +	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode) &&
>> +					!f2fs_compressed_file(dir))
>>  		set_inode_flag(inode, FI_INLINE_DATA);
>>  	if (f2fs_may_inline_dentry(inode))
>>  		set_inode_flag(inode, FI_INLINE_DENTRY);
>> -- 
>> 2.18.0.rc1
> .
> 
