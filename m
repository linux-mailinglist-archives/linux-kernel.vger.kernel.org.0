Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B821914AECF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 06:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgA1FBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 00:01:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:01:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so14437605wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 21:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Su4SwNX37TNM4nhd1IBgXGV7kw01IVOxPx+x6mxPg/k=;
        b=SYrwymRKgr5fVBJ/xV2QqQJl+XA8WWuU4qYFcgoTt3xr2seCypJRvuVIPE+eYto0mX
         l+fcWxOgk6nUWJeVFOaxYq9WYrgupyx7O5PzjWUNhbGGlO7m8BsstINZfD5YvMW/7Gn1
         XFCjh8Wz2aFt4ZytCrNDmwGnuSl088dE4h3tDS5dWbxj2XiOyNWqs9QTNNmKhdsaWXyQ
         36g2nqL2Jra+ntv6EHm0xnj3r/Vo/iE9XsNueMXv5Tvxt1aLANlmk31Qy8sOjJlgqda5
         x1HNsjJVANezXYBj3ZQWECOVcKDnzOKUAqQ7UJTd6XC9D4Rno4jMwC7oZxBhZNtEMqI1
         WkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su4SwNX37TNM4nhd1IBgXGV7kw01IVOxPx+x6mxPg/k=;
        b=ZK3Nq0lTH/rp0W0APKisYfn8s5ZljOoxLj5QzxYn/K86uaONIPoy3/Q4bpXT+XTh8p
         1U1I1Ncvec/ELssaLggmOIaUVm08Q+DTGYHJ/ZB1p84safVX70JpcLgeDWPGytWR++xx
         Bo7tgGZH1CvNLp8dfYMuCd7uZNAPX6xFXwfq7i8/nWauMoTLdc8pA1d3suo01+XpIaNM
         S6n+/ExS5tFn2l7o/4J7sBq0oMB3CTN95mG8Csxab1eBff34qNxLoxgdOPLLl4vOjZ5C
         NjIjguW2bvFh/PGZbphIYUBvTh2S/q7kxBa3b1twGpJC+Zhq9GbJPiD3HDsFRQQZpEOg
         t2Qg==
X-Gm-Message-State: APjAAAV7N3kDSZYOle3tJtLOB3yqc/m6uuLDgF5TF2psFrj6+0Lr7jjQ
        xyxjUL7lTuOUSbVEuGSe1Oa18n50r08Zv5xatN/wzQ==
X-Google-Smtp-Source: APXvYqxDtptadIkqR8DtGhAuiBY5Xz20GNiFiHVO3387vLuxGOv8Hx9tcwyf6DGbMhnhSgxmhILwXVhc/+EEVKw3N5g=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr27813450wrv.0.1580187668773;
 Mon, 27 Jan 2020 21:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-11-atish.patra@wdc.com>
In-Reply-To: <20200128022737.15371-11-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Jan 2020 10:30:57 +0530
Message-ID: <CAAhSdy3jEnwBsKx0NN8gu2PXvBfoFFYCjRY2kARK5jL4Dannyg@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] RISC-V: Support cpu hotplug
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Abner Chang <abner.chang@hpe.com>, Chester Lin <clin@suse.com>,
        nickhu@andestech.com, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 7:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> This patch enable support for cpu hotplug in RISC-V. It uses SBI HSM
