Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D267173CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB1Qb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:31:57 -0500
Received: from foss.arm.com ([217.140.110.172]:41040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Qb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:31:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC96C31B;
        Fri, 28 Feb 2020 08:31:56 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F673F73B;
        Fri, 28 Feb 2020 08:31:53 -0800 (PST)
Subject: Re: [PATCH v9 10/12] arm64: implement Shadow Call Stack
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200225173933.74818-1-samitolvanen@google.com>
 <20200225173933.74818-11-samitolvanen@google.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <56b82a54-044a-75ec-64e5-6ba25b19571f@arm.com>
Date:   Fri, 28 Feb 2020 16:31:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225173933.74818-11-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On 25/02/2020 17:39, Sami Tolvanen wrote:
> This change implements shadow stack switching, initial SCS set-up,
> and interrupt shadow stacks for arm64.

> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> new file mode 100644
> index 000000000000..c50d2b0c6c5f
> --- /dev/null
> +++ b/arch/arm64/include/asm/scs.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_SCS_H
> +#define _ASM_SCS_H
> +
> +#ifndef __ASSEMBLY__

As the whole file is guarded by this, why do you need to include it in assembly files at all?


> +
> +#include <linux/scs.h>
> +
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +
> +extern void scs_init_irq(void);
> +
> +static __always_inline void scs_save(struct task_struct *tsk)
> +{
> +	void *s;
> +
> +	asm volatile("mov %0, x18" : "=r" (s));
> +	task_set_scs(tsk, s);
> +}
> +
> +static inline void scs_overflow_check(struct task_struct *tsk)
> +{
> +	if (unlikely(scs_corrupted(tsk)))
> +		panic("corrupted shadow stack detected inside scheduler\n");

Could this ever catch anything with CONFIG_SHADOW_CALL_STACK_VMAP?
Wouldn't we have hit the vmalloc guard page at the point of overflow?


> +}
> +
> +#else /* CONFIG_SHADOW_CALL_STACK */
> +
> +static inline void scs_init_irq(void) {}
> +static inline void scs_save(struct task_struct *tsk) {}
> +static inline void scs_overflow_check(struct task_struct *tsk) {}
> +
> +#endif /* CONFIG_SHADOW_CALL_STACK */
> +
> +#endif /* __ASSEMBLY __ */
> +
> +#endif /* _ASM_SCS_H */



> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 9461d812ae27..4b18c3bbdea5 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S

If I corrupt x18 so that we take an exception (mov x18, xzr), we take that exception
whenever we run C code. The CPU 'vanishes' and I get a very upset scheduler shortly after.

Stack misalignment has the same problem, but the overflow test (eventually) catches that,
then calls panic() using the overflow stack. (See the kernel_ventry macro and __bad_stack
in entry.S)

It would be nice to have a per-cpu stack that we switch to when on the overflow stack.
(this would catch the scs overflow hitting the guard page too, as we should eat through
the regular stack until we overflowed it!)


> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d4ed9a19d8fe..f2cb344f998c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -358,6 +359,9 @@ void cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>
> +	/* Save the shadow stack pointer before exiting the idle task */

I can't work out why this needs to be before before idle_task_exit()...
It needs to run before init_idle(), which calls scs_task_reset(), but all that is on the
cpu_up() path. (if it is to pair those up, any reason core code can't do both?)


> +	scs_save(current);
> +
>  	idle_task_exit();
>
>  	local_daif_mask();
>


Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James
