Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A164E20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 23:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGJVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 17:51:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40888 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:51:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so1706872pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4raB3IqyErqkg+JW+87rFy9oaXPi9i1d2UYtDB+hVu8=;
        b=pMiktFKkY/frqdyoQe7sXxn6LL1Cu1eJU2aCdvxnAIjKEfBMVT2/a7GBTubBVbfWa+
         VrkYciVMRwRGNBsyxWRacUlQbz9KrF+YgOEQ71hxJjkKxT2GbmMOnuU6hw3Edpz1rbCX
         TVaEQ4RgH61os6AyO9go6PMGvQHfA26T17tshvtfCu+Y4EWNOD1RFFj6LJF3db0kSaGw
         8Y52qRyryah4clumr06EeeGgyEUDxNrK5Yj8CqCVoefgScQMSh511m0RPf+Ki7n+w5rf
         lcuyhHFh80YdhFGhsoBdDpij2xLcvg2j6MpWyUseC13csarlkuF/J5ijYVFflfpMRiG4
         GUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4raB3IqyErqkg+JW+87rFy9oaXPi9i1d2UYtDB+hVu8=;
        b=Ni6Tc8tINniwWOc/oSkF43orDneHCXZi0yzwvsmR2Ftle+QyqUY19DQyfA6cPb9kts
         zC3RhXOSCV+RiNTzdjKwKMTKiWzlE6zLDHqElmaWiMuNhkmkWYgAMDK90kz212SgnzaP
         dtpmaghLFfNRJtgttoRLnLDsSRvVPw7g3VvhB0LQ/TRZhzVhvDKogv8HCKJyNaIOKrzB
         2CqLFgTgSASU3b9OkUQYYf7D3wtJ2E9CZJF/VsHkmV5Vl1rpn0nuuNdTt/DEwBA72ZIy
         RILaKLvxTU72ZQgCX/3oL+qgxZSKKH7G8KDekTmZ4ZxnwZtRig4TzJ3Esd3wRyOtsg5Z
         0D0w==
X-Gm-Message-State: APjAAAURESH2dRC/xUQIYp2dFa/D3HeX5fz8lBJvz6nEVTgvk0zdHLLe
        XDAEI/0jNPV0HjN8RXcLQttMZBU/Z0iYo3nIJuUckA==
X-Google-Smtp-Source: APXvYqzpotPnFgfn8F3Q6TpCTjeRegyu0pJeMseHXkiht1BvBEBtrWB5K160JbdnR1FiaSX66t4gclal9uiAjRoVwZs=
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr620824pjb.138.1562795512264;
 Wed, 10 Jul 2019 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190710213238.91835-1-henryburns@google.com> <CALvZod7kMX5Xika8nqywyXHuBKqTfSPP7uZ1-OU2M4kmHLiuUw@mail.gmail.com>
In-Reply-To: <CALvZod7kMX5Xika8nqywyXHuBKqTfSPP7uZ1-OU2M4kmHLiuUw@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Wed, 10 Jul 2019 14:51:16 -0700
Message-ID: <CAGQXPTip1aMtChuKAYtYOti1QcZQOz4=Jy0w9O478KTMoT1c0A@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: remove z3fold_migration trylock
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Jonathan Adams <jwadams@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > z3fold_page_migrate() will never succeed because it attempts to acquire a
> > lock that has already been taken by migrate.c in __unmap_and_move().
> >
> > __unmap_and_move() migrate.c
> >   trylock_page(oldpage)
> >   move_to_new_page(oldpage_newpage)
> >     a_ops->migrate_page(oldpage, newpage)
> >       z3fold_page_migrate(oldpage, newpage)
> >         trylock_page(oldpage)
> >
> >
> > Signed-off-by: Henry Burns <henryburns@google.com>
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Please add the Fixes tag as well.
Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
>
> > ---
> >  mm/z3fold.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 985732c8b025..9fe9330ab8ae 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -1335,16 +1335,11 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
> >         zhdr = page_address(page);
> >         pool = zhdr_to_pool(zhdr);
> >
> > -       if (!trylock_page(page))
> > -               return -EAGAIN;
> > -
> >         if (!z3fold_page_trylock(zhdr)) {
> > -               unlock_page(page);
> >                 return -EAGAIN;
> >         }
> >         if (zhdr->mapped_count != 0) {
> >                 z3fold_page_unlock(zhdr);
> > -               unlock_page(page);
> >                 return -EBUSY;
> >         }
> >         new_zhdr = page_address(newpage);
> > @@ -1376,7 +1371,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
> >         queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
> >
> >         page_mapcount_reset(page);
> > -       unlock_page(page);
> >         put_page(page);
> >         return 0;
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
