Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD4E8C91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbfJ2QVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 12:21:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41572 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfJ2QVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:21:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so6274164ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHqqQMR6+pELeMsn4m+Zyhhppmk5ZzFeRmNW41G69NY=;
        b=snddbqKQs7Io2y+XHH7S+6IlGwavKlsmYsnrnwV2YyI+t386XlAEsPVUc3YSo0Sx6s
         qzGkgxiBSD7T9WMzePY4zvKaYpMreJJ5sE9ggGAXzBoakJYis0ZeU3Y23cXFPUNZS35j
         Wyob5MXk/4KapMrz1UDwby9oJ5iIP0FpqeSai8Qqo4872KzDqvyyRQK+P0VJRCs+ezgL
         ONCL914IfIsyIA95HOmZkaOJkoT7OqXje9hCJi6M9KWVHSF/dzj0Rqs987k4bfi9Q8R5
         lZigUvzygg+xqf55RINGOGNGllq8d118TEbpcqxfMGJB6cVxS4F6AzcR5/JruBe82IfG
         1vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHqqQMR6+pELeMsn4m+Zyhhppmk5ZzFeRmNW41G69NY=;
        b=kDdtksx4hOMtYYKb4nbK11odvh+ofdNrvsb/6vhj3o0TWpAFweR9ikCwpZh4EA1Dns
         1i0jPKN0e8NcPEDQoNnyNmYv+9pLaDCLI8fZqIB8uqF5QaTwN1+dKJ2i8Y5uqhR24KvC
         EDf6vuLvNyjrxh/hvtJZm8gcY9aHAEpPnIF4RyXvvmgqdlZXc3r4feMFQzZVj3+X1OT7
         4TrFUFGuCkQ+ZSNVEkRQki3W14CVtnEIm8fVd1KHzyiv/7GCqvthIeZbpSwHGCOBjipG
         CfP04rszoVhvseaylEsMcXe+70O2Ipv5LE5sKxV9vQqA19YN2lwby2DNkKDn2W5qZv/h
         O9nw==
X-Gm-Message-State: APjAAAUcA6CfkF9+y7Th+RVpa5JakdAsY/q22WfHJ4b3sc3yqDFa2clq
        BRQqRkzXf14QSsgXQbHkTHr53CH9OYUod6LZ95NenQ==
X-Google-Smtp-Source: APXvYqyd0QxemdDQgTBwZwHltyO4qSAUyUqw4X3Nw+xyXVcDvv4djU438g1zhCEf9OEiW/9ob4pw+XCMzbX8uhSY8aI=
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr3382952lja.48.1572366068556;
 Tue, 29 Oct 2019 09:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029153615.GP4114@hirez.programming.kicks-ass.net>
In-Reply-To: <20191029153615.GP4114@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 17:20:56 +0100
Message-ID: <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:
>
> > I only know that the call to the intel_pstate driver doesn't
> > happen, and that it is because cfs_rq_is_decayed returns TRUE.
> > So, I am asserting that the request is not actually decayed, and
> > should not have been deleted.
>
> So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
> removed from the list.
>
> Once it is removed, that cfs_rq will no longer be checked in the
> update_blocked_averages() loop. Which means done has less chance of
> getting false. Which in turn means that it's more likely
> rq->has_blocked_load becomes 0.
>
> Which all sounds good.
>
> Can you please trace what keeps the CPU awake?

I think that the sequence below is what intel pstate driver was using

rt/dl task wakes up and run for some times
rt/dl pelt signal is no more null so periodic decay happens.

before optimization update_cfs_rq_load_avg() for root cfs_rq was
called even if pelt was null,
which calls cfs_rq_util_change,  which calls intel pstate

after optimization its no more called.

The patch that i just sent will check that sequence but it's more a
hack than a clean fix because
it uses cfs notification to cpufreq for update that is not related to cfs.

I will look at a proper solution if the test confirms my assumption

>
> > Now, if we also look back at the comments for the original commit:
> >
> >       "In an edge case where temporary cgroups were leaking, this
> >       caused the kernel to consume good several tens of percents of
> >       CPU cycles running update_blocked_averages(), each run taking
> >       multiple millisecs."
> >
> > To my way of thinking: Fix the leak, don't program around it; The
> > commit breaks something else, so revert it.
>
> The leak was fixed, but it still doesn't make sense to keep idle cgroups
> on that list. Some people have a stupid amount of cgroups, most of which
> are pointless and unused, so being able to remove them is good.
>
> Which is why it got added back, once list management issues were sorted.
