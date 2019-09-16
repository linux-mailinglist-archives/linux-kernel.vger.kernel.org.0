Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE63B3DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfIPPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 11:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfIPPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:37:38 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8477621848;
        Mon, 16 Sep 2019 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568648257;
        bh=XXj6PzzdwbJempAZT8mwyx4CYSvHfLZU4rGUcOLrmg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqtJ9JNOUsezx8vpaHP7Lx5WlpApry44nZeOLJlg05z0A/RcqEi/L+dvkedGzKZyR
         I3IKnptiqHGvtHW+2heApzs2rczQD2Cc/DcwCAW/XAnwK62ryYFsDV7ZLWBYSeF9aq
         R6j2M4J63vpAmQFs7IuYozNqrm2QCPWzI5+ZBw78=
Date:   Mon, 16 Sep 2019 08:37:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: do not select same victim right
 again
Message-ID: <20190916153736.GA2493@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <69933b7f-48cc-47f9-ba6f-b5ca8f733cba@huawei.com>
 <20190909080654.GD21625@jaegeuk-macbookpro.roam.corp.google.com>
 <97237da2-897a-8420-94de-812e94aa751f@huawei.com>
 <20190909120443.GA31108@jaegeuk-macbookpro.roam.corp.google.com>
 <27725e65-53fe-5731-0201-9959b8ef6b49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27725e65-53fe-5731-0201-9959b8ef6b49@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16, Chao Yu wrote:
> On 2019/9/9 20:04, Jaegeuk Kim wrote:
> > On 09/09, Chao Yu wrote:
> >> On 2019/9/9 16:06, Jaegeuk Kim wrote:
> >>> On 09/09, Chao Yu wrote:
> >>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> >>>>> GC must avoid select the same victim again.
> >>>>
> >>>> Blocks in previous victim will occupy addition free segment, I doubt after this
> >>>> change, FGGC may encounter out-of-free space issue more frequently.
> >>>
> >>> Hmm, actually this change seems wrong by sec_usage_check().
> >>> We may be able to avoid this only in the suspicious loop?
> >>>
> >>> ---
> >>>  fs/f2fs/gc.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index e88f98ddf396..5877bd729689 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>>  		round++;
> >>>  	}
> >>>  
> >>> -	if (gc_type == FG_GC)
> >>> +	if (gc_type == FG_GC && seg_freed)
> >>
> >> That's original solution Sahitya provided to avoid infinite loop of GC, but I
> >> suggest to find the root cause first, then we added .invalid_segmap for that
> >> purpose.
> > 
> > I've checked the Sahitya's patch. So, it seems the problem can happen due to
> > is_alive or atomic_file.
> 
> For some conditions, this doesn't help, for example, two sections contain the
> same fewest valid blocks, it will cause to loop selecting them if it fails to
> migrate blocks.
> 
> How about keeping it as it is to find potential bug.

I think it'd be fine to merge this. Could you check the above scenario in more
detail?

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>  		sbi->cur_victim_sec = NULL_SEGNO;
> >>>  
> >>>  	if (sync)
> >>>
> > .
> > 
