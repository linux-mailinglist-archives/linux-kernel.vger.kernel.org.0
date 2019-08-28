Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7404A9FED9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1JqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:46:12 -0400
Received: from foss.arm.com ([217.140.110.172]:56516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1JqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:46:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4AFB337;
        Wed, 28 Aug 2019 02:46:10 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22B003F59C;
        Wed, 28 Aug 2019 02:46:10 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] sched/fair: Prevent active LB from preempting
 higher sched classes
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <20190815145107.5318-5-valentin.schneider@arm.com>
 <CAKfTPtCq3fv_ajgwnUUodnd+G_Bx6Jqod3751FnB5AASxZczYg@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1ba22164-bcae-3bec-a002-acca4e7c8eae@arm.com>
Date:   Wed, 28 Aug 2019 10:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCq3fv_ajgwnUUodnd+G_Bx6Jqod3751FnB5AASxZczYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2019 13:28, Vincent Guittot wrote:
> On Thu, 15 Aug 2019 at 16:52, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> The CFS load balancer can cause the cpu_stopper to run a function to
>> try and steal a remote rq's running task. However, it so happens
>> that while only CFS tasks will ever be migrated by that function, we
>> can end up preempting higher sched class tasks, since it is executed
>> by the cpu_stopper.
>>
>> This can potentially occur whenever a rq's running task is > CFS but
>> the rq has runnable CFS tasks.
>>
>> Check the sched class of the remote rq's running task after we've
>> grabbed its lock. If it's CFS, carry on, otherwise run
>> detach_one_task() locally since we don't need the cpu_stopper (that
>> !CFS task is doing the exact same thing).
> 
> AFAICT, this doesn't prevent from preempting !CFS task but only reduce
> the window.
> As soon as you unlock, !CFS task can preempt CFS before you start stop thread
> 

Right, if we end up kicking the cpu_stopper this can still happen (since
we drop the lock). Thing is, you can't detect it on the cpu_stopper side,
since the currently running is obviously not going to be CFS (and it's
too late anyway, we already preempted whatever was running there). Though
I should probably change the name of the patch to reflect that it's not a
100% cure.

I tweaked the nr_running check of the cpu_stop callback in patch 3/4 to try
to bail out early, but AFAICT that's the best we can do without big changes
elsewhere.

If we wanted to prevent those preemptions at all cost, I suppose we'd want
the equivalent of a sched class sitting between CFS and RT: have the
callback only run when there's no runnable > CFS tasks. But then by the
time we execute it we may no longer need to balance anything...

At the very least, what I'm proposing here alleviates *some* of the
preemption cases without swinging the wrecking ball too hard (and without
delaying the balancing either).

> testing  busiest->cfs.h_nr_running < 1 and/or
> busiest->curr->sched_class != &fair_sched_class
> in need_active_balance() will do almost the same and is much simpler
> than this patchset IMO.
> 

I had this initially but convinced myself out of it: since we hold no
lock in need_active_balance(), the information we get on the current task
(and, arguably, on the h_nr_running) is too volatile to be of any use.

I do believe those checks have their place in active_load_balance()'s
critical section, as that's the most accurate we're going to get. On the
plus side, if we *do* detect the remote rq's current task isn't CFS, we
can run detach_one_task() locally, which is an improvement IMO.
