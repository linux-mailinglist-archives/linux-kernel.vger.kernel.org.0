Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD915206E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 19:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBDS0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 13:26:43 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41236 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBDS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:26:43 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so16718240ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXW19wXJC3hVKT8Q66ZK6uUNSfw5Qexl8aHI+Ttvtxs=;
        b=WHBqARzUWFjo+MMe3akW5up70rA/ST5BWP8DO296nQBjZJ4mNrYdyCelzTgqa3aDt1
         pUmZOE5j+5GS7tEjY22hT/hcjlyEI/hBQgEMbEX9bUDk+/TU68QF8NQky2ZwkjT3ouio
         kEREvuPj90Q9fkwac5nGf/66rjfMk0ANG1/jPZeIOaccvYa6k6SkfRJYD5Jro35nOB21
         CtR2qo1S5SudrdMHwsvJXklMjL34qvYuvfSZC9Ry1cGLb/QWeJhuJq6kzgugG7sMLhEC
         vdZyg2mcdBnYCsc5O7qDg53GB0OT9qIN44HTAefcAaSzCBYikoEu/pL0UnDZVEIh23g4
         vPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXW19wXJC3hVKT8Q66ZK6uUNSfw5Qexl8aHI+Ttvtxs=;
        b=DEriGf7Oh6oDm6wn4uskC8hY2mPBz9TOXgY0zhrSA9VsmQxcMsM4zRkChec7eqIiGd
         K8bh5MR/kqVhOxXH2pNWlJeLxZa9wf1cOm4EUsTc+sfrIdita41xHD52bjxk9r6DLq4o
         r+tPN8xrkqQEJEoVpYrDbh7Lw8PTsngAoYJ2FZ2XiUJwPQRYayS3/ZpQ06k5MKX2epVL
         Wy+yJds8qxMBbHAwGVZC4kCJSTJ6eGJsA71zlwoN9Pdax2HDWMkSXt8dJMMso+otkHc/
         Qv3QCVow1o43W1/N6xKtvdAKZk/AVfstZMfJj4/xn+O5CgMytqW/IySauNdbl23rwdts
         r8xA==
X-Gm-Message-State: APjAAAVl0aVs2tF03878/ubsOs+fLuR1tnSPlt2mvbDd2TpOmwiV9GSi
        Pdx5TBNBvLkzURqG4q4S/QBHp6KD4mZE+oDsZHksqA==
X-Google-Smtp-Source: APXvYqyWlZJUlxQ2VY87YbQcTXag2pqAuJZii8aCl5eXc/BIwIavBIBZoHQXyGZml0g66L+XiREwrBzGWy5ET7lYbYQ=
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr28041600ilj.56.1580840801910;
 Tue, 04 Feb 2020 10:26:41 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
 <20200203205950.127629-1-sqazi@google.com> <20200204092004.GB19922@ming.t460p>
In-Reply-To: <20200204092004.GB19922@ming.t460p>
From:   Salman Qazi <sqazi@google.com>
Date:   Tue, 4 Feb 2020 10:26:29 -0800
Message-ID: <CAKUOC8Xvxa8nixstFOdjuf7_sCZNV6EqSDxTAQZjLhvf86LESA@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 1:20 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Feb 03, 2020 at 12:59:50PM -0800, Salman Qazi wrote:
> > We observed that it is possible for a flush to bypass the I/O
> > scheduler and get added to hctx->dispatch in blk_mq_sched_bypass_insert.
>
> We always bypass io scheduler for flush request.
>
> > This can happen while a kworker is running blk_mq_do_dispatch_sched call
> > in blk_mq_sched_dispatch_requests.
> >
> > However, the blk_mq_do_dispatch_sched call doesn't end in bounded time.
> > As a result, the flush can sit there indefinitely, as the I/O scheduler
> > feeds an arbitrary number of requests to the hardware.
>
> blk-mq supposes to handle requests in hctx->dispatch with higher
> priority, see blk_mq_sched_dispatch_requests().
>
> However, there is single hctx->run_work, so async run queue for dispatching
> flush request can only be run until another async run queue from scheduler
> is done.
>
> >
> > The solution is to periodically poll hctx->dispatch in
> > blk_mq_do_dispatch_sched, to put a bound on the latency of the commands
> > sitting there.
> >
> > Signed-off-by: Salman Qazi <sqazi@google.com>
> > ---
> >  block/blk-mq-sched.c   |  6 ++++++
> >  block/blk-mq.c         |  4 ++++
> >  block/blk-sysfs.c      | 33 +++++++++++++++++++++++++++++++++
> >  include/linux/blkdev.h |  2 ++
> >  4 files changed, 45 insertions(+)
> >
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index ca22afd47b3d..75cdec64b9c7 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -90,6 +90,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >       struct request_queue *q = hctx->queue;
> >       struct elevator_queue *e = q->elevator;
> >       LIST_HEAD(rq_list);
> > +     int count = 0;
> >
> >       do {
> >               struct request *rq;
> > @@ -97,6 +98,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> >                       break;
> >
> > +             if (count > 0 && count % q->max_sched_batch == 0 &&
> > +                 !list_empty_careful(&hctx->dispatch))
> > +                     break;
>
> q->max_sched_batch may not be needed, and it is reasonable to always
> disaptch requests in hctx->dispatch first.
>
> Also such trick is missed in dispatch from sw queue.

I will update the commit message, drop max_sched_batch and just turn
it into a simple check and add the same
thing to the dispatch from the sw queue.

>
>
> Thanks,
> Ming
>
