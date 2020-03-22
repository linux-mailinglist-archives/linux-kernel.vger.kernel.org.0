Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF518E958
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCVOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 10:16:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:49292 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgCVOQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:16:49 -0400
IronPort-SDR: oAZLyx8ZqFeacg7YgsQM8JJfPWyyjV6fgZRMuVmwUDDhyfVAOjOM4hPDntABz66+B0yBxVCJsU
 ZuF7CFEm1Unw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 07:16:46 -0700
IronPort-SDR: uft4PUcxrSB9cd53hVf1SOeOoCOOfwzC/067V4nnQmdpcnuB16IJniGRnOGNDoiNxJ9LZEzMy+
 0zGUXWJQT7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; 
   d="scan'208";a="249362586"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2020 07:16:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jG1PA-000AuW-8m; Sun, 22 Mar 2020 22:16:44 +0800
Date:   Sun, 22 Mar 2020 22:16:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo] BUILD SUCCESS
 aa93ec620be378cce1454286122915533ff8fa48
Message-ID: <5e777327.s2aCoSjEVFwbToYY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  for-mingo
branch HEAD: aa93ec620be378cce1454286122915533ff8fa48  Merge branches 'doc.2020.02.27a', 'fixes.2020.03.21a', 'kfree_rcu.2020.02.20a', 'locktorture.2020.02.20a', 'ovld.2020.02.20a', 'rcu-tasks.2020.02.20a', 'srcu.2020.02.20a' and 'torture.2020.02.20a' into HEAD

elapsed time: 837m

configs tested: 163
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sparc                            allyesconfig
powerpc                             defconfig
arc                              allyesconfig
riscv                               defconfig
nds32                               defconfig
openrisc                    or1ksim_defconfig
h8300                    h8300h-sim_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
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
alpha                randconfig-a001-20200322
m68k                 randconfig-a001-20200322
mips                 randconfig-a001-20200322
nds32                randconfig-a001-20200322
parisc               randconfig-a001-20200322
riscv                randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
c6x                  randconfig-a001-20200322
sparc64              randconfig-a001-20200322
s390                 randconfig-a001-20200322
csky                 randconfig-a001-20200322
xtensa               randconfig-a001-20200322
openrisc             randconfig-a001-20200322
sh                   randconfig-a001-20200322
i386                 randconfig-b003-20200322
i386                 randconfig-b001-20200322
x86_64               randconfig-b003-20200322
i386                 randconfig-b002-20200322
x86_64               randconfig-b002-20200322
x86_64               randconfig-c001-20200322
x86_64               randconfig-c002-20200322
x86_64               randconfig-c003-20200322
i386                 randconfig-c001-20200322
i386                 randconfig-c002-20200322
i386                 randconfig-c003-20200322
i386                 randconfig-d003-20200322
i386                 randconfig-d001-20200322
i386                 randconfig-d002-20200322
x86_64               randconfig-d001-20200322
x86_64               randconfig-d003-20200322
x86_64               randconfig-d002-20200322
x86_64               randconfig-e001-20200322
x86_64               randconfig-e002-20200322
x86_64               randconfig-e003-20200322
i386                 randconfig-e001-20200322
i386                 randconfig-e002-20200322
i386                 randconfig-e003-20200322
i386                 randconfig-f001-20200322
i386                 randconfig-f003-20200322
i386                 randconfig-f002-20200322
x86_64               randconfig-f002-20200322
x86_64               randconfig-f003-20200322
x86_64               randconfig-f001-20200322
i386                 randconfig-g003-20200322
x86_64               randconfig-g002-20200322
i386                 randconfig-g001-20200322
i386                 randconfig-g002-20200322
x86_64               randconfig-g001-20200322
x86_64               randconfig-g003-20200322
x86_64               randconfig-h002-20200322
x86_64               randconfig-h003-20200322
i386                 randconfig-h003-20200322
x86_64               randconfig-h001-20200322
i386                 randconfig-h001-20200322
i386                 randconfig-h002-20200322
arc                  randconfig-a001-20200322
arm                  randconfig-a001-20200322
arm64                randconfig-a001-20200322
ia64                 randconfig-a001-20200322
powerpc              randconfig-a001-20200322
sparc                randconfig-a001-20200322
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
