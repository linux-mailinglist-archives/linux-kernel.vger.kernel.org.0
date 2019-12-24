Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12612A0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLXLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:45:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33422 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:45:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so19649141wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2A+jytmQtdRl5GWvKCNixqLctCErGg5OSi0+wUYw3c=;
        b=TSAWbKG7l1Mx31P9nWN9bN+h45z+8h1n9g0CGmfExqPzKwlrZMMhVOEGsSfGKk9YYh
         PehRIq05XUTWtcpJeI/4U54dWkcMv9ZbmzzW6VPrBypuOPtfJ1CRN2n3CYS4fFdJmyO9
         ydYzOG+P8bF1JTAV3WOJNNzyfJSCQwTxWB83ra39KnUQ41dxUtciVpkGDuHoRDaxGZoQ
         5yyig7BLl2q+7ySuUPj9QDGLimwWShIm07mdZ4xjju8QKXFevJ7LH88F7FIKVHYGaYOX
         1MTvqJCpM2Xo0qCZtBftdS45xRrv2vKg4rT6NvpTXKNpd5hk0lM9EZSwiRHpM05H4LTK
         zvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2A+jytmQtdRl5GWvKCNixqLctCErGg5OSi0+wUYw3c=;
        b=leEcnVdisxulaKLf80yzuKbRWuY4ZU0nUw5YfVkVzcvahuAQWU3yJ3GvvhGEu/2AEC
         P0KEURK3pp/lqQtTp0A+FALUCSQMkry4VbYOm9HFi6iRolbbRDlRElHIzV/bl+IcGOxz
         6w31CIHbVqWfCgptQyfBr8fepKZf0/oZpMUIYTY/lhLbqtHGTlqMpgVZ8JdutQo5wOMJ
         As3Qmp0ELP5EYxdG6UxEe+dU68mfa4Lh3AuFQed8aFutU1BDpvxG0WNLE88EEnD1hdOH
         2i+xrYcCbQ5I/lT+lWkDuSHScDWNSGB0TTOIbcm2rYUvjyR/6+nlqUP4GXUTRTHjIzOp
         QVCg==
X-Gm-Message-State: APjAAAUBbC9EBmxuzJiS16ITCzf1iS2RSLfmNgnjy39eUT7ECEYIeB2z
        utvLPfbeFiRv2TsZuHdvhcQbRQRT+9gK5F4/0d/J1Q==
X-Google-Smtp-Source: APXvYqwRh/KSiwM5T+71pwzpL2M/9YEGsoP2Z3iVu3tI9znq3viSZjOlbFFFN2d/aWJuV8VcE7oAj5LmoYZU22I0gYM=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr33755276wrn.251.1577187903578;
 Tue, 24 Dec 2019 03:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20191224085544.24960-1-greentime.hu@sifive.com>
 <CAAhSdy0Ot4m7feJa94WJ6h+o_5-fPbdU6Dzs1az2YcH2qq33Mg@mail.gmail.com> <CAHCEehJKkgxMd3i-K4N6uzQmJ2nYEtB0w7nBVr1-Lh7xYSi6+A@mail.gmail.com>
In-Reply-To: <CAHCEehJKkgxMd3i-K4N6uzQmJ2nYEtB0w7nBVr1-Lh7xYSi6+A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 24 Dec 2019 17:14:52 +0530
Message-ID: <CAAhSdy2SV7WPKJGGXAaX8xN3rOSg-r0itDw4fHjoThgOuC5t2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Add numa support for riscv64 platform
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Greentime Hu <green.hu@gmail.com>, Christoph Hellwig <hch@lst.de>,
        greentime@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 5:03 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> Hi Anup,
