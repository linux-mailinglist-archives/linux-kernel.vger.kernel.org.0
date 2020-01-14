Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FFD13B575
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 23:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 17:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgANWsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:48:39 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6746B24658;
        Tue, 14 Jan 2020 22:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579042118;
        bh=BTo+94oGmlvczeWFI8XW1gn0MmSS6cijy7Lt787VDxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wqhr/zvIyoptz3YKW4ycHTYco8ysZnxCeKZko3DdvqL4vQ67ayBHHvXgHUIax/As
         KiiQfd+YeZc/P2rFIN6hAERYdTuGSap4Iy7OB44xQSXGQYlrwVFFtGWwJD6zLLepJM
         5/URMDqqWf93k1OQb7FdhqTf3I471hlX2x/8Bh6Y=
Date:   Tue, 14 Jan 2020 14:48:37 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
Message-ID: <20200114224837.GB19274@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
 <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
 <3776cb0b-4b18-ae0d-16a7-a591bec77a5e@huawei.com>
 <20200111180200.GA36424@jaegeuk-macbookpro.roam.corp.google.com>
 <72418aa5-7d2a-de26-f0b5-9c839f0c3404@huawei.com>
 <20200113161120.GA49290@jaegeuk-macbookpro.roam.corp.google.com>
 <326f0049-936c-7dc4-52c3-aa64e13b2cc6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326f0049-936c-7dc4-52c3-aa64e13b2cc6@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14, Chao Yu wrote:
