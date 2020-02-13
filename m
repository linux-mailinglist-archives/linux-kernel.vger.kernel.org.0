Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7A15CB15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 20:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgBMTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 14:21:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32976 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgBMTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:21:49 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so7817523ioh.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 11:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QOUSXFhncnCv9tdGLgXn7t709p+c+vsJCaqhbGCgQg=;
        b=pS/rA/XQrsxzALgzkkxUeROv/A+yx7tTwuLt9niMsfB6HwrxJMIlP3S2/4cJAI9Xxl
         FEwPSATlEOu0eg2zmBQmE+QLH8NFhPJGMSP43gExdI76wnbvkqAkqVwfXFs/8+X4+ZMP
         j9OHRJjNJPJf6srEwtDgNRoYZ2sM5AlxJ9JauV7+SkprHS0iAq04hzVRoYEkME95AMaA
         KWBQrY3h2AZsrbxjz6W33oBVnW+96Q/3aKr5x/uyP6f08CkG52DwaC/wKWy8OelXOhHG
         enBS8ih7VJX0/gHzC7y/6ktnVbeRNBA9p+kQy0prGSEVEFxHEx/6PeJiN5Xz0VnbYNg5
         CaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QOUSXFhncnCv9tdGLgXn7t709p+c+vsJCaqhbGCgQg=;
        b=Kpsi3XwwPZvxMcfsjsCtndk6H9DQxpBSOH4y4kUUm+XlrB+cc9oIducXu7xoBq2lB9
         so05zoo550BllKEztQfz0y/yuYgNsFM5qFNv4ah/1Dj/NdyauSv/m4Vkw4xFem8OOb9e
         iWqq8qNTGgVM1u1INMQiA+VhxA8kWSyR8OQKykZ3XK1D9fe857O6waOjcpEgdK7mvV96
         6UuBBPoh3x1OiM6Fyul/MEVrPKWT8KWum49W6Wdc6RXvqPzQPIz93zEn4a0BZnQ3Lyd9
         HZmWCpxMqdHFiZtCIzIkBDhL0NMjySVTKX8amWUBc3NVshlMkclGfgihQcg6pvwkKQxr
         OG3Q==
X-Gm-Message-State: APjAAAWNGOrC/IEJvsYIZ/d+nuN15JPicc5irMRlsFZqpJQDrEm8OuUB
        INNUpwyxmvMWIfUDXEqU0/6GTdNAGdX2Q4HxbbaJ5Q==
X-Google-Smtp-Source: APXvYqwbrJIHiF6yo1n6cPB8dSDhRLQlDy6lDN6DDMGk6NwCczSxpnrZielmwNpETh3CvySMVqQQMDSUdbfC5OaU1zc=
X-Received: by 2002:a5d:8c84:: with SMTP id g4mr23458168ion.289.1581621708984;
 Thu, 13 Feb 2020 11:21:48 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
In-Reply-To: <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 13 Feb 2020 11:21:37 -0800
Message-ID: <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 9:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/13/20 12:26 AM, Ming Lei wrote:
> > The approach used in blk_execute_rq() can be borrowed for workaround the
> > issue, such as:
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 94d697217887..c9ce19a86de7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/cgroup.h>
> >   #include <linux/blk-cgroup.h>
> >   #include <linux/highmem.h>
> > +#include <linux/sched/sysctl.h>
> >
> >   #include <trace/events/block.h>
> >   #include "blk.h"
> > @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
> >   int submit_bio_wait(struct bio *bio)
> >   {
> >       DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> > +     unsigned long hang_check;
> >
> >       bio->bi_private = &done;
> >       bio->bi_end_io = submit_bio_wait_endio;
> >       bio->bi_opf |= REQ_SYNC;
> >       submit_bio(bio);
> > -     wait_for_completion_io(&done);
> > +
> > +     /* Prevent hang_check timer from firing at us during very long I/O */
> > +     hang_check = sysctl_hung_task_timeout_secs;
> > +     if (hang_check)
> > +             while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> > +     else
> > +             wait_for_completion_io(&done);
> >
> >       return blk_status_to_errno(bio->bi_status);
> >   }
>
> Instead of suppressing the hung task complaints, has it been considered
> to use the bio splitting mechanism to make discard bios smaller? Block
> drivers may set a limit by calling blk_queue_max_discard_segments().
>  From block/blk-settings.c:
>
> /**
>   * blk_queue_max_discard_segments - set max segments for discard
>   * requests
>   * @q:  the request queue for the device
>   * @max_segments:  max number of segments
>   *
>   * Description:
>   *    Enables a low level driver to set an upper limit on the number of
>   *    segments in a discard request.
>   **/
> void blk_queue_max_discard_segments(struct request_queue *q,
>                 unsigned short max_segments)
> {
>         q->limits.max_discard_segments = max_segments;
> }
> EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
>

AFAICT, This is not actually sufficient, because the issuer of the bio
is waiting for the entire bio, regardless of how it is split later.
But, also there isn't a good mapping between the size of the secure
discard and how long it will take.  If given the geometry of a flash
device, it is not hard to construct a scenario where a relatively
small secure discard (few thousand sectors) will take a very long time
(multiple seconds).

Having said that, I don't like neutering the hung task timer either.

> Thanks,
>
> Bart.
