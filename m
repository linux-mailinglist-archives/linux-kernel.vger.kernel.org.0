Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB437DCC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634426AbfJRRIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 13:08:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393426AbfJRRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:08:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so4250506pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UWzFD043Ue79WGKfIetFLN4DBfqKitPsfYFXewJ5t0=;
        b=nWcskwJTgPUkf8O/Z86NIA7fDV4cpiaHC3Ueqyyz8e/XEyYoKxR6yf3jNKoqHK1RwX
         q9/de63hDE5jvM3jOwfisUoYu7KsgjZ+g+pTVDFODU5pmcbdGNRXHmA8sqYWa8eO+2D8
         bjMFAkUXX0+zLk/yGnFZ6U1pfS97/HMQ+PytOWO1BhJn+d+RzQtnD7sM36TcNgpChoFO
         D/IKPuJTps7o0U9JBWeOje+gDGn1ch8iVfnOFHHt1akLzBwBfQVYDEExotA+qlGsIRpB
         6U7oTPdmx3Qbkbz6suDHMv+OCgYBEijt5YyEks22yEU+a0pSucmy4drPSvyKwtBXmMji
         ygcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UWzFD043Ue79WGKfIetFLN4DBfqKitPsfYFXewJ5t0=;
        b=lb+ApahTGkHP3Ne0uN0x2Rbcee+qhSWw4USYzgQ0LjYyzLHO0cB+KaUXxF7yQ+eDp1
         6BSfZZ8uWQgxdAyqGstWZ9khGpQ3QCxKt0WieE7ZEcIE0SADWMBC05varVR4Sg60nVJy
         l3xSHTIL5egw3LSlWmJ4N2VVN+AeOVM+L0kUL+KPApmRP66I8REXGb6VHTvjER5hRhOH
         +CHTmPVJ5Wj0XVGLT2a0wYAtHQM77mj8A8lk/GEGFqi5s85T5RPLllGBTaQqUNwBtpVL
         8TuNSEx3sc7O7Q/blmmeonuFXA/QXcSMiNPmgzRL7c+mLnjtA5y+jIYRtG+7uRA6wSZT
         sqlw==
X-Gm-Message-State: APjAAAWLD9d7MxEN7m77dafU1Oo1AQVhRKoHVQCiNM7rOV71OKW+/kM0
        RiIWFOeRyKGP5sL4ArLA7+u+ZiI7N8kk6lUZ/QX3UA==
X-Google-Smtp-Source: APXvYqwMTHB75DXTaOJm2Sve5+OMZcpbIKiM0x7L5e1Y18IX8PxVGCevYYraWSoPpaUElTfnBJXuE7U683idtsb8qwg=
X-Received: by 2002:aa7:99c7:: with SMTP id v7mr8035590pfi.165.1571418528747;
 Fri, 18 Oct 2019 10:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-7-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-7-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 10:08:37 -0700
Message-ID: <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This change adds generic support for Clang's Shadow Call Stack, which
> uses a shadow stack to protect return addresses from being overwritten
> by an attacker. Details are available here:
>
>   https://clang.llvm.org/docs/ShadowCallStack.html
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile                       |   6 ++
>  arch/Kconfig                   |  39 ++++++++
>  include/linux/compiler-clang.h |   2 +
>  include/linux/compiler_types.h |   4 +
>  include/linux/scs.h            |  88 ++++++++++++++++++
>  init/init_task.c               |   6 ++
>  init/main.c                    |   3 +
>  kernel/Makefile                |   1 +
>  kernel/fork.c                  |   9 ++
>  kernel/sched/core.c            |   2 +
>  kernel/sched/sched.h           |   1 +
>  kernel/scs.c                   | 162 +++++++++++++++++++++++++++++++++
>  12 files changed, 323 insertions(+)
>  create mode 100644 include/linux/scs.h
>  create mode 100644 kernel/scs.c
>
> diff --git a/Makefile b/Makefile
> index ffd7a912fc46..e401fa500f62 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -846,6 +846,12 @@ ifdef CONFIG_LIVEPATCH
>  KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
>  endif
>
> +ifdef CONFIG_SHADOW_CALL_STACK
> +KBUILD_CFLAGS  += -fsanitize=shadow-call-stack
> +DISABLE_SCS    := -fno-sanitize=shadow-call-stack
> +export DISABLE_SCS
> +endif
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 5f8a5d84dbbe..a222adda8130 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -521,6 +521,45 @@ config STACKPROTECTOR_STRONG
>           about 20% of all kernel functions, which increases the kernel code
>           size by about 2%.
>
> +config ARCH_SUPPORTS_SHADOW_CALL_STACK
> +       bool
> +       help
> +         An architecture should select this if it supports Clang's Shadow
> +         Call Stack, has asm/scs.h, and implements runtime support for shadow
> +         stack switching.
> +
> +config SHADOW_CALL_STACK_VMAP
> +       def_bool n
> +       depends on SHADOW_CALL_STACK
> +       help
> +         Use virtually mapped shadow call stacks. Selecting this option
> +         provides better stack exhaustion protection, but increases per-thread
> +         memory consumption as a full page is allocated for each shadow stack.
> +
> +choice
> +       prompt "Return-oriented programming (ROP) protection"
> +       default ROP_PROTECTION_NONE
> +       help
> +         This option controls kernel protections against return-oriented
> +         programming (ROP) attacks.
> +
> +config ROP_PROTECTION_NONE
> +       bool "None"
> +
> +config SHADOW_CALL_STACK
> +       bool "Clang Shadow Call Stack"
> +       depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> +       depends on CC_IS_CLANG && CLANG_VERSION >= 70000