> On 2020/1/14 0:11, Jaegeuk Kim wrote:
> > On 01/13, Chao Yu wrote:
> >> On 2020/1/12 2:02, Jaegeuk Kim wrote:
> >>> On 01/11, Chao Yu wrote:
> >>>> On 2020/1/11 7:52, Jaegeuk Kim wrote:
> >>>>> On 01/06, Jaegeuk Kim wrote:
> >>>>>> On 01/06, Chao Yu wrote:
> >>>>>>> On 2020/1/3 14:50, Chao Yu wrote:
> >>>>>>>> This works to me. Could you run fsstress tests on compressed root directory?
> >>>>>>>> It seems still there are some bugs.
> >>>>>>>
> >>>>>>> Jaegeuk,
> >>>>>>>
> >>>>>>> Did you mean running por_fsstress testcase?
> >>>>>>>
> >>>>>>> Now, at least I didn't hit any problem for normal fsstress case.
> >>>>>>
> >>>>>> Yup. por_fsstress
> >>>>>
> >>>>> Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
> >>>>> I've fixed
> >>>>> - truncation offset
> >>>>> - i_compressed_blocks and its lock coverage
> >>>>> - error handling
> >>>>> - etc
> >>>>
> >>>> I changed as below, and por_fsstress stops panic the system.
> >>>>
> >>>> Could you merge all these fixes into original patch?
> >>>
> >>> Yup, let m roll up some early patches first once test results become good.
> >>
> >> I didn't encounter issue any more, how about por_fsstress test result in your
> >> enviornment? If there is, please share the call stack with me.
> > 
> > Sure, will do, once I hit an issue. BTW, I'm hitting another unreacheable nat
> > entry issue during por_stress without compression. :(
> 
> Did you enable any features during por_fsstress test?
> 
> I only hit below warning during por_fsstress test on image w/o compression.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 10 PID: 33483 at fs/fs-writeback.c:1448 __writeback_single_inode+0x28c/0x340
> Call Trace:
>  writeback_single_inode+0xad/0x120
>  sync_inode_metadata+0x3d/0x60
>  f2fs_sync_inode_meta+0x90/0xe0 [f2fs]
>  block_operations+0x17c/0x360 [f2fs]
>  f2fs_write_checkpoint+0x101/0xff0 [f2fs]
>  f2fs_sync_fs+0xa8/0x130 [f2fs]
>  f2fs_do_sync_file+0x19c/0x880 [f2fs]
>  do_fsync+0x38/0x60
>  __x64_sys_fsync+0x10/0x20
>  do_syscall_64+0x5f/0x220
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Does gc_mutex patch fix this?

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> >From bb17d7d77fe0b8a3e3632a7026550800ab9609e9 Mon Sep 17 00:00:00 2001
> >>>> From: Chao Yu <yuchao0@huawei.com>
> >>>> Date: Sat, 11 Jan 2020 16:58:20 +0800
> >>>> Subject: [PATCH] f2fs: compress: fix f2fs_put_rpages_mapping()
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/compress.c | 30 +++++++++++++++---------------
> >>>>  1 file changed, 15 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>>> index 502cd0ddc2a7..5c6a31d84ce4 100644
> >>>> --- a/fs/f2fs/compress.c
> >>>> +++ b/fs/f2fs/compress.c
> >>>> @@ -74,18 +74,10 @@ static void f2fs_put_compressed_page(struct page *page)
> >>>>  }
> >>>>
> >>>>  static void f2fs_drop_rpages(struct compress_ctx *cc,
> >>>> -		struct address_space *mapping, int len, bool unlock)
> >>>> +					int len, bool unlock)
> >>>>  {
> >>>>  	unsigned int i;
> >>>>  	for (i = 0; i < len; i++) {
> >>>> -		if (mapping) {
> >>>> -			pgoff_t start = start_idx_of_cluster(cc);
> >>>> -			struct page *page = find_get_page(mapping, start + i);
> >>>> -
> >>>> -			put_page(page);
> >>>> -			put_page(page);
> >>>> -			cc->rpages[i] = NULL;
> >>>> -		}
> >>>>  		if (!cc->rpages[i])
> >>>>  			continue;
> >>>>  		if (unlock)
> >>>> @@ -97,18 +89,25 @@ static void f2fs_drop_rpages(struct compress_ctx *cc,
> >>>>
> >>>>  static void f2fs_put_rpages(struct compress_ctx *cc)
> >>>>  {
> >>>> -	f2fs_drop_rpages(cc, NULL, cc->cluster_size, false);
> >>>> +	f2fs_drop_rpages(cc, cc->cluster_size, false);
> >>>>  }
> >>>>
> >>>>  static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
> >>>>  {
> >>>> -	f2fs_drop_rpages(cc, NULL, len, true);
> >>>> +	f2fs_drop_rpages(cc, len, true);
> >>>>  }
> >>>>
> >>>>  static void f2fs_put_rpages_mapping(struct compress_ctx *cc,
> >>>> -				struct address_space *mapping, int len)
> >>>> +				struct address_space *mapping,
> >>>> +				pgoff_t start, int len)
> >>>>  {
> >>>> -	f2fs_drop_rpages(cc, mapping, len, false);
> >>>> +	int i;
> >>>> +	for (i = 0; i < len; i++) {
> >>>> +		struct page *page = find_get_page(mapping, start + i);
> >>>> +
> >>>> +		put_page(page);
> >>>> +		put_page(page);
> >>>> +	}
> >>>>  }
> >>>>
> >>>>  static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
> >>>> @@ -680,7 +679,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
> >>>>
> >>>>  		if (!PageUptodate(page)) {
> >>>>  			f2fs_unlock_rpages(cc, i + 1);
> >>>> -			f2fs_put_rpages_mapping(cc, mapping, cc->cluster_size);
> >>>> +			f2fs_put_rpages_mapping(cc, mapping, start_idx,
> >>>> +					cc->cluster_size);
> >>>>  			f2fs_destroy_compress_ctx(cc);
> >>>>  			goto retry;
> >>>>  		}
> >>>> @@ -714,7 +714,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
> >>>>  unlock_pages:
> >>>>  	f2fs_unlock_rpages(cc, i);
> >>>>  release_pages:
> >>>> -	f2fs_put_rpages_mapping(cc, mapping, i);
> >>>> +	f2fs_put_rpages_mapping(cc, mapping, start_idx, i);
> >>>>  	f2fs_destroy_compress_ctx(cc);
> >>>>  	return ret;
> >>>>  }
> >>>> -- 
> >>>> 2.18.0.rc1
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> One another fix in f2fs-tools as well.
> >>>>> https://github.com/jaegeuk/f2fs-tools
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> > 
