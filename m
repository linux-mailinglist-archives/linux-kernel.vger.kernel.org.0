Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3A159B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 22:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBKVfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 16:35:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42765 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBKVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:35:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so11691014otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPD9BpDVwDUxM6Ip8EFlRULrgnjEP3aNdZIbOVFnMe0=;
        b=B36DxbZZRwo0TP4rDikBCgdf0HltQGxfonCU0xN5pDZFDZm/IDCxFJLUu9RD4TJKjC
         wXrxZ5GyC2AWBXmn87iB/TGJXJGGw/+YS4H5kRamVkLauyNnlgJ4ioKGHrocGiWjFhUo
         MTaip7Vg7uEqbQi/ZBe8/pZgqKxATTSSJZ4D58a+AAvNtm0ZGHUwtkEYQlfFqAcnsgmi
         qW2YpT1kG7XMDLPTauVsDkdRXFdNQd7izC6dJjaiv4QZcFjH4igk5gTy8LX24VHUCZOe
         4pBCo9vJhQ/y3yhG9LcVjX0JcApXUBZMpckrwjYDzMwxpe8KWH4cy8wcGeKWD4fgi1Je
         PbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPD9BpDVwDUxM6Ip8EFlRULrgnjEP3aNdZIbOVFnMe0=;
        b=S5jaLlcqxJWBq3UbPHPTnszjEFur21O6fDJfB3P+3ylff1Kp+zunH1Z0GdNnJlmiRU
         uwCzjNlGf6/ppgiwzwVZZgwMU3+rfVsOzJ0SwqFWJ8r5J0be90G7bD0OVICE58dvFGP4
         uaWkHT1oB9pS9on1K90nEAikM1vVHrmI4uyl5PhLe74eDzuXlT7aa85xTcfyduPns87G
         j7hdFuYmIQ19QaEGr9s2l2TS3+BpkdIM5zZSgrtkaYaNSw2az26e8GalMN6Ef16k0tHH
         z1whoMY8XVLgGp6CjoybHQ3CZNwHxepsM1epfK2omCAD/fNLJ7dSOJpZ5mC6P4Ab9YMY
         e4LA==
X-Gm-Message-State: APjAAAX3oxzi9jltR4iGnXmf8fC1mAzNGBgPtB+3zpiKjLoa/kBvGBV0
        dQ8E3VzJtXfQ3OxXmgUDYEJoemdt8+l/NujPcwUYcQ==
X-Google-Smtp-Source: APXvYqySdzbnrv+gR5SkneeztGn1ucffOgBcWtCYQKZBmEqr59hxm0NevVeUFsu2lvl70k/1QsEa/2LYduVqhkRnevo=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr6850754otb.33.1581456917229;
 Tue, 11 Feb 2020 13:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-6-almasrymina@google.com> <6cc406e7-757f-4922-ffc0-681df3ee0d18@oracle.com>
In-Reply-To: <6cc406e7-757f-4922-ffc0-681df3ee0d18@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 11 Feb 2020 13:35:06 -0800
Message-ID: <CAHS8izMGreJgOhG8ivE2OH9bq98BmvxAqtBc=M9waTqOKv3eeQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] hugetlb_cgroup: support noreserve mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 2:31 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/3/20 3:22 PM, Mina Almasry wrote:
> > Support MAP_NORESERVE accounting as part of the new counter.
> >
> > For each hugepage allocation, at allocation time we check if there is
> > a reservation for this allocation or not. If there is a reservation for
> > this allocation, then this allocation was charged at reservation time,
> > and we don't re-account it. If there is no reserevation for this
> > allocation, we charge the appropriate hugetlb_cgroup.
> >
> > The hugetlb_cgroup to uncharge for this allocation is stored in
> > page[3].private. We use new APIs added in an earlier patch to set this
> > pointer.
>
> Ah!  That reminded me to look at the migration code.  Turns out that none
> of the existing cgroup information (page[2]) is being migrated today.  That
> is a bug. :(  I'll confirm and fix in a patch separate from this series.
> We will need to make sure that new information added by this series in page[3]
> is also migrated.  That would be in an earlier patch where the use of the
> field is introduced.
>
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v10:
> > - Refactored deferred_reserve check.
> >
> > ---
> >  mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 33818ccaf7e89..ec0b55ea1506e 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1339,6 +1339,9 @@ static void __free_huge_page(struct page *page)
> >       clear_page_huge_active(page);
> >       hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
> >                                    page, false);
> > +     hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
> > +                                  page, true);
> > +
>
> When looking at the code without change markings, the two above lines
> look so similar my first thought is there must be a mistake.
>
> A suggestion for better code readability:
> - hugetlb_cgroup_uncharge_page could just take "struct hstate *h" and
>   get both hstate_index(h) and pages_per_huge_page(h).
> - Perhaps make hugetlb_cgroup_uncharge_page and
>   hugetlb_cgroup_uncharge_page_rsvd be wrappers around a common routine.
>   Then the above would look like:
>
>   hugetlb_cgroup_uncharge_page(h, page);
>   hugetlb_cgroup_uncharge_page_rsvd(h, page);
>

I did modify the interfaces to this, as it's much better for
readability indeed. Unfortunately the patch the adds interfaces
probably needs a re-review now as it's changed quite a bit, I did not
carry your or David's Reviewed-by.

>
> >       if (restore_reserve)
> >               h->resv_huge_pages++;
> >
> > @@ -2172,6 +2175,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> >       long gbl_chg;
> >       int ret, idx;
> >       struct hugetlb_cgroup *h_cg;
> > +     bool deferred_reserve;
> >
> >       idx = hstate_index(h);
> >       /*
> > @@ -2209,10 +2213,20 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> >                       gbl_chg = 1;
> >       }
> >
> > +     /* If this allocation is not consuming a reservation, charge it now.
> > +      */
> > +     deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
> > +     if (deferred_reserve) {
> > +             ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
> > +                                                &h_cg, true);
> > +             if (ret)
> > +                     goto out_subpool_put;
> > +     }
> > +
> >       ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
> >                                          false);
>
> Hmmm?  I'm starting to like the wrapper idea more as a way to help with
> readability of the bool rsvd argument.
>
> hugetlb_cgroup_charge_cgroup_rsvd()
> hugetlb_cgroup_charge_cgroup()
>
> At least to me it makes it easier to read.
> --
> Mike Kravetz
>
> >       if (ret)
> > -             goto out_subpool_put;
> > +             goto out_uncharge_cgroup_reservation;
> >
> >       spin_lock(&hugetlb_lock);
> >       /*
> > @@ -2236,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> >       }
> >       hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
> >                                    false);
> > +     /* If allocation is not consuming a reservation, also store the
> > +      * hugetlb_cgroup pointer on the page.
> > +      */
> > +     if (deferred_reserve) {
> > +             hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
> > +                                          page, true);
> > +     }
> > +
> >       spin_unlock(&hugetlb_lock);
> >
> >       set_page_private(page, (unsigned long)spool);
> > @@ -2261,6 +2283,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> >  out_uncharge_cgroup:
> >       hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
> >                                      false);
> > +out_uncharge_cgroup_reservation:
> > +     if (deferred_reserve)
> > +             hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
> > +                                            h_cg, true);
> >  out_subpool_put:
> >       if (map_chg || avoid_reserve)
> >               hugepage_subpool_put_pages(spool, 1);
> > --
> > 2.25.0.341.g760bfbb309-goog
