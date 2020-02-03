Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEF1508B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBCOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 09:47:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:29125 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBCOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:47:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 06:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="223959455"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2020 06:47:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iyd0A-000ALw-BU; Mon, 03 Feb 2020 22:47:02 +0800
Date:   Mon, 03 Feb 2020 22:46:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 05bd330a7fd8875c423fc07d8ddcad73c10e556e
Message-ID: <5e383230.vP2VHsIbH7NaGbmo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 05bd330a7fd8875c423fc07d8ddcad73c10e556e  x86/hyperv: Suspend/resume the hypercall page for hibernation

elapsed time: 2885m

configs tested: 163
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                         at91_dt_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                             allnoconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
arm                              allmodconfig
arm64                            allmodconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
i386                 randconfig-a003-20200201
i386                 randconfig-a002-20200201
x86_64               randconfig-a003-20200201
x86_64               randconfig-a002-20200201
i386                 randconfig-a001-20200201
x86_64               randconfig-a001-20200201
alpha                randconfig-a001-20200201
parisc               randconfig-a001-20200201
m68k                 randconfig-a001-20200201
nds32                randconfig-a001-20200201
mips                 randconfig-a001-20200201
riscv                randconfig-a001-20200201
h8300                randconfig-a001-20200201
nios2                randconfig-a001-20200201
sparc64              randconfig-a001-20200201
microblaze           randconfig-a001-20200201
c6x                  randconfig-a001-20200201
sh                   randconfig-a001-20200201
s390                 randconfig-a001-20200201
csky                 randconfig-a001-20200201
xtensa               randconfig-a001-20200201
openrisc             randconfig-a001-20200201
i386                 randconfig-b001-20200202
x86_64               randconfig-b002-20200202
i386                 randconfig-b002-20200202
x86_64               randconfig-b001-20200202
i386                 randconfig-b003-20200202
x86_64               randconfig-b003-20200202
x86_64               randconfig-c003-20200201
i386                 randconfig-c002-20200201
x86_64               randconfig-c002-20200201
i386                 randconfig-c001-20200201
x86_64               randconfig-c001-20200201
i386                 randconfig-c003-20200201
x86_64               randconfig-d003-20200202
i386                 randconfig-d001-20200202
x86_64               randconfig-d002-20200202
x86_64               randconfig-d001-20200202
i386                 randconfig-d003-20200202
i386                 randconfig-d002-20200202
i386                 randconfig-e003-20200201
i386                 randconfig-e002-20200201
x86_64               randconfig-e001-20200201
x86_64               randconfig-e003-20200201
i386                 randconfig-e001-20200201
x86_64               randconfig-e002-20200201
i386                 randconfig-f002-20200201
i386                 randconfig-f003-20200201
x86_64               randconfig-f002-20200201
i386                 randconfig-f001-20200201
x86_64               randconfig-f001-20200201
x86_64               randconfig-f003-20200201
x86_64               randconfig-g003-20200201
x86_64               randconfig-g001-20200201
i386                 randconfig-g001-20200201
x86_64               randconfig-g002-20200201
i386                 randconfig-g002-20200201
i386                 randconfig-g003-20200201
x86_64               randconfig-h001-20200201
i386                 randconfig-h002-20200201
x86_64               randconfig-h002-20200201
i386                 randconfig-h003-20200201
x86_64               randconfig-h003-20200201
i386                 randconfig-h001-20200201
arc                  randconfig-a001-20200201
ia64                 randconfig-a001-20200201
sparc                randconfig-a001-20200201
arm64                randconfig-a001-20200201
arm                  randconfig-a001-20200201
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
