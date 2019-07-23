Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73371241
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfGWHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:02:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGWHCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:02:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98D30E3EF60CA17B3872;
        Tue, 23 Jul 2019 15:01:38 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Jul
 2019 15:01:33 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity with enabled features
 in image
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190424094850.118323-1-yuchao0@huawei.com>
 <20190428133802.GB37346@jaegeuk-macbookpro.roam.corp.google.com>
 <373f4633-d331-5cf3-74b7-e982072bc4b4@kernel.org>
 <20190501032242.GA84420@jaegeuk-macbookpro.roam.corp.google.com>
 <3f170d86-e556-13ae-ce19-3bba3944f5fa@huawei.com>
 <192bae92-2193-570f-7b50-00334271bd2e@huawei.com>
 <a16a0c1c-16c6-5fe8-bfc4-7cc0e0866c77@huawei.com>
 <20190723013546.GA60778@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <00726135-f210-7791-a372-ef9cb1ae209f@huawei.com>
Date:   Tue, 23 Jul 2019 15:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723013546.GA60778@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/23 9:35, Jaegeuk Kim wrote:
> On 07/16, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2019/5/9 9:15, Chao Yu wrote:
>>> On 2019/5/5 10:51, Chao Yu wrote:
>>>> On 2019/5/1 11:22, Jaegeuk Kim wrote:
>>>>> On 04/29, Chao Yu wrote:
>>>>>> On 2019-4-28 21:38, Jaegeuk Kim wrote:
>>>>>>> On 04/24, Chao Yu wrote:
>>>>>>>> This patch fixes to do sanity with enabled features in image, if
>>>>>>>> there are features kernel can not recognize, just fail the mount.
>>>>>>>
>>>>>>> We need to figure out per-feature-based rejection, since some of them can
>>>>>>> be set without layout change.
>>
>> What about adding one field in superblock for compatible features in future?
>>
>> sb.feature(F2FS_FEATURE_LAST, max] stores uncompatible features
>> sb.compatible_feature stores compatible features
>>
>> If we follow above rule when adding one feature, then, we can fail the mount if
>> sb.feature(F2FS_FEATURE_LAST, max] is valid.
> 
> How about adding required_features flag in sb to check part of features only?

You mean all incompatible features can be add into sb.required_features later
like this?

__le32 required_features;	/* incompatible feature to old kernel */

And we can check required_features with supported features in current kernel?

if (le32_to_cpu(raw_super->required_features) &
	(~NOW_SUPPORTED_FEATURES_IN_CURRENT_KERNEL)) {
	print msg & ret error;
}

Thanks,

> 
>>
>> Thanks,
>>
>>>>>>
>>>>>> So any suggestion on how to implement this?
>>>>>
>>>>> Which features do we need to disallow? When we introduce new features, they
>>>>
>>>> I guess it should be the new features.
>>>>
>>>>> didn't hurt the previous flow by checking f2fs_sb_has_###().
>>>>
>>>> Yes, but new features may use new disk layout, if old kernel handled it with old
>>>> disk layout, there must be problematic.
>>>>
>>>> e.g. format image with -O extra_attr, and mount it with kernel who don't
>>>> recognize new inode layout.
>>>
>>> Jaegeuk,
>>>
>>> Any thoughts?
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Maybe:
>>>>>>
>>>>>> if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0))
>>>>>> 	check 4.14+ features
>>>>>> else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 9, 0))
>>>>>> 	check 4.9+ features
>>>>>> else if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 0))
>>>>>> 	check 4.4+ features
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>> ---
>>>>>>>>  fs/f2fs/f2fs.h  | 13 +++++++++++++
>>>>>>>>  fs/f2fs/super.c |  9 +++++++++
>>>>>>>>  2 files changed, 22 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>>> index f5ffc09705eb..15b640967e12 100644
>>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>>> @@ -151,6 +151,19 @@ struct f2fs_mount_info {
>>>>>>>>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>>>>>>>>  #define F2FS_FEATURE_SB_CHKSUM		0x0800
>>>>>>>>  
>>>>>>>> +#define F2FS_ALL_FEATURES	(F2FS_FEATURE_ENCRYPT |			\
>>>>>>>> +				F2FS_FEATURE_BLKZONED |			\
>>>>>>>> +				F2FS_FEATURE_ATOMIC_WRITE |		\
>>>>>>>> +				F2FS_FEATURE_EXTRA_ATTR |		\
>>>>>>>> +				F2FS_FEATURE_PRJQUOTA |			\
>>>>>>>> +				F2FS_FEATURE_INODE_CHKSUM |		\
>>>>>>>> +				F2FS_FEATURE_FLEXIBLE_INLINE_XATTR |	\
>>>>>>>> +				F2FS_FEATURE_QUOTA_INO |		\
>>>>>>>> +				F2FS_FEATURE_INODE_CRTIME |		\
>>>>>>>> +				F2FS_FEATURE_LOST_FOUND |		\
>>>>>>>> +				F2FS_FEATURE_VERITY |			\
>>>>>>>> +				F2FS_FEATURE_SB_CHKSUM)
>>>>>>>> +
>>>>>>>>  #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>>>>>>>>  	((raw_super->feature & cpu_to_le32(mask)) != 0)
>>>>>>>>  #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
>>>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>>>> index 4f8e9ab48b26..57f2fc6d14ba 100644
>>>>>>>> --- a/fs/f2fs/super.c
>>>>>>>> +++ b/fs/f2fs/super.c
>>>>>>>> @@ -2573,6 +2573,15 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>>>>>>  		return 1;
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>> +	/* check whether kernel supports all features */
>>>>>>>> +	if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
>>>>>>>> +		f2fs_msg(sb, KERN_INFO,
>>>>>>>> +			"Unsupported feature:%u: supported:%u",
>>>>>>>> +			le32_to_cpu(raw_super->feature),
>>>>>>>> +			F2FS_ALL_FEATURES);
>>>>>>>> +		return 1;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>>  	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
>>>>>>>>  	if (sanity_check_area_boundary(sbi, bh))
>>>>>>>>  		return 1;
>>>>>>>> -- 
>>>>>>>> 2.18.0.rc1
>>>>> .
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>> .
>>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>> .
>>>
> .
> 
