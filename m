Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3318F287
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 11:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCWKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 06:16:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:21975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgCWKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:16:14 -0400
IronPort-SDR: ptqLtiNSDtbPTw/n0Zj9JUKmwfYDjt13Z3rmiLrHUD1Yn1WgXpJeE8OdJD12y1QbcO0IFIUuaG
 GNhlcq/bSLWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:16:13 -0700
IronPort-SDR: wA3KlCg9EGRnpXHC8hzyl0QwbWu3mHDGaVwCiIsohlP/PYcNZ63plOiExCohj+/pgVVnPAmohn
 IqeKpWj9vrdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="249567586"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2020 03:16:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGK7u-000GoS-OR; Mon, 23 Mar 2020 18:16:10 +0800
Date:   Mon, 23 Mar 2020 18:15:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD REGRESSION
 72f26c3be409e0ccd52a48e7f5ffbdbb5cd0a960
Message-ID: <5e788c33.9TKJLVW1raof3BA/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 72f26c3be409e0ccd52a48e7f5ffbdbb5cd0a960  rcu-tasks: Add count for idle tasks on offline CPUs

Regressions in current branch:

kernel/rcu/tasks.h:736:39: warning: 'struct irq_work' declared inside parameter list will not be visible outside of this definition or declaration
kernel/rcu/tasks.h:740:1: warning: parameter names (without types) in function declaration
kernel/rcu/tasks.h:740:8: error: type defaults to 'int' in declaration of 'DEFINE_IRQ_WORK' [-Werror=implicit-int]
kernel/rcu/tasks.h:742:39: warning: 'struct irq_work' declared inside parameter list will not be visible outside of this definition or declaration
kernel/rcu/tasks.h:746:1: warning: parameter names (without types) in function declaration
kernel/rcu/tasks.h:746:8: error: type defaults to 'int' in declaration of 'DEFINE_IRQ_WORK' [-Werror=implicit-int]
kernel/rcu/tasks.h:751:19: error: 'rcu_tasks_trace_iw' undeclared (first use in this function); did you mean 'rcu_tasks_trace_qs'?
kernel/rcu/tasks.h:751:3: error: implicit declaration of function 'irq_work_queue'; did you mean 'drain_workqueue'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:757:19: error: 'rcu_tasks_trace_iw' undeclared (first use in this function); did you mean 'rcu_tasks_trace_qs'?
kernel/rcu/tasks.h:757:3: error: implicit declaration of function 'irq_work_queue'; did you mean 'drain_workqueue'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- ia64-allmodconfig
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-irq_work_queue-did-you-mean-drain_workqueue
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_trace_iw-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_trace_qs
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_IRQ_WORK
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-irq_work-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-allyesconfig
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-irq_work_queue-did-you-mean-drain_workqueue
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_trace_iw-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_trace_qs
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_IRQ_WORK
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-irq_work-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-allmodconfig
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-irq_work_queue-did-you-mean-drain_workqueue
|   |-- kernel-rcu-tasks.h:error:rcu_tasks_trace_iw-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_trace_qs
|   |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_IRQ_WORK
|   |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
|   `-- kernel-rcu-tasks.h:warning:struct-irq_work-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
`-- openrisc-randconfig-a001-20200323
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-irq_work_queue-did-you-mean-drain_workqueue
    |-- kernel-rcu-tasks.h:error:rcu_tasks_trace_iw-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_trace_qs
    |-- kernel-rcu-tasks.h:error:type-defaults-to-int-in-declaration-of-DEFINE_IRQ_WORK
    |-- kernel-rcu-tasks.h:warning:parameter-names-(without-types)-in-function-declaration
    `-- kernel-rcu-tasks.h:warning:struct-irq_work-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration

elapsed time: 481m

configs tested: 156
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
ia64                              allnoconfig
um                             i386_defconfig
mips                              allnoconfig
powerpc                           allnoconfig
nds32                               defconfig
riscv                             allnoconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200322
i386                 randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a001-20200322
i386                 randconfig-a003-20200322
x86_64               randconfig-a003-20200322
mips                 randconfig-a001-20200323
nds32                randconfig-a001-20200323
m68k                 randconfig-a001-20200323
parisc               randconfig-a001-20200323
alpha                randconfig-a001-20200323
riscv                randconfig-a001-20200323
mips                 randconfig-a001-20200322
c6x                  randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
sparc64              randconfig-a001-20200322
csky                 randconfig-a001-20200323
openrisc             randconfig-a001-20200323
s390                 randconfig-a001-20200323
sh                   randconfig-a001-20200323
xtensa               randconfig-a001-20200323
x86_64               randconfig-b001-20200323
x86_64               randconfig-b002-20200323
x86_64               randconfig-b003-20200323
i386                 randconfig-b001-20200323
i386                 randconfig-b002-20200323
i386                 randconfig-b003-20200323
i386                 randconfig-b003-20200322
i386                 randconfig-b001-20200322
x86_64               randconfig-b003-20200322
i386                 randconfig-b002-20200322
x86_64               randconfig-b002-20200322
x86_64               randconfig-c003-20200322
x86_64               randconfig-c001-20200322
i386                 randconfig-c002-20200322
x86_64               randconfig-c002-20200322
x86_64               randconfig-e001-20200323
i386                 randconfig-e002-20200323
x86_64               randconfig-e003-20200323
i386                 randconfig-e003-20200323
i386                 randconfig-e001-20200323
x86_64               randconfig-e002-20200323
i386                 randconfig-f001-20200323
i386                 randconfig-f003-20200323
i386                 randconfig-f002-20200323
x86_64               randconfig-f002-20200323
x86_64               randconfig-f001-20200323
x86_64               randconfig-h002-20200322
x86_64               randconfig-h003-20200322
i386                 randconfig-h003-20200322
x86_64               randconfig-h001-20200322
i386                 randconfig-h001-20200322
i386                 randconfig-h002-20200322
arm                  randconfig-a001-20200322
arm                  randconfig-a001-20200323
powerpc              randconfig-a001-20200323
arm64                randconfig-a001-20200323
ia64                 randconfig-a001-20200323
sparc                randconfig-a001-20200323
arc                  randconfig-a001-20200323
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
