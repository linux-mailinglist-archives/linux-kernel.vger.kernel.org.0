Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0917D752
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCIAfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 20:35:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:55777 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgCIAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:35:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 17:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="442586913"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2020 17:35:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jB6OH-0004mF-7k; Mon, 09 Mar 2020 08:35:29 +0800
Date:   Mon, 09 Mar 2020 08:35:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 d5528d5e91041e68e8eab9792ce627705a0ed273
Message-ID: <5e658f49.pJILVIEwxzpglspa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: d5528d5e91041e68e8eab9792ce627705a0ed273  partitions/efi: Fix partition name parsing in GUID partition entry

elapsed time: 480m

configs tested: 169
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
um                             i386_defconfig
c6x                              allyesconfig
s390                          debug_defconfig
m68k                           sun3_defconfig
i386                             allyesconfig
h8300                     edosk2674_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
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
x86_64               randconfig-a001-20200308
x86_64               randconfig-a002-20200308
x86_64               randconfig-a003-20200308
i386                 randconfig-a001-20200308
i386                 randconfig-a002-20200308
i386                 randconfig-a003-20200308
riscv                randconfig-a001-20200308
m68k                 randconfig-a001-20200308
alpha                randconfig-a001-20200308
mips                 randconfig-a001-20200308
nds32                randconfig-a001-20200308
parisc               randconfig-a001-20200308
sparc64              randconfig-a001-20200308
microblaze           randconfig-a001-20200308
c6x                  randconfig-a001-20200308
nios2                randconfig-a001-20200308
h8300                randconfig-a001-20200308
c6x                  randconfig-a001-20200309
h8300                randconfig-a001-20200309
microblaze           randconfig-a001-20200309
nios2                randconfig-a001-20200309
sparc64              randconfig-a001-20200309
csky                 randconfig-a001-20200308
openrisc             randconfig-a001-20200308
s390                 randconfig-a001-20200308
sh                   randconfig-a001-20200308
xtensa               randconfig-a001-20200308
x86_64               randconfig-b001-20200308
x86_64               randconfig-b002-20200308
x86_64               randconfig-b003-20200308
i386                 randconfig-b001-20200308
i386                 randconfig-b002-20200308
i386                 randconfig-b003-20200308
i386                 randconfig-c001-20200308
x86_64               randconfig-c003-20200308
i386                 randconfig-c002-20200308
x86_64               randconfig-c002-20200308
i386                 randconfig-c003-20200308
x86_64               randconfig-c001-20200308
i386                 randconfig-d001-20200308
x86_64               randconfig-d003-20200308
x86_64               randconfig-d001-20200308
i386                 randconfig-d003-20200308
x86_64               randconfig-d002-20200308
i386                 randconfig-d002-20200308
x86_64               randconfig-e001-20200308
x86_64               randconfig-e002-20200308
x86_64               randconfig-e003-20200308
i386                 randconfig-e001-20200308
i386                 randconfig-e002-20200308
i386                 randconfig-e003-20200308
i386                 randconfig-f003-20200308
x86_64               randconfig-f001-20200308
i386                 randconfig-f002-20200308
i386                 randconfig-f001-20200308
x86_64               randconfig-f002-20200308
x86_64               randconfig-f003-20200308
i386                 randconfig-g001-20200308
x86_64               randconfig-g003-20200308
i386                 randconfig-g003-20200308
x86_64               randconfig-g001-20200308
x86_64               randconfig-g002-20200308
i386                 randconfig-g002-20200308
x86_64               randconfig-h001-20200308
x86_64               randconfig-h002-20200308
x86_64               randconfig-h003-20200308
i386                 randconfig-h001-20200308
i386                 randconfig-h002-20200308
i386                 randconfig-h003-20200308
arc                  randconfig-a001-20200308
arm                  randconfig-a001-20200308
arm64                randconfig-a001-20200308
ia64                 randconfig-a001-20200308
powerpc              randconfig-a001-20200308
sparc                randconfig-a001-20200308
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
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