Version check LGTM.

> +       help
> +         This option enables Clang's Shadow Call Stack, which uses a shadow
> +         stack to protect function return addresses from being overwritten by
> +         an attacker. More information can be found from Clang's
> +         documentation:
> +
> +           https://clang.llvm.org/docs/ShadowCallStack.html
> +
> +endchoice
> +
>  config HAVE_ARCH_WITHIN_STACK_FRAMES
>         bool
>         help
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 333a6695a918..9af08391f205 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -42,3 +42,5 @@
>   * compilers, like ICC.
>   */
>  #define barrier() __asm__ __volatile__("" : : : "memory")
> +
> +#define __noscs                __attribute__((no_sanitize("shadow-call-stack")))

It looks like this attribute, (and thus a requirement to use this
feature), didn't exist until Clang 7.0: https://godbolt.org/z/p9u1we
(as noted above)

I think it's better to put __noscs behind a __has_attribute guard in
include/linux/compiler_attributes.h.  Otherwise, what will happen when
Clang 6.0 sees __noscs, for example? (-Wunknown-sanitizers will
happen).

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 72393a8c1a6c..be5d5be4b1ae 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -202,6 +202,10 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>
> +#ifndef __noscs
> +# define __noscs
> +#endif
> +

and then this can be removed.

>  #ifndef asm_volatile_goto
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
> diff --git a/include/linux/scs.h b/include/linux/scs.h
> new file mode 100644
> index 000000000000..dfbd80faa528
> --- /dev/null
> +++ b/include/linux/scs.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Shadow Call Stack support.
> + *
> + * Copyright (C) 2018 Google LLC
> + */
> +
> +#ifndef _LINUX_SCS_H
> +#define _LINUX_SCS_H
> +
> +#include <linux/gfp.h>
> +#include <linux/sched.h>
> +#include <asm/page.h>
> +
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +
> +#ifdef CONFIG_SHADOW_CALL_STACK_VMAP
> +# define SCS_SIZE              PAGE_SIZE
> +#else
> +# define SCS_SIZE              1024
> +#endif
> +
> +#define SCS_GFP                        (GFP_KERNEL | __GFP_ZERO)
> +
> +extern unsigned long init_shadow_call_stack[];
> +
> +static inline void *task_scs(struct task_struct *tsk)
> +{
> +       return task_thread_info(tsk)->shadow_call_stack;
> +}
> +
> +static inline void task_set_scs(struct task_struct *tsk, void *s)
> +{
> +       task_thread_info(tsk)->shadow_call_stack = s;
> +}
> +
> +extern void scs_init(void);
> +extern void scs_set_init_magic(struct task_struct *tsk);
> +extern void scs_task_init(struct task_struct *tsk);
> +extern void scs_task_reset(struct task_struct *tsk);
> +extern int scs_prepare(struct task_struct *tsk, int node);
> +extern bool scs_corrupted(struct task_struct *tsk);
> +extern void scs_release(struct task_struct *tsk);
> +
> +#else /* CONFIG_SHADOW_CALL_STACK */
> +
> +static inline void *task_scs(struct task_struct *tsk)
> +{
> +       return 0;
> +}
> +
> +static inline void task_set_scs(struct task_struct *tsk, void *s)
> +{
> +}
> +
> +static inline void scs_init(void)
> +{
> +}
> +
> +static inline void scs_set_init_magic(struct task_struct *tsk)
> +{
> +}
> +
> +static inline void scs_task_init(struct task_struct *tsk)
> +{
> +}
> +
> +static inline void scs_task_reset(struct task_struct *tsk)
> +{
> +}
> +
> +static inline int scs_prepare(struct task_struct *tsk, int node)
> +{
> +       return 0;
> +}
> +
> +static inline bool scs_corrupted(struct task_struct *tsk)
> +{
> +       return false;
> +}
> +
> +static inline void scs_release(struct task_struct *tsk)
> +{
> +}
> +
> +#endif /* CONFIG_SHADOW_CALL_STACK */
> +
> +#endif /* _LINUX_SCS_H */
> diff --git a/init/init_task.c b/init/init_task.c
> index 9e5cbe5eab7b..5e55ff45bbbf 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/audit.h>
>  #include <linux/numa.h>
> +#include <linux/scs.h>
>
>  #include <asm/pgtable.h>
>  #include <linux/uaccess.h>
> @@ -184,6 +185,11 @@ struct task_struct init_task
>  };
>  EXPORT_SYMBOL(init_task);
>
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
> +       __init_task_data __aligned(SCS_SIZE);
> +#endif
> +
>  /*
>   * Initial thread structure. Alignment of this is handled by a special
>   * linker map entry.
> diff --git a/init/main.c b/init/main.c
> index 91f6ebb30ef0..fb8bcdd729b9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -93,6 +93,7 @@
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/scs.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -578,6 +579,8 @@ asmlinkage __visible void __init start_kernel(void)
>         char *after_dashes;
>
>         set_task_stack_end_magic(&init_task);
> +       scs_set_init_magic(&init_task);
> +
>         smp_setup_processor_id();
>         debug_objects_early_init();
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index daad787fb795..313dbd44d576 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/
> +obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
>
>  obj-$(CONFIG_PERF_EVENTS) += events/
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bcdf53125210..ae7ebe9f0586 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -94,6 +94,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/thread_info.h>
>  #include <linux/stackleak.h>
> +#include <linux/scs.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -451,6 +452,8 @@ void put_task_stack(struct task_struct *tsk)
>
>  void free_task(struct task_struct *tsk)
>  {
> +       scs_release(tsk);
> +
>  #ifndef CONFIG_THREAD_INFO_IN_TASK
>         /*
>          * The task is finally done with both the stack and thread_info,
> @@ -834,6 +837,8 @@ void __init fork_init(void)
>                           NULL, free_vm_stack_cache);
>  #endif
>
> +       scs_init();
> +
>         lockdep_init_task(&init_task);
>         uprobes_init();
>  }
> @@ -907,6 +912,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>         clear_user_return_notifier(tsk);
>         clear_tsk_need_resched(tsk);
>         set_task_stack_end_magic(tsk);
> +       scs_task_init(tsk);
>
>  #ifdef CONFIG_STACKPROTECTOR
>         tsk->stack_canary = get_random_canary();
> @@ -2022,6 +2028,9 @@ static __latent_entropy struct task_struct *copy_process(
>                                  args->tls);
>         if (retval)
>                 goto bad_fork_cleanup_io;
> +       retval = scs_prepare(p, node);
> +       if (retval)
> +               goto bad_fork_cleanup_thread;
>
>         stackleak_task_init(p);
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dd05a378631a..e7faeb383008 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6013,6 +6013,8 @@ void init_idle(struct task_struct *idle, int cpu)
>         raw_spin_lock_irqsave(&idle->pi_lock, flags);
>         raw_spin_lock(&rq->lock);
>
> +       scs_task_reset(idle);
> +
>         __sched_fork(0, idle);
>         idle->state = TASK_RUNNING;
>         idle->se.exec_start = sched_clock();
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b3361e..c153003a011c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -58,6 +58,7 @@
>  #include <linux/profile.h>
>  #include <linux/psi.h>
>  #include <linux/rcupdate_wait.h>
> +#include <linux/scs.h>
>  #include <linux/security.h>
>  #include <linux/stop_machine.h>
>  #include <linux/suspend.h>
> diff --git a/kernel/scs.c b/kernel/scs.c
> new file mode 100644
> index 000000000000..47324e8d313b
> --- /dev/null
> +++ b/kernel/scs.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Shadow Call Stack support.
> + *
> + * Copyright (C) 2019 Google LLC
> + */
> +
> +#include <linux/cpuhotplug.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/scs.h>
> +#include <linux/vmalloc.h>
> +#include <asm/scs.h>
> +
> +#define SCS_END_MAGIC  0xaf0194819b1635f6UL
> +
> +static inline void *__scs_base(struct task_struct *tsk)
> +{
> +       return (void *)((uintptr_t)task_scs(tsk) & ~(SCS_SIZE - 1));
> +}
> +
> +#ifdef CONFIG_SHADOW_CALL_STACK_VMAP
> +
> +/* Keep a cache of shadow stacks */
> +#define SCS_CACHE_SIZE 2
> +static DEFINE_PER_CPU(void *, scs_cache[SCS_CACHE_SIZE]);
> +
> +static void *scs_alloc(int node)
> +{
> +       int i;
> +
> +       for (i = 0; i < SCS_CACHE_SIZE; i++) {
> +               void *s;
> +
> +               s = this_cpu_xchg(scs_cache[i], NULL);
> +               if (s) {
> +                       memset(s, 0, SCS_SIZE);
> +                       return s;
> +               }
> +       }
> +
> +       return __vmalloc_node_range(SCS_SIZE, SCS_SIZE,
> +                                   VMALLOC_START, VMALLOC_END,
> +                                   SCS_GFP, PAGE_KERNEL, 0,
> +                                   node, __builtin_return_address(0));
> +}
> +
> +static void scs_free(void *s)
> +{
> +       int i;
> +
> +       for (i = 0; i < SCS_CACHE_SIZE; i++) {
> +               if (this_cpu_cmpxchg(scs_cache[i], 0, s) != 0)
> +                       continue;
> +
> +               return;
> +       }
> +
> +       vfree_atomic(s);
> +}
> +
> +static int scs_cleanup(unsigned int cpu)
> +{
> +       int i;
> +       void **cache = per_cpu_ptr(scs_cache, cpu);
> +
> +       for (i = 0; i < SCS_CACHE_SIZE; i++) {
> +               vfree(cache[i]);
> +               cache[i] = NULL;
> +       }
> +
> +       return 0;
> +}
> +
> +void __init scs_init(void)
> +{
> +       cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "scs:scs_cache", NULL,
> +               scs_cleanup);
> +}
> +
> +#else /* !CONFIG_SHADOW_CALL_STACK_VMAP */
> +
> +static struct kmem_cache *scs_cache;
> +
> +static inline void *scs_alloc(int node)
> +{
> +       return kmem_cache_alloc_node(scs_cache, SCS_GFP, node);
> +}
> +
> +static inline void scs_free(void *s)
> +{
> +       kmem_cache_free(scs_cache, s);
> +}
> +
> +void __init scs_init(void)
> +{
> +       scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, SCS_SIZE,
> +                               0, NULL);
> +       WARN_ON(!scs_cache);
> +}
> +
> +#endif /* CONFIG_SHADOW_CALL_STACK_VMAP */
> +
> +static inline unsigned long *scs_magic(struct task_struct *tsk)
> +{
> +       return (unsigned long *)(__scs_base(tsk) + SCS_SIZE - sizeof(long));
> +}
> +
> +static inline void scs_set_magic(struct task_struct *tsk)
> +{
> +       *scs_magic(tsk) = SCS_END_MAGIC;
> +}
> +
> +void scs_task_init(struct task_struct *tsk)
> +{
> +       task_set_scs(tsk, NULL);
> +}
> +
> +void scs_task_reset(struct task_struct *tsk)
> +{
> +       task_set_scs(tsk, __scs_base(tsk));
> +}
> +
> +void scs_set_init_magic(struct task_struct *tsk)
> +{
> +       scs_save(tsk);
> +       scs_set_magic(tsk);
> +       scs_load(tsk);
> +}
> +
> +int scs_prepare(struct task_struct *tsk, int node)
> +{
> +       void *s;
> +
> +       s = scs_alloc(node);
> +       if (!s)
> +               return -ENOMEM;
> +
> +       task_set_scs(tsk, s);
> +       scs_set_magic(tsk);
> +
> +       return 0;
> +}
> +
> +bool scs_corrupted(struct task_struct *tsk)
> +{
> +       return *scs_magic(tsk) != SCS_END_MAGIC;
> +}
> +
> +void scs_release(struct task_struct *tsk)
> +{
> +       void *s;
> +
> +       s = __scs_base(tsk);
> +       if (!s)
> +               return;
> +
> +       WARN_ON(scs_corrupted(tsk));
> +
> +       scs_task_init(tsk);
> +       scs_free(s);
> +}
> --
> 2.23.0.866.gb869b98d4c-goog
>


-- 
Thanks,
~Nick Desaulniers
