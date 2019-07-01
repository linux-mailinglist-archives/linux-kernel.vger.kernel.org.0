Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE72CEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfE1Sh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 14:37:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44372 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfE1Sh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:37:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so11996475pfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRd/gH9xFkB/yz4FR3ftFniKvXd2c3N7GKAmUw5fpgQ=;
        b=lua1uHGwRz2QW0dSEiV2nKwBEHPGEBYmAFNEzXPKPrY79O3M9NVaYCPtLQqhWAXfjB
         f7wZQEO1E4PUIT0A81JS5BdYGKm/AhISmDiYYtDARF4+sNWIgGEyhn4aDlK8NevMipct
         ssYEmtLlDMmGUiqr92JTuh4WkkTJHaOpVme4vJilMHILXK/LJDofu5bei/9oW9eavQQD
         uGUeopb5pYkGKvUolymA/rv7qciuHolWMyts3KDO0yRkGKwLRplVZBSYEpNt/1/A/nTM
         N8rs/bBplt8+ZO//lCSDP7atmiwwrScpQbfLm9kAkMGcoO+s96uBuJYBg6OHDp1kqeT+
         BJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRd/gH9xFkB/yz4FR3ftFniKvXd2c3N7GKAmUw5fpgQ=;
        b=mydCwDw8kASRuq2v4p03Ptof+EIeHr+d/fiQQzEEOmg9zPhBC90/FYgV8YnShuXtMw
         M1QKeFjhvxKoRToR3wISn96HfxF2MsRBlVO0hfOtFywqheYjMrwHZp62C3qo+fuaySo8
         ghKwz9GcNuq13thdL3FNNTIUb2swGoyz3ZPRxqblBaa+JgfmGmy+vdN4V7RGXpYfwwIy
         pPnyRWKArkx3aKwfpEl/3iTIyLGZanEFjwObO0D4lp+KvYCjM/BVgYGSIFycF5kaotA2
         6i8klVkmyTsIFgFnumxtMRuL2VIZglDxk6W/xLVsr9/DcRLRQKuqbKgNDilOUcpx6yWj
         k9Eg==
X-Gm-Message-State: APjAAAVA+YmuHyIKjVnOwFGgQ4v58fStP6trTcadgmVCLXfhD96vxWNj
        pMAv3EaLEVGI1Q6XIXVWj4GJqA==
X-Google-Smtp-Source: APXvYqydHs0lnrmEf+EW1gDvqJC/avPQHeKYJsUoXeJTgdBDlzesYO26GlIPoBdvG8btUp//RDL06w==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr80317986pgp.72.1559068647775;
        Tue, 28 May 2019 11:37:27 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:6f81])
        by smtp.gmail.com with ESMTPSA id 79sm18309988pfz.144.2019.05.28.11.37.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 11:37:27 -0700 (PDT)
