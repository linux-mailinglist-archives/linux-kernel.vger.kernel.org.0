Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BEB36502
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFET4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 15:56:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36768 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:56:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id t126so814963ywf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9q4+At4yxP0TO9XKtv623886ZmeIrCw2KxtQ8rIVE+c=;
        b=ONPOG0criwRaERkMrKHfVu+FHkSVoaWJAe/3Qcz/W7LCrH5/GIScT4HA/6GrL0+9r8
         o6co8aqwlNSEl7NCQ5sS9tePoeHt4h9GPb68IhajREN/xrsWKcvK3qyMit8mTn0Syc/A
         7iA0JHtcd+FIK9ODp7RhnjbF13bEpwhQGYCei3mrBE/QI6K5gsvChkA/hORMbZ9/NFwj
         fOz5k6FisPTLo3cnO2KlMHYBKGSLayATbBhmtiVl0hlN7FVFEeyjwZxp9QJDFViYJ9Fr
         /8tGYfzZZKKv+lqP9TGaDdXxFpWTov0D05vVZG6KZ2JgmhFAjsoiImnW6hbJ2aiQ0DFz
         doOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9q4+At4yxP0TO9XKtv623886ZmeIrCw2KxtQ8rIVE+c=;
        b=gG6+UG7MhEuhOdyvlZsWr9KeajwfJNx31hztEbaBvJ7hsP92CePFjbY5eGKeHwhDaI
         Op46ttdhHSoiNPtLypdFYLQ+LEQ4o7oje088hIadxjVQscz3224iVGy5x/tm9+5ocyfc
         9jfZqRfc26lo3sVgM60wZV2ZUxcOmdoqhFfDaIawfvuCaFM7q3ftvz0VRlY7USX5bt7V
         Kc8dJZ++OkoiTeMZNUy5Kkjduv2DG7qihhuupc+Q50BmJKLCFFdiG19ukGuCKWfTmBiC
         11LCHOGA5zunj4PxvM3o8HaKMfHE4rVkm1wl0N0l4RWXvQMPguwOq2FnQithVX/e9PPB
         MfWg==
X-Gm-Message-State: APjAAAUL6ZOCNMhkUqcmfUpfDjDo/374pvLn2XsyiG+xap4his978FOa
        1fSPG1fIXUqTSvhGdsmlibb58tIW55+YgtXmdwVX0g==
X-Google-Smtp-Source: APXvYqyT6u3oJyZE6NCw9GM4C6IEV7j7fkZPEOKpEM78DGOX/BwgTrn0eHFIXgvbs4TMZ9Ae/bo4AwJhPu/gx1keGo4=
X-Received: by 2002:a81:a6d5:: with SMTP id d204mr22361086ywh.205.1559764607325;
 Wed, 05 Jun 2019 12:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
In-Reply-To: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 Jun 2019 12:56:36 -0700
Message-ID: <CALvZod7Ya=mPKryiCxKVguGV-hPEjXD_6gBOFs9zJWc_NQMMBQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] zpool: Add malloc_support_movable to zpool_driver
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com,
        Seth Jennings <sjenning@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 3:06 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> As a zpool_driver, zsmalloc can allocate movable memory because it
> support migate pages.
> But zbud and z3fold cannot allocate movable memory.
>
> This commit adds malloc_support_movable to zpool_driver.
> If a zpool_driver support allocate movable memory, set it to true.
> And add zpool_malloc_support_movable check malloc_support_movable
> to make sure if a zpool support allocate movable memory.
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

IMHO no need to block this series on z3fold query.

> ---
>  include/linux/zpool.h |  3 +++
>  mm/zpool.c            | 16 ++++++++++++++++
>  mm/zsmalloc.c         | 19 ++++++++++---------
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 7238865e75b0..51bf43076165 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -46,6 +46,8 @@ const char *zpool_get_type(struct zpool *pool);
>
>  void zpool_destroy_pool(struct zpool *pool);
>
> +bool zpool_malloc_support_movable(struct zpool *pool);
> +
>  int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
>                         unsigned long *handle);
>
> @@ -90,6 +92,7 @@ struct zpool_driver {
>                         struct zpool *zpool);
>         void (*destroy)(void *pool);
>
> +       bool malloc_support_movable;
>         int (*malloc)(void *pool, size_t size, gfp_t gfp,
>                                 unsigned long *handle);
>         void (*free)(void *pool, unsigned long handle);
> diff --git a/mm/zpool.c b/mm/zpool.c
> index a2dd9107857d..863669212070 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -238,6 +238,22 @@ const char *zpool_get_type(struct zpool *zpool)
>         return zpool->driver->type;
>  }
>
> +/**
> + * zpool_malloc_support_movable() - Check if the zpool support
> + * allocate movable memory
> + * @zpool:     The zpool to check
> + *
> + * This returns if the zpool support allocate movable memory.
> + *
> + * Implementations must guarantee this to be thread-safe.
> + *
> + * Returns: true if if the zpool support allocate movable memory, false if not
> + */
> +bool zpool_malloc_support_movable(struct zpool *zpool)
> +{
> +       return zpool->driver->malloc_support_movable;
> +}
> +
>  /**
>   * zpool_malloc() - Allocate memory
>   * @zpool:     The zpool to allocate from.
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 0787d33b80d8..8f3d9a4d46f4 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -437,15 +437,16 @@ static u64 zs_zpool_total_size(void *pool)
>  }
>
>  static struct zpool_driver zs_zpool_driver = {
> -       .type =         "zsmalloc",
> -       .owner =        THIS_MODULE,
> -       .create =       zs_zpool_create,
> -       .destroy =      zs_zpool_destroy,
> -       .malloc =       zs_zpool_malloc,
> -       .free =         zs_zpool_free,
> -       .map =          zs_zpool_map,
> -       .unmap =        zs_zpool_unmap,
> -       .total_size =   zs_zpool_total_size,
> +       .type =                   "zsmalloc",
> +       .owner =                  THIS_MODULE,
> +       .create =                 zs_zpool_create,
> +       .destroy =                zs_zpool_destroy,
> +       .malloc_support_movable = true,
> +       .malloc =                 zs_zpool_malloc,
> +       .free =                   zs_zpool_free,
> +       .map =                    zs_zpool_map,
> +       .unmap =                  zs_zpool_unmap,
> +       .total_size =             zs_zpool_total_size,
>  };
>
>  MODULE_ALIAS("zpool-zsmalloc");
> --
> 2.21.0 (Apple Git-120)
>
