Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F5798E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfG2UL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:11:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfG2ULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:11:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so38128896wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBs2XH1stLT9RSq/8zHtTMENwlKXXKYro8AoKfkCRxU=;
        b=ESrg15vvIX2QliCdNOmD818metRcak3U4lgoyUOfJF5b5qpQcOFHk0C5rbPIKNw1qq
         1/YcdaNMcX/6zvstceGw4yvHU1Rf/KH+kAvcYEprQkif0v58fm2J4T4LKWE+ujWj8ACl
         /6Cn7fMp0R/3d3Q5rNzDwfnJ6yr6pFBaNu9F2uUh7KXxX0hA0Of4ytteaddwvPWjr2ai
         IHueRhtmbIcmgRtC4iBgos3HVH7sOSkTIh66bPU+d5V7kcxvFHzIMKQYVyEDKop8Cbvo
         mqpZn0O4GvhScLBcknDAPX3u/sNr6wdE8yeeZnp6BC2CP44/ofXvyC6F0UELTqafJhKM
         SJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBs2XH1stLT9RSq/8zHtTMENwlKXXKYro8AoKfkCRxU=;
        b=TOodspb6ReMZSMJgsxgxFQHVwfigo13lOlX6Fqmypwax38WkcJlBGO2LU+LYi0Mvyg
         5MMthOBUrZUCKAiCA/1dO+MUHB2NsIF/M3tPUZ4tnMfp1ZSqrpGzFOufNg3vS3pts0Fy
         C8woaIqHR4gHnHWJDcEh3ctWvoUQoBe8I0SQo6wjczmk2qdFJhh/G9yc8fgCxfKK+3Ex
         wnT7hv3Iq//ROFqmZhNasDU9xiq5LWp0t7TtrkFDJTvQ0Siei+/PKX3Ze8R2ulfjJpSM
         GWSDGViy0uXzCqeYOtbs2lx3KwokAysxpUiwCFTtE++K2I5y1K6TmQN61reWd1tGf+jJ
         VsWg==
X-Gm-Message-State: APjAAAVZhbKThxqjeRsQTvSchvgPdkJXQo+LpinMUhJg50nwBAKKmk6H
        I/5VZEH3euwWwnZastfnkzf8TzmDT3k8DhkhpUq6WQ==
X-Google-Smtp-Source: APXvYqxFKlb66t4oKcBaMb48wYrx+/EeOSc5Ncb8ZjsZuiaefe638OkpcAYIjYItOQWGw5Iw4GJc21WafT9t8sruOeQ=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr126611598wrs.93.1564431082241;
 Mon, 29 Jul 2019 13:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190729194205.212846-1-surenb@google.com> <20190729195614.GA31529@kroah.com>
In-Reply-To: <20190729195614.GA31529@kroah.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 29 Jul 2019 13:11:11 -0700
Message-ID: <CAJuCfpFRsmN0gim_4fXNouzOxZWSJO6xkpLzoGvbBUE8tMOECA@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lizefan@huawei.com, Johannes Weiner <hannes@cmpxchg.org>,
        axboe@kernel.dk, Dennis Zhou <dennis@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 29, 2019 at 12:42:05PM -0700, Suren Baghdasaryan wrote:
> > When a process creates a new trigger by writing into /proc/pressure/*
> > files, permissions to write such a file should be used to determine whether
> > the process is allowed to do so or not. Current implementation would also
> > require such a process to have setsched capability. Setting of psi trigger
> > thread's scheduling policy is an implementation detail and should not be
> > exposed to the user level. Remove the permission check by using _nocheck
> > version of the function.
> >
> > Suggested-by: Nick Kralevich <nnk@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> $ ./scripts/get_maintainer.pl --file kernel/sched/psi.c
> Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
> Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
> linux-kernel@vger.kernel.org (open list:SCHEDULER)
>
>
> No where am I listed there, so why did you send this "To:" me?
>

Oh, sorry about that. Both Ingo and Peter are CC'ed directly. Should I
still resend?

> please fix up and resend.
>
> greg k-h
