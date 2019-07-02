Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038835D41B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGBQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 12:17:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:17:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D41228;
        Tue,  2 Jul 2019 09:17:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF22E3F246;
        Tue,  2 Jul 2019 09:17:12 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:17:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] stacktrace: Use PF_KTHREAD to check for kernel threads
Message-ID: <20190702161710.GB34718@lakrids.cambridge.arm.com>
References: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:53:35PM +0200, Thomas Gleixner wrote:
> !current->mm is not a reliable indicator for kernel threads as they might
> temporarily use a user mm. Check for PF_KTHREAD instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As a heads-up, I started looking into cleaning up bogus mm checks
tree-wide, since there are a number that look suspicious (e.g. arm64's
arch_dup_task_struct() and x86's __kernel_fpu_begin()).

I was hoping to add an is_kthread(tsk) helper to push people in the
right direction [1].

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=sched/kthread-cleanup

> ---
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -228,7 +228,7 @@ unsigned int stack_trace_save_user(unsig
>  	};
>  
>  	/* Trace user stack if not a kernel thread */
> -	if (!current->mm)
> +	if (current->flags & PF_KTHREAD)
>  		return 0;
>  
>  	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
