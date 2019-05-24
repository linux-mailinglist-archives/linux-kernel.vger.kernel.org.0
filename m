Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6C29CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfEXRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:19:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfEXRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B2780D;
        Fri, 24 May 2019 10:19:46 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F068E3F703;
        Fri, 24 May 2019 10:19:43 -0700 (PDT)
Date:   Fri, 24 May 2019 18:19:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190524171939.GA9120@fuggles.cambridge.arm.com>
References: <20190524165346.26373-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524165346.26373-1-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:53:46PM -0400, Waiman Long wrote:
> The kernel test robot has reported that the use of __this_cpu_add()
> causes bug messages like:
> 
>   BUG: using __this_cpu_add() in preemptible [00000000] code: ...
> 
> This is only an issue on preempt kernel where preemption can happen in
> the middle of a percpu operation. We are still using __this_cpu_*() for
> !preempt kernel to avoid additional overhead in case CONFIG_PREEMPT_COUNT
> is set.
> 
>  v2: Simplify the condition to just preempt or !preempt.
> 
> Fixes: a8654596f0371 ("locking/rwsem: Enable lock event counting")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lock_events.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
> index feb1acc54611..05f34068ec06 100644
> --- a/kernel/locking/lock_events.h
> +++ b/kernel/locking/lock_events.h
> @@ -30,13 +30,32 @@ enum lock_events {
>   */
>  DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);
>  
> +/*
> + * The purpose of the lock event counting subsystem is to provide a low
> + * overhead way to record the number of specific locking events by using
> + * percpu counters. It is the percpu sum that matters, not specifically
> + * how many of them happens in each cpu.
> + *
> + * In !preempt kernel, we can just use __this_cpu_*() as preemption
> + * won't happen in the middle of the percpu operation. In preempt kernel,
> + * preemption happens in the middle of the percpu operation may produce
> + * incorrect result.
> + */
> +#ifdef CONFIG_PREEMPT
> +#define lockevent_percpu_inc(x)		this_cpu_inc(x)
> +#define lockevent_percpu_add(x, v)	this_cpu_add(x, v)
> +#else
> +#define lockevent_percpu_inc(x)		__this_cpu_inc(x)
> +#define lockevent_percpu_add(x, v)	__this_cpu_add(x, v)

Are you sure this works wrt IRQs? For example, if I take an interrupt when
trying to update the counter, and then the irq handler takes a qspinlock
which in turn tries to update the counter. Would I lose an update in that
scenario?

Will