Date:   Tue, 28 May 2019 11:37:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com, ming.lei@redhat.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 1/1] blk-mq: Fix disabled hybrid polling
Message-ID: <20190528183726.GA25022@vader>
References: <dd30f4d94aa19956ad4500b1177741fd071ec37f.1558791181.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd30f4d94aa19956ad4500b1177741fd071ec37f.1558791181.git.asml.silence@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 04:42:11PM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Commit 4bc6339a583cec650b05 ("block: move blk_stat_add() to
> __blk_mq_end_request()") moved blk_stat_add(), so now it's called after
> blk_update_request(), which zeroes rq->__data_len. Without length,
> blk_stat_add() can't calculate stat bucket and returns error,
> effectively disabling hybrid polling.

I don't see how this patch fixes this problem, am I missing something?
The timing issue seems orthogonal.

> __blk_mq_end_request() is a right place to call blk_stat_add(), as it's
> guaranteed to be called for each request. Yet, calculating time there
> won't provide sufficient accuracy/precision for finer tuned hybrid
> polling, because a path from __blk_mq_complete_request() to
> __blk_mq_end_request() adds unpredictable overhead.
> 
> Add io_end_time_ns field in struct request, save time as soon as
> possible (at __blk_mq_complete_request()) and reuse later.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-mq.c         | 13 ++++++++++---
>  block/blk-stat.c       |  4 ++--
>  block/blk-stat.h       |  2 +-
>  include/linux/blkdev.h | 11 +++++++++++
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 32b8ad3d341b..8f6b6bfe0ccb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -330,6 +330,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	else
>  		rq->start_time_ns = 0;
>  	rq->io_start_time_ns = 0;
> +	rq->io_end_time_ns = 0;
>  	rq->nr_phys_segments = 0;
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>  	rq->nr_integrity_segments = 0;
> @@ -532,14 +533,17 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
>  
>  inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
> -	u64 now = 0;
> +	u64 now = rq->io_end_time_ns;

Kyber expects the timestamp passed in to kyber_complete_request() to
include the software overhead. iostat should probably include the
software overhead, too. So, we probably won't be able to avoid calling
ktime_get() twice, once for I/O time and one for the end-to-end time.

> -	if (blk_mq_need_time_stamp(rq))
> +	/* called directly bypassing __blk_mq_complete_request */
> +	if (blk_mq_need_time_stamp(rq) && !now) {
>  		now = ktime_get_ns();
> +		rq->io_end_time_ns = now;
> +	}
>  
>  	if (rq->rq_flags & RQF_STATS) {
>  		blk_mq_poll_stats_start(rq->q);
> -		blk_stat_add(rq, now);
> +		blk_stat_add(rq);
>  	}
>  
>  	if (rq->internal_tag != -1)
> @@ -579,6 +583,9 @@ static void __blk_mq_complete_request(struct request *rq)
>  	bool shared = false;
>  	int cpu;
>  
> +	if (blk_mq_need_time_stamp(rq))
> +		rq->io_end_time_ns = ktime_get_ns();
> +
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  	/*
>  	 * Most of single queue controllers, there is only one irq vector
> diff --git a/block/blk-stat.c b/block/blk-stat.c
> index 940f15d600f8..9b9b30927ea8 100644
> --- a/block/blk-stat.c
> +++ b/block/blk-stat.c
> @@ -48,7 +48,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
>  	stat->nr_samples++;
>  }
>  
> -void blk_stat_add(struct request *rq, u64 now)
> +void blk_stat_add(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_stat_callback *cb;
> @@ -56,7 +56,7 @@ void blk_stat_add(struct request *rq, u64 now)
>  	int bucket;
>  	u64 value;
>  
> -	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
> +	value = blk_rq_io_time(rq);
>  
>  	blk_throtl_stat_add(rq, value);
>  
> diff --git a/block/blk-stat.h b/block/blk-stat.h
> index 17b47a86eefb..2653818cee36 100644
> --- a/block/blk-stat.h
> +++ b/block/blk-stat.h
> @@ -65,7 +65,7 @@ struct blk_stat_callback {
>  struct blk_queue_stats *blk_alloc_queue_stats(void);
>  void blk_free_queue_stats(struct blk_queue_stats *);
>  
> -void blk_stat_add(struct request *rq, u64 now);
> +void blk_stat_add(struct request *rq);
>  
>  /* record time/size info in request but not add a callback */
>  void blk_stat_enable_accounting(struct request_queue *q);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..2a8d4b68d707 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -198,6 +198,9 @@ struct request {
>  	u64 start_time_ns;
>  	/* Time that I/O was submitted to the device. */
>  	u64 io_start_time_ns;
> +	/* Time that I/O was reported completed by the device. */
> +	u64 io_end_time_ns;
> +
>  
>  #ifdef CONFIG_BLK_WBT
>  	unsigned short wbt_flags;
> @@ -385,6 +388,14 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
>  
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> +static inline u64 blk_rq_io_time(struct request *rq)
> +{
> +	u64 start = rq->io_start_time_ns;
> +	u64 end = rq->io_end_time_ns;
> +
> +	return (end - start) ? end - start : 0;

I think you meant:

	return end >= start ? end - start : 0;

> +}
> +
>  struct request_queue {
>  	/*
>  	 * Together with queue_head for cacheline sharing
> -- 
> 2.21.0
> 
