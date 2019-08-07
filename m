Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58284396
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 07:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfHGFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 01:14:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfHGFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:14:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 515EB608D4; Wed,  7 Aug 2019 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565154896;
        bh=ez0bTbpDpuPBtcQ5H6/eqA/uGGQnkjV/1RrxwhZfFo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXXq4lmsF7O/FwTxcmMHNJxH43prALliIw6cL/MK51hvyl+VV8CyAfy68Hrm7Qj3Z
         4+rZcTYle0yhjpxwEvYtK341bTpmWh94pQxSYJ36iZq/ZE9j7Nt4qKDuBnCd2/6qkX
         TiLr6PODS1h8MtfIcGKQ8JnK8F5P+e5R/AMv6Fww=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B7E5608A5;
        Wed,  7 Aug 2019 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565154895;
        bh=ez0bTbpDpuPBtcQ5H6/eqA/uGGQnkjV/1RrxwhZfFo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sc5HEDwazQJF8wb/4wdkZZ7unmy8cLMMEWYTUNAjAayk8XuG2kLGGWvsBFA+jBcAV
         a3yqEbpqfT87LqqdiwwRRGGGK1vTYQENeGdKMaNkXyU61U0Ptef6S6EaSuLffXMHxn
         9l1Yzjd295fp9CnexEQ8iuZT6OH1taspEKt1FJzQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B7E5608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 7 Aug 2019 10:44:50 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v2] f2fs: Fix indefinite loop in f2fs_gc()
Message-ID: <20190807051449.GJ8289@codeaurora.org>
References: <1565090396-7263-1-git-send-email-stummala@codeaurora.org>
 <8766875c-1e35-22dc-48d2-45b6776e4f38@huawei.com>
 <20190807032458.GI8289@codeaurora.org>
 <28512520-d8fe-839f-67ab-45f89f12968d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28512520-d8fe-839f-67ab-45f89f12968d@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:37:22AM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/8/7 11:24, Sahitya Tummala wrote:
