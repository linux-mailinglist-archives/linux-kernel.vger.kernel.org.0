Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8F1517AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBDJUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:20:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgBDJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580808019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4HmF44R80GKRh8aK+Z42+sLW1TADRobX8DrtXDK9DG0=;
        b=f7Cjy7lzceiCH+FgPQBvBeyiyzjbOnHSvz/+N4jb2LqhQVQ0r9ycy1VOIhZ2DcB/ua1zzu
        zOk4PejpCqFckLFOglYzGy/zYM4gBIy556ymRoZOCFhF9rsTqBQK/bqCNwUnvlxGm95WtY
        kFuobHO/HNBSxi6CHHeYUV4DdYfQxmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-f5tWAjK_NNumwGHVwxlfuA-1; Tue, 04 Feb 2020 04:20:17 -0500
X-MC-Unique: f5tWAjK_NNumwGHVwxlfuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF4F18A6EC6;
        Tue,  4 Feb 2020 09:20:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 759B690F57;
        Tue,  4 Feb 2020 09:20:08 +0000 (UTC)
Date:   Tue, 4 Feb 2020 17:20:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200204092004.GB19922@ming.t460p>
References: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
 <20200203205950.127629-1-sqazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203205950.127629-1-sqazi@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:59:50PM -0800, Salman Qazi wrote:
> We observed that it is possible for a flush to bypass the I/O
> scheduler and get added to hctx->dispatch in blk_mq_sched_bypass_insert.

We always bypass io scheduler for flush request.

> This can happen while a kworker is running blk_mq_do_dispatch_sched call
> in blk_mq_sched_dispatch_requests.
> 
> However, the blk_mq_do_dispatch_sched call doesn't end in bounded time.
> As a result, the flush can sit there indefinitely, as the I/O scheduler
> feeds an arbitrary number of requests to the hardware.

blk-mq supposes to handle requests in hctx->dispatch with higher
priority, see blk_mq_sched_dispatch_requests().

However, there is single hctx->run_work, so async run queue for dispatching
flush request can only be run until another async run queue from scheduler
is done.

> 
> The solution is to periodically poll hctx->dispatch in
> blk_mq_do_dispatch_sched, to put a bound on the latency of the commands
> sitting there.
> 
> Signed-off-by: Salman Qazi <sqazi@google.com>
> ---
>  block/blk-mq-sched.c   |  6 ++++++
>  block/blk-mq.c         |  4 ++++
>  block/blk-sysfs.c      | 33 +++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h |  2 ++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd47b3d..75cdec64b9c7 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -90,6 +90,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  	struct request_queue *q = hctx->queue;
>  	struct elevator_queue *e = q->elevator;
>  	LIST_HEAD(rq_list);
> +	int count = 0;
>  
>  	do {
>  		struct request *rq;
> @@ -97,6 +98,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
>  			break;
>  
> +		if (count > 0 && count % q->max_sched_batch == 0 &&
> +		    !list_empty_careful(&hctx->dispatch))
> +			break;

q->max_sched_batch may not be needed, and it is reasonable to always
disaptch requests in hctx->dispatch first.

Also such trick is missed in dispatch from sw queue.


Thanks,
Ming