>
> On Tue, Dec 24, 2019 at 6:28 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > +Christoph, +Mike, +Ganpatro
> >
> > On Tue, Dec 24, 2019 at 2:25 PM Greentime Hu <greentime.hu@sifive.com> wrote:
> > >
> > > This implementation is based on arm64 porting. It is tested with
> > > qemu-system-riscv64, unleashed board and OmniXtend FPGA platform.
> > >
> > > There will be 2 nodes in /sys/devices/system/node if it is described in dts and
> > > CONFIG_NUMA is enabled. We can use numastat/numactl/numademo to see its status.
> >
> > This patch can be broken down into separate (more granular) patches.
> > For example:
> > 1. asm/pgtable.h change can be separate patch
> > 2. Movement of unflatten_device_tree() from setup_arch() to paging_init()
> > 3. changes in kernel/smpboot.c can also be separate patch
> >
> > Also, since this is ported from arm64 implementation, I strongly
> > suggest having a generic NUMA support which can be shared
> > between arm64 and riscv. I think Ganpat (CC'ed) here could be
> > the best person to maintain the generic NUMA support since he
> > originally added it for arm64.
> >
> > >
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > ---
> > >  arch/riscv/Kconfig               |  30 ++-
> > >  arch/riscv/include/asm/mmzone.h  |  13 ++
> > >  arch/riscv/include/asm/numa.h    |  46 ++++
> > >  arch/riscv/include/asm/pci.h     |  10 +
> > >  arch/riscv/include/asm/pgtable.h |  20 ++
> > >  arch/riscv/kernel/setup.c        |  26 ++-
> > >  arch/riscv/kernel/smpboot.c      |  20 +-
> > >  arch/riscv/mm/Makefile           |   1 +
> > >  arch/riscv/mm/init.c             |   3 +
> > >  arch/riscv/mm/numa.c             | 372 +++++++++++++++++++++++++++++++
> > >  10 files changed, 536 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/mmzone.h
> > >  create mode 100644 arch/riscv/include/asm/numa.h
> > >  create mode 100644 arch/riscv/mm/numa.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index bc7598fc5f00..53ae1816df50 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -22,7 +22,6 @@ config RISCV
> > >         select CLONE_BACKWARDS
> > >         select COMMON_CLK
> > >         select GENERIC_CLOCKEVENTS
> > > -       select GENERIC_CPU_DEVICES
> > >         select GENERIC_IRQ_SHOW
> > >         select GENERIC_PCI_IOMAP
> > >         select GENERIC_SCHED_CLOCK
> > > @@ -234,6 +233,35 @@ config TUNE_GENERIC
> > >         bool "generic"
> > >
> > >  endchoice
> > > +# Common NUMA Features
> > > +config NUMA
> > > +       bool "Numa Memory Allocation and Scheduler Support"
> > > +       select OF_NUMA
> > > +       select ARCH_SUPPORTS_NUMA_BALANCING
> > > +       depends on SPARSEMEM
> > > +       help
> > > +         Enable NUMA (Non Uniform Memory Access) support.
> > > +
> > > +         The kernel will try to allocate memory used by a CPU on the
> > > +         local memory of the CPU and add some more
> > > +         NUMA awareness to the kernel.
> > > +
> > > +config NODES_SHIFT
> > > +       int "Maximum NUMA Nodes (as a power of 2)"
> > > +       range 1 10
> > > +       default "2"
> > > +       depends on NEED_MULTIPLE_NODES
> > > +       help
> > > +         Specify the maximum number of NUMA Nodes available on the target
> > > +         system.  Increases memory reserved to accommodate various tables.
> > > +
> > > +config USE_PERCPU_NUMA_NODE_ID
> > > +       def_bool y
> > > +       depends on NUMA
> > > +
> > > +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> > > +       def_bool y
> > > +       depends on NUMA
> > >
> > >  config RISCV_ISA_C
> > >         bool "Emit compressed instructions when building Linux"
> > > diff --git a/arch/riscv/include/asm/mmzone.h b/arch/riscv/include/asm/mmzone.h
> > > new file mode 100644
> > > index 000000000000..fa17e01d9ab2
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/mmzone.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_MMZONE_H
> > > +#define __ASM_MMZONE_H
> > > +
> > > +#ifdef CONFIG_NUMA
> > > +
> > > +#include <asm/numa.h>
> > > +
> > > +extern struct pglist_data *node_data[];
> > > +#define NODE_DATA(nid)         (node_data[(nid)])
> > > +
> > > +#endif /* CONFIG_NUMA */
> > > +#endif /* __ASM_MMZONE_H */
> > > diff --git a/arch/riscv/include/asm/numa.h b/arch/riscv/include/asm/numa.h
> > > new file mode 100644
> > > index 000000000000..10a4513d078b
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/numa.h
> > > @@ -0,0 +1,46 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_NUMA_H
> > > +#define __ASM_NUMA_H
> > > +
> > > +#include <asm/topology.h>
> > > +
> > > +#ifdef CONFIG_NUMA
> > > +
> > > +extern nodemask_t numa_nodes_parsed __initdata;
> > > +
> > > +extern bool numa_off;
> > > +
> > > +/* Mappings between node number and cpus on that node. */
> > > +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > > +void numa_clear_node(unsigned int cpu);
> > > +
> > > +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > > +const struct cpumask *cpumask_of_node(int node);
> > > +#else
> > > +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> > > +static inline const struct cpumask *cpumask_of_node(int node)
> > > +{
> > > +       return node_to_cpumask_map[node];
> > > +}
> > > +#endif
> > > +
> > > +void __init riscv_numa_init(void);
> > > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > > +void __init numa_set_distance(int from, int to, int distance);
> > > +void __init numa_free_distance(void);
> > > +void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> > > +void numa_store_cpu_info(unsigned int cpu);
> > > +void numa_add_cpu(unsigned int cpu);
> > > +void numa_remove_cpu(unsigned int cpu);
> > > +
> > > +#else  /* CONFIG_NUMA */
> > > +
> > > +static inline void numa_store_cpu_info(unsigned int cpu) { }
> > > +static inline void numa_add_cpu(unsigned int cpu) { }
> > > +static inline void numa_remove_cpu(unsigned int cpu) { }
> > > +static inline void riscv_numa_init(void) { }
> > > +static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > > +
> > > +#endif /* CONFIG_NUMA */
> > > +
> > > +#endif /* __ASM_NUMA_H */
> > > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> > > index 5ac8daa1cc36..781aa8b6dcd3 100644
> > > --- a/arch/riscv/include/asm/pci.h
> > > +++ b/arch/riscv/include/asm/pci.h
> > > @@ -32,6 +32,16 @@ static inline int pci_proc_domain(struct pci_bus *bus)
> > >         /* always show the domain in /proc */
> > >         return 1;
> > >  }
> > > +
> > > +#ifdef CONFIG_NUMA
> > > +int pcibus_to_node(struct pci_bus *bus);
> > > +#ifndef cpumask_of_pcibus
> > > +#define cpumask_of_pcibus(bus) (pcibus_to_node(bus) == -1 ?            \
> > > +                                cpu_all_mask :                         \
> > > +                                cpumask_of_node(pcibus_to_node(bus)))
> > > +#endif
> > > +#endif /* CONFIG_NUMA */
> > > +
> > >  #endif  /* CONFIG_PCI */
> > >
> > >  #endif  /* __ASM_PCI_H */
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > index d3221017194d..04b7c38870f7 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -175,6 +175,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> > >         return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> > >  }
> > >
> > > +static inline pte_t pmd_pte(pmd_t pmd)
> > > +{
> > > +       return __pte(pmd_val(pmd));
> > > +}
> > > +
> > >  /* Yields the page frame number (PFN) of a page table entry */
> > >  static inline unsigned long pte_pfn(pte_t pte)
> > >  {
> > > @@ -288,6 +293,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
> > >         return pte;
> > >  }
> > >
> > > +#ifdef CONFIG_NUMA_BALANCING
> > > +/*
> > > + * See the comment in include/asm-generic/pgtable.h
> > > + */
> > > +static inline int pte_protnone(pte_t pte)
> > > +{
> > > +       return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
> > > +}
> > > +
> > > +static inline int pmd_protnone(pmd_t pmd)
> > > +{
> > > +       return pte_protnone(pmd_pte(pmd));
> > > +}
> > > +#endif
> > > +
> > >  /* Modify page protection bits */
> > >  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> > >  {
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 845ae0e12115..f6f2354036a0 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -53,6 +53,31 @@ void __init parse_dtb(void)
> > >  #endif
> > >  }
> > >
> > > +static DEFINE_PER_CPU(struct cpu, cpu_devices);
> > > +
> > > +static int __init topology_init(void)
> > > +{
> > > +       int i, ret;
> > > +
> > > +#ifdef CONFIG_NEED_MULTIPLE_NODES
> > > +       for_each_online_node(i)
> > > +               register_one_node(i);
> > > +#endif
> > > +
> > > +       for_each_possible_cpu(i) {
> > > +               struct cpu *cpu = &per_cpu(cpu_devices, i);
> > > +
> > > +               cpu->hotpluggable = 1;
> >
> > Strange !!!
> >
> > We cannot claim CPUs are hotpluggable until Atish's
> > Linux SBI v0.2 HSM patches are available.
>
> Thanks. It should be set to 0 for now.
> cpu->hotpluggable = 0;
>
> > If required then Linux RISC-V NUMA patches should
> > be based upon Atish's Linux SBI v0.2 HSM support.
> >
> > > +               ret = register_cpu(cpu, i);
> > > +               if (unlikely(ret))
> > > +                       pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
> > > +                              __func__, i, ret);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +subsys_initcall(topology_init);
> > > +
> > >  void __init setup_arch(char **cmdline_p)
> > >  {
> > >         init_mm.start_code = (unsigned long) _stext;
> > > @@ -66,7 +91,6 @@ void __init setup_arch(char **cmdline_p)
> > >
> > >         setup_bootmem();
> > >         paging_init();
> > > -       unflatten_device_tree();
> >
> > Movement of unflatten_device_tree() call from here to
> > paging_init() needs explanation.
> >
>
> It is moved to paging_init() is because that of_numa_init() will use
> of_numa_parse_cpu_nodes() and of_numa_parse_memory_nodes().
> We have to unflatten_device_tree() first then we can call
> riscv_numa_init(), but riscv_numa_init() shall be called before
> memblocks_present() because the node information will be used in
> memblocks_present().
> So the order will be like this.
>
> unflatten_device_tree(); //To get dt information for memory and nodes
> riscv_numa_init(); //It can use of_numa_parse_* and set the nodes information
> memblocks_present(); //The node information can be used now

The reasoning is fine. Please split your patch into smaller patches
with detailed commit description in each patch.

Regards,
Anup
