Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCB17B6E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 07:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFGl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 01:41:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11597 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbgCFGl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:41:58 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50BDDE1792697A077368;
        Fri,  6 Mar 2020 14:41:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 14:41:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        <dja@axtens.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 0/6] implement KASLR for powerpc/fsl_booke/64
Date:   Fri, 6 Mar 2020 14:40:27 +0800
Message-ID: <20200306064033.3398-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a try to implement KASLR for Freescale BookE64 which is based on
my earlier implementation for Freescale BookE32:
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718&state=*

The implementation for Freescale BookE64 is similar as BookE32. One
difference is that Freescale BookE64 set up a TLB mapping of 1G during
booting. Another difference is that ppc64 needs the kernel to be
64K-aligned. So we can randomize the kernel in this 1G mapping and make
it 64K-aligned. This can save some code to creat another TLB map at
early boot. The disadvantage is that we only have about 1G/64K = 16384
slots to put the kernel in.

    KERNELBASE

          64K                     |--> kernel <--|
           |                      |              |
        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
        |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
        |                         |                        1G
        |----->   offset    <-----|

                              kernstart_virt_addr

I'm not sure if the slot numbers is enough or the design has any
defects. If you have some better ideas, I would be happy to hear that.

Thank you all.

v3->v4:
  Do not define __kaslr_offset as a fixed symbol. Reference __run_at_load and
    __kaslr_offset by symbol instead of magic offsets.
  Use IS_ENABLED(CONFIG_PPC32) instead of #ifdef CONFIG_PPC32.
  Change kaslr-booke32 to kaslr-booke in index.rst
  Switch some instructions to 64-bit.
v2->v3:
  Fix build error when KASLR is disabled.
v1->v2:
  Add __kaslr_offset for the secondary cpu boot up.

Jason Yan (6):
  powerpc/fsl_booke/kaslr: refactor kaslr_legal_offset() and
    kaslr_early_init()
  powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
  powerpc/fsl_booke/64: implement KASLR for fsl_booke64
  powerpc/fsl_booke/64: do not clear the BSS for the second pass
  powerpc/fsl_booke/64: clear the original kernel if randomized
  powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst
    and add 64bit part

 Documentation/powerpc/index.rst               |  2 +-
 .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 +++++++-
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/kernel/exceptions-64e.S          | 23 +++++
 arch/powerpc/kernel/head_64.S                 | 13 +++
 arch/powerpc/kernel/setup_64.c                |  3 +
 arch/powerpc/mm/mmu_decl.h                    | 23 ++---
 arch/powerpc/mm/nohash/kaslr_booke.c          | 88 +++++++++++++------
 8 files changed, 144 insertions(+), 45 deletions(-)
 rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)

-- 
2.17.2

