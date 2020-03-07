Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188BC17CCCF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 09:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCGIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 03:23:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:35652 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGIXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:23:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 00:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="442202037"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2020 00:23:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAUk5-00066x-22; Sat, 07 Mar 2020 16:23:29 +0800
Date:   Sat, 07 Mar 2020 16:23:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 681ff0181bbfb183e32bc6beb6ec076304470479
Message-ID: <5e6359ec.9tc9sl2mIw1yrjoy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/mm
branch HEAD: 681ff0181bbfb183e32bc6beb6ec076304470479  x86/mm/init/32: Stop printing the virtual memory layout

elapsed time: 2007m

configs tested: 238
configs skipped: 84

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
parisc                generic-64bit_defconfig
h8300                    h8300h-sim_defconfig
ia64                                defconfig
powerpc                             defconfig
sh                                allnoconfig
s390                             allyesconfig
s390                       zfcpdump_defconfig
sparc64                           allnoconfig
mips                             allmodconfig
s390                                defconfig
um                                  defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
x86_64               randconfig-a001-20200305
x86_64               randconfig-a002-20200305
x86_64               randconfig-a003-20200305
i386                 randconfig-a001-20200305
i386                 randconfig-a002-20200305
i386                 randconfig-a003-20200305
x86_64               randconfig-a001-20200306
x86_64               randconfig-a002-20200306
x86_64               randconfig-a003-20200306
i386                 randconfig-a001-20200306
i386                 randconfig-a002-20200306
i386                 randconfig-a003-20200306
x86_64               randconfig-a001-20200307
x86_64               randconfig-a002-20200307
x86_64               randconfig-a003-20200307
i386                 randconfig-a001-20200307
i386                 randconfig-a002-20200307
i386                 randconfig-a003-20200307
alpha                randconfig-a001-20200306
m68k                 randconfig-a001-20200306
mips                 randconfig-a001-20200306
nds32                randconfig-a001-20200306
parisc               randconfig-a001-20200306
riscv                randconfig-a001-20200306
alpha                randconfig-a001-20200307
m68k                 randconfig-a001-20200307
mips                 randconfig-a001-20200307
nds32                randconfig-a001-20200307
parisc               randconfig-a001-20200307
c6x                  randconfig-a001-20200306
h8300                randconfig-a001-20200306
microblaze           randconfig-a001-20200306
nios2                randconfig-a001-20200306
sparc64              randconfig-a001-20200306
csky                 randconfig-a001-20200305
openrisc             randconfig-a001-20200305
s390                 randconfig-a001-20200305
sh                   randconfig-a001-20200305
xtensa               randconfig-a001-20200305
csky                 randconfig-a001-20200306
openrisc             randconfig-a001-20200306
s390                 randconfig-a001-20200306
sh                   randconfig-a001-20200306
xtensa               randconfig-a001-20200306
x86_64               randconfig-b001-20200306
x86_64               randconfig-b002-20200306
x86_64               randconfig-b003-20200306
i386                 randconfig-b001-20200306
i386                 randconfig-b002-20200306
i386                 randconfig-b003-20200306
x86_64               randconfig-b001-20200305
x86_64               randconfig-b002-20200305
x86_64               randconfig-b003-20200305
i386                 randconfig-b001-20200305
i386                 randconfig-b002-20200305
i386                 randconfig-b003-20200305
x86_64               randconfig-c001-20200305
x86_64               randconfig-c002-20200305
x86_64               randconfig-c003-20200305
i386                 randconfig-c001-20200305
i386                 randconfig-c002-20200305
i386                 randconfig-c003-20200305
x86_64               randconfig-c001-20200306
x86_64               randconfig-c002-20200306
x86_64               randconfig-c003-20200306
i386                 randconfig-c001-20200306
i386                 randconfig-c002-20200306
i386                 randconfig-c003-20200306
x86_64               randconfig-d001-20200305
x86_64               randconfig-d002-20200305
x86_64               randconfig-d003-20200305
i386                 randconfig-d001-20200305
i386                 randconfig-d002-20200305
i386                 randconfig-d003-20200305
x86_64               randconfig-d001-20200306
x86_64               randconfig-d002-20200306
x86_64               randconfig-d003-20200306
i386                 randconfig-d001-20200306
i386                 randconfig-d002-20200306
i386                 randconfig-d003-20200306
x86_64               randconfig-e001-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e001-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-e003-20200305
x86_64               randconfig-e001-20200306
x86_64               randconfig-e002-20200306
x86_64               randconfig-e003-20200306
i386                 randconfig-e001-20200306
i386                 randconfig-e002-20200306
i386                 randconfig-e003-20200306
x86_64               randconfig-f001-20200305
x86_64               randconfig-f002-20200305
x86_64               randconfig-f003-20200305
i386                 randconfig-f001-20200305
i386                 randconfig-f002-20200305
i386                 randconfig-f003-20200305
x86_64               randconfig-f001-20200306
x86_64               randconfig-f002-20200306
x86_64               randconfig-f003-20200306
i386                 randconfig-f001-20200306
i386                 randconfig-f002-20200306
i386                 randconfig-f003-20200306
x86_64               randconfig-f001-20200307
x86_64               randconfig-f002-20200307
x86_64               randconfig-f003-20200307
i386                 randconfig-f001-20200307
i386                 randconfig-f002-20200307
i386                 randconfig-f003-20200307
x86_64               randconfig-g001-20200305
x86_64               randconfig-g002-20200305
x86_64               randconfig-g003-20200305
i386                 randconfig-g001-20200305
i386                 randconfig-g002-20200305
i386                 randconfig-g003-20200305
x86_64               randconfig-g001-20200306
x86_64               randconfig-g002-20200306
x86_64               randconfig-g003-20200306
i386                 randconfig-g001-20200306
i386                 randconfig-g002-20200306
i386                 randconfig-g003-20200306
x86_64               randconfig-h001-20200305
x86_64               randconfig-h002-20200305
x86_64               randconfig-h003-20200305
i386                 randconfig-h001-20200305
i386                 randconfig-h002-20200305
i386                 randconfig-h003-20200305
x86_64               randconfig-h001-20200306
x86_64               randconfig-h002-20200306
x86_64               randconfig-h003-20200306
i386                 randconfig-h001-20200306
i386                 randconfig-h002-20200306
i386                 randconfig-h003-20200306
arc                  randconfig-a001-20200306
arm                  randconfig-a001-20200306
arm64                randconfig-a001-20200306
ia64                 randconfig-a001-20200306
powerpc              randconfig-a001-20200306
sparc                randconfig-a001-20200306
arc                  randconfig-a001-20200305
arm                  randconfig-a001-20200305
arm64                randconfig-a001-20200305
ia64                 randconfig-a001-20200305
powerpc              randconfig-a001-20200305
sparc                randconfig-a001-20200305
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
