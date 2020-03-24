Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2D191270
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCXOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 10:07:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46749 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbgCXOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585058842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guf8LTdbi3wmRiN5ykm7zFmobl16wEpjKymIGyI7jz0=;
        b=E3EVV1Pmzwj8o32QwAK4iz7cpYP+eMfLkyhoCBgB1NegkbbxkaljZY0mals24FzXXrvvbT
        /qv8be2Y/myHSN4+oD0HUJbgxw1LMGh8coU6yqL9NF2ADDjouZQnICmInlS4xK4eMH/i/e
        VJha6MV+yS6DY58YU/gZcDwb4pzL7k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Y-hw-xkwP0KoK8tU2EARNg-1; Tue, 24 Mar 2020 10:07:20 -0400
X-MC-Unique: Y-hw-xkwP0KoK8tU2EARNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2537813FD;
        Tue, 24 Mar 2020 14:07:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87BF05C241;
        Tue, 24 Mar 2020 14:07:04 +0000 (UTC)
Date:   Tue, 24 Mar 2020 22:06:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v3 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
Message-ID: <20200324140656.GA23550@ming.t460p>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
 <158503198072.1955.16227279292140721351.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158503198072.1955.16227279292140721351.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:39:40AM +0300, Konstantin Khlebnikov wrote:
> Currently io_ticks is approximated by adding one at each start and end of
> requests if jiffies counter has changed. This works perfectly for requests
> shorter than a jiffy or if one of requests starts/ends at each jiffy.
> 
> If disk executes just one request at a time and they are longer than two
> jiffies then only first and last jiffies will be accounted.
> 
> Fix is simple: at the end of request add up into io_ticks jiffies passed
> since last update rather than just one jiffy.
> 
> Example: common HDD executes random read 4k requests around 12ms.
> 
> fio --name=test --filename=/dev/sdb --rw=randread --direct=1 --runtime=30 &
> iostat -x 10 sdb
> 
> Note changes of iostat's "%util" 8,43% -> 99,99% before/after patch:
> 
> Before:
> 
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sdb               0,00     0,00   82,60    0,00   330,40     0,00     8,00     0,96   12,09   12,09    0,00   1,02   8,43
> 
> After:
> 
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sdb               0,00     0,00   82,50    0,00   330,00     0,00     8,00     1,00   12,10   12,10    0,00  12,12  99,99
> 
> For load estimation "%util" is not as useful as average queue length,
> but it clearly shows how often disk queue is completely empty.
> 
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/iostats.rst |    5 ++++-
>  block/bio.c                           |    8 ++++----
>  block/blk-core.c                      |    4 ++--
>  include/linux/genhd.h                 |    2 +-
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
> index df5b8345c41d..9b14b0c2c9c4 100644
> --- a/Documentation/admin-guide/iostats.rst
> +++ b/Documentation/admin-guide/iostats.rst
> @@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doing I/Os (unsigned int)
>  
>      Since 5.0 this field counts jiffies when at least one request was
>      started or completed. If request runs more than 2 jiffies then some
> -    I/O time will not be accounted unless there are other requests.
> +    I/O time might be not accounted in case of concurrent requests.
>  
>  Field 11 -- weighted # of milliseconds spent doing I/Os (unsigned int)
>      This field is incremented at each I/O start, I/O completion, I/O
> @@ -143,6 +143,9 @@ are summed (possibly overflowing the unsigned long variable they are
>  summed to) and the result given to the user.  There is no convenient
>  user interface for accessing the per-CPU counters themselves.
>  
> +Since 4.19 request times are measured with nanoseconds precision and
> +truncated to milliseconds before showing in this interface.
> +
>  Disks vs Partitions
>  -------------------
>  
> diff --git a/block/bio.c b/block/bio.c
> index 0985f3422556..b1053eb7af37 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1762,14 +1762,14 @@ void bio_check_pages_dirty(struct bio *bio)
>  	schedule_work(&bio_dirty_work);
>  }
>  
> -void update_io_ticks(struct hd_struct *part, unsigned long now)
> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>  {
>  	unsigned long stamp;
>  again:
>  	stamp = READ_ONCE(part->stamp);
>  	if (unlikely(stamp != now)) {
>  		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> -			__part_stat_add(part, io_ticks, 1);
> +			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
>  		}
>  	}
>  	if (part->partno) {
> @@ -1785,7 +1785,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
>  
>  	part_stat_lock();
>  
> -	update_io_ticks(part, jiffies);
> +	update_io_ticks(part, jiffies, false);
>  	part_stat_inc(part, ios[sgrp]);
>  	part_stat_add(part, sectors[sgrp], sectors);
>  	part_inc_in_flight(q, part, op_is_write(op));
> @@ -1803,7 +1803,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
>  
>  	part_stat_lock();
>  
> -	update_io_ticks(part, now);
> +	update_io_ticks(part, now, true);
>  	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>  	part_stat_add(part, time_in_queue, duration);
>  	part_dec_in_flight(q, part, op_is_write(req_op));
> diff --git a/block/blk-core.c b/block/blk-core.c
> index abfdcf81a228..4401b30a1751 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1337,7 +1337,7 @@ void blk_account_io_done(struct request *req, u64 now)
>  		part_stat_lock();
>  		part = req->part;
>  
> -		update_io_ticks(part, jiffies);
> +		update_io_ticks(part, jiffies, true);
>  		part_stat_inc(part, ios[sgrp]);
>  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>  		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
> @@ -1379,7 +1379,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
>  		rq->part = part;
>  	}
>  
> -	update_io_ticks(part, jiffies);
> +	update_io_ticks(part, jiffies, false);
>  
>  	part_stat_unlock();
>  }
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index d5c75df64bba..f1066f10b062 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -467,7 +467,7 @@ static inline void free_part_info(struct hd_struct *part)
>  	kfree(part->info);
>  }
>  
> -void update_io_ticks(struct hd_struct *part, unsigned long now);
> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
>  
>  /* block/genhd.c */
>  extern void device_add_disk(struct device *parent, struct gendisk *disk,
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

