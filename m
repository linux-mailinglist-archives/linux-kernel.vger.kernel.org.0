Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8BB20A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbfIMNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:24:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45003 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbfIMNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so2334483oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNDaD+BINlkv6zoJWVAiIFvwXDeqZpIPbFP97WR4on8=;
        b=NY8Uxdciwud+TlgN5rFiZ22gRRT/FsOYn0/dyvVNO5SjNA8q8U9wbB9WuCguoQ4OLS
         cucDdIPRVQUdZ8mQkp/7PWYmyVNxAMzc7dcEirHOM7tz/KNZxkOoJmmgq0agqCNayUHw
         VQNKilSgzSSKGpQPJSpsrtjLyqYaXGWkNUEVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNDaD+BINlkv6zoJWVAiIFvwXDeqZpIPbFP97WR4on8=;
        b=oVqO+Uj531gdDeVCwuQi9xVttSVXfsLBpcpHxTdre0BRBDy11zgzFZPIls/lplosfB
         DGoOPcDcoR1V/uq/nYhdcYz5chJ7aAQ5M9pMKzfG8utVrKwHegnwTJyMSsCmStXeW445
         oGDLGsDpcRYcavExtPuN/RwO68wJGZLYf917iw7mrd1NAAckdaj0cyaJ1HKfaUlxCQd4
         OeIK1HUOY6G344Mm1PAbQ+VosVAm2F1P2mDFbhbnlZFQ0eSgsLmDt7jqeIWsHq1Li6IS
         pa3fRHL5qxma8pr7XWsQH3EpxYc6qsr+s1VrbP7/OSECAbleoR4+oMKQbrWukk8DId1y
         miJw==
X-Gm-Message-State: APjAAAUPaIf4qyYi++iWAje1fWL6KhohNDZWiVLhtENJgrH24N/54aiz
        CVJBodSjca35chiM6rP8ZxPlczxcd9hjr7KqYCI=
X-Google-Smtp-Source: APXvYqx2DsbUY0klNcbUf1E/tzhDANawNCiM1uaIHpFkxS+wDuY6KNjrLx+5nFf7dr3YheKmko3hz+Y+4kFifE1TfcA=
X-Received: by 2002:a05:6638:777:: with SMTP id y23mr39817270jad.111.1568381086045;
 Fri, 13 Sep 2019 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <1568258490-25359-1-git-send-email-teawaterz@linux.alibaba.com>
In-Reply-To: <1568258490-25359-1-git-send-email-teawaterz@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 13 Sep 2019 09:24:09 -0400
Message-ID: <CALZtONCO5BJJw-RjrhEeap95nZy0h9GBqYgx2apVB62ZemY54g@mail.gmail.com>
Subject: Re: [PATCH] zswap: Add CONFIG_ZSWAP_IO_SWITCH
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, chris@chris-wilson.co.uk,
        Johannes Weiner <hannes@cmpxchg.org>, ziqian.lzq@antfin.com,
        osandov@fb.com, Huang Ying <ying.huang@intel.com>,
        aryabinin@virtuozzo.com, vovoy@chromium.org,
        richard.weiyang@gmail.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, jglisse@redhat.com, b.zolnierkie@samsung.com,
        axboe@kernel.dk, dennis@kernel.org, josef@toxicpanda.com,
        tj@kernel.org, oleg@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:22 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> I use zswap to handle the swap IO issue in a VM that uses a swap file.
