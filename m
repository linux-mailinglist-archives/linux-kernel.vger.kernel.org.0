Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078E8774CB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfGZXHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 19:07:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39334 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGZXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:07:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id z128so16736726yba.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrtRmk0oRnuWgbrd0YoseM/P5P8a271SeH+Gw2pTm2Y=;
        b=JRm10WCLRxh/551IVqtkLiXtX0KmaUMMzhAGaHZ8CHTo4OqCH9YulZg+eNaCbCFaF1
         vHRFjJO6MDfWaNaZZwaPqvQXUI1Mo/YoDwzlG67phmmya2ja/Xk0HJ08MV0+tZ77bDwU
         9RJzYEjTwEn5yB+01dszHApaV8BWH2CEwbBdnWAPnSlPOUV48oWhAZIYEncndioYLBod
         ndL/W9NkkiNTeZJSW8GnFZNdOrFvCY0uG7b3OqrGKUR5EOmrrwxcquwNi2zTGceGAMBu
         U2p4ZLJRoUXCQQUz3Hh6bOgWd9HI0SQwncXmupXj9UvnvPvIwT8418a8vFEdcsH0D3fs
         yVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrtRmk0oRnuWgbrd0YoseM/P5P8a271SeH+Gw2pTm2Y=;
        b=TYUX5ujhRfi3nq4AZLNzhOyM8FpwU5+98vaLTG7Z1wMn4fxLwqkl5wY8gIkMAGsJv7
         0tS/GPpiVZmEvyqKxhs7W1RXYLhCKwFOzID0CzQ18ABVdT5sE+BBwbhMHYSsF9uYCJAl
         zwWBWPKUgSksrddf3cKpMBr1lAANv1V5C8EET4GYgEtGLozWSu0J9C5SXnR24MErtuul
         nX48HFyCN6ZsqLpDWULbezk7fG4642DGHmmVkNuXFmVE6iLlqopfLM31Q/UW7sW+sRiA
         eN2br720AW0EEx93UAkkNcVjASKIfWia3VKPTMZ5Nm9VOHf1uLtKgPBEpUyDaoeYms21
         Qh5Q==
X-Gm-Message-State: APjAAAW+4JJwLeWM5/QDBlp90sIDSvzGgUEdtQU2Wyl6xo49m1Dllpv1
        O7vBYqgu3QO6A2UBlEn+UalvxSfEEAfdiDZzTqwvTg==
X-Google-Smtp-Source: APXvYqwEnA4QDIyzPUl/Tt7HDrIuWTWNbMk2HgzNOZ+r5XoUixWIxZY4BQOEKnf9hO0dtzJCFPBZeeB/6Q2L1SHNack=
X-Received: by 2002:a25:9903:: with SMTP id z3mr59762121ybn.293.1564182438043;
 Fri, 26 Jul 2019 16:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com> <20190726224810.79660-2-henryburns@google.com>
In-Reply-To: <20190726224810.79660-2-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Jul 2019 16:07:07 -0700
Message-ID: <CALvZod4QoBsKKg3Ld0Sc5DtQdmjPPJb_tH_yh-N53b3AgSOMrA@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() race condition
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Adams <jwadams@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:48 PM Henry Burns <henryburns@google.com> wrote:
>
> The constraint from the zpool use of z3fold_destroy_pool() is there are no
> outstanding handles to memory (so no active allocations), but it is possible
> for there to be outstanding work on either of the two wqs in the pool.
>
> Calling z3fold_deregister_migration() before the workqueues are drained
> means that there can be allocated pages referencing a freed inode,
> causing any thread in compaction to be able to trip over the bad
> pointer in PageMovable().
>
> Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: <stable@vger.kernel.org>
> ---
>  mm/z3fold.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 43de92f52961..ed19d98c9dcd 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -817,16 +817,19 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
>  static void z3fold_destroy_pool(struct z3fold_pool *pool)
>  {
>         kmem_cache_destroy(pool->c_handle);
> -       z3fold_unregister_migration(pool);
>
>         /*
>          * We need to destroy pool->compact_wq before pool->release_wq,
>          * as any pending work on pool->compact_wq will call
>          * queue_work(pool->release_wq, &pool->work).
> +        *
> +        * There are still outstanding pages until both workqueues are drained,
> +        * so we cannot unregister migration until then.
>          */
>
>         destroy_workqueue(pool->compact_wq);
>         destroy_workqueue(pool->release_wq);
> +       z3fold_unregister_migration(pool);
>         kfree(pool);
>  }
>
> --
> 2.22.0.709.g102302147b-goog
>
