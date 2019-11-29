Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B100F10D1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfK2HFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 02:05:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbfK2HFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:05:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53DBF9292813DBDE57C3;
        Fri, 29 Nov 2019 15:05:09 +0800 (CST)
Received: from huawei.com (10.67.189.2) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 15:04:55 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <christophe.leroy@c-s.fr>
CC:     <liucheng32@huawei.com>, <yi.zhang@huawei.com>,
        <wangkefeng.wang@huawei.com>, <shaolexi@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/kasan: KASAN is not supported on RELOCATABLE && FSL_BOOKE
Date:   Fri, 29 Nov 2019 15:04:55 +0800
Message-ID: <20191129070455.62084-1-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_RELOCATABLE and CONFIG_KASAN cannot be enabled at the same time
on ppce500 fsl_booke. All functions called before kasan_early_init()
should be disabled with kasan check. When CONFIG_RELOCATABLE is enabled
on ppce500 fsl_booke, relocate_init() is called before kasan_early_init()
which triggers kasan check and results in boot failure.
Call trace and functions which triggers kasan check(*):
  - _start
   - set_ivor
    - relocate_init(*)
     - early_get_first_memblock_info(*)
      - of_scan_flat_dt(*)
	...
    - kasan_early_init

Potential solutions could be 1. implement relocate_init and all its children
function in a seperate file or 2. introduce a global vairable in KASAN, only
enable KASAN check when init is done.

Disable KASAN when RELOCATABLE is selected on fsl_booke for now until
it is supported.

Signed-off-by: Lexi Shao <shaolexi@huawei.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3e56c9c2f16e..14f3da63c088 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -171,7 +171,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
 	select HAVE_ARCH_JUMP_LABEL
-	select HAVE_ARCH_KASAN			if PPC32
+	select HAVE_ARCH_KASAN			if PPC32 && !(RELOCATABLE && FSL_BOOKE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-- 
2.12.3

