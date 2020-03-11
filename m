Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF48180CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 01:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgCKAlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 20:41:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbgCKAln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:41:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCDE26520FF5B53561BA;
        Wed, 11 Mar 2020 08:41:41 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 Mar
 2020 08:41:36 +0800
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: change default compression algorithm
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200310125009.12966-1-yuchao0@huawei.com>
 <20200310161515.GA1067@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4d8384b9-88fe-2a15-13ff-238d9fd4027a@huawei.com>
Date:   Wed, 11 Mar 2020 08:41:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200310161515.GA1067@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/11 0:15, Eric Biggers wrote:
> On Tue, Mar 10, 2020 at 08:50:05PM +0800, Chao Yu wrote:
>> Use LZ4 as default compression algorithm, as compared to LZO, it shows
>> almost the same compression ratio and much better decompression speed.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index db3a63f7c769..ebffe7aa08ee 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1577,7 +1577,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
>>  	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
>>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
>> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
>> +	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
>>  	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
>>  	F2FS_OPTION(sbi).compress_ext_cnt = 0;
>>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
> 
> This makes sense, but it's unclear to me why comparing the different compression
> algorithms is happening just now, after support for both LZO and LZ4 was already
> merged into mainline and now has to be supported forever.  During review months
> ago, multiple people suggested that LZ4 is better than LZO, so there's not much
> reason to support LZO at all.

Agreed,

Jaegeuk, thoughts?

Let me remove lzo if you have no objection on this.

Thanks,

> 
> - Eric
> .
> 
