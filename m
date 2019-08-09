Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9975087DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407407AbfHIP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHIP0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:26:44 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0C720B7C;
        Fri,  9 Aug 2019 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565364403;
        bh=vOaWmQOdEkHrjuID4rcqTdiWg2RvixgqY9+LyZX6vRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+Kdg+PbzXk7bijKexoiY6UXntP319d8zalLVCpWz8sZB0BS4L04ravlj9OXUJGfl
         Y4FSkfnR1BRebi8jICQNudgcKcuyB9dwZ6snrmkxt6ar/fE8et4NMlaAxtpMOdLSmv
         TmoVEYHHzodTz6vHAtqoOJ0kSNssa2AFanWZWTwQ=
Date:   Fri, 9 Aug 2019 08:26:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] f2fs: introduce sb.required_features to store
 incompatible features
Message-ID: <20190809152642.GC93481@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190801042215.GC84433@jaegeuk-macbookpro.roam.corp.google.com>
 <345c55ea-01c2-a9d1-4367-716dbd08ae9d@huawei.com>
 <20190801223509.GB27597@jaegeuk-macbookpro.roam.corp.google.com>
 <8e906ddb-81d8-b63e-0c19-1ee9fc7f5cbf@huawei.com>
 <20190806003522.GA98101@jaegeuk-macbookpro.roam.corp.google.com>
 <e48514d5-0f3f-8dd7-06ab-b7faf71101ba@huawei.com>
 <20190806012407.GB1029@jaegeuk-macbookpro.roam.corp.google.com>
 <103d1df0-eb5b-4854-0959-a84785eb85a8@huawei.com>
 <20190806021144.GB7280@jaegeuk-macbookpro.roam.corp.google.com>
 <a155121f-2e1b-c3c5-17bb-b5ac3f4a7b1f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a155121f-2e1b-c3c5-17bb-b5ac3f4a7b1f@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Chao Yu wrote:
