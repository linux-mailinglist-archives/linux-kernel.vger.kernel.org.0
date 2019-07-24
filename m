Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473EF731AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGXObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:31:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXObf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:31:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A11B28;
        Wed, 24 Jul 2019 07:31:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7A43F71A;
        Wed, 24 Jul 2019 07:31:33 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:31:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH] perf/core: Fix creating kernel counters for PMUs that
 override event->cpu
Message-ID: <20190724143130.GF2624@lakrids.cambridge.arm.com>
References: <c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:53:24PM +0300, Leonard Crestez wrote:
> Some hardware PMU drivers will override perf_event.cpu inside their
> event_init callback. This causes a lockdep splat when initialized through
> the kernel API:
> 
> WARNING: CPU: 0 PID: 250 at kernel/events/core.c:2917 ctx_sched_out+0x78/0x208
> CPU: 0 PID: 250 Comm: systemd-udevd Not tainted 5.3.0-rc1-next-20190723-00024-g94e04593c88a #80
> Hardware name: FSL i.MX8MM EVK board (DT)
> pstate: 40000085 (nZcv daIf -PAN -UAO)
> pc : ctx_sched_out+0x78/0x208
> lr : ctx_sched_out+0x78/0x208
> sp : ffff0000127a3750
> x29: ffff0000127a3750 x28: 0000000000000000
> x27: ffff00001162bf20 x26: ffff000008cf3310
> x25: ffff0000127a3de0 x24: ffff0000115ff808
> x23: ffff7dffbff851b8 x22: 0000000000000004
> x21: ffff7dffbff851b0 x20: 0000000000000000
> x19: ffff7dffbffc51b0 x18: 0000000000000010
> x17: 0000000000000001 x16: 0000000000000007
> x15: 2e8ba2e8ba2e8ba3 x14: 0000000000005114
> x13: ffff0000117d5e30 x12: ffff000011898378
> x11: 0000000000000000 x10: ffff0000117d5000
> x9 : 0000000000000045 x8 : 0000000000000000
> x7 : ffff000010168194 x6 : ffff0000117d59d0
> x5 : 0000000000000001 x4 : ffff80007db56128
> x3 : ffff80007db56128 x2 : 0d9c118347a77600
> x1 : 0000000000000000 x0 : 0000000000000024
> Call trace:
>  ctx_sched_out+0x78/0x208
>  __perf_install_in_context+0x160/0x248
>  remote_function+0x58/0x68
>  generic_exec_single+0x100/0x180
>  smp_call_function_single+0x174/0x1b8
>  perf_install_in_context+0x178/0x188
>  perf_event_create_kernel_counter+0x118/0x160
> 
> Fix by calling perf_install_in_context with event->cpu, just like
> perf_event_open

Ouch; good spot!

> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> I don't understand why PMUs outside the core are bound to a CPU anyway,
> all this patch does is attempt to satisfy the assumptions made by
> __perf_install_in_context and ctx_sched_out at init time so that lockdep
> no longer complains.

If you care about the background:

It's necessary because portions of the perf core code rely on
serialization that can only be ensured when all management of the PMU
occurs on the same CPU. e.g. for the per-cpu ringbuffers.

There are also some system/uncore PMUs that exist for groups of CPUs
(e.g. clusters or sockets), but are exposed as a single logical PMU,
assocaited with one CPU per group.

> 
> ctx_sched_out asserts ctx->lock which seems to be taken by
> __perf_install_in_context:
> 
> 	struct perf_event_context *ctx = event->ctx;
> 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
> 	...
> 	raw_spin_lock(&cpuctx->ctx.lock);
> 
> The lockdep warning happens when ctx != &cpuctx->ctx which can happen if
> __perf_install_in_context is called on a cpu other than event->cpu.
> 
> Found while working on this patch:
> https://patchwork.kernel.org/patch/11056785/
> 
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 026a14541a38..0463c1151bae 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11272,11 +11272,11 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
>  	if (!exclusive_event_installable(event, ctx)) {
>  		err = -EBUSY;
>  		goto err_unlock;
>  	}
>  
> -	perf_install_in_context(ctx, event, cpu);
> +	perf_install_in_context(ctx, event, event->cpu);
>  	perf_unpin_context(ctx);
>  	mutex_unlock(&ctx->mutex);
>  
>  	return event;

This matches what we in a regular perf_event_open() syscall, and I
believe this is sane. I think we should also update the comment a few
lines above that refers to @cpu, since that's potentially misleading.
Could we change that from:

  Check if the @cpu we're creating an event for is online.

... to:

  Check if the new event's CPU is online.

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