> extension to online/offline any hart. As a result, the harts are
> returned to firmware once they are offline. If the harts are brought
> online afterwards, they re-enter Linux kernel as if a secondary hart
> booted for the first time. All booting requirements are honored during
> this process.
>
> Tested both on QEMU and HighFive Unleashed board with. Test result follows.
>
> ---------------------------------------------------
> Offline cpu 2
> ---------------------------------------------------
> $ echo 0 > /sys/devices/system/cpu/cpu2/online
> [   32.828684] CPU2: off
> $ cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 3
> hart            : 3
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 4
> hart            : 4
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 5
> hart            : 5
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 6
> hart            : 6
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 7
> hart            : 7
> isa             : rv64imafdcsu
> mmu             : sv48
>
> ---------------------------------------------------
> online cpu 2
> ---------------------------------------------------
> $ echo 1 > /sys/devices/system/cpu/cpu2/online
> $ cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 2
> hart            : 2
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 3
> hart            : 3
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 4
> hart            : 4
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 5
> hart            : 5
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 6
> hart            : 6
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 7
> hart            : 7
> isa             : rv64imafdcsu
> mmu             : sv48
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig               | 12 ++++-
>  arch/riscv/include/asm/cpu_ops.h |  5 ++
>  arch/riscv/include/asm/smp.h     |  7 +++
>  arch/riscv/kernel/Makefile       |  1 +
>  arch/riscv/kernel/cpu-hotplug.c  | 84 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpu_ops.c      | 34 +++++++++++++
>  arch/riscv/kernel/setup.c        | 26 ++++++++++
>  7 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/cpu-hotplug.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 518da42be545..99fb481dc805 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -22,7 +22,6 @@ config RISCV
>         select CLONE_BACKWARDS
>         select COMMON_CLK
>         select GENERIC_CLOCKEVENTS
> -       select GENERIC_CPU_DEVICES
>         select GENERIC_IRQ_SHOW
>         select GENERIC_PCI_IOMAP
>         select GENERIC_SCHED_CLOCK
> @@ -247,6 +246,17 @@ config NR_CPUS
>         depends on SMP
>         default "8"
>
> +config HOTPLUG_CPU
> +       bool "Support for hot-pluggable CPUs"
> +       depends on SMP
> +       select GENERIC_IRQ_MIGRATION
> +       help
> +
> +         Say Y here to experiment with turning CPUs off and on.  CPUs
> +         can be controlled through /sys/devices/system/cpu.
> +
> +         Say N if you want to disable CPU hotplug.
> +
>  choice
>         prompt "CPU Tuning"
>         default TUNE_GENERIC
> diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
> index 27e9dfee5460..d53d7086f627 100644
> --- a/arch/riscv/include/asm/cpu_ops.h
> +++ b/arch/riscv/include/asm/cpu_ops.h
> @@ -23,6 +23,11 @@ struct cpu_operations {
>         int             (*cpu_prepare)(unsigned int cpu);
>         int             (*cpu_start)(unsigned int cpu,
>                                      struct task_struct *tidle);
> +#ifdef CONFIG_HOTPLUG_CPU
> +       int             (*cpu_disable)(unsigned int cpu);
> +       void            (*cpu_stop)(void);
> +       int             (*cpu_is_stopped)(unsigned int cpu);
> +#endif
>  };
>
>  extern const struct cpu_operations *cpu_ops[NR_CPUS];
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 023f74fb8b3b..8d9c50c0f91c 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -43,6 +43,13 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>   */
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>
> +#if defined CONFIG_HOTPLUG_CPU
> +int __cpu_disable(void);
> +void __cpu_die(unsigned int cpu);
> +void cpu_stop(void);
> +#else
> +#endif /* CONFIG_HOTPLUG_CPU */
> +
>  #else
>
>  static inline void show_ipi_stats(struct seq_file *p, int prec)
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d77def5b4e87..6fe35a719de1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -43,5 +43,6 @@ obj-$(CONFIG_PERF_EVENTS)     += perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> +obj-$(CONFIG_HOTPLUG_CPU)      += cpu-hotplug.o
>
>  clean:
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> new file mode 100644
> index 000000000000..835b0747803e
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/cpu.h>
> +#include <linux/sched/hotplug.h>
> +#include <asm/irq.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +
> +void cpu_stop(void);
> +bool can_hotplug_cpu(void)
> +{
> +       return true;
> +}
> +
> +void arch_cpu_idle_dead(void)
> +{
> +       cpu_stop();
> +}
> +
> +/*
> + * __cpu_disable runs on the processor to be shutdown.
> + */
> +int __cpu_disable(void)
> +{
> +       int ret = 0;
> +       unsigned int cpu = smp_processor_id();
> +
> +       if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_stop)
> +               return -EOPNOTSUPP;
> +
> +       if (cpu_ops[cpu]->cpu_disable)
> +               ret = cpu_ops[cpu]->cpu_disable(cpu);
> +
> +       if (ret)
> +               return ret;
> +
> +       remove_cpu_topology(cpu);
> +       set_cpu_online(cpu, false);
> +       irq_migrate_all_off_this_cpu();
> +
> +       return ret;
> +}
> +
> +/*
> + * Called on the thread which is asking for a CPU to be shutdown.
> + */
> +void __cpu_die(unsigned int cpu)
> +{
> +       int ret = 0;
> +
> +       if (!cpu_wait_death(cpu, 5)) {
> +               pr_err("CPU %u: didn't die\n", cpu);
> +               return;
> +       }
> +       pr_notice("CPU%u: off\n", cpu);
> +
> +       /* Verify from the firmware if the cpu is really stopped*/
> +       if (cpu_ops[cpu]->cpu_is_stopped)
> +               ret = cpu_ops[cpu]->cpu_is_stopped(cpu);
> +       if (ret)
> +               pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
> +}
> +
> +/*
> + * Called from the idle thread for the CPU which has been shutdown.
> + */
> +void cpu_stop(void)
> +{
> +       idle_task_exit();
> +
> +       (void)cpu_report_death();
> +
> +       cpu_ops[smp_processor_id()]->cpu_stop();
> +       /* It should never reach here */
> +       BUG();
> +}
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index 454df032066f..9b315137b945 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -59,6 +59,34 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>         return rc;
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int sbi_cpu_disable(unsigned int cpuid)
> +{
> +       if (!cpu_sbi_ops.cpu_stop)
> +               return -EOPNOTSUPP;
> +       return 0;
> +}
> +
> +static void sbi_cpu_stop(void)
> +{
> +       int ret;
> +
> +       ret = sbi_hsm_hart_stop();
> +       pr_crit("Unable to stop the cpu %u (%d)\n", smp_processor_id(), ret);
> +}
> +
> +static int sbi_cpu_is_stopped(unsigned int cpuid)
> +{
> +       int rc;
> +       int hartid = cpuid_to_hartid_map(cpuid);
> +
> +       rc = sbi_hsm_hart_get_status(hartid);
> +
> +       if (rc == RISCV_HART_FIRMWARE_STOPPED)
> +               return 0;
> +       return rc;
> +}
> +#endif
>  static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>  {
>         int hartid = cpuid_to_hartid_map(cpuid);
> @@ -82,6 +110,11 @@ const struct cpu_operations cpu_sbi_ops = {
>         .name           = "sbi",
>         .cpu_prepare    = sbi_cpu_prepare,
>         .cpu_start      = sbi_cpu_start,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .cpu_disable    = sbi_cpu_disable,
> +       .cpu_stop       = sbi_cpu_stop,
> +       .cpu_is_stopped = sbi_cpu_is_stopped,
> +#endif
>  };
>
>  const struct cpu_operations cpu_spinwait_ops = {
> @@ -90,6 +123,7 @@ const struct cpu_operations cpu_spinwait_ops = {
>         .cpu_start      = spinwait_cpu_start,
>  };
>
> +
>  int __init cpu_set_ops(int cpuid)
>  {
>         if (sbi_hsm_is_available())
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 8208d1109ddb..dfab3bd40f2a 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -43,6 +43,7 @@ struct screen_info screen_info = {
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
>  void __init parse_dtb(void)
>  {
> @@ -90,3 +91,28 @@ void __init setup_arch(char **cmdline_p)
>
>         riscv_fill_hwcap();
>  }
> +
> +static inline bool can_hotplug_cpu(unsigned int cpu)
> +{
> +#ifdef CONFIG_HOTPLUG_CPU
> +       if (cpu_ops[cpu]->cpu_stop)
> +               return true;
> +#endif
> +       return false;
> +}
> +
> +static int __init topology_init(void)
> +{
> +       int i;
> +
> +       pr_err("%s: In\n", __func__);

Remove this pr_err()

> +       for_each_possible_cpu(i) {
> +               struct cpu *cpu = &per_cpu(cpu_devices, i);
> +
> +               cpu->hotpluggable = can_hotplug_cpu(i);
> +               register_cpu(cpu, i);
> +       }
> +
> +       return 0;
> +}
> +subsys_initcall(topology_init);
> --
> 2.24.0
>

Regards,
Anup
