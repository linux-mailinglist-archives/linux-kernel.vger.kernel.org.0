Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86701BBCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502499AbfIWUPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 16:15:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42209 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:15:07 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so36660321iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp6TMonzbuKlj33/BD70j5mcW8fMXi5umrwspsU0yM0=;
        b=bkgRAK8T3TSB8yADJditMdMUoiZ+K2NcwqoDPIgl7k65NTZgnQe+6AqAyePYWLy6Ju
         YSZfIBzKKQq5CzFsQrRlizYDZWrDJMWKvJ44aVNFe+3Qv+wpuwLxI2wYkWGvmPHmW3W3
         f93dMu1/W9JMNKc0jYWvqy2yYCUHWu5Q1Rvwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp6TMonzbuKlj33/BD70j5mcW8fMXi5umrwspsU0yM0=;
        b=olSzPzInAP8FoWXhj1zKMit9ooVjrYoup1e4jqk3GAKLYx9/oWiqzPK9ZgO+6WBORN
         OQy3CPSEjQjJEa1f0RLXrWNz0m/2MPUGQYxl/GScdznm5ZAbnkknD3Au9LH26AflGdxY
         qB//3mLRyBS0Tf9kqbRxQtKwxZIWc0ty/9Vl+qRsCZSJcFLP1EfEoj8CBiqgdqUZbq9Z
         EmyEd7QKfQ4faNCPSz+LojGX/9l4rByHPcY02qJGE4z2716oCktPLShWiJW5BwhxLNVK
         pjm3/+8Q4iGbyWDpPGgWFs6+JRD0W92UVwHs/TfMK0y2JegaolC6xnqnymgOc3b6NIbO
         VXug==
X-Gm-Message-State: APjAAAUeGLw6v8roKRNP5wciT9RBWCoYEvyZ5i6zy16fBn6q2TgwB1C5
        tT6ripzMFm+v7wT0B3in4muRWps94YzRPPNsY4s=
X-Google-Smtp-Source: APXvYqwO5Em5+XJuiPV4ZrZ53a6N6x5NEVARmGtsCO+2CLPZiMl0XC+iZXFMJtOR+QaIV4DwlepFcqhJToxVRZ72Y6k=
X-Received: by 2002:a02:9443:: with SMTP id a61mr1412409jai.35.1569269704624;
 Mon, 23 Sep 2019 13:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <1569209505-15801-1-git-send-email-teawaterz@linux.alibaba.com>
In-Reply-To: <1569209505-15801-1-git-send-email-teawaterz@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Mon, 23 Sep 2019 16:14:27 -0400
Message-ID: <CALZtOND21Lo7_a7a0LKMZzdo1_=+42GgbhAAn0LOJHbFe8yjFA@mail.gmail.com>
Subject: Re: [RFC v3] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO issue
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
        axboe@kernel.dk, dennis@kernel.org,
        Josef Bacik <josef@toxicpanda.com>, tj@kernel.org,
        oleg@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 11:32 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> This is the third version of this patch.  The first and second version
> is in [1] and [2].
> This verion is updated according to the comments from Randy Dunlap
> in [3].
>
> Currently, I use a VM that has 2 CPUs, 4G memory and 4G swap file.
> I found that swap will affect the IO performance when it is running.
> So I open zswap to handle it because it just use CPU cycles but not
> disk IO.
>
> It work OK but I found that zswap is slower than normal swap in this
> VM.  zswap is about 300M/s and normal swap is about 500M/s. (The reason
> is disk inside VM has fscache in host machine.)

I must be missing something here - if zswap in the guest is *slower*
than real swap, why are you using zswap?

Also, I don't see why zswap is slower than normal swap, unless you
mean that your zswap is full, since once zswap fills up any additional
swap will absolutely be slower than not having zswap at all.

> So open zswap is make memory shrinker slower but good for IO performance
> in this VM.
> So I just want zswap work when the disk of the swap file is under high
> IO load.
>
> This commit is designed for this idea.
> It add two parameters read_in_flight_limit and write_in_flight_limit to
> zswap.
> In zswap_frontswap_store, pages will be stored to zswap only when
> the IO in flight number of swap device is bigger than
> zswap_read_in_flight_limit or zswap_write_in_flight_limit
> when zswap is enabled.
> Then the zswap just work when the IO in flight number of swap device
> is low.

