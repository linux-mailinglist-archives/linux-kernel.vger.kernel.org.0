Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABACD839E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfHFTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 15:53:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34996 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:53:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so18903932otq.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqsW5OxmHQog0ub+PR7AiYisz4NBU3NrkElZBQlr6Eg=;
        b=VV9Ppa9ubKevm1FzmVSanYWoYM0w7rLwWRQmH965qhyVf1qatFwRlusXKU/hTIjN/F
         IGToUS+l7tA+5npP8+46S8ldh8waArpKKeXjxGZU+wRX1VNMT5mlsXobnrk4Q2YVf4Nh
         axRqXmQ7WKuzDsjRxzbt4No6hSL7FTZTTLuX2Xt1B2jqW3czAGvb8xcvf/jlPpjgMWlQ
         vebcyyCW8t1ZXr0E1jPM/vjquO5UdIrsBzFiTlo8s3XwrDwxy/ywQSTgWL65/Tu1q03U
         pwfVuJS1FaZZIrMlUKIbHjF/TkZ6S0nQ5eI1C8MAYjQjRqV4FxZo7NCvMcm13Iqn0pnK
         Wvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqsW5OxmHQog0ub+PR7AiYisz4NBU3NrkElZBQlr6Eg=;
        b=NfFtBplAWIbWABBCQhpBB5as2LrHjGnwcrJbcsJFFo4no1kQWHCLLG9SR14Q3lis/w
         Dll/AHl/CiCJ249vpIxSe/wS3JTkzKKuJB7W2eORzWpHW9ra57y/Eqek0wWErxksuxGN
         z4aI1vIuVMbneV+RAdT8yR4JquZB4zfrgOMzgWLIz1yfN6m941yeu2PCulpiZCLOkZdo
         GmJQgQjZXTFFUMBViIOiPIfdijxaUmK52qsFyeerReApYEJSrSANjuk0V9OQapqxI4Fh
         WNNxkC/pFOfrHa/f3Exgh85ckfuwJRI26kj7ePAaKQo/fQsKlk72vjKEZL50rRtpkJea
         LpmQ==
X-Gm-Message-State: APjAAAVFSt9OhShEuXMW0hCIUrabsUKhyhjMOzzi3MfJwxzCe/MS6KlD
        7Q+z32dE/lCMhhjcFqtyu9z4BPoWIqQ4LLocZqg+Fg==
X-Google-Smtp-Source: APXvYqwwLAAeLEryd1T7Fj/e7qjG8GzcaLSq1KsTk2lQtSKu8Wn++OZ/kBVzpBstbZZetXSWgB410s/9UQ4SvZCq298=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr5424136ioe.86.1565121222227;
 Tue, 06 Aug 2019 12:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190802015332.229322-1-henryburns@google.com>
 <20190802015332.229322-2-henryburns@google.com> <20190805042821.GA102749@google.com>
 <CAGQXPTiHtNJsBz8dGCvejtmvGgPNHBoQHSmbX4XkxJ5DTmUWGg@mail.gmail.com> <20190806013846.GA71899@google.com>
In-Reply-To: <20190806013846.GA71899@google.com>
From:   Henry Burns <henryburns@google.com>
Date:   Tue, 6 Aug 2019 12:53:06 -0700
Message-ID: <CAGQXPThXpTwnV+VM2qSyJyRv9LzKhVStCE5SORWBrwddBr2OCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zsmalloc.c: Fix race condition in zs_destroy_pool
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, henrywolfeburns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I will lose access to this email in 3 days, so I've cc'd a
personal email.


