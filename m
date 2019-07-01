Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7B46C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFNVn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 17:43:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:52059 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfFNVn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:43:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 14:43:27 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2019 14:43:27 -0700
Received: from [10.254.88.254] (kliang2-mobl.ccr.corp.intel.com [10.254.88.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1938A5803E4;
        Fri, 14 Jun 2019 14:43:26 -0700 (PDT)
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups
 unnecessarily
To:     Stephane Eranian <eranian@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <20190601082722.44543-1-irogers@google.com>
 <5084acfa-59a4-996f-bb1d-69fbbac01b87@linux.intel.com>
 <CABPqkBRDzZnofavMC0gYoRQ3iawe19qqGwufdRQJVyjr4E7xrg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a6dd0755-dd17-c2d0-5228-6cc4ef8a40ed@linux.intel.com>
Date:   Fri, 14 Jun 2019 17:43:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBRDzZnofavMC0gYoRQ3iawe19qqGwufdRQJVyjr4E7xrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2019 3:10 PM, Stephane Eranian wrote:
> On Thu, Jun 13, 2019 at 9:13 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 6/1/2019 4:27 AM, Ian Rogers wrote:
>>> Currently perf_rotate_context assumes that if the context's nr_events !=
>>> nr_active a rotation is necessary for perf event multiplexing. With
>>> cgroups, nr_events is the total count of events for all cgroups and
>>> nr_active will not include events in a cgroup other than the current
>>> task's. This makes rotation appear necessary for cgroups when it is not.
>>>
>>> Add a perf_event_context flag that is set when rotation is necessary.
>>> Clear the flag during sched_out and set it when a flexible sched_in
>>> fails due to resources.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    include/linux/perf_event.h |  5 +++++
>>>    kernel/events/core.c       | 42 +++++++++++++++++++++++---------------
>>>    2 files changed, 30 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index 15a82ff0aefe..7ab6c251aa3d 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -747,6 +747,11 @@ struct perf_event_context {
>>>        int                             nr_stat;
>>>        int                             nr_freq;
>>>        int                             rotate_disable;
>>> +     /*
>>> +      * Set when nr_events != nr_active, except tolerant to events not
>>> +      * needing to be active due to scheduling constraints, such as cgroups.
>>> +      */
>>> +     int                             rotate_necessary;
>>
>> It looks like the rotate_necessary is only useful for cgroup and cpuctx.
>> Why not move it to struct perf_cpu_context and under #ifdef
>> CONFIG_CGROUP_PERF?
>> And rename it cgrp_rotate_necessary?
>>
> I am not sure I see the point here. What I'd like to see is a uniform
> signal for rotation needed in per-task, per-cpu or per-cgroup modes > Ian's patch does that. It does make it a lot more efficient in cgroup
> mode, by avoiding unnecessary rotations, and does not alter/improve
> on any of the other two modes.

I just thought if it is only used by cgroup, it may be better to move it 
under #ifdef CONFIG_CGROUP_PERF. For users who don't care about cgroup, 
it may save some space.
But if it's designed as a uniform signal, this is OK.

Thanks,
Kan

> 
>> Thanks,
>> Kan
>>
>>>        refcount_t                      refcount;
>>>        struct task_struct              *task;
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index abbd4b3b96c2..41ae424b9f1d 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2952,6 +2952,12 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>>>        if (!ctx->nr_active || !(is_active & EVENT_ALL))
>>>                return;
>>>
>>> +     /*
>>> +      * If we had been multiplexing, no rotations are necessary now no events
>>> +      * are active.
>>> +      */
>>> +     ctx->rotate_necessary = 0;
>>> +
>>>        perf_pmu_disable(ctx->pmu);
>>>        if (is_active & EVENT_PINNED) {
>>>                list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
>>> @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>>>                        sid->can_add_hw = 0;
>>>        }
>>>
>>> +     /*
>>> +      * If the group wasn't scheduled then set that multiplexing is necessary
>>> +      * for the context. Note, this won't be set if the event wasn't
>>> +      * scheduled due to event_filter_match failing due to the earlier
>>> +      * return.
>>> +      */
>>> +     if (event->state == PERF_EVENT_STATE_INACTIVE)
>>> +             sid->ctx->rotate_necessary = 1;
>>> +
>>>        return 0;
>>>    }
>>>
>>> @@ -3690,24 +3705,17 @@ ctx_first_active(struct perf_event_context *ctx)
>>>    static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>>>    {
>>>        struct perf_event *cpu_event = NULL, *task_event = NULL;
>>> -     bool cpu_rotate = false, task_rotate = false;
>>> -     struct perf_event_context *ctx = NULL;
>>> +     struct perf_event_context *task_ctx = NULL;
>>> +     int cpu_rotate, task_rotate;
>>>
>>>        /*
>>>         * Since we run this from IRQ context, nobody can install new
>>>         * events, thus the event count values are stable.
>>>         */
>>>
>>> -     if (cpuctx->ctx.nr_events) {
>>> -             if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
>>> -                     cpu_rotate = true;
>>> -     }
>>> -
>>> -     ctx = cpuctx->task_ctx;
>>> -     if (ctx && ctx->nr_events) {
>>> -             if (ctx->nr_events != ctx->nr_active)
>>> -                     task_rotate = true;
>>> -     }
>>> +     cpu_rotate = cpuctx->ctx.rotate_necessary;
>>> +     task_ctx = cpuctx->task_ctx;
>>> +     task_rotate = task_ctx ? task_ctx->rotate_necessary : 0;
>>>
>>>        if (!(cpu_rotate || task_rotate))
>>>                return false;
>>> @@ -3716,7 +3724,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>>>        perf_pmu_disable(cpuctx->ctx.pmu);
>>>
>>>        if (task_rotate)
>>> -             task_event = ctx_first_active(ctx);
>>> +             task_event = ctx_first_active(task_ctx);
>>>        if (cpu_rotate)
>>>                cpu_event = ctx_first_active(&cpuctx->ctx);
>>>
>>> @@ -3724,17 +3732,17 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>>>         * As per the order given at ctx_resched() first 'pop' task flexible
>>>         * and then, if needed CPU flexible.
>>>         */
>>> -     if (task_event || (ctx && cpu_event))
>>> -             ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
>>> +     if (task_event || (task_ctx && cpu_event))
>>> +             ctx_sched_out(task_ctx, cpuctx, EVENT_FLEXIBLE);
>>>        if (cpu_event)
>>>                cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>>
>>>        if (task_event)
>>> -             rotate_ctx(ctx, task_event);
>>> +             rotate_ctx(task_ctx, task_event);
>>>        if (cpu_event)
>>>                rotate_ctx(&cpuctx->ctx, cpu_event);
>>>
>>> -     perf_event_sched_in(cpuctx, ctx, current);
>>> +     perf_event_sched_in(cpuctx, task_ctx, current);
>>>
>>>        perf_pmu_enable(cpuctx->ctx.pmu);
>>>        perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>>