> This VM has 4G memory and 2 CPUs.  And I set up 4G swap in /swapfile.
> This is test script:
> cat 1.sh
> ./usemem --sleep 3600 -M -a -n 1 $((3 * 1024 * 1024 * 1024)) &
> sleep 10
> echo 1 > /proc/sys/vm/drop_caches
> ./usemem -S -f /test2 $((2 * 1024 * 1024 * 1024)) &
> while [ True ]; do ./usemem -a -n 1 $((1 * 1024 * 1024 * 1024)); done
>
> Without ZSWAP:
> echo 100 > /proc/sys/vm/swappiness
> swapon /swapfile
> sh 1.sh
> ...
> ...
> 1207959552 bytes / 2076479 usecs = 568100 KB/s
> 61088 usecs to free memory
> 1207959552 bytes / 2035439 usecs = 579554 KB/s
> 55073 usecs to free memory
> 2415919104 bytes / 24054408 usecs = 98081 KB/s
> 3741 usecs to free memory
> 1207959552 bytes / 1954371 usecs = 603594 KB/s
> 53161 usecs to free memory
> ...
> ...
>
> With ZSWAP:
> echo 100 > /proc/sys/vm/swappiness
> swapon /swapfile
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo zsmalloc > /sys/module/zswap/parameters/zpool
> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> echo 20 > /sys/module/zswap/parameters/max_pool_percent
> echo 1 > /sys/module/zswap/parameters/enabled
> sh 1.sh
> 1207959552 bytes / 3619283 usecs = 325934 KB/s
> 194825 usecs to free memory
> 1207959552 bytes / 3439563 usecs = 342964 KB/s
> 218419 usecs to free memory
> 2415919104 bytes / 19508762 usecs = 120935 KB/s
> 5632 usecs to free memory
> 1207959552 bytes / 3329369 usecs = 354315 KB/s
> 179764 usecs to free memory
>
> The normal io speed is increased from 98081 KB/s to 120935 KB/s.
> But I found 2 issues of zswap in this machine:
> 1. Because the disk of VM has the file cache in the host layer,
>    so normal swap speed is higher than with zswap.

I don't understand what you mean, that normal swap speed is higher
than with zswap.  Anyway, if that's true for your use case, then just
disable zswap, don't try to make zswap disable itself.

>
> 2. Because zswap need allocates memory to store the compressed pages,
>    it will make memory capacity worse.

