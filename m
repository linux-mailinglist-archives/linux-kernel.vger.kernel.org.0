Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5981C155E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 13:45:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32787 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:45:25 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so656152ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv1kvEcWkzcNvNPqv64VfZraoKRdXQxBTXoh9bslLzQ=;
        b=Yq3BqGLv9D7m0CRiQahwggqXEm7STfDWVMLYIDKxdzLlpIMkFGG1P/WrnRBslzBAJ6
         WeroT6qPoJWwh5T9AvKYDnEvpa97qeNpqDwC/ItOsc846qDyR6A8tUELeiqZI1gROvyC
         wZO55uuYYT6ie4TXyY/VjnRC/6K0fd+wBEdTVg6vSyZ0245naO9XBsGILb+SaAgDuKZs
         mpGU8p0OAu7xPosBeUbIe3T4myXaH++Gk+3mH+L1HrWdBEX2noZZWBXEH4lbYBr2Chg1
         DXu5hQG8KqgR2zJLkGEhw89CT3XGfw4C5NtgGc4s8qmdahja6x/NM9z+z78h9Iiw6F4r
         dpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv1kvEcWkzcNvNPqv64VfZraoKRdXQxBTXoh9bslLzQ=;
        b=q+pXdl3cCdHauI7ZlHehTQtZ+KRFklWV5AZUs7qMj3uq3ZeouZnI1+qt3F7RDxOco+
         RGsgKEV3yXrqcOhtPs3whXe5k5UFQBwUUGPFGgnrh6crHJOrGHwEsCqEfNPgve2pK7YU
         tUMWyY1XfofNT9kuXrnzISkZiBIY364bZ8CoDabD7XPr1TuTJghTAiQnBweXzJCDetfQ
         tcASTBQaddF4dG7uYhSN6oZPgxT9LMiAVvKhEI9e8oHrsysBqVlVid3WkUpauL+JJgRj
         AfTX7TZmYjiZJwY+6f3/Q4bJUuJBmb06ozF4BQkYzfOA4MtWlW1WcVyxHzt2vz1Ol1hv
         cZFA==
X-Gm-Message-State: APjAAAXhtnM7LyBmBkzUPksu92wjgmG2jmR+OLf7syOl6/ZMblAWTeAP
        5q2z6sqKfOLYjpZyqbx3lFKGMlMqB5vIaFTGPz082w==
X-Google-Smtp-Source: APXvYqygZ0ibySu8hVzqQaib2EPPXlBM0zvGZ6nI7HuYV1xfw/4eVle9rNlFoNDR8s+8b+s1WmGkYpD6ug5SQ3fb038=
X-Received: by 2002:a5d:9285:: with SMTP id s5mr618138iom.85.1581101124081;
 Fri, 07 Feb 2020 10:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
In-Reply-To: <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
From:   Salman Qazi <sqazi@google.com>
Date:   Fri, 7 Feb 2020 10:45:12 -0800
Message-ID: <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 7:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-06 13:12, Salman Qazi wrote:
> > + *
> > + * Returns true if hctx->dispatch was found non-empty and
> > + * run_work has to be run again.
>
> Please elaborate this comment and explain why this is necessary (to
> avoid that flush processing is postponed forever).
>
> > + * Returns true if hctx->dispatch was found non-empty and
> > + * run_work has to be run again.
>
> Same comment here.

Will do.

>
> > +again:
> > +     run_again = false;
> > +
> >       /*
> >        * If we have previous entries on our dispatch list, grab them first for
> >        * more fair dispatch.
> > @@ -208,19 +234,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >               blk_mq_sched_mark_restart_hctx(hctx);
> >               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> >                       if (has_sched_dispatch)
> > -                             blk_mq_do_dispatch_sched(hctx);
> > +                             run_again = blk_mq_do_dispatch_sched(hctx);
> >                       else
> > -                             blk_mq_do_dispatch_ctx(hctx);
> > +                             run_again = blk_mq_do_dispatch_ctx(hctx);
> >               }
> >       } else if (has_sched_dispatch) {
> > -             blk_mq_do_dispatch_sched(hctx);
> > +             run_again = blk_mq_do_dispatch_sched(hctx);
> >       } else if (hctx->dispatch_busy) {
> >               /* dequeue request one by one from sw queue if queue is busy */
> > -             blk_mq_do_dispatch_ctx(hctx);
> > +             run_again = blk_mq_do_dispatch_ctx(hctx);
> >       } else {
> >               blk_mq_flush_busy_ctxs(hctx, &rq_list);
> >               blk_mq_dispatch_rq_list(q, &rq_list, false);
> >       }
> > +
> > +     if (run_again) {
> > +             if (!restarted) {
> > +                     restarted = true;
> > +                     goto again;
> > +             }
> > +
> > +             blk_mq_run_hw_queue(hctx, true);
> > +     }
>
> So this patch changes blk_mq_sched_dispatch_requests() such that it
> iterates at most two times? How about implementing that loop with an
> explicit for-loop? I think that will make
> blk_mq_sched_dispatch_requests() easier to read. As you may know forward
> goto's are accepted in kernel code but backward goto's are frowned upon.
>

About the goto, I don't know if backwards gotos in general are frowned
upon.  There are plenty of examples
in the kernel source.  This particular label, 'again' for instance:

$ grep -r again: mm/|wc -l
22
$ grep -r again: block/|wc -l
4

But, just because others have done it doesn't mean I should.  So, I
will attempt to explain why I think this is a good idea.
If I were to write this as a for-loop, it will look like this:

for (i = 0; i == 0 || (run_again && i < 2); i++) {
/* another level of 8 character wide indentation */
    run_again = false;
   /* a bunch of code that possibly sets run_again to true
}

if (run_again)
    blk_mq_run_hw_queue(hctx, true);

[Another alternative is to set run_again to true, and simplify the for-loop
condition to run_again && i < 2.  But, again, lots of verbiage and a boolean
in the for-loop condition.]

The for-loop is far from idiomatic.  It's not clear what it does when
you first look at it.
It distracts from the common path of the code, which is something that
almost always
runs exactly once.  There is now an additional level of indentation.
The readers of the
code aren't any better off, because they still have to figure out what
run_again is and if
they care about it.  And the only way to do that is to read the entire
body of the loop, and
comments at the top of the functions.

The goto in this case preserves the intent of the code better.  It is
dealing with an exceptional
and unusual case.  Indeed this kind of use is not unusual in the
kernel, for instance to deal
with possible but unlikely races.

Just my $0.02.

> Thanks,
>
> Bart.
