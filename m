Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502A218459C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCMLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:09:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26660 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCMLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:09:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584097748; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=4CqveVje8eZtIec9/f8lDvI9y7a9yJdcnoX9VxusUoU=; b=vIyx8zVpemwBTmMox6NyLWjzOzppEd8mQXeO0sTwAp5Rnh7KcOe4+TWkq+fehlDVmj6GVxjw
 UV8ECGP5Sm9UMRv0gwf9Qy9nnWomxN5kEYc6CWED2ImcJ0dK5f2LTA0i8bhGlUrLbDqWjDuo
 c5TRaoXItSzil0M3bNZEz1tqlJ4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b69c5.7f8b3ef91688-smtp-out-n05;
 Fri, 13 Mar 2020 11:08:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87E14C44788; Fri, 13 Mar 2020 11:08:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D12A8C433D2;
        Fri, 13 Mar 2020 11:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D12A8C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 13 Mar 2020 16:38:46 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
Message-ID: <20200313110846.GL20234@codeaurora.org>
References: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
 <fa7d88ee-01e2-e82c-6c79-f24b90fbd472@huawei.com>
 <20200313033912.GJ20234@codeaurora.org>
 <a8f01157-0b1b-d83a-488d-bb48cf8954ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f01157-0b1b-d83a-488d-bb48cf8954ab@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:30:55PM +0800, Chao Yu wrote:
> On 2020/3/13 11:39, Sahitya Tummala wrote:
> > On Fri, Mar 13, 2020 at 10:20:04AM +0800, Chao Yu wrote:
> >> On 2020/3/12 19:14, Sahitya Tummala wrote:
> >>> F2FS already has a default timeout of 5 secs for discards that
> >>> can be issued during umount, but it can take more than the 5 sec
> >>> timeout if the underlying UFS device queue is already full and there
> >>> are no more available free tags to be used. In that case, submit_bio()
> >>> will wait for the already queued discard requests to complete to get
> >>> a free tag, which can potentially take way more than 5 sec.
> >>>
> >>> Fix this by submitting the discard requests with REQ_NOWAIT
> >>> flags during umount. This will return -EAGAIN for UFS queue/tag full
> >>> scenario without waiting in the context of submit_bio(). The FS can
> >>> then handle these requests by retrying again within the stipulated
> >>> discard timeout period to avoid long latencies.
> >>>
> >>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>> ---
> >>>  fs/f2fs/segment.c | 14 +++++++++++++-
> >>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index fb3e531..a06bbac 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -1124,10 +1124,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >>>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> >>>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> >>>  					&(dcc->fstrim_list) : &(dcc->wait_list);
> >>> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> >>> +	int flag;
> >>>  	block_t lstart, start, len, total_len;
> >>>  	int err = 0;
> >>>  
> >>> +	flag = dpolicy->sync ? REQ_SYNC : 0;
> >>> +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> >>> +
> >>>  	if (dc->state != D_PREP)
> >>>  		return 0;
> >>>  
> >>> @@ -1203,6 +1206,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >>>  		bio->bi_end_io = f2fs_submit_discard_endio;
> >>>  		bio->bi_opf |= flag;
> >>>  		submit_bio(bio);
> >>> +		if ((flag & REQ_NOWAIT) && (dc->error == -EAGAIN)) {
> >>
> >> If we want to update dc->state, we need to cover it with dc->lock.
> > 
> > Sure, will update it.
> > 
> >>
> >>> +			dc->state = D_PREP;
> >>
> >> BTW, one dc can be referenced by multiple bios, so dc->state could be updated to
> >> D_DONE later by f2fs_submit_discard_endio(), however we just relocate it to
> >> pending list... which is inconsistent status.
> > 
> > In that case dc->bio_ref will reflect it and until it becomes 0, the dc->state
> > will not be updated to D_DONE in f2fs_submit_discard_endio()?
> 
> __submit_discard_cmd()
>  lock()
>  dc->state = D_SUBMIT;
>  dc->bio_ref++;
>  unlock()
> ...
>  submit_bio()
> 				f2fs_submit_discard_endio()
> 				 dc->error = -EAGAIN;
> 				 lock()
> 				 dc->bio_ref--;
> 
>  dc->state = D_PREP;
> 
> 				 dc->state = D_DONE;
> 				 unlock()
> 
> So finally, dc's state is D_DONE, and it's in wait list, then will be relocated
> to pending list.

In case of queue full, f2fs_submit_discard_endio() will not be called
asynchronously. It will be called in the context of submit_bio() itself.
So by the time, submit_bio returns dc->error will be -EAGAIN and dc->state
will be D_DONE. 

submit_bio()
->blk_mq_make_request
->blk_mq_get_request()
  ->bio_wouldblock_error() (called due to queue full)
    ->bio_endio()
    
Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>> +			err = dc->error;
> >>> +			break;
> >>> +		}
> >>>  
> >>>  		atomic_inc(&dcc->issued_discard);
> >>>  
> >>> @@ -1510,6 +1518,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>>  			}
> >>>  
> >>>  			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> >>> +			if (dc->error == -EAGAIN) {
> >>> +				congestion_wait(BLK_RW_ASYNC, HZ/50);
> >>> +				__relocate_discard_cmd(dcc, dc);
> >>> +			}
> >>>  
> >>>  			if (issued >= dpolicy->max_requests)
> >>>  				break;
> >>>
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
