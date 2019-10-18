Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73DEDBD12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437986AbfJRFcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:32:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJRFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:32:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so4744718wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpUdtRZLCMWCE2pmgbqMCnO+ca2VrAa6THp+EdS32g0=;
        b=WnxLA/4qFYmYNv+uh8zSB+n98MDKY4/X+1hsTlDKM6RySJ1Uu6y3xAksZ6QWCGMNuC
         rVIHurjG66Ir2cp37i2ZVQGuY2U5sd3aBt9dr8Vu95rOkRqGnLYG6d3CvhKkiS0cvF1n
         9duE+0KqbkjsxnKCZHMMKoXyiyiaVlcXe0jvrnul7wIRSnsZqQSV71NpfYO66++PWPMY
         p1t3824K6uFYswQXepQ5H7PmsaOjTQW8MSL5L6JZpgQdUGemG6h5a1xVmau+J3VVqKqM
         v2sas0q8Ws64hksvWfbacUnNkfetqIBgcinGxwGvsDWgCPH5TcbEExKomIPYvoBH+/Hu
         TSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpUdtRZLCMWCE2pmgbqMCnO+ca2VrAa6THp+EdS32g0=;
        b=n3c+OVhd3sIjGAMUYGD08EL3yCT8AnW6NxwwcYIqaEWkZQpyt9fhLA5meEMvUNQokk
         Mibyn+9+dlKM7AU6FCUA/mSAuVzIfnIwWMhR7abJkuS58B+4ERKZjDWYpGNhlfY9VhrX
         eVzZeoDXlLtWUz1bQ5l6NgS0wqu2h/kAGIUa5CZ7M1G//UkPkB8MTLY7zXP0/YatoS7U
         t6noz+WMznshxeq+jJ50QFq+/nXFmOnfopYvgTrYwpZq+YO0vrl17hjM9u56RT+E5nNC
         ALivwvtU8jgwXupyHq6e2hhX5Yh5I/EcYyIU5lai23f1ER1iXoITApanV2qFCpFGVkaQ
         P9aA==
X-Gm-Message-State: APjAAAX4oiQ4GDUoDqKl0su3mNa6eMkj5v0MY+Wc+5NoQCJA1mmnoafg
        k69Bq1NHafGXlDqIXa8GzBQs0I+AeQOw9tpRmiWzotapmOM=
X-Google-Smtp-Source: APXvYqwwwBuUBCt7oqEwdI8TI1PlPWwkwe5zKEfrYA6s60h8NummaGNVZdFHXmYdZXHuWxAqMUcCKTRj1ImrgTkeu60=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr5028401wme.24.1571367619176;
 Thu, 17 Oct 2019 20:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-10-hch@lst.de>
