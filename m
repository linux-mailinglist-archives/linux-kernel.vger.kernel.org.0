Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885981739E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgB1Ocf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 09:32:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:26474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgB1Ocf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:32:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 06:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="232545922"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2020 06:32:32 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7ggp-000FAY-DX; Fri, 28 Feb 2020 22:32:31 +0800
Date:   Fri, 28 Feb 2020 22:32:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 645e64662af4dba9eb4a80bbab2663dd22018312
Message-ID: <5e59246d.6LN6hGRslJUdGw8R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/build
branch HEAD: 645e64662af4dba9eb4a80bbab2663dd22018312  x86/Kconfig: Make CMDLINE_OVERRIDE depend on non-empty CMDLINE

elapsed time: 2924m

configs tested: 298
configs skipped: 128

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
h8300                     edosk2674_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
sh                  sh7785lcr_32bit_defconfig
mips                      fuloong2e_defconfig
h8300                    h8300h-sim_defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
sparc64                          allmodconfig
sparc64                             defconfig
sparc64                           allnoconfig
openrisc                 simple_smp_defconfig
csky                                defconfig
sh                                allnoconfig
microblaze                    nommu_defconfig
s390                          debug_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
ia64                                defconfig
powerpc                             defconfig
sparc64                          allyesconfig
um                                  defconfig
nios2                         3c120_defconfig
sh                               allmodconfig
nds32                             allnoconfig
powerpc                       ppc64_defconfig
mips                             allyesconfig
xtensa                          iss_defconfig
sh                            titan_defconfig
c6x                              allyesconfig
riscv                             allnoconfig
microblaze                      mmu_defconfig
riscv                               defconfig
mips                      malta_kvm_defconfig
sparc                               defconfig
m68k                           sun3_defconfig
xtensa                       common_defconfig
parisc                            allnoconfig
s390                              allnoconfig
powerpc                           allnoconfig
parisc                generic-64bit_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
x86_64               randconfig-a001-20200227
x86_64               randconfig-a002-20200227
x86_64               randconfig-a003-20200227
i386                 randconfig-a001-20200227
i386                 randconfig-a002-20200227
i386                 randconfig-a003-20200227
x86_64               randconfig-a001-20200226
x86_64               randconfig-a002-20200226
x86_64               randconfig-a003-20200226
i386                 randconfig-a001-20200226
i386                 randconfig-a002-20200226
i386                 randconfig-a003-20200226
x86_64               randconfig-a001-20200228
x86_64               randconfig-a002-20200228
x86_64               randconfig-a003-20200228
i386                 randconfig-a001-20200228
i386                 randconfig-a002-20200228
i386                 randconfig-a003-20200228
alpha                randconfig-a001-20200227
m68k                 randconfig-a001-20200227
mips                 randconfig-a001-20200227
nds32                randconfig-a001-20200227
parisc               randconfig-a001-20200227
riscv                randconfig-a001-20200227
alpha                randconfig-a001-20200228
m68k                 randconfig-a001-20200228
mips                 randconfig-a001-20200228
nds32                randconfig-a001-20200228
parisc               randconfig-a001-20200228
riscv                randconfig-a001-20200228
alpha                randconfig-a001-20200226
m68k                 randconfig-a001-20200226
mips                 randconfig-a001-20200226
nds32                randconfig-a001-20200226
parisc               randconfig-a001-20200226
riscv                randconfig-a001-20200226
c6x                  randconfig-a001-20200226
h8300                randconfig-a001-20200226
microblaze           randconfig-a001-20200226
nios2                randconfig-a001-20200226
sparc64              randconfig-a001-20200226
c6x                  randconfig-a001-20200227
h8300                randconfig-a001-20200227
microblaze           randconfig-a001-20200227
nios2                randconfig-a001-20200227
sparc64              randconfig-a001-20200227
c6x                  randconfig-a001-20200228
h8300                randconfig-a001-20200228
microblaze           randconfig-a001-20200228
nios2                randconfig-a001-20200228
sparc64              randconfig-a001-20200228
csky                 randconfig-a001-20200226
openrisc             randconfig-a001-20200226
s390                 randconfig-a001-20200226
sh                   randconfig-a001-20200226
xtensa               randconfig-a001-20200226
csky                 randconfig-a001-20200227
openrisc             randconfig-a001-20200227
s390                 randconfig-a001-20200227
sh                   randconfig-a001-20200227
xtensa               randconfig-a001-20200227
csky                 randconfig-a001-20200228
openrisc             randconfig-a001-20200228
s390                 randconfig-a001-20200228
sh                   randconfig-a001-20200228
xtensa               randconfig-a001-20200228
x86_64               randconfig-b001-20200228
x86_64               randconfig-b002-20200228
x86_64               randconfig-b003-20200228
i386                 randconfig-b001-20200228
i386                 randconfig-b002-20200228
i386                 randconfig-b003-20200228
x86_64               randconfig-b001-20200227
x86_64               randconfig-b002-20200227
x86_64               randconfig-b003-20200227
i386                 randconfig-b001-20200227
i386                 randconfig-b002-20200227
i386                 randconfig-b003-20200227
x86_64               randconfig-b001-20200226
x86_64               randconfig-b002-20200226
x86_64               randconfig-b003-20200226
i386                 randconfig-b001-20200226
i386                 randconfig-b002-20200226
i386                 randconfig-b003-20200226
x86_64               randconfig-c001-20200227
x86_64               randconfig-c002-20200227
x86_64               randconfig-c003-20200227
i386                 randconfig-c001-20200227
i386                 randconfig-c002-20200227
i386                 randconfig-c003-20200227
x86_64               randconfig-c001-20200226
x86_64               randconfig-c002-20200226
x86_64               randconfig-c003-20200226
i386                 randconfig-c001-20200226
i386                 randconfig-c002-20200226
i386                 randconfig-c003-20200226
x86_64               randconfig-c001-20200228
x86_64               randconfig-c002-20200228
x86_64               randconfig-c003-20200228
i386                 randconfig-c001-20200228
i386                 randconfig-c002-20200228
i386                 randconfig-c003-20200228
x86_64               randconfig-d001-20200227
x86_64               randconfig-d002-20200227
x86_64               randconfig-d003-20200227
i386                 randconfig-d001-20200227
i386                 randconfig-d002-20200227
i386                 randconfig-d003-20200227
x86_64               randconfig-d001-20200226
x86_64               randconfig-d002-20200226
x86_64               randconfig-d003-20200226
i386                 randconfig-d001-20200226
i386                 randconfig-d002-20200226
i386                 randconfig-d003-20200226
x86_64               randconfig-d001-20200228
x86_64               randconfig-d002-20200228
x86_64               randconfig-d003-20200228
i386                 randconfig-d001-20200228
i386                 randconfig-d002-20200228
i386                 randconfig-d003-20200228
x86_64               randconfig-e001-20200227
x86_64               randconfig-e002-20200227
x86_64               randconfig-e003-20200227
i386                 randconfig-e001-20200227
i386                 randconfig-e002-20200227
i386                 randconfig-e003-20200227
x86_64               randconfig-e001-20200226
x86_64               randconfig-e002-20200226
x86_64               randconfig-e003-20200226
i386                 randconfig-e001-20200226
i386                 randconfig-e002-20200226
i386                 randconfig-e003-20200226
x86_64               randconfig-e001-20200228
x86_64               randconfig-e002-20200228
x86_64               randconfig-e003-20200228
i386                 randconfig-e001-20200228
i386                 randconfig-e002-20200228
i386                 randconfig-e003-20200228
x86_64               randconfig-f001-20200226
x86_64               randconfig-f002-20200226
x86_64               randconfig-f003-20200226
i386                 randconfig-f001-20200226
i386                 randconfig-f002-20200226
i386                 randconfig-f003-20200226
x86_64               randconfig-f001-20200227
x86_64               randconfig-f002-20200227
x86_64               randconfig-f003-20200227
i386                 randconfig-f001-20200227
i386                 randconfig-f002-20200227
i386                 randconfig-f003-20200227
x86_64               randconfig-f001-20200228
x86_64               randconfig-f002-20200228
x86_64               randconfig-f003-20200228
i386                 randconfig-f001-20200228
i386                 randconfig-f002-20200228
i386                 randconfig-f003-20200228
x86_64               randconfig-g001-20200227
x86_64               randconfig-g002-20200227
x86_64               randconfig-g003-20200227
i386                 randconfig-g001-20200227
i386                 randconfig-g002-20200227
i386                 randconfig-g003-20200227
x86_64               randconfig-g001-20200228
x86_64               randconfig-g002-20200228
x86_64               randconfig-g003-20200228
i386                 randconfig-g001-20200228
i386                 randconfig-g002-20200228
i386                 randconfig-g003-20200228
x86_64               randconfig-g001-20200226
i386                 randconfig-g002-20200226
i386                 randconfig-g003-20200226
x86_64               randconfig-g003-20200226
i386                 randconfig-g001-20200226
x86_64               randconfig-g002-20200226
i386                 randconfig-h003-20200226
i386                 randconfig-h002-20200226
x86_64               randconfig-h002-20200226
x86_64               randconfig-h003-20200226
i386                 randconfig-h001-20200226
x86_64               randconfig-h001-20200226
x86_64               randconfig-h001-20200227
x86_64               randconfig-h002-20200227
x86_64               randconfig-h003-20200227
i386                 randconfig-h001-20200227
i386                 randconfig-h002-20200227
i386                 randconfig-h003-20200227
x86_64               randconfig-h001-20200228
x86_64               randconfig-h002-20200228
x86_64               randconfig-h003-20200228
i386                 randconfig-h001-20200228
i386                 randconfig-h002-20200228
i386                 randconfig-h003-20200228
arm                  randconfig-a001-20200227
arm64                randconfig-a001-20200227
ia64                 randconfig-a001-20200227
powerpc              randconfig-a001-20200227
arc                  randconfig-a001-20200228
arm                  randconfig-a001-20200228
arm64                randconfig-a001-20200228
ia64                 randconfig-a001-20200228
powerpc              randconfig-a001-20200228
sparc                randconfig-a001-20200228
arc                  randconfig-a001-20200227
sparc                randconfig-a001-20200227
riscv                            allmodconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                                defconfig
sh                          rsk7269_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
