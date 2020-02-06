Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C450153D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 04:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgBFC7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 21:59:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727806AbgBFC7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:59:46 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D61C27A59F3BC42EF3F;
        Thu,  6 Feb 2020 10:59:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 10:59:30 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 6/6] powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst and add 64bit part
Date:   Thu, 6 Feb 2020 10:58:25 +0800
Message-ID: <20200206025825.22934-7-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200206025825.22934-1-yanaijie@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support both 32 and 64 bit KASLR for fsl booke. Add document for
64 bit part and rename kaslr-booke32.rst to kaslr-booke.rst.

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
 .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)
 rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)

diff --git a/Documentation/powerpc/kaslr-booke32.rst b/Documentation/powerpc/kaslr-booke.rst
similarity index 59%
rename from Documentation/powerpc/kaslr-booke32.rst
rename to Documentation/powerpc/kaslr-booke.rst
index 8b259fdfdf03..42121fed8249 100644
--- a/Documentation/powerpc/kaslr-booke32.rst
+++ b/Documentation/powerpc/kaslr-booke.rst
@@ -1,15 +1,18 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===========================
-KASLR for Freescale BookE32
-===========================
+=========================
+KASLR for Freescale BookE
+=========================
 
 The word KASLR stands for Kernel Address Space Layout Randomization.
 
 This document tries to explain the implementation of the KASLR for
-Freescale BookE32. KASLR is a security feature that deters exploit
+Freescale BookE. KASLR is a security feature that deters exploit
 attempts relying on knowledge of the location of kernel internals.
 
+KASLR for Freescale BookE32
+-------------------------
+
 Since CONFIG_RELOCATABLE has already supported, what we need to do is
 map or copy kernel to a proper place and relocate. Freescale Book-E
 parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
@@ -38,5 +41,29 @@ bit of the entropy to decide the index of the 64M zone. Then we chose a
 
                               kernstart_virt_addr
 
+
+KASLR for Freescale BookE64
+---------------------------
+
+The implementation for Freescale BookE64 is similar as BookE32. One
+difference is that Freescale BookE64 set up a TLB mapping of 1G during
+booting. Another difference is that ppc64 needs the kernel to be
+64K-aligned. So we can randomize the kernel in this 1G mapping and make
+it 64K-aligned. This can save some code to creat another TLB map at early
+boot. The disadvantage is that we only have about 1G/64K = 16384 slots to
+put the kernel in::
+
+    KERNELBASE
+
+          64K                     |--> kernel <--|
+           |                      |              |
+        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
+        |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
+        +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
+        |                         |                        1G
+        |----->   offset    <-----|
+
+                              kernstart_virt_addr
+
 To enable KASLR, set CONFIG_RANDOMIZE_BASE = y. If KASLR is enable and you
 want to disable it at runtime, add "nokaslr" to the kernel cmdline.
-- 
2.17.2