> On 2019/8/6 10:11, Jaegeuk Kim wrote:
> > On 08/06, Chao Yu wrote:
> >> On 2019/8/6 9:24, Jaegeuk Kim wrote:
> >>> On 08/06, Chao Yu wrote:
> >>>> On 2019/8/6 8:35, Jaegeuk Kim wrote:
> >>>>> On 08/02, Chao Yu wrote:
> >>>>>> On 2019/8/2 6:35, Jaegeuk Kim wrote:
> >>>>>>> On 08/01, Chao Yu wrote:
> >>>>>>>> On 2019/8/1 12:22, Jaegeuk Kim wrote:
> >>>>>>>>> On 07/31, Chao Yu wrote:
> >>>>>>>>>> On 2019/7/31 7:18, Jaegeuk Kim wrote:
> >>>>>>>>>>> On 07/29, Chao Yu wrote:
> >>>>>>>>>>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Later after this patch was merged, all new incompatible feature's
> >>>>>>>>>>>> bit should be added into sb.required_features field, and define new
> >>>>>>>>>>>> feature function with F2FS_INCOMPAT_FEATURE_FUNCS() macro.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Then during mount, we will do sanity check with enabled features in
> >>>>>>>>>>>> image, if there are features in sb.required_features that kernel can
> >>>>>>>>>>>> not recognize, just fail the mount.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>> v3:
> >>>>>>>>>>>> - change commit title.
> >>>>>>>>>>>> - fix wrong macro name.
> >>>>>>>>>>>>  fs/f2fs/f2fs.h          | 15 +++++++++++++++
> >>>>>>>>>>>>  fs/f2fs/super.c         | 10 ++++++++++
> >>>>>>>>>>>>  include/linux/f2fs_fs.h |  3 ++-
> >>>>>>>>>>>>  3 files changed, 27 insertions(+), 1 deletion(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>>>>>>>>> index a6eb828af57f..b8e17d4ddb8d 100644
> >>>>>>>>>>>> --- a/fs/f2fs/f2fs.h
> >>>>>>>>>>>> +++ b/fs/f2fs/f2fs.h
> >>>>>>>>>>>> @@ -163,6 +163,15 @@ struct f2fs_mount_info {
> >>>>>>>>>>>>  #define F2FS_CLEAR_FEATURE(sbi, mask)					\
> >>>>>>>>>>>>  	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
> >>>>>>>>>>>>  
> >>>>>>>>>>>> +#define F2FS_INCOMPAT_FEATURES		0
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +#define F2FS_HAS_INCOMPAT_FEATURE(sbi, mask)				\
> >>>>>>>>>>>> +	((sbi->raw_super->required_features & cpu_to_le32(mask)) != 0)
> >>>>>>>>>>>> +#define F2FS_SET_INCOMPAT_FEATURE(sbi, mask)				\
> >>>>>>>>>>>> +	(sbi->raw_super->required_features |= cpu_to_le32(mask))
> >>>>>>>>>>>> +#define F2FS_CLEAR_INCOMPAT_FEATURE(sbi, mask)				\
> >>>>>>>>>>>> +	(sbi->raw_super->required_features &= ~cpu_to_le32(mask))
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  /*
> >>>>>>>>>>>>   * Default values for user and/or group using reserved blocks
> >>>>>>>>>>>>   */
> >>>>>>>>>>>> @@ -3585,6 +3594,12 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
> >>>>>>>>>>>>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
> >>>>>>>>>>>>  F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
> >>>>>>>>>>>>  
> >>>>>>>>>>>> +#define F2FS_INCOMPAT_FEATURE_FUNCS(name, flagname) \
> >>>>>>>>>>>> +static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
> >>>>>>>>>>>> +{ \
> >>>>>>>>>>>> +	return F2FS_HAS_INCOMPAT_FEATURE(sbi, F2FS_FEATURE_##flagname); \
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  #ifdef CONFIG_BLK_DEV_ZONED
> >>>>>>>>>>>>  static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> >>>>>>>>>>>>  				    block_t blkaddr)
> >>>>>>>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>>>>>>>>>> index 5540fee0fe3f..3701dcce90e6 100644
> >>>>>>>>>>>> --- a/fs/f2fs/super.c
> >>>>>>>>>>>> +++ b/fs/f2fs/super.c
> >>>>>>>>>>>> @@ -2513,6 +2513,16 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>  		return -EINVAL;
> >>>>>>>>>>>>  	}
> >>>>>>>>>>>>  
> >>>>>>>>>>>> +	/* check whether current kernel supports all features on image */
> >>>>>>>>>>>> +	if (le32_to_cpu(raw_super->required_features) &
> >>>>>>>>>>>
> >>>>>>>>>>> ...
> >>>>>>>>>>> #define F2FS_FEATURE_VERITY	0x0400	/* reserved */
> >>>>>>>>>>> ...
> >>>>>>>>>>> #define F2FS_FEATURE_CASEFOLD	0x1000
> >>>>>>>>>>> #define F2FS_FEATURE_SUPPORT	0x1BFF
> >>>>>>>>>>>
> >>>>>>>>>>> 	if (le32_to_cpu(raw_super->required_features) & ~F2FS_FEATURE_SUPPORT) {
> >>>>>>>>>>> 		...
> >>>>>>>>>>> 		return -EINVAL;
> >>>>>>>>>>> 	}
> >>>>>>>>>>
> >>>>>>>>>> Um, I thought .required_features are used to store new feature flags from 0x0.
> >>>>>>>>>>
> >>>>>>>>>> All 'F2FS_FEATURE_SUPPORT' bits should be stored in sb.feature instead of
> >>>>>>>>>> sb.required_features, I'm confused...
> >>>>>>>>>
> >>>>>>>>> I'm thinking,
> >>>>>>>>>
> >>>>>>>>> f2fs-tools     sb->required_features     f2fs    F2FS_FEATURE_SUPPORT
> >>>>>>>>> v0             0                         v0      no_check -> ok
> >>>>>>>>> v1             0x1BFF                    v0      no_check -> ok
> >>>>>>>>> v0             0                         v1      0x1BFF -> ok
> >>>>>>>>> v1             0x1BFF                    v1      0x1BFF -> ok
> >>>>>>>>> v2             0x3BFF                    v1      0x1BFF -> fail
> >>>>>>>>> v1             0x1BFF                    v2      0x3BFF -> ok
> >>>>>>>>> v2             0x3BFF                    v2      0x3BFF -> ok
> >>>>>>>>
> >>>>>>>> I see, it's a bit waste for 0x1FFF low bits in sb->required_features. Why not
> >>>>>>>> leaving 0x0FFF in sb->feature w/o sanity check. And make all new incompatible
> >>>>>>>> features (including casefold) adding into sb->required_features.
> >>>>>>>
> >>>>>>> I don't think we can define like this, and we still have 32bits feature filed.
> >>>>>>> This would give another confusion to understand. VERITY is reserved only now.
> >>>>>>>
> >>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
> >>>>>>
> >>>>>> Oops, so you want to make .required_features being almost a mirror of .feature,
> >>>>>> and do sanity check on it... I can see now. :P
> >>>>>>
> >>>>>> If so, why not just use .feature:
> >>>>>
> >>>>> Sometimes, we don't need to set the flag, but not required at some point.
> >>>>> (e.g., verify)
> >>>>
> >>>> Sorry, I'm not sure whether I have understood your point... :(
> >>>>
> >>>> IIUC of your point, we have defined F2FS_FEATURE_SUPPORT (0x0BFF) which excludes
> >>>> F2FS_FEATURE_VERITY (0x0400) feature bit, then once verity feature merged in
> >>>> kernel, we can add it into F2FS_FEATURE_SUPPORT, any problem we may face here?
> >>>
> >>> I was thinking the cases like "don't care features" made by mkfs. For example,
> >>> mkfs can set F2FS_FEATURE_BLKZONED, which doesn't need f2fs being supported.
> >>
> >> Yes, I can understand this.
> >>
> >> So F2FS_FEATURE_SUPPORT can exclude them directly?
> > 
> > No, I'd like to control it via mkfs. Kernel always needs to say what they can
> > support, IIUC your point.
> 
> Oh, it's different macros, we will define F2FS_INCOMPAT_FEATURE_SUPPORT 0x19B9,
> and F2FS_ALL_FEATURE_SUPPORT (0x0001 | 0x0002 ... ).
> 
> In sanity check function, we only check .feature with
> F2FS_INCOMPAT_FEATURE_SUPPORT. And of course, meanwhile kernel will say it
> supports features in F2FS_ALL_FEATURE_SUPPORT.

Still I don't get the point where we need multiple macros. Why not user just can
give required_feature in mkfs and check it by kernel later?

> 
> Thanks,
> 
> > 
> >>
> >> excluded:
> >>
> >> #define F2FS_FEATURE_BLKZONED		0x0002
> >> #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
> >> #define F2FS_FEATURE_LOST_FOUND		0x0200
> >>
> >> included:
> >>
> >> #define F2FS_FEATURE_ENCRYPT		0x0001
> >> #define F2FS_FEATURE_EXTRA_ATTR		0x0008
> >> #define F2FS_FEATURE_PRJQUOTA		0x0010
> >> #define F2FS_FEATURE_INODE_CHKSUM	0x0020
> >> #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
> >> #define F2FS_FEATURE_QUOTA_INO		0x0080
> >> #define F2FS_FEATURE_INODE_CRTIME	0x0100
> >> #define F2FS_FEATURE_SB_CHKSUM		0x0800
> >> //#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
> >> #define F2FS_FEATURE_CASEFOLD		0x1000
> >>
> >> #define F2FS_FEATURE_SUPPORT		0x19B9
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks
> >>>>
> >>>>>
> >>>>>>
> >>>>>> kernel	tool
> >>>>>> v5.2 .. 1.12
> >>>>>> #define	F2FS_FEATURE_SUPPORT		0x0BFF
> >>>>>>
> >>>>>> v5.3 .. 1.13
> >>>>>> #define F2FS_FEATURE_CASEFOLD		0x1000
> >>>>>> #define	F2FS_FEATURE_SUPPORT		0x1BFF
> >>>>>>
> >>>>>> v5.4 .. 1.14
> >>>>>> #define F2FS_FEATURE_CASEFOLD		0x1000
> >>>>>> #define F2FS_FEATURE_COMPRESS		0x2000
> >>>>>> #define	F2FS_FEATURE_SUPPORT		0x3BFF
> >>>>>>
> >>>>>> f2fs-tools	sb->feature		f2fs	F2FS_FEATURE_SUPPORT
> >>>>>>
> >>>>>> [enable all features in tools]
> >>>>>> v1.12		0x0BFF			v5.2	no_check -> ok
> >>>>>> v1.12		0x0BFF			v5.3	0x1BFF -> ok
> >>>>>> v1.12		0x0BFF			v5.4	0x3BFF -> ok
> >>>>>>
> >>>>>> v1.13		0x1BFF			v5.2	that's issue we need to fix
> >>>>>> v1.13		0x1BFF			v5.3	0x1BFF -> ok
> >>>>>> v1.13		0x1BFF			v5.4	0x3BFF -> ok
> >>>>>>
> >>>>>> v1.14		0x3BFF			v5.2	that's issue we need to fix
> >>>>>> v1.14		0x3BFF			v5.3	0x1BFF -> fail
> >>>>>> v1.14		0x3BFF			v5.4	0x3BFF -> ok
> >>>>>>
> >>>>>> Or am I missing something?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Then that would be:
> >>>>>>>>
> >>>>>>>> kernel	tool
> >>>>>>>> v5.2 .. 1.12
> >>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0000
> >>>>>>>>
> >>>>>>>> v5.3 .. 1.13
> >>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
> >>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0001
> >>>>>>>>
> >>>>>>>> v5.4 .. 1.14
> >>>>>>>> #define F2FS_FEATURE_CASEFOLD		0x0001
> >>>>>>>> #define F2FS_FEATURE_COMPRESS		0x0002
> >>>>>>>> #define	F2FS_FEATURE_SUPPORT		0x0003
> >>>>>>>>
> >>>>>>>> f2fs-tools	sb->required_features	f2fs	F2FS_FEATURE_SUPPORT
> >>>>>>>>
> >>>>>>>> v1.12		0x0000			v5.2	no_check -> ok
> >>>>>>>> v1.12		0x0000			v5.3	0x0001 -> ok
> >>>>>>>> v1.12		0x0000			v5.4	0x0003 -> ok
> >>>>>>>>
> >>>>>>>> v1.13		0x0001			v5.2	that's issue we need to fix
> >>>>>>>> v1.13		0x0001			v5.3	0x0001 -> ok
> >>>>>>>> v1.13		0x0001			v5.4	0x0003 -> ok
> >>>>>>>>
> >>>>>>>> v1.14		0x0003			v5.2	that's issue we need to fix
> >>>>>>>> v1.14		0x0003			v5.3	0x0001 -> fail
> >>>>>>>> v1.14		0x0003			v5.4	0x0003 -> ok
> >>>>>>>>
> >>>>>>>> And all compatible features can be added into sb->feature[_VERITY, ....].
> >>>>>>>>
> >>>>>>>> Would that okay to you?
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> +			~F2FS_INCOMPAT_FEATURES) {
> >>>>>>>>>>>> +		f2fs_info(sbi, "Unsupported feature: %x: supported: %x",
> >>>>>>>>>>>> +			  le32_to_cpu(raw_super->required_features) ^
> >>>>>>>>>>>> +			  F2FS_INCOMPAT_FEATURES,
> >>>>>>>>>>>> +			  F2FS_INCOMPAT_FEATURES);
> >>>>>>>>>>>> +		return -EINVAL;
> >>>>>>>>>>>> +	}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  	/* Check checksum_offset and crc in superblock */
> >>>>>>>>>>>>  	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
> >>>>>>>>>>>>  		crc_offset = le32_to_cpu(raw_super->checksum_offset);
> >>>>>>>>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >>>>>>>>>>>> index a2b36b2e286f..4141be3f219c 100644
> >>>>>>>>>>>> --- a/include/linux/f2fs_fs.h
> >>>>>>>>>>>> +++ b/include/linux/f2fs_fs.h
> >>>>>>>>>>>> @@ -117,7 +117,8 @@ struct f2fs_super_block {
> >>>>>>>>>>>>  	__u8 hot_ext_count;		/* # of hot file extension */
> >>>>>>>>>>>>  	__le16	s_encoding;		/* Filename charset encoding */
> >>>>>>>>>>>>  	__le16	s_encoding_flags;	/* Filename charset encoding flags */
> >>>>>>>>>>>> -	__u8 reserved[306];		/* valid reserved region */
> >>>>>>>>>>>> +	__le32 required_features;       /* incompatible features to old kernel */
> >>>>>>>>>>>> +	__u8 reserved[302];		/* valid reserved region */
> >>>>>>>>>>>>  	__le32 crc;			/* checksum of superblock */
> >>>>>>>>>>>>  } __packed;
> >>>>>>>>>>>>  
> >>>>>>>>>>>> -- 
> >>>>>>>>>>>> 2.22.0
> >>>>>>>>>>> .
> >>>>>>>>>>>
> >>>>>>>>> .
> >>>>>>>>>
> >>>>>>> .
> >>>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> > 
