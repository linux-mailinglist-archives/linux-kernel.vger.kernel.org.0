Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8741E197268
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgC3CWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:22:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728976AbgC3CWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:22:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78D72942388DF4EB45FC;
        Mon, 30 Mar 2020 10:22:33 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:22:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        <dja@axtens.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v5 5/6] powerpc/fsl_booke/64: clear the original kernel if randomized
Date:   Mon, 30 Mar 2020 10:20:22 +0800
Message-ID: <20200330022023.3691-6-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200330022023.3691-1-yanaijie@huawei.com>
References: <20200330022023.3691-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original kernel still exists in the memory, clear it now.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 24ad34641869..6c46f24cc53d 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -382,8 +382,10 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 	unsigned long kernel_sz;
 
 	if (IS_ENABLED(CONFIG_PPC64)) {
-		if (__run_at_load == 1)
+		if (__run_at_load == 1) {
+			kaslr_late_init();
 			return;
+		}
 
 		/* Get the first memblock size */
 		early_get_first_memblock_info(dt_ptr, &size);
-- 
2.17.2

