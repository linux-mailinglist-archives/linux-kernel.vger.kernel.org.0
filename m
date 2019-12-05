Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29440114357
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 16:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfLEPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 10:16:39 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18480 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575558997; x=1607094997;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=C1oFzrj34QolL5H4aOWLvQyygWmB7hXl2AlARDmhXA0=;
  b=pcQRlDOUDeED+5lZdZ7RVkh27dJEv4HdL0UDDCkuueAharbY9mCSA3QL
   1j0pUn4DRkJa70YdRgJ6u++Tx/uIdCVtOHKHZVgOfxV2POhPC+RfdgMKH
   McWZ94Sj08TcUswFoszP57x66I0UfxHt82c1txUWhQkN6g80rJsbWGC8Z
   M=;
IronPort-SDR: mVNUuZ+mLMtgI+ouYSr5spb8rh4BJmura+tGZom9JtflYE6DAyBLYOcahm4Tz8UX1BPsYN84vg
 BADtA2XhAQQA==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="7284652"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Dec 2019 15:16:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 0E886A2047;
        Thu,  5 Dec 2019 15:16:34 +0000 (UTC)
Received: from EX13D04UEA002.ant.amazon.com (10.43.61.61) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:16:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D04UEA002.ant.amazon.com (10.43.61.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:16:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.28.85.76) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 15:16:32 +0000
Subject: Re: [PATCH v2 1/1] xen/blkback: Aggressively shrink page pools if a
 memory pressure is detected
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj38.park@gmail.com>, SeongJae Park <sjpark@amazon.de>
References: <20191205150932.3793-1-sjpark@amazon.com>
 <20191205150932.3793-2-sjpark@amazon.com>