In-Reply-To: <20191017173743.5430-10-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:30:08 +0530
Message-ID: <CAAhSdy288Mue2YE-MWNW9KcYvF_5qswpqjeMycxiN0GGNMHNOg@mail.gmail.com>
Subject: Re: [PATCH 09/15] riscv: provide native clint access for M-mode
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> RISC-V has the concept of a cpu level interrupt controller.  The
> interface for it is split between a standardized part that is exposed
> as bits in the mstatus/sstatus register and the mie/mip/sie/sip
> CRS.  But the bit to actually trigger IPIs is not standardized and
> just mentioned as implementable using MMIO.
>
> Add support for IPIs using MMIO using the SiFive clint layout (which is
> also shared by Ariane, Kendrye and the Qemu virt platform).  Additional
> the MMIO block also support the time value and timer compare registers,
> so they are also set up using the same OF node.  Support for other
> layouts should also be relatively easy to add in the future.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/clint.h | 39 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/sbi.h   |  2 ++
>  arch/riscv/kernel/Makefile     |  1 +
>  arch/riscv/kernel/clint.c      | 44 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c      |  2 ++
>  arch/riscv/kernel/smp.c        | 16 ++++++++++---
>  arch/riscv/kernel/smpboot.c    |  4 ++++
>  7 files changed, 105 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/clint.h
>  create mode 100644 arch/riscv/kernel/clint.c
>
> diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> new file mode 100644
> index 000000000000..02a26b68f21d
> --- /dev/null
> +++ b/arch/riscv/include/asm/clint.h
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef _ASM_CLINT_H
> +#define _ASM_CLINT_H 1
> +
> +#include <linux/io.h>
> +#include <linux/smp.h>
> +
> +#ifdef CONFIG_RISCV_M_MODE
> +extern u32 __iomem *clint_ipi_base;
> +
> +void clint_init_boot_cpu(void);
> +
> +static inline void clint_send_ipi_single(unsigned long hartid)
> +{
> +       writel(1, clint_ipi_base + hartid);
> +}
> +
> +static inline void clint_send_ipi_mask(const struct cpumask *hartid_mask)
> +{
> +       int hartid;
> +
> +       for_each_cpu(hartid, hartid_mask)
> +               clint_send_ipi_single(hartid);
> +}
> +
> +static inline void clint_clear_ipi(unsigned long hartid)
> +{
> +       writel(0, clint_ipi_base + hartid);
> +}
> +#else /* CONFIG_RISCV_M_MODE */
> +#define clint_init_boot_cpu()  do { } while (0)
> +
> +/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
> +void clint_send_ipi_single(unsigned long hartid);
> +void clint_send_ipi_mask(const struct cpumask *hartid_mask);
> +void clint_clear_ipi(unsigned long hartid);
> +#endif /* CONFIG_RISCV_M_MODE */
> +
> +#endif /* _ASM_CLINT_H */
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index a4774bafe033..407d1024f9eb 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -97,6 +97,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
>  void sbi_set_timer(uint64_t stime_value);
> +void sbi_clear_ipi(void);
> +void sbi_send_ipi(const unsigned long *hart_mask);
>  void sbi_remote_fence_i(const unsigned long *hart_mask);
>  #endif /* CONFIG_RISCV_SBI */
>  #endif /* _ASM_RISCV_SBI_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d8c35fa93cc6..2dca51046899 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -29,6 +29,7 @@ obj-y += vdso.o
>  obj-y  += cacheinfo.o
>  obj-y  += vdso/
>
> +obj-$(CONFIG_RISCV_M_MODE)     += clint.o
>  obj-$(CONFIG_FPU)              += fpu.o
>  obj-$(CONFIG_SMP)              += smpboot.o
>  obj-$(CONFIG_SMP)              += smp.o
> diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
> new file mode 100644
> index 000000000000..3647980d14c3
> --- /dev/null
> +++ b/arch/riscv/kernel/clint.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Christoph Hellwig.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/types.h>
> +#include <asm/clint.h>
> +#include <asm/csr.h>
> +#include <asm/timex.h>
> +#include <asm/smp.h>
> +
> +/*
> + * This is the layout used by the SiFive clint, which is also shared by the qemu
> + * virt platform, and the Kendryte KD210 at least.
> + */
> +#define CLINT_IPI_OFF          0
> +#define CLINT_TIME_CMP_OFF     0x4000
> +#define CLINT_TIME_VAL_OFF     0xbff8
> +
> +u32 __iomem *clint_ipi_base;
> +
> +void clint_init_boot_cpu(void)
> +{
> +       struct device_node *np;
> +       void __iomem *base;
> +
> +       np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
> +       if (!np) {
> +               panic("clint not found");
> +               return;
> +       }
> +
> +       base = of_iomap(np, 0);
> +       if (!base)
> +               panic("could not map CLINT");
> +
> +       clint_ipi_base = base + CLINT_IPI_OFF;
> +       riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
> +       riscv_time_val = base + CLINT_TIME_VAL_OFF;
> +
> +       clint_clear_ipi(boot_cpu_hartid);
> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a990a6cb184f..f4ba71b66c73 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
>
> +#include <asm/clint.h>
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> @@ -65,6 +66,7 @@ void __init setup_arch(char **cmdline_p)
>         setup_bootmem();
>         paging_init();
>         unflatten_device_tree();
> +       clint_init_boot_cpu();
>
>  #ifdef CONFIG_SWIOTLB
>         swiotlb_init(1);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b18cd6c8e8fb..c46df9c2e927 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -14,6 +14,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/delay.h>
>
> +#include <asm/clint.h>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> @@ -90,7 +91,10 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>         smp_mb__after_atomic();
>
>         riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
> -       sbi_send_ipi(cpumask_bits(&hartid_mask));
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               sbi_send_ipi(cpumask_bits(&hartid_mask));
> +       else
> +               clint_send_ipi_mask(&hartid_mask);
>  }
>
>  static void send_ipi_single(int cpu, enum ipi_message_type op)
> @@ -101,12 +105,18 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
>         set_bit(op, &ipi_data[cpu].bits);
>         smp_mb__after_atomic();
>
> -       sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
> +       else
> +               clint_send_ipi_single(hartid);
>  }
>
>  static inline void clear_ipi(void)
>  {
> -       csr_clear(CSR_SIP, SIE_SSIE);
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               csr_clear(CSR_SIP, SIE_SSIE);
> +       else
> +               clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
>  }
>
>  void riscv_software_interrupt(void)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 18ae6da5115e..6300b09f1d1d 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/mm.h>
> +#include <asm/clint.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -134,6 +135,9 @@ asmlinkage void __init smp_callin(void)
>  {
>         struct mm_struct *mm = &init_mm;
>
> +       if (!IS_ENABLED(CONFIG_RISCV_SBI))
> +               clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
> +
>         /* All kernel threads share the same mm context.  */
>         mmgrab(mm);
>         current->active_mm = mm;
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
