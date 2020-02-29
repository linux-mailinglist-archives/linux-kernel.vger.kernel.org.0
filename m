Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746E2174711
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgB2Nb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 08:31:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgB2Nb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:31:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6692750wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE9aFfpApAFVlSFBYBDEJYtuwrgVB6eyYMUjWGBuC/w=;
        b=Lwz1EJsFZ9Lk7VKmUgzWqiMHcQFCAzkOhViiS1HdECbEzoOtB2QWeYhddcIG9C0QKz
         XuWqk85/k7fENLfJWiu7YLUM6RolaL0XqJ+FOWXElgLlqf4tp7L191zzBz8qtnxeWiVK
         vDGiHtaHrPux95HNYaAawFqgfV39rmEgBX3YW+vfHrJReDrB211mHBxW+sWIiTecNbtp
         5AxHEUhg7Ggv1UIe+rWGtqnHv3iT0EqFm5NRFMXDp+NwWQBVjCzQDng9HVIk/lsx5LJg
         o3QWovhi2MV06RyTzWoB2o3vVjAx7fHZIMPSA6L9eGHyBwQ1BM15crrfC2G1Iy8PV84v
         kh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE9aFfpApAFVlSFBYBDEJYtuwrgVB6eyYMUjWGBuC/w=;
        b=D7KHYC3f4CjLLZw1O4ihdSDljfsbsFmGSRvYJM2cw9ZPUGy20lmqDu0qvaS8zp+Z7/
         4sNSxNHAsAvLs6NZ527z3Yy8WDtfKre85RdfsOUQFW+9Biz+NjoFmsjNcbMMIm5ocHzU
         Gh4dT2/d8JAm4Qmmm+ySfNcLvnjuERwe0HPepJ862fvl8HbaLkOVWPYCpj91f2qDubKN
         l4VeAlnAQhD6VXQGq5jfzG7Gk/Eh9YKxHu1pYQ5+ROukeuOXH1HnjcWdbReKEAZDaKjP
         P//eX5fqsjduGJhMQc/QNRU4sWqaRlnCbvR1MoEWvASe+pk0ahMTV4e+7AsnfA/yRdws
         MCpw==
X-Gm-Message-State: APjAAAWJAvl6zSrPsftLNQI6WFTCXvDTrDbSzB6nbepiAg4iZtTeNbYN
        gIvE90Z10H6n+JctjuEcvD0st8zuPkjn09oELrsEww==
X-Google-Smtp-Source: APXvYqwxVx5wghY0fHNC9PMV7GnNKvHdhDAfBAYO4HSOUmKTvC2E8QzCsuRjBXjpIu5vWTReJet/MWx+Vgz0Qr4LI7g=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr10701497wrs.230.1582983112454;
 Sat, 29 Feb 2020 05:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20200229124449.22797-1-alex@ghiti.fr>
