Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF07BDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGaKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 06:02:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfGaKCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:02:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B326B11197D3251F626;
        Wed, 31 Jul 2019 18:02:43 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 18:02:40 +0800
Subject: Re: [PATCH v3 RESEND] f2fs: introduce sb.required_features to store
 incompatible features
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190729150351.12223-1-chao@kernel.org>
 <20190730231850.GA7097@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c7232d80-a4d8-88ae-2eca-01290dd0e56a@huawei.com>
Date:   Wed, 31 Jul 2019 18:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190730231850.GA7097@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/31 7:18, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Later after this patch was merged, all new incompatible feature's
>> bit should be added into sb.required_features field, and define new
>> feature function with F2FS_INCOMPAT_FEATURE_FUNCS() macro.
>>
>> Then during mount, we will do sanity check with enabled features in
>> image, if there are features in sb.required_features that kernel can
>> not recognize, just fail the mount.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3:
>> - change commit title.
>> - fix wrong macro name.
>>  fs/f2fs/f2fs.h          | 15 +++++++++++++++
>>  fs/f2fs/super.c         | 10 ++++++++++
>>  include/linux/f2fs_fs.h |  3 ++-
>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a6eb828af57f..b8e17d4ddb8d 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -163,6 +163,15 @@ struct f2fs_mount_info {
>>  #define F2FS_CLEAR_FEATURE(sbi, mask)					\
>>  	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
>>  
>> +#define F2FS_INCOMPAT_FEATURES		0
>> +
>> +#define F2FS_HAS_INCOMPAT_FEATURE(sbi, mask)				\
>> +	((sbi->raw_super->required_features & cpu_to_le32(mask)) != 0)
>> +#define F2FS_SET_INCOMPAT_FEATURE(sbi, mask)				\
>> +	(sbi->raw_super->required_features |= cpu_to_le32(mask))
>> +#define F2FS_CLEAR_INCOMPAT_FEATURE(sbi, mask)				\
>> +	(sbi->raw_super->required_features &= ~cpu_to_le32(mask))
>> +
>>  /*
>>   * Default values for user and/or group using reserved blocks
>>   */
>> @@ -3585,6 +3594,12 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>  F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>>  
>> +#define F2FS_INCOMPAT_FEATURE_FUNCS(name, flagname) \
>> +static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
>> +{ \
>> +	return F2FS_HAS_INCOMPAT_FEATURE(sbi, F2FS_FEATURE_##flagname); \
>> +}
>> +
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>>  				    block_t blkaddr)
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 5540fee0fe3f..3701dcce90e6 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2513,6 +2513,16 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>  		return -EINVAL;
>>  	}
>>  
>> +	/* check whether current kernel supports all features on image */
>> +	if (le32_to_cpu(raw_super->required_features) &
> 
> ...
> #define F2FS_FEATURE_VERITY	0x0400	/* reserved */
> ...
> #define F2FS_FEATURE_CASEFOLD	0x1000
> #define F2FS_FEATURE_SUPPORT	0x1BFF
> 
> 	if (le32_to_cpu(raw_super->required_features) & ~F2FS_FEATURE_SUPPORT) {
> 		...
> 		return -EINVAL;
> 	}

Um, I thought .required_features are used to store new feature flags from 0x0.

All 'F2FS_FEATURE_SUPPORT' bits should be stored in sb.feature instead of
sb.required_features, I'm confused...

Thanks,

> 
> 
>> +			~F2FS_INCOMPAT_FEATURES) {
>> +		f2fs_info(sbi, "Unsupported feature: %x: supported: %x",
>> +			  le32_to_cpu(raw_super->required_features) ^
>> +			  F2FS_INCOMPAT_FEATURES,
>> +			  F2FS_INCOMPAT_FEATURES);
>> +		return -EINVAL;
>> +	}
>> +
>>  	/* Check checksum_offset and crc in superblock */
>>  	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
>>  		crc_offset = le32_to_cpu(raw_super->checksum_offset);
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index a2b36b2e286f..4141be3f219c 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -117,7 +117,8 @@ struct f2fs_super_block {
>>  	__u8 hot_ext_count;		/* # of hot file extension */
>>  	__le16	s_encoding;		/* Filename charset encoding */
>>  	__le16	s_encoding_flags;	/* Filename charset encoding flags */
>> -	__u8 reserved[306];		/* valid reserved region */
>> +	__le32 required_features;       /* incompatible features to old kernel */
>> +	__u8 reserved[302];		/* valid reserved region */
>>  	__le32 crc;			/* checksum of superblock */
>>  } __packed;
>>  
>> -- 
>> 2.22.0
> .
> 
