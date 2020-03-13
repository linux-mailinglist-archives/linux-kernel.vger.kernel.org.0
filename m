Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9656218471B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCMMmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:42:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgCMMmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:42:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A13AF30E;
        Fri, 13 Mar 2020 05:42:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F1F3F534;
        Fri, 13 Mar 2020 05:42:48 -0700 (PDT)
References: <20200312165429.990-1-vincent.guittot@linaro.org> <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com> <jhjpndgjxxk.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
In-reply-to: <jhjpndgjxxk.mognet@arm.com>
Date:   Fri, 13 Mar 2020 12:42:41 +0000
Message-ID: <jhj4kuspgse.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 13 2020, Valentin Schneider wrote:
> On Fri, Mar 13 2020, Vincent Guittot wrote:
>>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> > index 3c8a379c357e..97a0307312d9 100644
>>> > --- a/kernel/sched/fair.c
>>> > +++ b/kernel/sched/fair.c
>>> > @@ -9025,6 +9025,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>> >               case migrate_util:
>>> >                       util = cpu_util(cpu_of(rq));
>>> >
>>> > +                     /*
>>> > +                      * Don't try to pull utilization from a CPU with one
>>> > +                      * running task. Whatever its utilization, we will fail
>>> > +                      * detach the task.
>>> > +                      */
>>> > +                     if (nr_running <= 1)
>>> > +                             continue;
>>> > +
>>>
>>> Doesn't this break misfit? If the busiest group is group_misfit_task, it
>>> is totally valid for the runqueues to have a single running task -
>>> that's the CPU-bound task we want to upmigrate.
>>
>>  group_misfit_task has its dedicated migrate_misfit case
>>
>
> Doh, yes, sorry. I think my rambling on ASYM_PACKING / reduced capacity
> migration is still relevant, though.
>

And with more coffee that's another Doh, ASYM_PACKING would end up as
migrate_task. So this only affects the reduced capacity migration, which
might be hard to notice in benchmarks.
