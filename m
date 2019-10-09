Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD43D1B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfJIWZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 18:25:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36468 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfJIWZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:25:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id x64so1426332ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOr0EjO8ZYNpH3XybPh3rB6lRmS6eQuMeIiMtrlftWQ=;
        b=Hh2WEp7plONxJwvwa0Y5K4Bolxjg6ELdA9/VQOmm/eXpB2wi1N+HeCBFz5IZTxgUFV
         Xcf8tlsDgb9eCYjocQeo/pUUIYP18pGn6R1hQR+oU7llCulW49MnRaDpAl+v4+pG6kjd
         81Ha2F9Uuwl5gHtUrY4LoAn86wOeNDOJPnH6SGL35pIMGeBz27Pn3PZ7LE8MNxAaBBFZ
         IM1t//IDIxoTiUxSxI3pKnVme7HdhdBLFzdawkhMN8OiZqgKyble+uJ++HC6ec/vzJF2
         yWmhLJkSXrbplHrHwtubCcdpv7PyG1+RYeYelIZxkZFTXGQCtufnKvrGlYutBev6z295
         OFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOr0EjO8ZYNpH3XybPh3rB6lRmS6eQuMeIiMtrlftWQ=;
        b=G9cRofuQub5Jdj+IY9yQHVDzDmlpjMCTAsak+XwvSfB19no0S5mizb4ZLXVcfHlyXx
         tbfHpuCFQSUaHQfr5q2jb5oNSmlPr5vWIQMes8t4vopn9EKgsMc2wUr/bTHr3Rci4JG3
         kaShHU+MEzRYxtK0M34qe67hd+KUG8B2XOCBMF5kAtxRykgSld6rUkF1t2FVtnN0bpt2
         VDlw96kbExaUAakKCHh3sW02dpnYHsXbI02ZfpFZtUcAISKRbPFo49hRpvU6wffM43vl
         8Aex6X3H2HBbVzok9mdVW3Hqw0jglDjRD9S76HTasJZ7PmgrHFIhl3asiZnaVh8/NRBa
         UWpg==
X-Gm-Message-State: APjAAAWZZanWggEZJ0moImzdn9PiogWy5isBXwx8nr2+rI9rPojg9wFs
        XwFc9/ar7FHpFQJptqsHB3I++xSbF35heKTLFgYhww==
X-Google-Smtp-Source: APXvYqynlHxg47jhvD1rer1MqzgbiOH4AqQFxJXN5dDv8yvBvhs6kCc4akm6Ky14f2e2fKcjn59wpkg7sORtQq7GYIw=
X-Received: by 2002:a81:9907:: with SMTP id q7mr4387541ywg.296.1570659922107;
 Wed, 09 Oct 2019 15:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191009211857.35587-1-minchan@kernel.org>
In-Reply-To: <20191009211857.35587-1-minchan@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 9 Oct 2019 15:25:10 -0700
Message-ID: <CALvZod4-hTrOy_Fdd+3tCm0cNHwOOr0UFwLwVkGOw=qJDxfFEw@mail.gmail.com>
Subject: Re: [PATCH] fs: annotate refault stalls from bdev_read_page
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 2:19 PM Minchan Kim <minchan@kernel.org> wrote:
>
> From: Minchan Kim <minchan@google.com>
>
> If block device supports rw_page operation, it doesn't submit bio
> so annotation in submit_bio for refault stall doesn't work.
> It happens with zram in android, especially swap read path which
> could consume CPU cycle for decompress.

What about zswap? Do we need the same in zswap_frontswap_load()?

>
> Annotate bdev_read_page() to account the synchronous IO overhead
> to prevent underreport memory pressure.
>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@google.com>
> ---
>  fs/block_dev.c | 13 +++++++++++++
>  mm/memory.c    |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9c073dbdc1b0..82ca28eb9a57 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -26,6 +26,7 @@
>  #include <linux/writeback.h>
>  #include <linux/mpage.h>
>  #include <linux/mount.h>
> +#include <linux/psi.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/uio.h>
>  #include <linux/namei.h>
> @@ -701,6 +702,8 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
>  {
>         const struct block_device_operations *ops = bdev->bd_disk->fops;
>         int result = -EOPNOTSUPP;
> +       unsigned long pflags;
> +       bool workingset_read;
>
>         if (!ops->rw_page || bdev_get_integrity(bdev))
>                 return result;
> @@ -708,9 +711,19 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
>         result = blk_queue_enter(bdev->bd_queue, 0);
>         if (result)
>                 return result;
> +
> +       workingset_read = PageWorkingset(page);
> +       if (workingset_read)
> +               psi_memstall_enter(&pflags);
> +
>         result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
>                               REQ_OP_READ);
> +
> +       if (workingset_read)
> +               psi_memstall_leave(&pflags);
> +
>         blk_queue_exit(bdev->bd_queue);
> +
>         return result;
>  }
>  EXPORT_SYMBOL_GPL(bdev_read_page);
> diff --git a/mm/memory.c b/mm/memory.c
> index 06935826d71e..6357d5a0a2a5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2801,6 +2801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                         if (page) {
>                                 __SetPageLocked(page);
>                                 __SetPageSwapBacked(page);
> +                               SetPageWorkingset(page);
>                                 set_page_private(page, entry.val);
>                                 lru_cache_add_anon(page);
>                                 swap_readpage(page, true);
> --
> 2.23.0.581.g78d2f28ef7-goog
>