From:   <sjpark@amazon.com>
Message-ID: <78340df5-5b4f-ddd8-db79-75f8449be4b3@amazon.com>
Date:   Thu, 5 Dec 2019 16:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205150932.3793-2-sjpark@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 16:09, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
>
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>
> Therefore, `blkfront` running guests can cause a memory pressure in the
> `blkback` running guest by attaching a large number of block devices and
> inducing I/O.  System administrators can avoid such problematic
> situations by limiting the maximum number of devices each guest can
> attach.  However, finding the optimal limit is not so easy.  Improper
> set of the limit can result in the memory pressure or a resource
> underutilization.  This commit avoids such problematic situations by
> shrinking the pools aggressively (further the limit) for a while (users
> can set this duration via a module parameter) if a memory pressure is
> detected.
>
> Discussions
> ===========
>
> The `blkback`'s original shrinking mechanism returns only pages in the
> pool which are not currently be used by `blkback`.  In other words, the
> pages that will be shrunk are not mapped with foreign pages.  Because
> this commit is changing only the shrink limit but uses the shrinking
> mechanism as is, this commit does not introduce improper mappings
> related security issues.
>
> Once a memory pressure is detected, this commit keeps the aggressive
> shrinking limit for a user-specified time duration.  The duration should
> be neither too long nor too short.  If it is too long, free pages pool
> shrinking overhead can reduce the I/O performance.  If it is too short,
> `blkback` will not free enough pages to reduce the memory pressure.
> This commit sets the value as `10 milliseconds` by default because it is
> a short time in terms of I/O while it is a long time in terms of memory
> operations.  Also, as the original shrinking mechanism works for at
> least every 100 milliseconds, this could be a somewhat reasonable
> choice.  I also tested other durations (refer to the below section for
> more details) and confirmed that 10 milliseconds is the one that works
> best.  That said, the proper duration depends on actual configurations
> and workloads.  That's why this commit is allowing users to set it as
> their optimal value via the module parameter.
>
> Memory Pressure Test
> ====================
>
> To show how this commit fixes the above mentioned memory pressure
> situation well, I configured a test environment on a xen-running system.
> On the `blkfront` running guest instances, I attach a large number of
> network-backed volume devices and induce I/O to those.  Meanwhile, I
> measure the number of pages that swapped in and out on the `blkback`
> running guest.  The test ran twice, once for the `blkback` before this
> commit and once for that after this commit.  As shown below, this commit
> has dramatically reduced the memory pressure:
>
>                 pswpin  pswpout
>     before      76,672  185,799
>     after          212    3,325
>
> Optimal Aggressive Shrinking Duration
> -------------------------------------
>
> To find a best aggressive shrinking duration, I repeated the test with
> three different durations (1ms, 10ms, and 100ms).  The results are as
> below:
>
>     duration    pswpin  pswpout
>     1           852     6,424
>     10          212     3,325
>     100         203     3,340
>
> As expected, the numbers have further decreased by increasing the
> duration, but the reduction stopped from the `10ms`.  Based on this
> results, I chose the default duration as 10ms.
>
> Performance Overhead Test
> =========================
>
> This commit could incur I/O performance degradation under severe memory
> pressure because the aggressive shrinking will require more page
> allocations per I/O.  To show the overhead, I artificially made an
> aggressive pages pool shrinking situation and measured the I/O
> performance of a `blkfront` running guest.
>
> For the artificial shrinking, I set the `blkback.max_buffer_pages` using
> the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
> the value to `1024` and `0`.  The `1024` is the default value.  Setting
> the value as `0` is same to a situation doing the aggressive shrinking
> always (worst-case).
>
> For the I/O performance measurement, I use a simple `dd` command.
>
> Default Performance
> -------------------
>
>     [dom0]# echo 1024 >
> /sys/module/xen_blkback/parameters/max_buffer_pages
>     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k
> count=$((256*512)); sync; done
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s
>
> Worst-case Performance
> ----------------------
>
>     [dom0]# echo 0 >
> /sys/module/xen_blkback/parameters/max_buffer_pages
>     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k
> count=$((256*512)); sync; done
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s
>
> In short, even worst case aggressive shrinking makes no visible
> performance degradation.  I think this is due to the slow speed of the
> I/O.  In other words, the additional page allocation overhead is hidden
> under the much slower I/O latency.
>
> Nevertheless, pleaset note that this is just a very simple and minimal
> test.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 3666afa639d1..72d068328ef1 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -135,6 +135,31 @@ module_param(log_stats, int, 0644);
>  /* Number of free pages to remove on each call to gnttab_free_pages */
>  #define NUM_BATCH_FREE_PAGES 10
>  
> +/*
> + * Once a memory pressure is detected, keep aggressive shrinking of the free
> + * page pools for this time (milliseconds)
> + */
> +static int xen_blkif_aggressive_shrinking_duration = 10;
> +module_param_named(aggressive_shrinking_duration,
> +		xen_blkif_aggressive_shrinking_duration, int, 0644);
> +MODULE_PARM_DESC(aggressive_shrinking_duration,
> +"Duration in ms to do aggressive shrinking when a memory pressure is detected");
> +
> +static unsigned long xen_blk_mem_pressure_end;
> +
> +static unsigned long blkif_shrink_count(struct shrinker *shrinker,
> +				struct shrink_control *sc)
> +{
> +	xen_blk_mem_pressure_end = jiffies +
> +		msecs_to_jiffies(xen_blkif_aggressive_shrinking_duration);
> +	return 0;
> +}
> +
> +static struct shrinker blkif_shrinker = {
> +	.count_objects = blkif_shrink_count,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>  static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>  {
>  	return xen_blkif_pgrant_timeout &&
> @@ -656,8 +681,11 @@ int xen_blkif_schedule(void *arg)
>  			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
>  		}
>  
> -		/* Shrink if we have more than xen_blkif_max_buffer_pages */
> -		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
> +		/* Shrink the free pages pool if it is too large. */
> +		if (time_before(jiffies, xen_blk_mem_pressure_end))
> +			shrink_free_pagepool(ring, 0);
> +		else
> +			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
>  
>  		if (log_stats && time_after(jiffies, ring->st_print))
>  			print_stats(ring);
> @@ -1500,6 +1528,9 @@ static int __init xen_blkif_init(void)
>  	if (rc)
>  		goto failed_init;
>  
> +	if (register_shrinker(&blkif_shrinker))
> +		pr_warn("shrinker registration failed\n");
> +
>   failed_init:
>  	return rc;
>  }

CC-ing xen-devel@lists.xenproject.org


Thanks,
SeongJae Park

