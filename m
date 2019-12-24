Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3ED12A03B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 11:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLXK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 05:58:28 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37493 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfLXK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:58:28 -0500
Received: by mail-yb1-f195.google.com with SMTP id x14so8237464ybr.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yPzM4Hj9QiyQKVDwJdYAZcoFvt32Z4y6AEA6SmmL2c=;
        b=rPq4+fNlvQXZ1HtLGWyP1LnTuIO/U+31pvoDjE0XOCay3dzPAiedQvZDJDQKWm0p7v
         NFkq5YoWQDqwgIgz/vK6cFrSFKZZpx7veRqaEm9WHXstFjT4deJ790hXpF9N+hi/bC7v
         ScSybWvde8xdyWQY4oaUd4yAxIBVTLnvtReibm+uKdsyIKteEXjnzscBiNQ6IaiiqZNY
         1cy2h0ERIpYLVVxQ1of7rjpFKJq94ZVEz3tf5EqZvz9AwEEHp7jxzz8sISMIItBNuNlx
         rvKhQp7U3BrW98G2/aWFSxgZbM/FBy4xQSX4BWlRAIeJp0HVDtj2Ejfps6Ec1G9/eptT
         rwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yPzM4Hj9QiyQKVDwJdYAZcoFvt32Z4y6AEA6SmmL2c=;
        b=U41uB1B3yOASl8dXVcXkluXvjtwyyJGa8ACrDlGVUbP8Tyx88RXvZD8maU/vo/I83o
         GJn6yw1cglJ0pWunRCO0mWwQGbho0sTIIVYUOtb+v5VA1NENM1DlMG4HsEbE1gEO8fIe
         BcBak3QpfB69BuKGHUckI/ENmXeCmOeoEVZ+XyoAkT7f5v6Am+r2a+4WMNDlaokulPvU
         D6Ogn2f49pSu+Hm1kHX3lSlXQv+KfP5s0vf6tLACbT9dYeARcUggHGZmPTci3LuoCwiT
         oW3WgsvUzq+W8eZacPyUfqhBBoZ/ZqwYmyFMYMkZctG1odJRJ+uo9+uMQU1+YoUx6oav
         xvJg==
X-Gm-Message-State: APjAAAVS7Je3NskGsMU4BDUhqPqiJ53AbOThkYWn5L97ps+s3/gcAcvt
        v5k2XivWOPFnLg6F9iooZBAI0WCLzsD8MLYdgew=
X-Google-Smtp-Source: APXvYqy6zn8Ix3a3/WBu6YqzcIW9k3ssVTVzT/XBkObhuNqsGHER8GC27cf6NnVQ74v+gYfukV/6CPoeCQM+Y5eG+us=
X-Received: by 2002:a25:37ca:: with SMTP id e193mr24424303yba.241.1577185106403;
 Tue, 24 Dec 2019 02:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20191224085544.24960-1-greentime.hu@sifive.com> <CAAhSdy0Ot4m7feJa94WJ6h+o_5-fPbdU6Dzs1az2YcH2qq33Mg@mail.gmail.com>
In-Reply-To: <CAAhSdy0Ot4m7feJa94WJ6h+o_5-fPbdU6Dzs1az2YcH2qq33Mg@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 24 Dec 2019 16:28:14 +0530
Message-ID: <CAKTKpr5p9=T8vOVg2erM7efAj2R6-sAOUZAZyzuFUROR9LUN7g@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Add numa support for riscv64 platform
To:     Anup Patel <anup@brainfault.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        Christoph Hellwig <hch@lst.de>, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Catalin, Will and Mark.