In-Reply-To: <20200229124449.22797-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 29 Feb 2020 19:01:39 +0530
Message-ID: <CAAhSdy3pfLkoNefEu_jKB29TRLOLyifMUNU1fbXyvzWaY0kjeA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Introduce CONFIG_RELOCATABLE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 6:14 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This config allows to compile the kernel as PIE and to relocate it at any
> virtual address at runtime: this paves the way to KASLR and to 4-level
> page table folding at runtime. Runtime relocation is possible since
> relocation metadata are embedded into the kernel.
>
> Note that relocating at runtime introduces an overhead even if the kernel
> is loaded at the same address it was linked at and that the compiler
> options are those used in arm64 which uses the same RELA relocation format.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Tested-by: Zong Li <zong.li@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Changes in v2:
> - Make RELOCATABLE depend on MMU as suggested by Anup
> - Rename kernel_load_addr into kernel_virt_addr as suggested by Anup
> - Use __pa_symbol instead of __pa, as suggested by Zong
> - Rebased on top of v5.6-rc3
> - Tested with sv48 patchset
> - Add Reviewed/Tested-by from Zong
>
>  arch/riscv/Kconfig              | 12 +++++
>  arch/riscv/Makefile             |  5 +-
>  arch/riscv/boot/loader.lds.S    |  2 +-
>  arch/riscv/include/asm/page.h   |  5 +-
>  arch/riscv/kernel/head.S        |  3 +-
>  arch/riscv/kernel/vmlinux.lds.S | 10 ++--
>  arch/riscv/mm/Makefile          |  4 ++
>  arch/riscv/mm/init.c            | 92 ++++++++++++++++++++++++++++-----
>  8 files changed, 111 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 73f029eae0cc..f5f3d474504d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,18 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> +config RELOCATABLE
> +       bool
> +       depends on MMU
> +       help
> +          This builds a kernel as a Position Independent Executable (PIE),
> +          which retains all relocation metadata required to relocate the
> +          kernel binary at runtime to a different virtual address than the
> +          address it was linked at.
> +          Since RISCV uses the RELA relocation format, this requires a
> +          relocation pass at runtime even if the kernel is loaded at the
> +          same address it was linked at.
> +
>  source "arch/riscv/Kconfig.socs"
>
>  menu "Platform type"
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index b9009a2fbaf5..5a115cf6a9c1 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -9,7 +9,10 @@
>  #
>
>  OBJCOPYFLAGS    := -O binary
> -LDFLAGS_vmlinux :=
> +ifeq ($(CONFIG_RELOCATABLE),y)
> +LDFLAGS_vmlinux := -shared -Bsymbolic -z notext -z norelro
> +KBUILD_CFLAGS += -fPIE
> +endif
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>         LDFLAGS_vmlinux := --no-relax
>  endif
> diff --git a/arch/riscv/boot/loader.lds.S b/arch/riscv/boot/loader.lds.S
> index 47a5003c2e28..a9ed218171aa 100644
> --- a/arch/riscv/boot/loader.lds.S
> +++ b/arch/riscv/boot/loader.lds.S
> @@ -7,7 +7,7 @@ ENTRY(_start)
>
>  SECTIONS
>  {
> -       . = PAGE_OFFSET;
> +       . = CONFIG_PAGE_OFFSET;
>
>         .payload : {
>                 *(.payload)
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 8ca1930caa44..af5810f9aebd 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -31,9 +31,9 @@
>   * When not using MMU this corresponds to the first free page in
>   * physical memory (aligned on a page boundary).
>   */
> -#define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> +#define PAGE_OFFSET            kernel_virt_addr
>
> -#define KERN_VIRT_SIZE (-PAGE_OFFSET)
> +#define KERN_VIRT_SIZE         (-_AC(CONFIG_PAGE_OFFSET, UL))
>
>  #ifndef __ASSEMBLY__
>
> @@ -97,6 +97,7 @@ extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
>
> +extern unsigned long kernel_virt_addr;
>  extern unsigned long max_low_pfn;
>  extern unsigned long min_low_pfn;
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 271860fc2c3f..d792912c2da3 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -131,7 +131,8 @@ clear_bss_done:
>  #ifdef CONFIG_MMU
>  relocate:
>         /* Relocate return address */
> -       li a1, PAGE_OFFSET
> +       la a1, kernel_virt_addr
> +       REG_L a1, 0(a1)
>         la a2, _start
>         sub a1, a1, a2
>         add ra, ra, a1
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 1e0193ded420..5bf69e9b91e6 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>
> -#define LOAD_OFFSET PAGE_OFFSET
> +#define LOAD_OFFSET CONFIG_PAGE_OFFSET
>  #include <asm/vmlinux.lds.h>
>  #include <asm/page.h>
>  #include <asm/cache.h>
> @@ -71,9 +71,11 @@ SECTIONS
>
>         EXCEPTION_TABLE(0x10)
>
> -       .rel.dyn : {
> -               *(.rel.dyn*)
> -       }
> +        .rela.dyn : ALIGN(8) {
> +               __rela_dyn_start = .;
> +                *(.rela .rela*)
> +               __rela_dyn_end = .;
> +        }
>
>         _end = .;
>
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 50b7af58c566..27593d362248 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  CFLAGS_init.o := -mcmodel=medany
> +ifdef CONFIG_RELOCATABLE
> +CFLAGS_init.o += -fno-pie
> +endif
> +
>  ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_init.o = -pg
>  endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 965a8cf4829c..428aee2669aa 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -12,6 +12,9 @@
>  #include <linux/sizes.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#ifdef CONFIG_RELOCATABLE
> +#include <linux/elf.h>
> +#endif
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> @@ -28,6 +31,9 @@ EXPORT_SYMBOL(empty_zero_page);
>  extern char _start[];
>  void *dtb_early_va;
>
> +unsigned long kernel_virt_addr = _AC(CONFIG_PAGE_OFFSET, UL);
> +EXPORT_SYMBOL(kernel_virt_addr);
> +
>  static void __init zone_sizes_init(void)
>  {
>         unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -132,7 +138,8 @@ void __init setup_bootmem(void)
>                 phys_addr_t end = reg->base + reg->size;
>
>                 if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> -                       mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> +                       mem_size = min(reg->size,
> +                                      (phys_addr_t)-kernel_virt_addr);
>
>                         /*
>                          * Remove memblock from the end of usable area to the
> @@ -269,7 +276,7 @@ static phys_addr_t __init alloc_pmd(uintptr_t va)
>         if (mmu_enabled)
>                 return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>
> -       pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> +       pmd_num = (va - kernel_virt_addr) >> PGDIR_SHIFT;
>         BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>         return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>  }
> @@ -370,6 +377,54 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>  #endif
>
> +#ifdef CONFIG_RELOCATABLE
> +extern unsigned long __rela_dyn_start, __rela_dyn_end;
> +
> +#ifdef CONFIG_64BIT
> +#define Elf_Rela Elf64_Rela
> +#define Elf_Addr Elf64_Addr
> +#else
> +#define Elf_Rela Elf32_Rela
> +#define Elf_Addr Elf32_Addr
> +#endif
> +
> +void __init relocate_kernel(uintptr_t load_pa)
> +{
> +       Elf_Rela *rela = (Elf_Rela *)&__rela_dyn_start;
> +       uintptr_t link_addr = _AC(CONFIG_PAGE_OFFSET, UL);
> +       /*
> +        * This holds the offset between the linked virtual address and the
> +        * relocated virtual address.
> +        */
> +       uintptr_t reloc_offset = kernel_virt_addr - link_addr;
> +       /*
> +        * This holds the offset between linked virtual address and physical
> +        * address whereas va_pa_offset holds the offset between relocated
> +        * virtual address and physical address.
> +        */
> +       uintptr_t va_link_pa_offset = link_addr - load_pa;
> +
> +       for ( ; rela < (Elf_Rela *)&__rela_dyn_end; rela++) {
> +               Elf_Addr addr = (rela->r_offset - va_link_pa_offset);
> +               Elf_Addr relocated_addr = rela->r_addend;
> +
> +               if (rela->r_info != R_RISCV_RELATIVE)
> +                       continue;
> +
> +               /*
> +                * Make sure to not relocate vdso symbols like rt_sigreturn
> +                * which are linked from the address 0 in vmlinux since
> +                * vdso symbol addresses are actually used as an offset from
> +                * mm->context.vdso in VDSO_OFFSET macro.
> +                */
> +               if (relocated_addr >= link_addr)
> +                       relocated_addr += reloc_offset;
> +
> +               *(Elf_Addr *)addr = relocated_addr;
> +       }
> +}
> +#endif
> +
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
>         uintptr_t va, end_va;
> @@ -377,9 +432,20 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>         uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>
> -       va_pa_offset = PAGE_OFFSET - load_pa;
> +       va_pa_offset = kernel_virt_addr - load_pa;
>         pfn_base = PFN_DOWN(load_pa);
>
> +#ifdef CONFIG_RELOCATABLE
> +       /*
> +        * Early page table uses only one PGDIR, which makes it possible
> +        * to map 1GB aligned on 1GB: if the relocation offset makes the kernel
> +        * cross over a 1G boundary, raise a bug since a part of the kernel
> +        * would not get mapped.
> +        */
> +       BUG_ON(SZ_1G - (kernel_virt_addr & (SZ_1G - 1)) < load_sz);
> +       relocate_kernel(load_pa);
> +#endif
> +
>         /*
>          * Enforce boot alignment requirements of RV32 and
>          * RV64 by only allowing PMD or PGD mappings.
> @@ -387,7 +453,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         BUG_ON(map_size == PAGE_SIZE);
>
>         /* Sanity check alignment and size */
> -       BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
> +       BUILD_BUG_ON((_AC(CONFIG_PAGE_OFFSET, UL) % PGDIR_SIZE) != 0);
>         BUG_ON((load_pa % map_size) != 0);
>         BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>
> @@ -400,13 +466,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>                            (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
>         /* Setup trampoline PGD and PMD */
> -       create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
> +       create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>                            (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
> -       create_pmd_mapping(trampoline_pmd, PAGE_OFFSET,
> +       create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
>                            load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
>  #else
>         /* Setup trampoline PGD */
> -       create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
> +       create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>                            load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
>  #endif
>
> @@ -415,10 +481,10 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>          * us to reach paging_init(). We map all memory banks later
>          * in setup_vm_final() below.
>          */
> -       end_va = PAGE_OFFSET + load_sz;
> -       for (va = PAGE_OFFSET; va < end_va; va += map_size)
> +       end_va = kernel_virt_addr + load_sz;
> +       for (va = kernel_virt_addr; va < end_va; va += map_size)
>                 create_pgd_mapping(early_pg_dir, va,
> -                                  load_pa + (va - PAGE_OFFSET),
> +                                  load_pa + (va - kernel_virt_addr),
>                                    map_size, PAGE_KERNEL_EXEC);
>
>         /* Create fixed mapping for early FDT parsing */
> @@ -457,9 +523,9 @@ static void __init setup_vm_final(void)
>                         break;
>                 if (memblock_is_nomap(reg))
>                         continue;
> -               if (start <= __pa(PAGE_OFFSET) &&
> -                   __pa(PAGE_OFFSET) < end)
> -                       start = __pa(PAGE_OFFSET);
> +               if (start <= __pa_symbol(kernel_virt_addr) &&
> +                   __pa(kernel_virt_addr) < end)
> +                       start = __pa_symbol(kernel_virt_addr);
>
>                 map_size = best_map_size(start, end - start);
>                 for (pa = start; pa < end; pa += map_size) {
> --
> 2.20.1
>