On Mon, Aug 5, 2019 at 6:38 PM Minchan Kim <minchan@kernel.org> wrote:
> On Mon, Aug 05, 2019 at 10:34:41AM -0700, Henry Burns wrote:
> > On Sun, Aug 4, 2019 at 9:28 PM Minchan Kim <minchan@kernel.org> wrote:
> > > On Thu, Aug 01, 2019 at 06:53:32PM -0700, Henry Burns wrote:
> > > > In zs_destroy_pool() we call flush_work(&pool->free_work). However, we
> > > > have no guarantee that migration isn't happening in the background
> > > > at that time.
> > > >
> > > > Since migration can't directly free pages, it relies on free_work
> > > > being scheduled to free the pages.  But there's nothing preventing an
> > > > in-progress migrate from queuing the work *after*
> > > > zs_unregister_migration() has called flush_work().  Which would mean
> > > > pages still pointing at the inode when we free it.
> > >
> > > We already unregister shrinker so there is no upcoming async free call
> > > via shrinker so the only concern is zs_compact API direct call from
> > > the user. Is that what what you desribe from the description?
> >
> > What I am describing is a call to zsmalloc_aops->migratepage() by
> > kcompactd (which can call schedule work in either
> > zs_page_migrate() or zs_page_putback should the zspage become empty).
> >
> > While we are migrating a page, we remove it from the class. Suppose
> > zs_free() loses a race with migration. We would schedule
> > async_free_zspage() to handle freeing that zspage, however we have no
> > guarantee that migration has finished
> > by the time we finish flush_work(&pool->work). In that case we then
> > call iput(inode), and now we have a page
> > pointing to a non-existent inode. (At which point something like
> > kcompactd would potentially BUG() if it tries to get a page
> > (from the inode) that doesn't exist anymore)
> >
>
> True.
> I totally got mixed up internal migration and external migration. :-/
>
> >
> > >
> > > If so, can't we add a flag to indicate destroy of the pool and
> > > global counter to indicate how many of zs_compact was nested?
> > >
> > > So, zs_unregister_migration in zs_destroy_pool can set the flag to
> > > prevent upcoming zs_compact call and wait until the global counter
> > > will be zero. Once it's done, finally flush the work.
> > >
> > > My point is it's not a per-class granuarity but global.
> >
> > We could have a pool level counter of isolated pages, and wait for
> > that to finish before starting flush_work(&pool->work); However,
> > that would require an atomic_long in zs_pool, and we would have to eat
> > the cost of any contention over that lock. Still, it might be
> > preferable to a per-class granularity.
>
> That would be better for performance-wise but how it's significant?
> Migration is not already hot path so adding a atomic variable in that path
> wouldn't make noticible slow.
>
> Rather than performance, my worry is maintainance so prefer simple and
> not fragile.

It sounds to me like you are saying that the current approach is fine, does this
match up with your understanding?

>
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Since we know at destroy time all objects should be free, no new
> > > > migrations can come in (since zs_page_isolate() fails for fully-free
> > > > zspages).  This means it is sufficient to track a "# isolated zspages"
> > > > count by class, and have the destroy logic ensure all such pages have
> > > > drained before proceeding.  Keeping that state under the class
> > > > spinlock keeps the logic straightforward.
> > > >
> > > > Signed-off-by: Henry Burns <henryburns@google.com>
> > > > ---
> > > >  mm/zsmalloc.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 65 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > > index efa660a87787..1f16ed4d6a13 100644
> > > > --- a/mm/zsmalloc.c
> > > > +++ b/mm/zsmalloc.c
> > > > @@ -53,6 +53,7 @@
> > > >  #include <linux/zpool.h>
> > > >  #include <linux/mount.h>
> > > >  #include <linux/migrate.h>
> > > > +#include <linux/wait.h>
> > > >  #include <linux/pagemap.h>
> > > >  #include <linux/fs.h>
> > > >
> > > > @@ -206,6 +207,10 @@ struct size_class {
> > > >       int objs_per_zspage;
> > > >       /* Number of PAGE_SIZE sized pages to combine to form a 'zspage' */
> > > >       int pages_per_zspage;
> > > > +#ifdef CONFIG_COMPACTION
> > > > +     /* Number of zspages currently isolated by compaction */
> > > > +     int isolated;
> > > > +#endif
> > > >
> > > >       unsigned int index;
> > > >       struct zs_size_stat stats;
> > > > @@ -267,6 +272,8 @@ struct zs_pool {
> > > >  #ifdef CONFIG_COMPACTION
> > > >       struct inode *inode;
> > > >       struct work_struct free_work;
> > > > +     /* A workqueue for when migration races with async_free_zspage() */
> > > > +     struct wait_queue_head migration_wait;
> > > >  #endif
> > > >  };
> > > >
> > > > @@ -1917,6 +1924,21 @@ static void putback_zspage_deferred(struct zs_pool *pool,
> > > >
> > > >  }
> > > >
> > > > +static inline void zs_class_dec_isolated(struct zs_pool *pool,
> > > > +                                      struct size_class *class)
> > > > +{
> > > > +     assert_spin_locked(&class->lock);
> > > > +     VM_BUG_ON(class->isolated <= 0);
> > > > +     class->isolated--;
> > > > +     /*
> > > > +      * There's no possibility of racing, since wait_for_isolated_drain()
> > > > +      * checks the isolated count under &class->lock after enqueuing
> > > > +      * on migration_wait.
> > > > +      */
> > > > +     if (class->isolated == 0 && waitqueue_active(&pool->migration_wait))
> > > > +             wake_up_all(&pool->migration_wait);
> > > > +}
> > > > +
> > > >  static void replace_sub_page(struct size_class *class, struct zspage *zspage,
> > > >                               struct page *newpage, struct page *oldpage)
> > > >  {
> > > > @@ -1986,6 +2008,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
> > > >        */
> > > >       if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
> > > >               get_zspage_mapping(zspage, &class_idx, &fullness);
> > > > +             class->isolated++;
> > > >               remove_zspage(class, zspage, fullness);
> > > >       }
> > > >
> > > > @@ -2085,8 +2108,14 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
> > > >        * Page migration is done so let's putback isolated zspage to
> > > >        * the list if @page is final isolated subpage in the zspage.
> > > >        */
> > > > -     if (!is_zspage_isolated(zspage))
> > > > +     if (!is_zspage_isolated(zspage)) {
> > > > +             /*
> > > > +              * We still hold the class lock while all of this is happening,
> > > > +              * so we cannot race with zs_destroy_pool()
> > > > +              */
> > > >               putback_zspage_deferred(pool, class, zspage);
> > > > +             zs_class_dec_isolated(pool, class);
> > > > +     }
> > > >
> > > >       reset_page(page);
> > > >       put_page(page);
> > > > @@ -2131,9 +2160,11 @@ static void zs_page_putback(struct page *page)
> > > >
> > > >       spin_lock(&class->lock);
> > > >       dec_zspage_isolation(zspage);
> > > > -     if (!is_zspage_isolated(zspage))
> > > > -             putback_zspage_deferred(pool, class, zspage);
> > > >
> > > > +     if (!is_zspage_isolated(zspage)) {
> > > > +             putback_zspage_deferred(pool, class, zspage);
> > > > +             zs_class_dec_isolated(pool, class);
> > > > +     }
> > > >       spin_unlock(&class->lock);
> > > >  }
> > > >
> > > > @@ -2156,8 +2187,36 @@ static int zs_register_migration(struct zs_pool *pool)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static bool class_isolated_are_drained(struct size_class *class)
> > > > +{
> > > > +     bool ret;
> > > > +
> > > > +     spin_lock(&class->lock);
> > > > +     ret = class->isolated == 0;
> > > > +     spin_unlock(&class->lock);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +/* Function for resolving migration */
> > > > +static void wait_for_isolated_drain(struct zs_pool *pool)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     /*
> > > > +      * We're in the process of destroying the pool, so there are no
> > > > +      * active allocations. zs_page_isolate() fails for completely free
> > > > +      * zspages, so we need only wait for each size_class's isolated
> > > > +      * count to hit zero.
> > > > +      */
> > > > +     for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> > > > +             wait_event(pool->migration_wait,
> > > > +                        class_isolated_are_drained(pool->size_class[i]));
> > > > +     }
> > > > +}
> > > > +
> > > >  static void zs_unregister_migration(struct zs_pool *pool)
> > > >  {
> > > > +     wait_for_isolated_drain(pool); /* This can block */
> > > >       flush_work(&pool->free_work);
> > > >       iput(pool->inode);
> > > >  }
> > > > @@ -2401,6 +2460,8 @@ struct zs_pool *zs_create_pool(const char *name)
> > > >       if (!pool->name)
> > > >               goto err;
> > > >
> > > > +     init_waitqueue_head(&pool->migration_wait);
> > > > +
> > > >       if (create_cache(pool))
> > > >               goto err;
> > > >
> > > > @@ -2466,6 +2527,7 @@ struct zs_pool *zs_create_pool(const char *name)
> > > >               class->index = i;
> > > >               class->pages_per_zspage = pages_per_zspage;
> > > >               class->objs_per_zspage = objs_per_zspage;
> > > > +             class->isolated = 0;
> > > >               spin_lock_init(&class->lock);
> > > >               pool->size_class[i] = class;
> > > >               for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
> > > > --
> > > > 2.22.0.770.g0f2c4a37fd-goog
> > > >