On Tue, Dec 24, 2019 at 4:00 PM Anup Patel <anup@brainfault.org> wrote:
>
> +Christoph, +Mike, +Ganpatro
>
> On Tue, Dec 24, 2019 at 2:25 PM Greentime Hu <greentime.hu@sifive.com> wrote:
> >
> > This implementation is based on arm64 porting. It is tested with
> > qemu-system-riscv64, unleashed board and OmniXtend FPGA platform.
> >
> > There will be 2 nodes in /sys/devices/system/node if it is described in dts and
> > CONFIG_NUMA is enabled. We can use numastat/numactl/numademo to see its status.
>
> This patch can be broken down into separate (more granular) patches.
> For example:
> 1. asm/pgtable.h change can be separate patch
> 2. Movement of unflatten_device_tree() from setup_arch() to paging_init()
> 3. changes in kernel/smpboot.c can also be separate patch
>
> Also, since this is ported from arm64 implementation, I strongly
> suggest having a generic NUMA support which can be shared
> between arm64 and riscv. I think Ganpat (CC'ed) here could be
> the best person to maintain the generic NUMA support since he
> originally added it for arm64.
>
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/Kconfig               |  30 ++-
> >  arch/riscv/include/asm/mmzone.h  |  13 ++
> >  arch/riscv/include/asm/numa.h    |  46 ++++
> >  arch/riscv/include/asm/pci.h     |  10 +
> >  arch/riscv/include/asm/pgtable.h |  20 ++
> >  arch/riscv/kernel/setup.c        |  26 ++-
> >  arch/riscv/kernel/smpboot.c      |  20 +-
> >  arch/riscv/mm/Makefile           |   1 +
> >  arch/riscv/mm/init.c             |   3 +
> >  arch/riscv/mm/numa.c             | 372 +++++++++++++++++++++++++++++++
> >  10 files changed, 536 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/mmzone.h
> >  create mode 100644 arch/riscv/include/asm/numa.h
> >  create mode 100644 arch/riscv/mm/numa.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bc7598fc5f00..53ae1816df50 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -22,7 +22,6 @@ config RISCV
> >         select CLONE_BACKWARDS
> >         select COMMON_CLK
> >         select GENERIC_CLOCKEVENTS
> > -       select GENERIC_CPU_DEVICES
> >         select GENERIC_IRQ_SHOW
> >         select GENERIC_PCI_IOMAP
> >         select GENERIC_SCHED_CLOCK
> > @@ -234,6 +233,35 @@ config TUNE_GENERIC
> >         bool "generic"
> >
> >  endchoice
> > +# Common NUMA Features
> > +config NUMA
> > +       bool "Numa Memory Allocation and Scheduler Support"
> > +       select OF_NUMA
> > +       select ARCH_SUPPORTS_NUMA_BALANCING
> > +       depends on SPARSEMEM
> > +       help
> > +         Enable NUMA (Non Uniform Memory Access) support.
> > +
> > +         The kernel will try to allocate memory used by a CPU on the
> > +         local memory of the CPU and add some more
> > +         NUMA awareness to the kernel.
> > +
> > +config NODES_SHIFT
> > +       int "Maximum NUMA Nodes (as a power of 2)"
> > +       range 1 10
> > +       default "2"
> > +       depends on NEED_MULTIPLE_NODES
> > +       help
> > +         Specify the maximum number of NUMA Nodes available on the target
> > +         system.  Increases memory reserved to accommodate various tables.
> > +
> > +config USE_PERCPU_NUMA_NODE_ID
> > +       def_bool y
> > +       depends on NUMA
> > +
> > +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> > +       def_bool y
> > +       depends on NUMA
> >
> >  config RISCV_ISA_C
> >         bool "Emit compressed instructions when building Linux"
> > diff --git a/arch/riscv/include/asm/mmzone.h b/arch/riscv/include/asm/mmzone.h
> > new file mode 100644
> > index 000000000000..fa17e01d9ab2
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/mmzone.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_MMZONE_H
> > +#define __ASM_MMZONE_H
> > +
> > +#ifdef CONFIG_NUMA
> > +
> > +#include <asm/numa.h>
> > +
> > +extern struct pglist_data *node_data[];
> > +#define NODE_DATA(nid)         (node_data[(nid)])
> > +
> > +#endif /* CONFIG_NUMA */
> > +#endif /* __ASM_MMZONE_H */
> > diff --git a/arch/riscv/include/asm/numa.h b/arch/riscv/include/asm/numa.h
> > new file mode 100644
> > index 000000000000..10a4513d078b
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/numa.h
> > @@ -0,0 +1,46 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_NUMA_H
> > +#define __ASM_NUMA_H
> > +
> > +#include <asm/topology.h>
> > +
> > +#ifdef CONFIG_NUMA
> > +
> > +extern nodemask_t numa_nodes_parsed __initdata;
> > +
> > +extern bool numa_off;
> > +
> > +/* Mappings between node number and cpus on that node. */
> > +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > +void numa_clear_node(unsigned int cpu);
> > +
> > +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > +const struct cpumask *cpumask_of_node(int node);
> > +#else
> > +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> > +static inline const struct cpumask *cpumask_of_node(int node)
> > +{
> > +       return node_to_cpumask_map[node];
> > +}
> > +#endif
> > +
> > +void __init riscv_numa_init(void);
> > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > +void __init numa_set_distance(int from, int to, int distance);
> > +void __init numa_free_distance(void);
> > +void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> > +void numa_store_cpu_info(unsigned int cpu);
> > +void numa_add_cpu(unsigned int cpu);
> > +void numa_remove_cpu(unsigned int cpu);
> > +
> > +#else  /* CONFIG_NUMA */
> > +
> > +static inline void numa_store_cpu_info(unsigned int cpu) { }
> > +static inline void numa_add_cpu(unsigned int cpu) { }
> > +static inline void numa_remove_cpu(unsigned int cpu) { }
> > +static inline void riscv_numa_init(void) { }
> > +static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > +
> > +#endif /* CONFIG_NUMA */
> > +
> > +#endif /* __ASM_NUMA_H */
> > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> > index 5ac8daa1cc36..781aa8b6dcd3 100644
> > --- a/arch/riscv/include/asm/pci.h
> > +++ b/arch/riscv/include/asm/pci.h
> > @@ -32,6 +32,16 @@ static inline int pci_proc_domain(struct pci_bus *bus)
> >         /* always show the domain in /proc */
> >         return 1;
> >  }
> > +
> > +#ifdef CONFIG_NUMA
> > +int pcibus_to_node(struct pci_bus *bus);
> > +#ifndef cpumask_of_pcibus
> > +#define cpumask_of_pcibus(bus) (pcibus_to_node(bus) == -1 ?            \
> > +                                cpu_all_mask :                         \
> > +                                cpumask_of_node(pcibus_to_node(bus)))
> > +#endif
> > +#endif /* CONFIG_NUMA */
> > +
> >  #endif  /* CONFIG_PCI */
> >
> >  #endif  /* __ASM_PCI_H */
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index d3221017194d..04b7c38870f7 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -175,6 +175,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> >         return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> >  }
> >
> > +static inline pte_t pmd_pte(pmd_t pmd)
> > +{
> > +       return __pte(pmd_val(pmd));
> > +}
> > +
> >  /* Yields the page frame number (PFN) of a page table entry */
> >  static inline unsigned long pte_pfn(pte_t pte)
> >  {
> > @@ -288,6 +293,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >         return pte;
> >  }
> >
> > +#ifdef CONFIG_NUMA_BALANCING
> > +/*
> > + * See the comment in include/asm-generic/pgtable.h
> > + */
> > +static inline int pte_protnone(pte_t pte)
> > +{
> > +       return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
> > +}
> > +
> > +static inline int pmd_protnone(pmd_t pmd)
> > +{
> > +       return pte_protnone(pmd_pte(pmd));
> > +}
> > +#endif
> > +
> >  /* Modify page protection bits */
> >  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >  {
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 845ae0e12115..f6f2354036a0 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -53,6 +53,31 @@ void __init parse_dtb(void)
> >  #endif
> >  }
> >
> > +static DEFINE_PER_CPU(struct cpu, cpu_devices);
> > +
> > +static int __init topology_init(void)
> > +{
> > +       int i, ret;
> > +
> > +#ifdef CONFIG_NEED_MULTIPLE_NODES
> > +       for_each_online_node(i)
> > +               register_one_node(i);
> > +#endif
> > +
> > +       for_each_possible_cpu(i) {
> > +               struct cpu *cpu = &per_cpu(cpu_devices, i);
> > +
> > +               cpu->hotpluggable = 1;
>
> Strange !!!
>
> We cannot claim CPUs are hotpluggable until Atish's
> Linux SBI v0.2 HSM patches are available.
>
> If required then Linux RISC-V NUMA patches should
> be based upon Atish's Linux SBI v0.2 HSM support.
>
> > +               ret = register_cpu(cpu, i);
> > +               if (unlikely(ret))
> > +                       pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
> > +                              __func__, i, ret);
> > +       }
> > +
> > +       return 0;
> > +}
> > +subsys_initcall(topology_init);
> > +
> >  void __init setup_arch(char **cmdline_p)
> >  {
> >         init_mm.start_code = (unsigned long) _stext;
> > @@ -66,7 +91,6 @@ void __init setup_arch(char **cmdline_p)
> >
> >         setup_bootmem();
> >         paging_init();
> > -       unflatten_device_tree();
>
> Movement of unflatten_device_tree() call from here to
> paging_init() needs explanation.
>
> >
> >  #ifdef CONFIG_SWIOTLB
> >         swiotlb_init(1);
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 261f4087cc39..bcb67ac403e4 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <asm/irq.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/numa.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/sections.h>
> >  #include <asm/sbi.h>
> > @@ -45,6 +46,11 @@ void __init smp_prepare_boot_cpu(void)
> >  void __init smp_prepare_cpus(unsigned int max_cpus)
> >  {
> >         int cpuid;
> > +       unsigned int this_cpu;
> > +
> > +       this_cpu = smp_processor_id();
> > +       numa_store_cpu_info(this_cpu);
> > +       numa_add_cpu(this_cpu);
> >
> >         /* This covers non-smp usecase mandated by "nosmp" option */
> >         if (max_cpus == 0)
> > @@ -54,6 +60,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >                 if (cpuid == smp_processor_id())
> >                         continue;
> >                 set_cpu_present(cpuid, true);
> > +               numa_store_cpu_info(cpuid);
> >         }
> >  }
> >
> > @@ -72,6 +79,7 @@ void __init setup_smp(void)
> >                 if (hart == cpuid_to_hartid_map(0)) {
> >                         BUG_ON(found_boot_cpu);
> >                         found_boot_cpu = 1;
> > +                       early_map_cpu_to_node(0, of_node_to_nid(dn));
> >                         continue;
> >                 }
> >                 if (cpuid >= NR_CPUS) {
> > @@ -81,6 +89,7 @@ void __init setup_smp(void)
> >                 }
> >
> >                 cpuid_to_hartid_map(cpuid) = hart;
> > +               early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
> >                 cpuid++;
> >         }
> >
> > @@ -136,15 +145,20 @@ void __init smp_cpus_done(unsigned int max_cpus)
> >  asmlinkage __visible void __init smp_callin(void)
> >  {
> >         struct mm_struct *mm = &init_mm;
> > +       unsigned int this_cpu;
> > +
> > +       this_cpu = smp_processor_id();
> >
> >         /* All kernel threads share the same mm context.  */
> >         mmgrab(mm);
> >         current->active_mm = mm;
> >
> >         trap_init();
> > -       notify_cpu_starting(smp_processor_id());
> > -       update_siblings_masks(smp_processor_id());
> > -       set_cpu_online(smp_processor_id(), 1);
> > +       notify_cpu_starting(this_cpu);
> > +       numa_store_cpu_info(this_cpu);
> > +       numa_add_cpu(this_cpu);
> > +       update_siblings_masks(this_cpu);
> > +       set_cpu_online(this_cpu, true);
> >         /*
> >          * Remote TLB flushes are ignored while the CPU is offline, so emit
> >          * a local TLB flush right now just in case.
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index 9d9a17335686..59c956c0b0d0 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -17,3 +17,4 @@ ifeq ($(CONFIG_MMU),y)
> >  obj-$(CONFIG_SMP) += tlbflush.o
> >  endif
> >  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> > +obj-$(CONFIG_NUMA)         += numa.o
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 573463d1c799..17c749744e05 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/sections.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/io.h>
> > +#include <asm/numa.h>
> >
> >  #include "../kernel/head.h"
> >
> > @@ -453,6 +454,8 @@ static void __init setup_vm_final(void)
> >  void __init paging_init(void)
> >  {
> >         setup_vm_final();
> > +       unflatten_device_tree();
> > +       riscv_numa_init();
> >         memblocks_present();
> >         sparse_init();
> >         setup_zero_page();
> > diff --git a/arch/riscv/mm/numa.c b/arch/riscv/mm/numa.c
> > new file mode 100644
> > index 000000000000..b679b2831990
> > --- /dev/null
> > +++ b/arch/riscv/mm/numa.c
> > @@ -0,0 +1,372 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NUMA support, based on the arm64 implementation.
> > + *
> > + * Copyright (C) 2015 Cavium Inc.
> > + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> > + * Copyright (C) 2019 SiFive, Inc
> > + */
> > +
> > +#define pr_fmt(fmt) "NUMA: " fmt
> > +
> > +#include <linux/memblock.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/device.h>
> > +#include <linux/pci.h>
> > +
> > +struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > +EXPORT_SYMBOL(node_data);
> > +nodemask_t numa_nodes_parsed __initdata;
> > +static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
> > +
> > +static u8 *numa_distance;
> > +static int numa_distance_cnt;
> > +bool numa_off;
> > +
> > +static __init int numa_parse_early_param(char *opt)
> > +{
> > +       if (!opt)
> > +               return -EINVAL;
> > +       if (str_has_prefix(opt, "off"))
> > +               numa_off = true;
> > +
> > +       return 0;
> > +}
> > +early_param("numa", numa_parse_early_param);
> > +
> > +cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > +EXPORT_SYMBOL(node_to_cpumask_map);
> > +
> > +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > +
> > +/*
> > + * Returns a pointer to the bitmask of CPUs on Node 'node'.
> > + */
> > +const struct cpumask *cpumask_of_node(int node)
> > +{
> > +       if (WARN_ON(node >= nr_node_ids))
> > +               return cpu_none_mask;
> > +
> > +       if (WARN_ON(node_to_cpumask_map[node] == NULL))
> > +               return cpu_online_mask;
> > +
> > +       return node_to_cpumask_map[node];
> > +}
> > +EXPORT_SYMBOL(cpumask_of_node);
> > +
> > +#endif
> > +
> > +int pcibus_to_node(struct pci_bus *bus)
> > +{
> > +       return dev_to_node(&bus->dev);
> > +}
> > +EXPORT_SYMBOL(pcibus_to_node);
> > +
> > +static void numa_update_cpu(unsigned int cpu, bool remove)
> > +{
> > +       int nid = cpu_to_node(cpu);
> > +
> > +       if (nid == NUMA_NO_NODE)
> > +               return;
> > +
> > +       if (remove)
> > +               cpumask_clear_cpu(cpu, node_to_cpumask_map[nid]);
> > +       else
> > +               cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
> > +}
> > +
> > +void numa_add_cpu(unsigned int cpu)
> > +{
> > +       numa_update_cpu(cpu, false);
> > +}
> > +
> > +/*
> > + * Set the cpu to node and mem mapping
> > + */
> > +void numa_store_cpu_info(unsigned int cpu)
> > +{
> > +       set_cpu_numa_node(cpu, cpu_to_node_map[cpu]);
> > +}
> > +
> > +void __init early_map_cpu_to_node(unsigned int cpu, int nid)
> > +{
> > +       /* fallback to node 0 */
> > +       if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
> > +               nid = 0;
> > +
> > +       cpu_to_node_map[cpu] = nid;
> > +
> > +       /*
> > +        * We should set the numa node of cpu0 as soon as possible, because it
> > +        * has already been set up online before. cpu_to_node(0) will soon be
> > +        * called.
> > +        */
> > +       if (!cpu)
> > +               set_cpu_numa_node(cpu, nid);
> > +}
> > +
> > +static int __init numa_alloc_distance(void)
> > +{
> > +       size_t size;
> > +       u64 phys;
> > +       int i, j;
> > +
> > +       size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
> > +       phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
> > +                                     size, PAGE_SIZE);
> > +       if (WARN_ON(!phys))
> > +               return -ENOMEM;
> > +
> > +       memblock_reserve(phys, size);
> > +
> > +       numa_distance = __va(phys);
> > +       numa_distance_cnt = nr_node_ids;
> > +
> > +       /* fill with the default distances */
> > +       for (i = 0; i < numa_distance_cnt; i++)
> > +               for (j = 0; j < numa_distance_cnt; j++)
> > +                       numa_distance[i * numa_distance_cnt + j] = i == j ?
> > +                               LOCAL_DISTANCE : REMOTE_DISTANCE;
> > +
> > +       pr_debug("Initialized distance table, cnt=%d\n", numa_distance_cnt);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * numa_add_memblk() - Set node id to memblk
> > + * @nid: NUMA node ID of the new memblk
> > + * @start: Start address of the new memblk
> > + * @end:  End address of the new memblk
> > + *
> > + * RETURNS:
> > + * 0 on success, -errno on failure.
> > + */
> > +int __init numa_add_memblk(int nid, u64 start, u64 end)
> > +{
> > +       int ret;
> > +
> > +       ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
> > +       if (ret < 0) {
> > +               pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
> > +                       start, (end - 1), nid);
> > +               return ret;
> > +       }
> > +
> > +       node_set(nid, numa_nodes_parsed);
> > +       return ret;
> > +}
> > +
> > +/*
> > + * Initialize NODE_DATA for a node on the local memory
> > + */
> > +static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> > +{
> > +       const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
> > +       u64 nd_pa;
> > +       void *nd;
> > +       int tnid;
> > +
> > +       if (start_pfn >= end_pfn)
> > +               pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
> > +
> > +       nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> > +       if (!nd_pa)
> > +               panic("Cannot allocate %zu bytes for node %d data\n",
> > +                     nd_size, nid);
> > +
> > +       nd = __va(nd_pa);
> > +
> > +       /* report and initialize */
> > +       pr_info("NODE_DATA [mem %#010Lx-%#010Lx]\n",
> > +               nd_pa, nd_pa + nd_size - 1);
> > +       tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> > +       if (tnid != nid)
> > +               pr_info("NODE_DATA(%d) on node %d\n", nid, tnid);
> > +
> > +       node_data[nid] = nd;
> > +       memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> > +       NODE_DATA(nid)->node_id = nid;
> > +       NODE_DATA(nid)->node_start_pfn = start_pfn;
> > +       NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
> > +}
> > +
> > +void __init numa_set_distance(int from, int to, int distance)
> > +{
> > +       if (!numa_distance) {
> > +               pr_warn_once("Warning: distance table not allocated yet\n");
> > +               return;
> > +       }
> > +
> > +       if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
> > +                       from < 0 || to < 0) {
> > +               pr_warn_once("Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
> > +                           from, to, distance);
> > +               return;
> > +       }
> > +
> > +       if ((u8)distance != distance ||
> > +           (from == to && distance != LOCAL_DISTANCE)) {
> > +               pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
> > +                            from, to, distance);
> > +               return;
> > +       }
> > +
> > +       numa_distance[from * numa_distance_cnt + to] = distance;
> > +}
> > +
> > +/*
> > + * Return NUMA distance @from to @to
> > + */
> > +int __node_distance(int from, int to)
> > +{
> > +       if (from >= numa_distance_cnt || to >= numa_distance_cnt)
> > +               return from == to ? LOCAL_DISTANCE : REMOTE_DISTANCE;
> > +       return numa_distance[from * numa_distance_cnt + to];
> > +}
> > +EXPORT_SYMBOL(__node_distance);
> > +
> > +static int __init numa_register_nodes(void)
> > +{
> > +       int nid;
> > +       struct memblock_region *mblk;
> > +
> > +       /* Check that valid nid is set to memblks */
> > +       for_each_memblock(memory, mblk)
> > +               if (mblk->nid == NUMA_NO_NODE || mblk->nid >= MAX_NUMNODES) {
> > +                       pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> > +                               mblk->nid, mblk->base,
> > +                               mblk->base + mblk->size - 1);
> > +                       return -EINVAL;
> > +               }
> > +
> > +       /* Finally register nodes. */
> > +       for_each_node_mask(nid, numa_nodes_parsed) {
> > +               unsigned long start_pfn, end_pfn;
> > +
> > +               get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> > +               setup_node_data(nid, start_pfn, end_pfn);
> > +               node_set_online(nid);
> > +       }
> > +
> > +       /* Setup online nodes to actual nodes*/
> > +       node_possible_map = numa_nodes_parsed;
> > +
> > +       return 0;
> > +}
> > +static void __init setup_node_to_cpumask_map(void)
> > +{
> > +       int node;
> > +
> > +       /* setup nr_node_ids if not done yet */
> > +       if (nr_node_ids == MAX_NUMNODES)
> > +               setup_nr_node_ids();
> > +
> > +       /* allocate and clear the mapping */
> > +       for (node = 0; node < nr_node_ids; node++) {
> > +               alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
> > +               cpumask_clear(node_to_cpumask_map[node]);
> > +       }
> > +
> > +       /* cpumask_of_node() will now work */
> > +       pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
> > +}
> > +
> > +void __init numa_free_distance(void)
> > +{
> > +       size_t size;
> > +
> > +       if (!numa_distance)
> > +               return;
> > +
> > +       size = numa_distance_cnt * numa_distance_cnt *
> > +               sizeof(numa_distance[0]);
> > +
> > +       memblock_free(__pa(numa_distance), size);
> > +       numa_distance_cnt = 0;
> > +       numa_distance = NULL;
> > +}
> > +static int __init numa_init(int (*init_func)(void))
> > +{
> > +       int ret;
> > +
> > +       nodes_clear(numa_nodes_parsed);
> > +       nodes_clear(node_possible_map);
> > +       nodes_clear(node_online_map);
> > +
> > +       ret = numa_alloc_distance();
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = init_func();
> > +       if (ret < 0)
> > +               goto out_free_distance;
> > +
> > +       if (nodes_empty(numa_nodes_parsed)) {
> > +               pr_info("No NUMA configuration found\n");
> > +               ret = -EINVAL;
> > +               goto out_free_distance;
> > +       }
> > +
> > +       ret = numa_register_nodes();
> > +       if (ret < 0)
> > +               goto out_free_distance;
> > +
> > +       setup_node_to_cpumask_map();
> > +
> > +       return 0;
> > +out_free_distance:
> > +       numa_free_distance();
> > +       return ret;
> > +}
> > +
> > +/**
> > + * dummy_numa_init() - Fallback dummy NUMA init
> > + *
> > + * Used if there's no underlying NUMA architecture, NUMA initialization
> > + * fails, or NUMA is disabled on the command line.
> > + *
> > + * Must online at least one node (node 0) and add memory blocks that cover all
> > + * allowed memory. It is unlikely that this function fails.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +static int __init dummy_numa_init(void)
> > +{
> > +       int ret;
> > +       struct memblock_region *mblk;
> > +
> > +       if (numa_off)
> > +               pr_info("NUMA disabled\n"); /* Forced off on command line. */
> > +       pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n",
> > +               memblock_start_of_DRAM(), memblock_end_of_DRAM() - 1);
> > +
> > +       for_each_memblock(memory, mblk) {
> > +               ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
> > +               if (!ret)
> > +                       continue;
> > +
> > +               pr_err("NUMA init failed\n");
> > +               return ret;
> > +       }
> > +
> > +       numa_off = true;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * riscv_numa_init() - Initialize NUMA
> > + *
> > + * Try each configured NUMA initialization method until one succeeds. The
> > + * last fallback is dummy single node config encomapssing whole memory.
> > + */
> > +void __init riscv_numa_init(void)
> > +{
> > +       if (!numa_off) {
> > +               if (!numa_init(of_numa_init))
> > +                       return;
> > +       }
> > +
> > +       numa_init(dummy_numa_init);
> > +}
> > --
> > 2.17.1
> >
>
> Regards,
> Anup

Thanks,
Ganapat
