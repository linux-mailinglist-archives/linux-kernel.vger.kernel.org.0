Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13B66A10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfGLJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 05:38:18 -0400
Received: from ozlabs.ru ([107.173.13.209]:58432 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfGLJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:38:16 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 29E88AE807DE;
        Fri, 12 Jul 2019 05:30:01 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel v4 2/4] powerpc/iommu: Allow bypass-only for DMA
Date:   Fri, 12 Jul 2019 19:29:53 +1000
Message-Id: <20190712092955.56218-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712092955.56218-1-aik@ozlabs.ru>
References: <20190712092955.56218-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER8 and newer support a bypass mode which maps all host memory to
PCI buses so an IOMMU table is not always required. However if we fail to
create such a table, the DMA setup fails and the kernel does not boot.

This skips the 32bit DMA setup check if the bypass is can be selected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

This minor thing helped me debugging next 2 patches so it can help
somebody else too.
---
 arch/powerpc/kernel/dma-iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index a0879674a9c8..c963d704fa31 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -122,18 +122,17 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
-	if (!tbl) {
-		dev_info(dev, "Warning: IOMMU dma not supported: mask 0x%08llx"
-			", table unavailable\n", mask);
-		return 0;
-	}
-
 	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
 		dev->archdata.iommu_bypass = true;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
 		return 1;
 	}
 
+	if (!tbl) {
+		dev_err(dev, "Warning: IOMMU dma not supported: mask 0x%08llx, table unavailable\n", mask);
+		return 0;
+	}
+
 	if (tbl->it_offset > (mask >> tbl->it_page_shift)) {
 		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
 		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
-- 
2.17.1

