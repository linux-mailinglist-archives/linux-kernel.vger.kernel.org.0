Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7C15B425
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgBLWzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:55:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:30548 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBLWzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:55:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 14:55:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="237856459"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 14:55:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j20ug-000AkP-MU; Thu, 13 Feb 2020 06:55:22 +0800
Date:   Thu, 13 Feb 2020 06:55:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f861854e1b435b27197417f6f90d87188003cb24
Message-ID: <5e448252.Mpnr0WZ6a23s7tzl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: f861854e1b435b27197417f6f90d87188003cb24  perf/x86/intel: Fix inaccurate period in context switch for auto-reload

elapsed time: 1724m

configs tested: 243
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sparc                            allyesconfig
riscv                          rv32_defconfig
s390                                defconfig
arc                                 defconfig
sparc64                             defconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
nds32                               defconfig
sh                                allnoconfig
xtensa                       common_defconfig
alpha                               defconfig
microblaze                    nommu_defconfig
parisc                              defconfig
um                                  defconfig
m68k                       m5475evb_defconfig
microblaze                      mmu_defconfig
m68k                             allmodconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
riscv                               defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
xtensa                          iss_defconfig
csky                                defconfig
nds32                             allnoconfig
arc                              allyesconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
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
parisc                         b180_defconfig
parisc                        c3000_defconfig
x86_64               randconfig-a001-20200213
x86_64               randconfig-a002-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
i386                 randconfig-a002-20200213
i386                 randconfig-a003-20200213
i386                 randconfig-a003-20200212
x86_64               randconfig-a003-20200212
i386                 randconfig-a001-20200212
x86_64               randconfig-a002-20200212
i386                 randconfig-a002-20200212
x86_64               randconfig-a001-20200212
alpha                randconfig-a001-20200212
m68k                 randconfig-a001-20200212
nds32                randconfig-a001-20200212
parisc               randconfig-a001-20200212
riscv                randconfig-a001-20200212
alpha                randconfig-a001-20200213
m68k                 randconfig-a001-20200213
mips                 randconfig-a001-20200213
nds32                randconfig-a001-20200213
parisc               randconfig-a001-20200213
riscv                randconfig-a001-20200213
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
csky                 randconfig-a001-20200212
openrisc             randconfig-a001-20200212
s390                 randconfig-a001-20200212
sh                   randconfig-a001-20200212
xtensa               randconfig-a001-20200212
x86_64               randconfig-b001-20200212
x86_64               randconfig-b002-20200212
x86_64               randconfig-b003-20200212
i386                 randconfig-b001-20200212
i386                 randconfig-b002-20200212
i386                 randconfig-b003-20200212
x86_64               randconfig-b001-20200213
x86_64               randconfig-b002-20200213
x86_64               randconfig-b003-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b002-20200213
i386                 randconfig-b003-20200213
x86_64               randconfig-b001-20200211
x86_64               randconfig-b002-20200211
x86_64               randconfig-b003-20200211
i386                 randconfig-b001-20200211
i386                 randconfig-b002-20200211
i386                 randconfig-b003-20200211
x86_64               randconfig-c001-20200212
x86_64               randconfig-c002-20200212
x86_64               randconfig-c003-20200212
i386                 randconfig-c001-20200212
i386                 randconfig-c002-20200212
i386                 randconfig-c003-20200212
x86_64               randconfig-c001-20200211
x86_64               randconfig-c002-20200211
x86_64               randconfig-c003-20200211
i386                 randconfig-c001-20200211
i386                 randconfig-c002-20200211
i386                 randconfig-c003-20200211
x86_64               randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
i386                 randconfig-c002-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-d001-20200212
x86_64               randconfig-d002-20200212
x86_64               randconfig-d003-20200212
i386                 randconfig-d001-20200212
i386                 randconfig-d002-20200212
i386                 randconfig-d003-20200212
x86_64               randconfig-d001-20200211
x86_64               randconfig-d002-20200211
x86_64               randconfig-d003-20200211
i386                 randconfig-d001-20200211
i386                 randconfig-d002-20200211
i386                 randconfig-d003-20200211
x86_64               randconfig-e001-20200212
x86_64               randconfig-e002-20200212
x86_64               randconfig-e003-20200212
i386                 randconfig-e001-20200212
i386                 randconfig-e002-20200212
i386                 randconfig-e003-20200212
x86_64               randconfig-e001-20200213
x86_64               randconfig-e002-20200213
x86_64               randconfig-e003-20200213
i386                 randconfig-e001-20200213
i386                 randconfig-e002-20200213
i386                 randconfig-e003-20200213
x86_64               randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f001-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
x86_64               randconfig-f001-20200212
x86_64               randconfig-f002-20200212
x86_64               randconfig-f003-20200212
i386                 randconfig-f001-20200212
i386                 randconfig-f002-20200212
i386                 randconfig-f003-20200212
x86_64               randconfig-f001-20200211
x86_64               randconfig-f002-20200211
x86_64               randconfig-f003-20200211
i386                 randconfig-f001-20200211
i386                 randconfig-f002-20200211
i386                 randconfig-f003-20200211
x86_64               randconfig-g001-20200212
x86_64               randconfig-g002-20200212
x86_64               randconfig-g003-20200212
i386                 randconfig-g001-20200212
i386                 randconfig-g002-20200212
i386                 randconfig-g003-20200212
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-g001-20200211
x86_64               randconfig-g002-20200211
x86_64               randconfig-g003-20200211
i386                 randconfig-g001-20200211
i386                 randconfig-g002-20200211
i386                 randconfig-g003-20200211
x86_64               randconfig-h001-20200212
x86_64               randconfig-h002-20200212
x86_64               randconfig-h003-20200212
i386                 randconfig-h001-20200212
i386                 randconfig-h002-20200212
i386                 randconfig-h003-20200212
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200211
arm                  randconfig-a001-20200211
arm64                randconfig-a001-20200211
ia64                 randconfig-a001-20200211
powerpc              randconfig-a001-20200211
sparc                randconfig-a001-20200211
arc                  randconfig-a001-20200212
arm                  randconfig-a001-20200212
arm64                randconfig-a001-20200212
ia64                 randconfig-a001-20200212
powerpc              randconfig-a001-20200212
sparc                randconfig-a001-20200212
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
