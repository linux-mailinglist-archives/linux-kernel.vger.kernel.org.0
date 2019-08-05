Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A930781239
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfHEG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 02:26:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbfHEG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:26:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B389BDC3C4B824952CB;
        Mon,  5 Aug 2019 14:26:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 14:26:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 03/10] powerpc: introduce kimage_vaddr to store the kernel base
Date:   Mon, 5 Aug 2019 14:43:28 +0800
Message-ID: <20190805064335.19156-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190805064335.19156-1-yanaijie@huawei.com>
References: <20190805064335.19156-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kernel base is a fixed value - KERNELBASE. To support KASLR, we
need a variable to store the kernel base.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Tested-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/include/asm/page.h | 2 ++
 arch/powerpc/mm/init-common.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 0d52f57fca04..60a68d3a54b1 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -315,6 +315,8 @@ void arch_free_page(struct page *page, int order);
 
 struct vm_area_struct;
 
+extern unsigned long kimage_vaddr;
+
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
 #include <asm/slice.h>
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 152ae0d21435..d4801ce48dc5 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,6 +25,8 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
 EXPORT_SYMBOL_GPL(memstart_addr);
 phys_addr_t kernstart_addr;
 EXPORT_SYMBOL_GPL(kernstart_addr);
+unsigned long kimage_vaddr = KERNELBASE;
+EXPORT_SYMBOL_GPL(kimage_vaddr);
 
 static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
 static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
-- 
2.17.2