> > Hi Chao,
> > 
> > On Wed, Aug 07, 2019 at 10:04:16AM +0800, Chao Yu wrote:
> >> Hi Sahitya,
> >>
> >> On 2019/8/6 19:19, Sahitya Tummala wrote:
> >>> Policy - Foreground GC, LFS and greedy GC mode.
> >>>
> >>> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
> >>> enough free segements to proceed and thus it keeps calling gc_more
> >>> for the same victim segment.  This can happen if the selected victim
> >>> segment could not be GC'd due to failed blkaddr validity check i.e.
> >>> is_alive() returns false for the blocks set in current validity map.
> >>>
> >>> Fix this by keeping track of such invalid segments and skip those
> >>> segments for selection in get_victim_by_default() to avoid endless
> >>> GC loop under such error scenarios.
> >>>
> >>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>> ---
> >>> v2: fix as per Chao's suggestion to handle this error case
> >>>
> >>>  fs/f2fs/gc.c      | 15 ++++++++++++++-
> >>>  fs/f2fs/segment.c |  5 +++++
> >>>  fs/f2fs/segment.h |  3 +++
> >>>  3 files changed, 22 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index 8974672..321a78a 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -382,6 +382,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >>>  			nsearched++;
> >>>  		}
> >>>  
> >>> +		/*
> >>> +		 * skip selecting the invalid segno (that is failed due to block
> >>> +		 * validity check failed during GC) to avoid endless GC loop in
> >>> +		 * such cases.
> >>> +		 */
> >>> +		if (test_bit(segno, sm->invalid_segmap))
> >>> +			goto next;
> >>> +
> >>>  		secno = GET_SEC_FROM_SEG(sbi, segno);
> >>>  
> >>>  		if (sec_usage_check(sbi, secno))
> >>> @@ -975,6 +983,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>  	int off;
> >>>  	int phase = 0;
> >>>  	int submitted = 0;
> >>> +	struct sit_info *sit_i = SIT_I(sbi);
> >>>  
> >>>  	start_addr = START_BLOCK(sbi, segno);
> >>>  
> >>> @@ -1008,8 +1017,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>  		}
> >>>  
> >>>  		/* Get an inode by ino with checking validity */
> >>> -		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
> >>> +		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs)) {
> >>> +			if (!test_and_set_bit(segno, sit_i->invalid_segmap))
> >>> +				f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
> >>> +						start_addr + off, segno);
> >>
> >> Oh, there is some normal cases in is_alive(), such as f2fs_get_node_page() or
> >> f2fs_get_node_info() failure due to no memory, we should bypass such cases. I
> > 
> > Oh, yes, I have missed this point.
> > 
> >> guess something like this:
> >>
> >> if (source_blkaddr != blkaddr) {
> >> 	if (unlikely(check_valid_map(sbi, segno, off))) {
> > 
> > check_valid_map() is validated before is_alive(). So I think this check again
> > may not be needed. What do you think?
> 
> > race in between is_alive() and update_sit_entry()
> 
> There will be a race case:
> 
> gc_data_segment			f2fs_truncate_data_blocks_range
> check_valid_map
> 				f2fs_invalidate_blocks
> 				update_sit_entry
> 				f2fs_test_and_clear_bit(, se->cur_valid_map);
> 				unlock_page(node_page)
> is_alive
> lock_page(node_page)
> blkaddr should be NULL and not equal to source_blkaddr, I think this is a normal
> case, right?
> 

Got it, thanks for the clarification.

> Thanks,
> 
> > 
> >> 		if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
> >> 			f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
> >> 				start_addr + off, segno);
> >> 			set_sbi_flag(sbi, SBI_NEED_FSCK);
> >> 		}
> >> 	}
> >> 	return false;
> >> }
> >>
> >> I think this will be safe to call check_valid_map(), because there should be no
> >> race in between is_alive() and update_sit_entry() from all paths due to node
> >> page lock dependence.
> >>
> >> One more concern is should we use this under CONFIG_F2FS_CHECK_FS? If there is
> >> actually such a bug can cause data inconsistency, we'd better find the root
> >> cause in debug version.
> >>
> > 
> > Yes, I agree with you. I will include this under CONFIG_F2FS_CHECK_FS.
> > 
> > Thanks,
> > 
> >> Thanks,
> >>
> >>>  			continue;
> >>> +		}
> >>>  
> >>>  		if (phase == 2) {
> >>>  			f2fs_ra_node_page(sbi, dni.ino);
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index a661ac3..d45a1d3 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -4017,6 +4017,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
> >>>  		return -ENOMEM;
> >>>  #endif
> >>>  
> >>> +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> >>> +	if (!sit_i->invalid_segmap)
> >>> +		return -ENOMEM;
> >>> +
> >>>  	/* init SIT information */
> >>>  	sit_i->s_ops = &default_salloc_ops;
> >>>  
> >>> @@ -4518,6 +4522,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
> >>>  #ifdef CONFIG_F2FS_CHECK_FS
> >>>  	kvfree(sit_i->sit_bitmap_mir);
> >>>  #endif
> >>> +	kvfree(sit_i->invalid_segmap);
> >>>  	kvfree(sit_i);
> >>>  }
> >>>  
> >>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >>> index b746028..bc5dbe8 100644
> >>> --- a/fs/f2fs/segment.h
> >>> +++ b/fs/f2fs/segment.h
> >>> @@ -246,6 +246,9 @@ struct sit_info {
> >>>  	unsigned long long min_mtime;		/* min. modification time */
> >>>  	unsigned long long max_mtime;		/* max. modification time */
> >>>  
> >>> +	/* list of segments to be ignored by GC in case of errors */
> >>> +	unsigned long *invalid_segmap;
> >>> +
> >>>  	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
> >>>  };
> >>>  
> >>>
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
