Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA531432A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATTwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 14:52:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:9724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgATTwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:52:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400"; 
   d="scan'208";a="425273367"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2020 11:52:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itd63-0006DE-I7; Tue, 21 Jan 2020 03:52:27 +0800
Date:   Tue, 21 Jan 2020 03:51:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 615bf8d9a96b3695eb6bb9b35c2279f5a17fd8c3
Message-ID: <5e2604dc.vuKtQBJaEnWyKJgA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: 615bf8d9a96b3695eb6bb9b35c2279f5a17fd8c3  efi/x86: Disallow efi=old_map in mixed mode

elapsed time: 491m

configs tested: 163
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64               randconfig-e001-20200120
x86_64               randconfig-e002-20200120
x86_64               randconfig-e003-20200120
i386                 randconfig-e001-20200120
i386                 randconfig-e002-20200120
i386                 randconfig-e003-20200120
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
csky                 randconfig-a001-20200120
openrisc             randconfig-a001-20200120
s390                 randconfig-a001-20200120
sh                   randconfig-a001-20200120
xtensa               randconfig-a001-20200120
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-g001-20200120
x86_64               randconfig-g002-20200120
x86_64               randconfig-g003-20200120
i386                 randconfig-g001-20200120
i386                 randconfig-g002-20200120
i386                 randconfig-g003-20200120
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                randconfig-a001-20200121
m68k                 randconfig-a001-20200121
mips                 randconfig-a001-20200121
nds32                randconfig-a001-20200121
parisc               randconfig-a001-20200121
riscv                randconfig-a001-20200121
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
ia64                                defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
csky                 randconfig-a001-20200121
openrisc             randconfig-a001-20200121
s390                 randconfig-a001-20200121
sh                   randconfig-a001-20200121
xtensa               randconfig-a001-20200121
x86_64               randconfig-d001-20200121
x86_64               randconfig-d002-20200121
x86_64               randconfig-d003-20200121
i386                 randconfig-d001-20200121
i386                 randconfig-d002-20200121
i386                 randconfig-d003-20200121
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
x86_64               randconfig-f001-20200121
x86_64               randconfig-f002-20200121
x86_64               randconfig-f003-20200121
i386                 randconfig-f001-20200121
i386                 randconfig-f002-20200121
i386                 randconfig-f003-20200121
c6x                  randconfig-a001-20200121
h8300                randconfig-a001-20200121
microblaze           randconfig-a001-20200121
nios2                randconfig-a001-20200121
sparc64              randconfig-a001-20200121
x86_64               randconfig-e001-20200121
x86_64               randconfig-e002-20200121
x86_64               randconfig-e003-20200121
i386                 randconfig-e001-20200121
i386                 randconfig-e002-20200121
i386                 randconfig-e003-20200121
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64               randconfig-a001-20200120
x86_64               randconfig-a002-20200120
x86_64               randconfig-a003-20200120
i386                 randconfig-a001-20200120
i386                 randconfig-a002-20200120
i386                 randconfig-a003-20200120
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-c001-20200121
x86_64               randconfig-c002-20200121
x86_64               randconfig-c003-20200121
i386                 randconfig-c001-20200121
i386                 randconfig-c002-20200121
i386                 randconfig-c003-20200121
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
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
x86_64               randconfig-d001-20200120
x86_64               randconfig-d002-20200120
x86_64               randconfig-d003-20200120
i386                 randconfig-d001-20200120
i386                 randconfig-d002-20200120
i386                 randconfig-d003-20200120

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
