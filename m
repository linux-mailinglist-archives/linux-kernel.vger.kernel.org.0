Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6418AAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 03:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCSChT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 22:37:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbgCSChT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:37:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 485D598D51686BB0ABD9;
        Thu, 19 Mar 2020 10:37:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 19 Mar
 2020 10:37:07 +0800
Subject: Re: [PATCH v2] f2fs: use kmem_cache pool during inline xattr lookups
To:     Ju Hyung Park <qkrwngud825@gmail.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
References: <20200225101710.40123-1-yuchao0@huawei.com>
 <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <08d03473-9871-ba10-4626-58c4479ef9d1@huawei.com>
Date:   Thu, 19 Mar 2020 10:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ju Hyung,

On 2020/3/18 20:14, Ju Hyung Park wrote:
> Hi Chao.
> 
> I got the time around to test this patch.
> The v2 patch seems to work just fine, and the code looks good.

Thanks a lot for the review and test.

> 
> On Tue, Feb 25, 2020 at 7:17 PM Chao Yu <yuchao0@huawei.com> wrote:
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index a3360a97e624..e46a10eb0e42 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -23,6 +23,25 @@
>>  #include "xattr.h"
>>  #include "segment.h"
>>
>> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
>> +{
>> +       *is_inline = (size == sbi->inline_xattr_slab_size);
> 
> Would it be meaningless to change this to the following code?
> if (likely(size == sbi->inline_xattr_slab_size))
>     *is_inline = true;
> else
>     *is_inline = false;

Yup, I guess it's very rare that user will change inline xattr size via remount,
so I'm okay with this change.

Jaegeuk,

Could you please help to update the patch in your git tree directly?

Thanks,

> 
> The above statement seems to be only false during the initial mount
> and the rest(millions) seems to be always true.
> 
> Thanks.
> .
> 
