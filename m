Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB48292A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfHFB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 21:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfHFB2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:28:40 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC592147A;
        Tue,  6 Aug 2019 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565054919;
        bh=KnLY1sAJ7ObFvAXL3EPBllmg22XMnePEwMFus9ls9Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0zWqr68TcP+9F8cFVvHxfxnP2RZnRTkMHBKP/fAw2rF14+rdMrRy3hBa8l1iq5lkX
         JvUoidCCMZemeRklpULqGSnW3yoR7gWkN5fqYyWGb5VMuH4B9D9QLFPJDjO3BQ+jRw
         lzVQ67jhsbsFGxg3vtHFUmQ9mYGw0R9Lien6XcoU=
Date:   Mon, 5 Aug 2019 18:28:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: avoid out-of-range memory access"
Message-ID: <20190806012839.GD1029@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190802101548.96543-1-yuchao0@huawei.com>
 <20190806004215.GC98101@jaegeuk-macbookpro.roam.corp.google.com>
 <dd284020-77b0-1627-2fc2-bc51745adfd3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd284020-77b0-1627-2fc2-bc51745adfd3@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Chao Yu wrote:
> On 2019/8/6 8:42, Jaegeuk Kim wrote:
> > On 08/02, Chao Yu wrote:
> >> As Pavel Machek reported:
> >>
> >> "We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
> >> good idea to report it to the syslog and mark filesystem as "needing
> >> fsck" if filesystem can do that."
> >>
> >> Still we need improve the original patch with:
> >> - use unlikely keyword
> >> - add message print
> >> - return EUCLEAN
> >>
> >> However, after rethink this patch, I don't think we should add such
> >> condition check here as below reasons:
> >> - We have already checked the field in f2fs_sanity_check_ckpt(),
> >> - If there is fs corrupt or security vulnerability, there is nothing
> >> to guarantee the field is integrated after the check, unless we do
> >> the check before each of its use, however no filesystem does that.
> >> - We only have similar check for bitmap, which was added due to there
> >> is bitmap corruption happened on f2fs' runtime in product.
> >> - There are so many key fields in SB/CP/NAT did have such check
> >> after f2fs_sanity_check_{sb,cp,..}.
> >>
> >> So I propose to revert this unneeded check.
> > 
> > IIRC, this came from security vulnerability report which can access
> 
> I don't think that's correct report, since we have checked validation of that
> field during mount, if it can be ruined after that, any variables can't be trusted.

I assumed this was reproduced with a fuzzed image.
I'll check it with Ocean.

> 
> Now we just check bitmaps at real-time, because we have encountered such bitmap
> corruption in product.
> 
> Thanks,
> 
> > out-of-boundary memory region. Could you write another patch to address the
> > above issues?
> > 
> >>
> >> This reverts commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/segment.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 9693fa4c8971..2eff9c008ae0 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -3492,11 +3492,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>  		seg_i = CURSEG_I(sbi, i);
> >>  		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
> >>  		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
> >> -		if (blk_off > ENTRIES_IN_SUM) {
> >> -			f2fs_bug_on(sbi, 1);
> >> -			f2fs_put_page(page, 1);
> >> -			return -EFAULT;
> >> -		}
> >>  		seg_i->next_segno = segno;
> >>  		reset_curseg(sbi, i, 0);
> >>  		seg_i->alloc_type = ckpt->alloc_type[i];
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
