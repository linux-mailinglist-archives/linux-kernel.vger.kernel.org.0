Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262ED145AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAVRSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:18:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:45697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:18:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 09:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="374981053"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2020 09:18:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iuJe2-000D8c-HR; Thu, 23 Jan 2020 01:18:22 +0800
Date:   Thu, 23 Jan 2020 01:17:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 8728497895794d1f207a836e02dae762ad175d56
Message-ID: <5e2883a2.hAPl3/AYDx8LEmih%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/urgent
branch HEAD: 8728497895794d1f207a836e02dae762ad175d56  objtool: Skip samples subdirectory

elapsed time: 520m

configs tested: 158
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
h8300                    h8300h-sim_defconfig
alpha                randconfig-a001-20200122
m68k                 randconfig-a001-20200122
mips                 randconfig-a001-20200122
nds32                randconfig-a001-20200122
parisc               randconfig-a001-20200122
riscv                randconfig-a001-20200122
x86_64               randconfig-a001-20200122
x86_64               randconfig-a002-20200122
x86_64               randconfig-a003-20200122
i386                 randconfig-a001-20200122
i386                 randconfig-a002-20200122
i386                 randconfig-a003-20200122
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
csky                 randconfig-a001-20200122
openrisc             randconfig-a001-20200122
s390                 randconfig-a001-20200122
sh                   randconfig-a001-20200122
xtensa               randconfig-a001-20200122
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sparc                            allyesconfig
x86_64               randconfig-g001-20200122
x86_64               randconfig-g002-20200122
x86_64               randconfig-g003-20200122
i386                 randconfig-g001-20200122
i386                 randconfig-g002-20200122
i386                 randconfig-g003-20200122
i386                                defconfig
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
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-c001-20200122
x86_64               randconfig-c002-20200122
x86_64               randconfig-c003-20200122
i386                 randconfig-c001-20200122
i386                 randconfig-c002-20200122
i386                 randconfig-c003-20200122
c6x                  randconfig-a001-20200122
h8300                randconfig-a001-20200122
microblaze           randconfig-a001-20200122
nios2                randconfig-a001-20200122
sparc64              randconfig-a001-20200122
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
x86_64               randconfig-d001-20200122
x86_64               randconfig-d002-20200122
x86_64               randconfig-d003-20200122
i386                 randconfig-d001-20200122
i386                 randconfig-d002-20200122
i386                 randconfig-d003-20200122
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-b001-20200122
x86_64               randconfig-b002-20200122
x86_64               randconfig-b003-20200122
i386                 randconfig-b001-20200122
i386                 randconfig-b002-20200122
i386                 randconfig-b003-20200122
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arc                  randconfig-a001-20200122
arm                  randconfig-a001-20200122
arm64                randconfig-a001-20200122
ia64                 randconfig-a001-20200122
powerpc              randconfig-a001-20200122
sparc                randconfig-a001-20200122
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-h001-20200122
x86_64               randconfig-h002-20200122
x86_64               randconfig-h003-20200122
i386                 randconfig-h001-20200122
i386                 randconfig-h002-20200122
i386                 randconfig-h003-20200122
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-e001-20200122
x86_64               randconfig-e002-20200122
x86_64               randconfig-e003-20200122
i386                 randconfig-e001-20200122
i386                 randconfig-e002-20200122
i386                 randconfig-e003-20200122

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
