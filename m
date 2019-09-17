Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51339B50DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfIQO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 10:57:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfIQO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:57:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAEv4-0000D2-0Y; Tue, 17 Sep 2019 16:57:30 +0200
Date:   Tue, 17 Sep 2019 16:57:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 2/8] sched: __set_cpus_allowed_ptr: Check cpus_mask,
 not cpus_ptr
Message-ID: <20190917145729.pul3dmbrdnshne6m@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-3-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-3-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-27 00:56:32 [-0500], Scott Wood wrote:
> This function is concerned with the long-term cpu mask, not the
> transitory mask the task might have while migrate disabled.  Before
> this patch, if a task was migrate disabled at the time
> __set_cpus_allowed_ptr() was called, and the new mask happened to be
> equal to the cpu that the task was running on, then the mask update
> would be lost.

lost as in "would not be carried out" I assume.

> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c3407707e367..6e643d656d71 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1218,7 +1218,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  		goto out;
>  	}
>  
> -	if (cpumask_equal(p->cpus_ptr, new_mask))
> +	if (cpumask_equal(&p->cpus_mask, new_mask))
>  		goto out;
>  
>  	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {


Sebastian
