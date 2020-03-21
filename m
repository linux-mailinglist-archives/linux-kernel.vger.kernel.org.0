Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FC18DDA6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 03:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgCUCdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 22:33:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:41588 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgCUCdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 22:33:17 -0400
IronPort-SDR: DltsOJ2iGIbfJX+TlIohR0nk3aFt1p7suprr34BWibkBrep+9sOv0nKHauT3fS+2nsdNk1Jnuh
 qF2RGmI1VQMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 19:33:17 -0700
IronPort-SDR: Hs+yxtVMUt6FrSR0Tp9Es+w0IZzm+8V/2buDL+Me6ND8jopJ+vEhfZH7QZ5mdugUkDeERF+To1
 8QHfM9mV5a8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="292078137"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2020 19:33:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFTwo-0000iY-UB; Sat, 21 Mar 2020 10:33:14 +0800
Date:   Sat, 21 Mar 2020 10:32:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.03.18a] BUILD SUCCESS
 a068dafb411657fba5595088ff0609642bafb0d1
Message-ID: <5e757cb5.9pL77QMRaPDT76kN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.03.18a
branch HEAD: a068dafb411657fba5595088ff0609642bafb0d1  squash! rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks

elapsed time: 481m

configs tested: 180
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
sparc64                          allmodconfig
riscv                               defconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
sh                          rsk7269_defconfig
powerpc                       ppc64_defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200321
x86_64               randconfig-a002-20200321
x86_64               randconfig-a003-20200321
i386                 randconfig-a001-20200321
i386                 randconfig-a002-20200321
i386                 randconfig-a003-20200321
x86_64               randconfig-a001-20200320
x86_64               randconfig-a002-20200320
x86_64               randconfig-a003-20200320
i386                 randconfig-a001-20200320
i386                 randconfig-a002-20200320
i386                 randconfig-a003-20200320
alpha                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
parisc               randconfig-a001-20200321
riscv                randconfig-a001-20200321
alpha                randconfig-a001-20200320
m68k                 randconfig-a001-20200320
mips                 randconfig-a001-20200320
nds32                randconfig-a001-20200320
parisc               randconfig-a001-20200320
riscv                randconfig-a001-20200320
c6x                  randconfig-a001-20200320
h8300                randconfig-a001-20200320
microblaze           randconfig-a001-20200320
nios2                randconfig-a001-20200320
sparc64              randconfig-a001-20200320
csky                 randconfig-a001-20200320
openrisc             randconfig-a001-20200320
s390                 randconfig-a001-20200320
sh                   randconfig-a001-20200320
xtensa               randconfig-a001-20200320
x86_64               randconfig-b001-20200320
x86_64               randconfig-b002-20200320
x86_64               randconfig-b003-20200320
i386                 randconfig-b001-20200320
i386                 randconfig-b002-20200320
i386                 randconfig-b003-20200320
x86_64               randconfig-c001-20200320
x86_64               randconfig-c002-20200320
x86_64               randconfig-c003-20200320
i386                 randconfig-c001-20200320
i386                 randconfig-c002-20200320
i386                 randconfig-c003-20200320
x86_64               randconfig-c001-20200321
x86_64               randconfig-c002-20200321
x86_64               randconfig-c003-20200321
i386                 randconfig-c001-20200321
i386                 randconfig-c002-20200321
i386                 randconfig-c003-20200321
x86_64               randconfig-d001-20200320
x86_64               randconfig-d002-20200320
x86_64               randconfig-d003-20200320
i386                 randconfig-d001-20200320
i386                 randconfig-d002-20200320
i386                 randconfig-d003-20200320
x86_64               randconfig-e001-20200321
x86_64               randconfig-e002-20200321
x86_64               randconfig-e003-20200321
i386                 randconfig-e001-20200321
i386                 randconfig-e002-20200321
i386                 randconfig-e003-20200321
x86_64               randconfig-g001-20200320
x86_64               randconfig-g002-20200320
x86_64               randconfig-g003-20200320
i386                 randconfig-g001-20200320
i386                 randconfig-g002-20200320
i386                 randconfig-g003-20200320
x86_64               randconfig-h001-20200320
x86_64               randconfig-h002-20200320
x86_64               randconfig-h003-20200320
i386                 randconfig-h001-20200320
i386                 randconfig-h002-20200320
i386                 randconfig-h003-20200320
arc                  randconfig-a001-20200320
arm                  randconfig-a001-20200320
arm64                randconfig-a001-20200320
ia64                 randconfig-a001-20200320
powerpc              randconfig-a001-20200320
sparc                randconfig-a001-20200320
arm                  randconfig-a001-20200321
arm64                randconfig-a001-20200321
ia64                 randconfig-a001-20200321
powerpc              randconfig-a001-20200321
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
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