Ok, so maybe I understand what you mean, your disk I/O is normally
very fast, but once your host-side cache is full it starts actually
writing to your host physical disk, and your guest swap I/O drops way
down (since caching pages in host memory is much faster than writing
to a host physical disk).  Is that what's going on?  That was not
clear at all to me from the commit description...

In general I think the description of this commit, as well as the docs
and even user interface of how to use it, is very confusing.  I can
see how it would be beneficial in this specific situation, but I'm not
a fan of the implementation, and I'm very concerned that nobody will
be able to understand how to use it properly - when should they enable
it?  What limit values should they use?  Why are there separate read
and write limits?  None of that is clear to me, and I'm fairly
certainly it would not be clear to other normal users.

Is there a better way this can be done?

>
> [1] https://lkml.org/lkml/2019/9/11/935
> [2] https://lkml.org/lkml/2019/9/20/90
> [3] https://lkml.org/lkml/2019/9/20/1076
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  include/linux/swap.h |  3 +++
>  mm/Kconfig           | 18 ++++++++++++++++
>  mm/page_io.c         | 16 +++++++++++++++
>  mm/zswap.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+)
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
> index 56cec63..387c3b5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -546,6 +546,24 @@ config ZSWAP
>           they have not be fully explored on the large set of potential
>           configurations and workloads that exist.
>
> +config ZSWAP_IO_SWITCH
> +       bool "Compressed cache for swap pages according to the IO status"
> +       depends on ZSWAP
> +       help
> +         This function helps the system that normal swap speed is higher
> +         than zswap speed to handle the swap IO issue.
> +         For example, a VM where the disk device is not set cache config or
> +         set cache=writeback.
> +
> +         This function makes zswap just work when the disk of the swap file
> +         is under high IO load.
> +         It add two parameters (read_in_flight_limit and
> +         write_in_flight_limit) to zswap.  When zswap is enabled, pages will
> +         be stored to zswap only when the IO in flight number of swap device
> +         is bigger than zswap_read_in_flight_limit or
> +         zswap_write_in_flight_limit.
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

this potentially will read inflight stats info from all possible cpus,
that's not something I'm a big fan of adding to every single page swap
call...it's not awful, but there might be scaling issues for systems
with lots of cpus.

> +}
> +#endif
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0e22744..0190b2d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,14 @@ static u64 zswap_reject_compress_poor;
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
>  static u64 zswap_reject_kmemcache_fail;
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/*
> + * Store failed because zswap_read_in_flight_limit or
> + * zswap_write_in_flight_limit is bigger than IO in flight number of
> + * swap device
> + */
> +static u64 zswap_reject_io;
> +#endif
>  /* Duplicate store was encountered (rare) */
>  static u64 zswap_duplicate_entry;
>
> @@ -114,6 +122,24 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>                    bool, 0644);
>
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/*
> + * zswap will not try to store the page if zswap_read_in_flight_limit is
> + * bigger than IO read in flight number of swap device
> + */
> +static unsigned int zswap_read_in_flight_limit;
> +module_param_named(read_in_flight_limit, zswap_read_in_flight_limit,
> +                  uint, 0644);
> +
> +/*
> + * zswap will not try to store the page if zswap_write_in_flight_limit is
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
> @@ -1009,6 +1035,34 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
> @@ -1264,6 +1318,10 @@ static int __init zswap_debugfs_init(void)
>                            zswap_debugfs_root, &zswap_reject_kmemcache_fail);
>         debugfs_create_u64("reject_compress_poor", 0444,
>                            zswap_debugfs_root, &zswap_reject_compress_poor);
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +       debugfs_create_u64("reject_io", 0444,

"reject_io" is not very clear about why it was rejected; I think most
people will assume this means pages were rejected because of I/O
errors, not because the I/O inflight page count was lower than the set
limit.

> +                          zswap_debugfs_root, &zswap_reject_io);
> +#endif
>         debugfs_create_u64("written_back_pages", 0444,
>                            zswap_debugfs_root, &zswap_written_back_pages);
>         debugfs_create_u64("duplicate_entry", 0444,
> --
> 2.7.4
>
