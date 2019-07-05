Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466795FB43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfGDPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 11:54:33 -0400
Received: from foss.arm.com ([217.140.110.172]:44658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfGDPyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:54:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D24A2B;
        Thu,  4 Jul 2019 08:54:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B6503F703;
        Thu,  4 Jul 2019 08:54:31 -0700 (PDT)
Date:   Thu, 4 Jul 2019 16:54:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.3
Message-ID: <20190704155427.GA48571@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sending an early pull request for 5.3 as I'll be on holiday for the
next two weeks. The PTRACE_SYSEMU patches touch powerpc and x86 lightly
(the acks are in place). There are a few conflicts but nothing
complicated, the resolution is as per linux-next. If anything goes
wrong, Will is around during the merging window.

Thanks.

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 0c61efd322b75ed3143e3d130ebecbebf561adf5:

  Merge branch 'for-next/perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux (2019-07-01 15:53:35 +0100)

----------------------------------------------------------------
arm64 updates for 5.3:

- arm64 support for syscall emulation via PTRACE_SYSEMU{,_SINGLESTEP}

- Wire up VM_FLUSH_RESET_PERMS for arm64, allowing the core code to
  manage the permissions of executable vmalloc regions more strictly

- Slight performance improvement by keeping softirqs enabled while
  touching the FPSIMD/SVE state (kernel_neon_begin/end)

- Expose a couple of ARMv8.5 features to user (HWCAP): CondM (new XAFLAG
  and AXFLAG instructions for floating point comparison flags
  manipulation) and FRINT (rounding floating point numbers to integers)

- Re-instate ARM64_PSEUDO_NMI support which was previously marked as
  BROKEN due to some bugs (now fixed)

- Improve parking of stopped CPUs and implement an arm64-specific
  panic_smp_self_stop() to avoid warning on not being able to stop
  secondary CPUs during panic

- perf: enable the ARM Statistical Profiling Extensions (SPE) on ACPI
  platforms

- perf: DDR performance monitor support for iMX8QXP

- cache_line_size() can now be set from DT or ACPI/PPTT if provided to
  cope with a system cache info not exposed via the CPUID registers

- Avoid warning on hardware cache line size greater than
  ARCH_DMA_MINALIGN if the system is fully coherent

- arm64 do_page_fault() and hugetlb cleanups

- Refactor set_pte_at() to avoid redundant READ_ONCE(*ptep)

- Ignore ACPI 5.1 FADTs reported as 5.0 (infer from the 'arm_boot_flags'
  introduced in 5.1)

- CONFIG_RANDOMIZE_BASE now enabled in defconfig

- Allow the selection of ARM64_MODULE_PLTS, currently only done via
  RANDOMIZE_BASE (and an erratum workaround), allowing modules to spill
  over into the vmalloc area

- Make ZONE_DMA32 configurable

----------------------------------------------------------------
Aaro Koskinen (1):
      arm64: Implement panic_smp_self_stop()

Anshuman Khandual (10):
      arm64/hugetlb: Use macros for contiguous huge page sizes
      arm64/mm: Move PTE_VALID from SW defined to HW page table entry definitions
      arm64/mm: Simplify protection flag creation for kernel huge mappings
      arm64/mm: Change BUG_ON() to VM_BUG_ON() in [pmd|pud]_set_huge()
      arm64/mm: Identify user instruction aborts
      arm64/mm: Drop mmap_sem before calling __do_kernel_fault()
      arm64/mm: Drop task_struct argument from __do_page_fault()
      arm64/mm: Document write abort detection from ESR
      arm64/mm: Refactor __do_page_fault()
      arm64/mm: Drop [PTE|PMD]_TYPE_FAULT

Ard Biesheuvel (5):
      acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
      arm64: module: create module allocations without exec permissions
      arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
      arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
      arm64: bpf: do not allocate executable memory

Bartlomiej Zolnierkiewicz (1):
      arm64: remove redundant 'default n' from Kconfig

Catalin Marinas (2):
      arm64: ARM64_MODULES_PLTS must depend on MODULES
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux

Florian Fainelli (1):
      arm64: Allow user selection of ARM64_MODULE_PLTS

Frank Li (3):
      dt-bindings: perf: imx8-ddr: add imx8qxp ddr performance monitor
      drivers/perf: imx_ddr: Add DDR performance counter support to perf
      MAINTAINERS: Add maintainer entry for the imx8 DDR PMU driver

Jayachandran C (1):
      arm64: Improve parking of stopped CPUs

Jeremy Linton (4):
      ACPI/PPTT: Modify node flag detection to find last IDENTICAL
      ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
      arm_pmu: acpi: spe: Add initial MADT/SPE probing
      perf: arm_spe: Enable ACPI/Platform automatic module loading

Julien Grall (4):
      arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
      arm64/fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and use it
      arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
      arm64/cpufeature: Convert hook_lock to raw_spin_lock_t in cpu_enable_ssbs()

Julien Thierry (7):
      arm64: Do not enable IRQs for ct_user_exit
      arm64: irqflags: Pass flags as readonly operand to restore instruction
      arm64: irqflags: Add condition flags to inline asm clobber list
      arm64: Fix interrupt tracing in the presence of NMIs
      arm64: Fix incorrect irqflag restore for priority masking
      arm64: irqflags: Introduce explicit debugging for IRQ priorities
      arm64: Allow selecting Pseudo-NMI again

Liu Song (1):
      arm64: kernel: use aff3 instead of aff2 in comment

Mark Brown (2):
      arm64: Expose ARMv8.5 CondM capability to userspace
      arm64: Expose FRINT capabilities to userspace

Mark Rutland (1):
      arm64: mm: avoid redundant READ_ONCE(*ptep)

Masayoshi Mizuma (1):
      arm64/mm: Correct the cache line size warning with non coherent device

Miles Chen (1):
      arm64: mm: make CONFIG_ZONE_DMA32 configurable

Nick Desaulniers (1):
      arm64: defconfig: enable CONFIG_RANDOMIZE_BASE

Odin Ugedal (1):
      arm64: Fix comment after #endif

Shaokun Zhang (2):
      drivers: base: cacheinfo: Add variable to record max cache line size
      arm64: cacheinfo: Update cache_line_size detected from DT or PPTT

Sudeep Holla (4):
      ptrace: move clearing of TIF_SYSCALL_EMU flag to core
      arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
      arm64: ptrace: add support for syscall emulation
      x86/entry: Simplify _TIF_SYSCALL_EMU handling

Wei Li (1):
      arm64: fix kernel stack overflow in kdump capture kernel

jinho lim (1):
      arm64: rename dump_instr as dump_kernel_instr

 Documentation/arm64/elf_hwcaps.txt                 |   8 +
 .../devicetree/bindings/perf/fsl-imx-ddr.txt       |  21 +
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig                                 |  35 +-
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/acpi.h                      |   3 +
 arch/arm64/include/asm/arch_gicv3.h                |   4 +-
 arch/arm64/include/asm/cache.h                     |   5 +-
 arch/arm64/include/asm/cacheflush.h                |   3 +
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/daifflags.h                 |  75 ++-
 arch/arm64/include/asm/fpsimd.h                    |   5 +-
 arch/arm64/include/asm/hwcap.h                     |   2 +
 arch/arm64/include/asm/irqflags.h                  |  79 ++-
 arch/arm64/include/asm/kvm_host.h                  |   7 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   3 +-
 arch/arm64/include/asm/pgtable-prot.h              |   1 -
 arch/arm64/include/asm/pgtable.h                   |  56 ++-
 arch/arm64/include/asm/ptrace.h                    |  10 +-
 arch/arm64/include/asm/simd.h                      |  10 +-
 arch/arm64/include/asm/sysreg.h                    |   1 +
 arch/arm64/include/asm/thread_info.h               |   5 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   2 +
 arch/arm64/include/uapi/asm/ptrace.h               |   3 +
 arch/arm64/kernel/acpi.c                           |  10 +-
 arch/arm64/kernel/cacheinfo.c                      |   9 +
 arch/arm64/kernel/cpufeature.c                     |   8 +-
 arch/arm64/kernel/cpuinfo.c                        |   2 +
 arch/arm64/kernel/entry.S                          |  84 +++-
 arch/arm64/kernel/fpsimd.c                         | 139 ++++--
 arch/arm64/kernel/irq.c                            |  26 +
 arch/arm64/kernel/module.c                         |   4 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/arm64/kernel/ptrace.c                         |   6 +-
 arch/arm64/kernel/sleep.S                          |   2 +-
 arch/arm64/kernel/smp.c                            |  27 +-
 arch/arm64/kernel/traps.c                          |  23 +-
 arch/arm64/kvm/fpsimd.c                            |   4 +-
 arch/arm64/kvm/hyp/switch.c                        |   2 +-
 arch/arm64/mm/dma-mapping.c                        |  12 +-
 arch/arm64/mm/fault.c                              |  61 ++-
 arch/arm64/mm/hugetlbpage.c                        |  12 +-
 arch/arm64/mm/init.c                               |   5 +-
 arch/arm64/mm/mmu.c                                |  14 +-
 arch/arm64/mm/pageattr.c                           |  48 +-
 arch/arm64/net/bpf_jit_comp.c                      |   2 +-
 arch/powerpc/kernel/ptrace.c                       |   1 -
 arch/x86/entry/common.c                            |  17 +-
 arch/x86/kernel/ptrace.c                           |   3 -
 drivers/acpi/pptt.c                                |  61 ++-
 drivers/base/cacheinfo.c                           |   5 +
 drivers/irqchip/irq-gic-v3.c                       |   7 +
 drivers/perf/Kconfig                               |   8 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm_pmu_acpi.c                        |  72 +++
 drivers/perf/arm_spe_pmu.c                         |  12 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   | 554 +++++++++++++++++++++
 include/linux/acpi.h                               |   5 +
 include/linux/cacheinfo.h                          |   2 +
 include/linux/perf/arm_pmu.h                       |   2 +
 kernel/irq/irqdesc.c                               |   8 +-
 kernel/ptrace.c                                    |   3 +
 mm/vmalloc.c                                       |  11 -
 64 files changed, 1318 insertions(+), 312 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
 create mode 100644 drivers/perf/fsl_imx8_ddr_perf.c

-- 
Catalin
