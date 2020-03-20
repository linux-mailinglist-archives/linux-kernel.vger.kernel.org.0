Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC918CF99
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:58:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36254 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:58:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so6514924ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7r1qxHQegnboauCIg3jTRpS+zMkxV7bRKkMIfeKjijk=;
        b=J6/Jt1Y2epfdGVLsQdjgnnkBP/tUkdHgxZ8WnxTFvNIxfPzElWcaSNYET38cGsTawF
         TiHN32voBTNIqCfndaBu85e8411XQ2F3c9Ed6kVGcGNTe+5vR3gXLk/LL6TtC5qxQ7Gv
         cGuXVxl2WY5SERovfF2peuo82Rw521aP4GMPIMLOEbJKsZ+ob3m2H4krAkZ/bjy7zHJR
         0B0vFFZMtxsJPdidT5G8QHkJ3FvWda78MAJDxRRV7krXlgznFxr+tXS0+8dwu00TFRGe
         hLNweMhimMzKPgaV4FJ1F2nj4xVUUTFYLA1eVnqjRk0hhbANoCExFXgqZNQeN9b/gyMm
         OAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7r1qxHQegnboauCIg3jTRpS+zMkxV7bRKkMIfeKjijk=;
        b=U/OsXdV/OzIGw1O5AslQJhfBJZ8U4m6mDZPDWDpCmWTYEW9lz4e0I0MLiIXaEispKh
         7yhGPIecZGc0/9TEbQCgG61vCvDe1w7E/SC6NaO/YXgq310A/yVV8YVfaGkS5/GJJ+FS
         rre+SH1xS780S/wFR9EE9vQsVwKI8Yym7nrHgSlUk7E2UpzO1+t+a94KidOhoH4O5rYm
         ZNz8O7+GydZ00bZS8/hYGr6MB005yBFC+l2u5VNBAextYW5MEdKSrIXh9dlOpP+yT5Zp
         kCDxgqvW03+zBxbbKpC5ohEiYjUAqVzyTGVMQ/BIDKMPpICEx/G9MwxOgaxteSi5svF1
         P+AA==
X-Gm-Message-State: ANhLgQ2OsslfW5OmwWOhTo6tDgU8y+mIUjPqF8OyftvQDC2rNZ6jw5ga
        zSRdSpUfWO+WGD6eGsPKhPlxK6zwBS7e7vOvYBQMBg==
X-Google-Smtp-Source: ADFU+vsE6Vs5c/V4TTfZzJZBdNnU4Q9miHz5oGEtzI0KxzH/6VfYinOrqfHlbgo2S6Kmj61vIfHg/1lEx1b1lrEuOKw=
X-Received: by 2002:a2e:8790:: with SMTP id n16mr5470666lji.4.1584712689711;
 Fri, 20 Mar 2020 06:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com> <e400d0b1-173f-bcfd-40c0-2e473e14e7ae@arm.com>
In-Reply-To: <e400d0b1-173f-bcfd-40c0-2e473e14e7ae@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Mar 2020 14:57:57 +0100
Message-ID: <CAKfTPtAiFpAd7NnQorNajQZn4FV+Nn01yv_KNJcgd+MFLnH1sw@mail.gmail.com>
Subject: Re: [PATCH] sched: Remove unused last_load_update_tick rq member
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 14:44, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> + Vincent Guittot

Thanks Dietmar

>
> On 20.03.20 14:21, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > The commit 5e83eafbfd3b ("sched/fair: Remove the rq->cpu_load[] update
> > code") eliminated the use case for rq->last_load_update_tick. Removing
> > it.
> >
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a9983d..c41ee26 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6685,7 +6685,6 @@ void __init sched_init(void)
> >
> >               rq_attach_root(rq, &def_root_domain);
> >  #ifdef CONFIG_NO_HZ_COMMON
> > -             rq->last_load_update_tick = jiffies;
> >               rq->last_blocked_load_update_tick = jiffies;
> >               atomic_set(&rq->nohz_flags, 0);
> >  #endif
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 9ea6478..6e14fad 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -860,7 +860,6 @@ struct rq {
> >  #endif
> >  #ifdef CONFIG_NO_HZ_COMMON
> >  #ifdef CONFIG_SMP
> > -     unsigned long           last_load_update_tick;
> >       unsigned long           last_blocked_load_update_tick;
> >       unsigned int            has_blocked_load;
> >  #endif /* CONFIG_SMP */
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
