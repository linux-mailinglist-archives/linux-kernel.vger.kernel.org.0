Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A3199E58
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgCaSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 14:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgCaSq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:46:57 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F894207FF;
        Tue, 31 Mar 2020 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585680416;
        bh=YpdsDoiVHzsdfsRG8KkgIZ0+9jhzFhX4NZGYfworz/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTmueXNPeYP3+RbCPpfmqtZg8VIynDk2iSoPacbf8L7eEtVJtf9rOT2i3Nsy+Dtv+
         SKoe/ro1QnZEHE/uoqDT7vwXbnoLv9zmIQ2CT0sweiLJEOOg1LZcjemYYMAuGhuS4f
         wit+aWnqbnS0BcanGg3WD43qlWRVuZhhTXoKGdiA=
Date:   Tue, 31 Mar 2020 11:46:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix long latency due to discard during umount
Message-ID: <20200331184655.GB198665@google.com>
References: <1585550730-1858-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585550730-1858-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, Sahitya Tummala wrote:
> F2FS already has a default timeout of 5 secs for discards that
> can be issued during umount, but it can take more than the 5 sec
> timeout if the underlying UFS device queue is already full and there
> are no more available free tags to be used. In that case, submit_bio()
> will wait for the already queued discard requests to complete to get
> a free tag, which can potentially take way more than 5 sec.
> 
> Fix this by submitting the discard requests with REQ_NOWAIT
> flags during umount. This will return -EAGAIN for UFS queue/tag full
> scenario without waiting in the context of submit_bio(). The FS can
> then handle these requests by retrying again within the stipulated
> discard timeout period to avoid long latencies.

Sorry, Sahitya, but, do we really need to do like this? How about just
controlling # of outstanding discarding bios in __issue_discard_cmd()?

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v3:
> -Handle the regression reported by Chao with v2.
> -simplify the logic to split the dc with multiple bios incase any bio returns
>  EAGAIN and retry those new dc within 5 sec timeout.
> 
>  fs/f2fs/segment.c | 65 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fb3e531..55d18c7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1029,13 +1029,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
>  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
>  	unsigned long flags;
>  
> -	dc->error = blk_status_to_errno(bio->bi_status);
> -
>  	spin_lock_irqsave(&dc->lock, flags);
> +	if (!dc->error)
> +		dc->error = blk_status_to_errno(bio->bi_status);
> +
>  	dc->bio_ref--;
> -	if (!dc->bio_ref && dc->state == D_SUBMIT) {
> -		dc->state = D_DONE;
> -		complete_all(&dc->wait);
> +	if (!dc->bio_ref) {
> +		if (dc->error || dc->state == D_SUBMIT) {
> +			dc->state = D_DONE;
> +			complete_all(&dc->wait);
> +		}
>  	}
>  	spin_unlock_irqrestore(&dc->lock, flags);
>  	bio_put(bio);
> @@ -1124,10 +1127,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
>  					&(dcc->fstrim_list) : &(dcc->wait_list);
> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> +	int flag;
>  	block_t lstart, start, len, total_len;
>  	int err = 0;
>  
> +	flag = dpolicy->sync ? REQ_SYNC : 0;
> +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> +
>  	if (dc->state != D_PREP)
>  		return 0;
>  
> @@ -1192,10 +1198,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		dc->bio_ref++;
>  		spin_unlock_irqrestore(&dc->lock, flags);
>  
> -		atomic_inc(&dcc->queued_discard);
> -		dc->queued++;
> -		list_move_tail(&dc->list, wait_list);
> -
>  		/* sanity check on discard range */
>  		__check_sit_bitmap(sbi, lstart, lstart + len);
>  
> @@ -1203,6 +1205,29 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		bio->bi_end_io = f2fs_submit_discard_endio;
>  		bio->bi_opf |= flag;
>  		submit_bio(bio);
> +		if (flag & REQ_NOWAIT) {
> +			if (dc->error == -EAGAIN) {
> +				spin_lock_irqsave(&dc->lock, flags);
> +				dc->len -= len;
> +				if (!dc->len) {
> +					dc->len = total_len;
> +					dc->state = D_PREP;
> +					reinit_completion(&dc->wait);
> +				} else {
> +					dcc->undiscard_blks -= total_len;
> +					if (dc->state == D_PARTIAL)
> +						dc->state = D_SUBMIT;
> +				}
> +				err = dc->error;
> +				dc->error = 0;
> +				spin_unlock_irqrestore(&dc->lock, flags);
> +				break;
> +			}
> +		}
> +
> +		atomic_inc(&dcc->queued_discard);
> +		dc->queued++;
> +		list_move_tail(&dc->list, wait_list);
>  
>  		atomic_inc(&dcc->issued_discard);
>  
> @@ -1214,8 +1239,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		len = total_len;
>  	}
>  
> -	if (!err && len)
> -		__update_discard_tree_range(sbi, bdev, lstart, start, len);
> +	if ((!err || err == -EAGAIN) && total_len && dc->start != start)
> +		__update_discard_tree_range(sbi, bdev, lstart, start,
> +					total_len);
>  	return err;
>  }
>  
> @@ -1470,12 +1496,15 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct list_head *pend_list;
>  	struct discard_cmd *dc, *tmp;
>  	struct blk_plug plug;
> -	int i, issued = 0;
> +	int i, err, issued = 0;
>  	bool io_interrupted = false;
> +	bool retry;
>  
>  	if (dpolicy->timeout != 0)
>  		f2fs_update_time(sbi, dpolicy->timeout);
>  
> +retry:
> +	retry = false;
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>  		if (dpolicy->timeout != 0 &&
>  				f2fs_time_over(sbi, dpolicy->timeout))
> @@ -1509,7 +1538,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  				break;
>  			}
>  
> -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
> +			if (err == -EAGAIN) {
> +				congestion_wait(BLK_RW_ASYNC,
> +						DEFAULT_IO_TIMEOUT);
> +				retry = true;
> +			}
>  
>  			if (issued >= dpolicy->max_requests)
>  				break;
> @@ -1522,6 +1556,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			break;
>  	}
>  
> +	if (retry)
> +		goto retry;
> +
>  	if (!issued && io_interrupted)
>  		issued = -1;
>  
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
