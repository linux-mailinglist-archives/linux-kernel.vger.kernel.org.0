Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6A13EDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407014AbgAPSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:05:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:57386 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404981AbgAPRju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 09:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="214162921"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2020 09:39:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1is97U-0005KR-HA; Fri, 17 Jan 2020 01:39:48 +0800
Date:   Fri, 17 Jan 2020 01:38:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 5167c506d62dd9ffab73eba23c79b0a8845c9fe1
Message-ID: <5e209fab.EUeNSFspWp8E2PjZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 5167c506d62dd9ffab73eba23c79b0a8845c9fe1  tick/common: Touch watchdog in tick_unfreeze() on all CPUs

elapsed time: 609m

configs tested: 148
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-c001-20200116
x86_64               randconfig-c002-20200116
x86_64               randconfig-c003-20200116
i386                 randconfig-c001-20200116
i386                 randconfig-c002-20200116
i386                 randconfig-c003-20200116
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
alpha                randconfig-a001-20200116
m68k                 randconfig-a001-20200116
mips                 randconfig-a001-20200116
nds32                randconfig-a001-20200116
parisc               randconfig-a001-20200116
riscv                randconfig-a001-20200116
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-a001-20200116
x86_64               randconfig-a002-20200116
x86_64               randconfig-a003-20200116
i386                 randconfig-a001-20200116
i386                 randconfig-a002-20200116
i386                 randconfig-a003-20200116
ia64                                defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-d001-20200116
x86_64               randconfig-d002-20200116
x86_64               randconfig-d003-20200116
i386                 randconfig-d001-20200116
i386                 randconfig-d002-20200116
i386                 randconfig-d003-20200116
arc                  randconfig-a001-20200116
arm                  randconfig-a001-20200116
arm64                randconfig-a001-20200116
ia64                 randconfig-a001-20200116
powerpc              randconfig-a001-20200116
sparc                randconfig-a001-20200116
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arc                  randconfig-a001-20200117
arm                  randconfig-a001-20200117
arm64                randconfig-a001-20200117
ia64                 randconfig-a001-20200117
powerpc              randconfig-a001-20200117
sparc                randconfig-a001-20200117
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64               randconfig-d001-20200117
x86_64               randconfig-d002-20200117
x86_64               randconfig-d003-20200117
i386                 randconfig-d001-20200117
i386                 randconfig-d002-20200117
i386                 randconfig-d003-20200117
x86_64               randconfig-b001-20200116
x86_64               randconfig-b002-20200116
x86_64               randconfig-b003-20200116
i386                 randconfig-b001-20200116
i386                 randconfig-b002-20200116
i386                 randconfig-b003-20200116
x86_64               randconfig-e001-20200116
x86_64               randconfig-e002-20200116
x86_64               randconfig-e003-20200116
i386                 randconfig-e001-20200116
i386                 randconfig-e002-20200116
i386                 randconfig-e003-20200116

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
