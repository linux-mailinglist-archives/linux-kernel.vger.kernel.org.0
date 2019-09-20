Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9882FB8DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437898AbfITJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 05:25:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408502AbfITJZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:25:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 696D475169ACCDB8F39B;
        Fri, 20 Sep 2019 17:25:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 17:25:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <oss@buserror.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v7 12/12] powerpc/fsl_booke/32: Document KASLR implementation
Date:   Fri, 20 Sep 2019 17:45:46 +0800
Message-ID: <20190920094546.44948-13-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190920094546.44948-1-yanaijie@huawei.com>
References: <20190920094546.44948-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document to explain how we implement KASLR for fsl_booke32.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 Documentation/powerpc/kaslr-booke32.rst | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/powerpc/kaslr-booke32.rst

diff --git a/Documentation/powerpc/kaslr-booke32.rst b/Documentation/powerpc/kaslr-booke32.rst
new file mode 100644
index 000000000000..8b259fdfdf03
--- /dev/null
+++ b/Documentation/powerpc/kaslr-booke32.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+KASLR for Freescale BookE32
+===========================
+
+The word KASLR stands for Kernel Address Space Layout Randomization.
+
+This document tries to explain the implementation of the KASLR for
+Freescale BookE32. KASLR is a security feature that deters exploit
+attempts relying on knowledge of the location of kernel internals.
+
+Since CONFIG_RELOCATABLE has already supported, what we need to do is
+map or copy kernel to a proper place and relocate. Freescale Book-E
+parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
+entries are not suitable to map the kernel directly in a randomized
+region, so we chose to copy the kernel to a proper place and restart to
+relocate.
+
+Entropy is derived from the banner and timer base, which will change every
+build and boot. This not so much safe so additionally the bootloader may
+pass entropy via the /chosen/kaslr-seed node in device tree.
+
+We will use the first 512M of the low memory to randomize the kernel
+image. The memory will be split in 64M zones. We will use the lower 8
+bit of the entropy to decide the index of the 64M zone. Then we chose a
+16K aligned offset inside the 64M zone to put the kernel in::
+
+    KERNELBASE
+
+        |-->   64M   <--|
+        |               |
+        +---------------+    +----------------+---------------+
+        |               |....|    |kernel|    |               |
+        +---------------+    +----------------+---------------+
+        |                         |
+        |----->   offset    <-----|
+
+                              kernstart_virt_addr
+
+To enable KASLR, set CONFIG_RANDOMIZE_BASE = y. If KASLR is enable and you
+want to disable it at runtime, add "nokaslr" to the kernel cmdline.
-- 
2.17.2

