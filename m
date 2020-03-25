Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB9192120
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 07:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgCYGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 02:34:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:28785 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgCYGeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:34:07 -0400
IronPort-SDR: VBg4T4el3lPldvDQeJdFIr0rks4NSamwhxL9qpvsvSYBONilSsRHto4uG0Ls1LPPMvRGEKtcQG
 HDvqjQQvvWrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 23:34:06 -0700
IronPort-SDR: OCxjtQ+iilDJby8a0OVcFPT0aScf4Y1F5+JK4TbKCYmVDyq06RWSMrJMr8OPEwLog9zVpmbIpU
 0R5HxzapRs4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="238444741"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2020 23:34:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGzc4-000D22-Q4; Wed, 25 Mar 2020 14:34:04 +0800
Date:   Wed, 25 Mar 2020 14:33:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 1826d56bcef9c38287f7c1a8e3b7778863e0b9d7
Message-ID: <5e7afb31.CeuJlNglXDsXZfcH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 1826d56bcef9c38287f7c1a8e3b7778863e0b9d7  x86/cpu: Cleanup the now unused CPU match macros

elapsed time: 483m

configs tested: 156
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
sh                          rsk7269_defconfig
sparc64                           allnoconfig
nios2                         3c120_defconfig
s390                             allyesconfig
parisc                            allnoconfig
sparc64                          allyesconfig
sh                  sh7785lcr_32bit_defconfig
um                           x86_64_defconfig
s390                                defconfig
nds32                             allnoconfig
ia64                              allnoconfig
riscv                    nommu_virt_defconfig
xtensa                          iss_defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
alpha                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
parisc               randconfig-a001-20200324
riscv                randconfig-a001-20200324
h8300                randconfig-a001-20200324
microblaze           randconfig-a001-20200324
nios2                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
sparc64              randconfig-a001-20200324
s390                 randconfig-a001-20200324
csky                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
openrisc             randconfig-a001-20200324
sh                   randconfig-a001-20200324
x86_64               randconfig-b001-20200324
x86_64               randconfig-b002-20200324
x86_64               randconfig-b003-20200324
i386                 randconfig-b001-20200324
i386                 randconfig-b002-20200324
i386                 randconfig-b003-20200324
x86_64               randconfig-c003-20200324
i386                 randconfig-c002-20200324
x86_64               randconfig-c001-20200324
x86_64               randconfig-c002-20200324
i386                 randconfig-c003-20200324
i386                 randconfig-c001-20200324
x86_64               randconfig-d001-20200324
x86_64               randconfig-d002-20200324
x86_64               randconfig-d003-20200324
i386                 randconfig-d001-20200324
i386                 randconfig-d002-20200324
i386                 randconfig-d003-20200324
x86_64               randconfig-e001-20200324
x86_64               randconfig-e002-20200324
x86_64               randconfig-e003-20200324
i386                 randconfig-e001-20200324
i386                 randconfig-e002-20200324
i386                 randconfig-e003-20200324
i386                 randconfig-f001-20200324
i386                 randconfig-f003-20200324
i386                 randconfig-f002-20200324
x86_64               randconfig-f002-20200324
x86_64               randconfig-f003-20200324
x86_64               randconfig-f001-20200324
x86_64               randconfig-g001-20200324
x86_64               randconfig-g002-20200324
x86_64               randconfig-g003-20200324
i386                 randconfig-g001-20200324
i386                 randconfig-g002-20200324
i386                 randconfig-g003-20200324
x86_64               randconfig-h001-20200324
x86_64               randconfig-h002-20200324
x86_64               randconfig-h003-20200324
i386                 randconfig-h001-20200324
i386                 randconfig-h002-20200324
i386                 randconfig-h003-20200324
arm                  randconfig-a001-20200324
arm64                randconfig-a001-20200324
ia64                 randconfig-a001-20200324
arc                  randconfig-a001-20200324
sparc                randconfig-a001-20200324
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                             defconfig
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