well of course, this is the tradeoff with zswap; it's faster than real
swap (or at least it's supposed to be), but doesn't provide as much
memory pressure relief as real swap.

> For example:
> Command "./usemem -a -n 1 $((7 * 1024 * 1024 * 1024))" request 7G memory
> from this machine.
> It will work OK without zswap but got OOM when zswap is opened.
>
> This commit adds CONFIG_ZSWAP_IO_SWITCH that try to handle the issues
> and let zswap keep save IO.
> It add two parameters read_in_flight_limit and write_in_flight_limit to
> zswap.
> In zswap_frontswap_store, pages will be stored to zswap only when
> the IO in flight number of swap device is bigger than
> zswap_read_in_flight_limit or zswap_write_in_flight_limit
> when zswap is enabled.
> Then the zswap just work when the IO in flight number of swap device
> is low.
>
> This is the test result:
> echo 100 > /proc/sys/vm/swappiness
> swapon /swapfile
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo zsmalloc > /sys/module/zswap/parameters/zpool
> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> echo 20 > /sys/module/zswap/parameters/max_pool_percent
> echo 1 > /sys/module/zswap/parameters/enabled
> echo 3 > /sys/module/zswap/parameters/read_in_flight_limit
> echo 50 > /sys/module/zswap/parameters/write_in_flight_limit
> sh 1.sh
> ...
> 1207959552 bytes / 2320861 usecs = 508280 KB/s
> 106164 usecs to free memory
> 1207959552 bytes / 2343916 usecs = 503280 KB/s
> 79386 usecs to free memory
> 2415919104 bytes / 20136015 usecs = 117167 KB/s
> 4411 usecs to free memory
> 1207959552 bytes / 1833403 usecs = 643419 KB/s
> 70452 usecs to free memory
> ...
> killall usemem
> ./usemem -a -n 1 $((7 * 1024 * 1024 * 1024))
> 8455716864 bytes / 14457505 usecs = 571159 KB/s
> 365961 usecs to free memory
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

Unless you can significantly clarify why this is needed, i'm a nak.

Naked-by: Dan Streetman <ddstreet@ieee.org>


> ---
>  include/linux/swap.h |  3 +++
>  mm/Kconfig           | 11 +++++++++++
>  mm/page_io.c         | 16 +++++++++++++++
>  mm/zswap.c           | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index de2c67a..82b621f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -389,6 +389,9 @@ extern void end_swap_bio_write(struct bio *bio);
>  extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
>         bio_end_io_t end_write_func);
>  extern int swap_set_page_dirty(struct page *page);
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +extern void swap_io_in_flight(struct page *page, unsigned int inflight[2]);
> +#endif
>
>  int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
>                 unsigned long nr_pages, sector_t start_block);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 56cec63..d077e51 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -546,6 +546,17 @@ config ZSWAP
>           they have not be fully explored on the large set of potential
>           configurations and workloads that exist.
>
> +config ZSWAP_IO_SWITCH
> +       bool "Compressed cache for swap pages according to the IO status"
> +       depends on ZSWAP
> +       def_bool n
> +       help
> +         Add two parameters read_in_flight_limit and write_in_flight_limit to
> +         ZSWAP.  When ZSWAP is enabled, pages will be stored to zswap only
> +         when the IO in flight number of swap device is bigger than
> +         zswap_read_in_flight_limit or zswap_write_in_flight_limit.
> +         If unsure, say "n".
> +
>  config ZPOOL
>         tristate "Common API for compressed memory storage"
>         help
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 24ee600..e66b050 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -434,3 +434,19 @@ int swap_set_page_dirty(struct page *page)
>                 return __set_page_dirty_no_writeback(page);
>         }
>  }
> +
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +void swap_io_in_flight(struct page *page, unsigned int inflight[2])
> +{
> +       struct swap_info_struct *sis = page_swap_info(page);
> +
> +       if (!sis->bdev) {
> +               inflight[0] = 0;
> +               inflight[1] = 0;
> +               return;
> +       }
> +
> +       part_in_flight_rw(bdev_get_queue(sis->bdev), sis->bdev->bd_part,
> +                                         inflight);
> +}
> +#endif
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0e22744..1255645 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,13 @@ static u64 zswap_reject_compress_poor;
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
>  static u64 zswap_reject_kmemcache_fail;
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/* Store failed because zswap_read_in_flight_limit or
> + * zswap_write_in_flight_limit is bigger than IO in flight number of
> + * swap device
> + */
> +static u64 zswap_reject_io;
> +#endif
>  /* Duplicate store was encountered (rare) */
>  static u64 zswap_duplicate_entry;
>
> @@ -114,6 +121,22 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>                    bool, 0644);
>
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/* zswap will not try to store the page if zswap_read_in_flight_limit is
> + * bigger than IO read in flight number of swap device
> + */
> +static unsigned int zswap_read_in_flight_limit;
> +module_param_named(read_in_flight_limit, zswap_read_in_flight_limit,
> +                  uint, 0644);
> +
> +/* zswap will not try to store the page if zswap_write_in_flight_limit is
> + * bigger than IO write in flight number of swap device
> + */
> +static unsigned int zswap_write_in_flight_limit;
> +module_param_named(write_in_flight_limit, zswap_write_in_flight_limit,
> +                  uint, 0644);
> +#endif
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -1009,6 +1032,34 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>                 goto reject;
>         }
>
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +       if (zswap_read_in_flight_limit || zswap_write_in_flight_limit) {
> +               unsigned int inflight[2];
> +               bool should_swap = false;
> +
> +               swap_io_in_flight(page, inflight);
> +
> +               if (zswap_write_in_flight_limit &&
> +                       inflight[1] < zswap_write_in_flight_limit)
> +                       should_swap = true;
> +
> +               if (zswap_read_in_flight_limit &&
> +                       (should_swap ||
> +                        (!should_swap && !zswap_write_in_flight_limit))) {
> +                       if (inflight[0] < zswap_read_in_flight_limit)
> +                               should_swap = true;
> +                       else
> +                               should_swap = false;
> +               }
> +
> +               if (should_swap) {
> +                       zswap_reject_io++;
> +                       ret = -EIO;
> +                       goto reject;
> +               }
> +       }
> +#endif
> +
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
>                 zswap_pool_limit_hit++;
> @@ -1264,6 +1315,10 @@ static int __init zswap_debugfs_init(void)
>                            zswap_debugfs_root, &zswap_reject_kmemcache_fail);
>         debugfs_create_u64("reject_compress_poor", 0444,
>                            zswap_debugfs_root, &zswap_reject_compress_poor);
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +       debugfs_create_u64("reject_io", 0444,
> +                          zswap_debugfs_root, &zswap_reject_io);
> +#endif
>         debugfs_create_u64("written_back_pages", 0444,
>                            zswap_debugfs_root, &zswap_written_back_pages);
>         debugfs_create_u64("duplicate_entry", 0444,
> --
> 2.7.4
>
