Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15BB179F76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 06:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEFpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 00:45:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:47117 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgCEFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:45:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 21:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="232848304"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2020 21:45:03 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9jJb-000BQM-Hc; Thu, 05 Mar 2020 13:44:59 +0800
Date:   Thu, 05 Mar 2020 13:44:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.21a] BUILD SUCCESS
 e9e44c69beeeee04ffc25e703311ebb4b6dcbd3b
Message-ID: <5e6091a3.PiKxG4C0z22XCJr8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.21a
branch HEAD: e9e44c69beeeee04ffc25e703311ebb4b6dcbd3b  kcsan: Add current->state to implicitly atomic accesses

elapsed time: 8425m

configs tested: 238
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
i386                             allyesconfig
openrisc                    or1ksim_defconfig
mips                      fuloong2e_defconfig
riscv                          rv32_defconfig
ia64                                defconfig
riscv                    nommu_virt_defconfig
ia64                             alldefconfig
sh                          rsk7269_defconfig
sparc64                          allyesconfig
parisc                generic-32bit_defconfig
um                           x86_64_defconfig
microblaze                    nommu_defconfig
i386                              allnoconfig
powerpc                             defconfig
s390                       zfcpdump_defconfig
mips                              allnoconfig
nds32                             allnoconfig
mips                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
nios2                         3c120_defconfig
mips                      malta_kvm_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                     edosk2674_defconfig
s390                              allnoconfig
powerpc                           allnoconfig
parisc                            allnoconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200228
x86_64               randconfig-a002-20200228
x86_64               randconfig-a003-20200228
i386                 randconfig-a001-20200228
i386                 randconfig-a002-20200228
i386                 randconfig-a003-20200228
x86_64               randconfig-a001-20200229
x86_64               randconfig-a002-20200229
x86_64               randconfig-a003-20200229
i386                 randconfig-a001-20200229
i386                 randconfig-a002-20200229
i386                 randconfig-a003-20200229
alpha                randconfig-a001-20200228
m68k                 randconfig-a001-20200228
mips                 randconfig-a001-20200228
nds32                randconfig-a001-20200228
parisc               randconfig-a001-20200228
riscv                randconfig-a001-20200228
alpha                randconfig-a001-20200229
m68k                 randconfig-a001-20200229
nds32                randconfig-a001-20200229
parisc               randconfig-a001-20200229
riscv                randconfig-a001-20200229
c6x                  randconfig-a001-20200229
h8300                randconfig-a001-20200229
microblaze           randconfig-a001-20200229
nios2                randconfig-a001-20200229
sparc64              randconfig-a001-20200229
c6x                  randconfig-a001-20200228
h8300                randconfig-a001-20200228
microblaze           randconfig-a001-20200228
nios2                randconfig-a001-20200228
sparc64              randconfig-a001-20200228
csky                 randconfig-a001-20200228
openrisc             randconfig-a001-20200228
s390                 randconfig-a001-20200228
sh                   randconfig-a001-20200228
xtensa               randconfig-a001-20200228
csky                 randconfig-a001-20200229
openrisc             randconfig-a001-20200229
s390                 randconfig-a001-20200229
xtensa               randconfig-a001-20200229
x86_64               randconfig-b001-20200229
x86_64               randconfig-b002-20200229
x86_64               randconfig-b003-20200229
i386                 randconfig-b001-20200229
i386                 randconfig-b002-20200229
i386                 randconfig-b003-20200229
x86_64               randconfig-b001-20200228
x86_64               randconfig-b002-20200228
x86_64               randconfig-b003-20200228
i386                 randconfig-b001-20200228
i386                 randconfig-b002-20200228
i386                 randconfig-b003-20200228
x86_64               randconfig-c001-20200228
x86_64               randconfig-c002-20200228
x86_64               randconfig-c003-20200228
i386                 randconfig-c001-20200228
i386                 randconfig-c002-20200228
i386                 randconfig-c003-20200228
x86_64               randconfig-c001-20200229
x86_64               randconfig-c002-20200229
x86_64               randconfig-c003-20200229
i386                 randconfig-c001-20200229
i386                 randconfig-c002-20200229
i386                 randconfig-c003-20200229
x86_64               randconfig-d001-20200228
x86_64               randconfig-d002-20200228
x86_64               randconfig-d003-20200228
i386                 randconfig-d001-20200228
i386                 randconfig-d002-20200228
i386                 randconfig-d003-20200228
x86_64               randconfig-d001-20200229
x86_64               randconfig-d002-20200229
x86_64               randconfig-d003-20200229
i386                 randconfig-d001-20200229
i386                 randconfig-d002-20200229
i386                 randconfig-d003-20200229
x86_64               randconfig-e001-20200301
x86_64               randconfig-e002-20200301
x86_64               randconfig-e003-20200301
i386                 randconfig-e001-20200301
i386                 randconfig-e002-20200301
i386                 randconfig-e003-20200301
x86_64               randconfig-e001-20200228
x86_64               randconfig-e002-20200228
x86_64               randconfig-e003-20200228
i386                 randconfig-e001-20200228
i386                 randconfig-e002-20200228
i386                 randconfig-e003-20200228
x86_64               randconfig-e001-20200229
x86_64               randconfig-e002-20200229
x86_64               randconfig-e003-20200229
i386                 randconfig-e001-20200229
i386                 randconfig-e002-20200229
i386                 randconfig-e003-20200229
x86_64               randconfig-f001-20200228
x86_64               randconfig-f002-20200228
x86_64               randconfig-f003-20200228
i386                 randconfig-f001-20200228
i386                 randconfig-f002-20200228
i386                 randconfig-f003-20200228
x86_64               randconfig-f001-20200229
x86_64               randconfig-f002-20200229
x86_64               randconfig-f003-20200229
i386                 randconfig-f001-20200229
i386                 randconfig-f002-20200229
i386                 randconfig-f003-20200229
x86_64               randconfig-g001-20200229
x86_64               randconfig-g002-20200229
x86_64               randconfig-g003-20200229
i386                 randconfig-g001-20200229
i386                 randconfig-g002-20200229
i386                 randconfig-g003-20200229
x86_64               randconfig-g001-20200228
x86_64               randconfig-g002-20200228
x86_64               randconfig-g003-20200228
i386                 randconfig-g001-20200228
i386                 randconfig-g002-20200228
i386                 randconfig-g003-20200228
x86_64               randconfig-h001-20200228
x86_64               randconfig-h002-20200228
x86_64               randconfig-h003-20200228
i386                 randconfig-h001-20200228
i386                 randconfig-h002-20200228
i386                 randconfig-h003-20200228
x86_64               randconfig-h001-20200229
x86_64               randconfig-h002-20200229
x86_64               randconfig-h003-20200229
i386                 randconfig-h001-20200229
i386                 randconfig-h002-20200229
i386                 randconfig-h003-20200229
arc                  randconfig-a001-20200229
arm                  randconfig-a001-20200229
arm64                randconfig-a001-20200229
ia64                 randconfig-a001-20200229
powerpc              randconfig-a001-20200229
sparc                randconfig-a001-20200229
arc                  randconfig-a001-20200228
arm                  randconfig-a001-20200228
arm64                randconfig-a001-20200228
ia64                 randconfig-a001-20200228
powerpc              randconfig-a001-20200228
sparc                randconfig-a001-20200228
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
