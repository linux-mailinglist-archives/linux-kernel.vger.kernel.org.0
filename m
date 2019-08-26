Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA53D9CF69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfHZMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 08:20:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbfHZMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BDns9gKlwxpRlHhqhuBNzBymFwV4gKbwNK9MNccRpjM=; b=PisG1R988rboJUKD6QMjE0RUsg
        GEPj3/jtyahkelXlueyAwolhWoZomPJyq4YYOEoCLgcfr6pX52duvbAfMy/S/BUV9dXwISp9N9CLI
        Qwvtso1cwTLYaFh7TrzB6XwVrDAQCudJNoOQzpIBc8xYZBStTC4iEG6msppk574uCIOAPVdr8RH2A
        EpfX7yMKCD3ADjwtDRyK0Bzo+MTYvRImyE4w1+LUXYaN4ryqbTl95lXLroWDfHqxEeOigdOTMviBo
        bZXuL8+Pv4pNtHSy14lCsiTcEgwhn/TTBszS39FuWZkkmkT9cxjaE8Nt8DGetzrMTyUP1DEMxJSqJ
        XQakTBfg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Dym-0003Vd-4h; Mon, 26 Aug 2019 12:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] swiotlb-xen: remove page-coherent.h
Date:   Mon, 26 Aug 2019 14:19:42 +0200
Message-Id: <20190826121944.515-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826121944.515-1-hch@lst.de>
References: <20190826121944.515-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing left of page-coherent.h is two functions implemented by
the architecture for non-coherent DMA support that are never called for
fully coherent architectures.  Just move the prototypes for those to
swiotlb-xen.h instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/xen/page-coherent.h   |  2 --
 arch/arm64/include/asm/xen/page-coherent.h |  2 --
 arch/x86/include/asm/xen/page-coherent.h   | 11 -----------
 drivers/xen/swiotlb-xen.c                  |  3 ---
 include/Kbuild                             |  1 -
 include/xen/arm/page-coherent.h            | 10 ----------
 include/xen/swiotlb-xen.h                  |  6 ++++++
 7 files changed, 6 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/include/asm/xen/page-coherent.h
 delete mode 100644 arch/arm64/include/asm/xen/page-coherent.h
 delete mode 100644 arch/x86/include/asm/xen/page-coherent.h
 delete mode 100644 include/xen/arm/page-coherent.h

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
deleted file mode 100644
index 27e984977402..000000000000
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <xen/arm/page-coherent.h>
diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
deleted file mode 100644
index 27e984977402..000000000000
--- a/arch/arm64/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <xen/arm/page-coherent.h>
diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
deleted file mode 100644
index c9c8398a31ff..000000000000
--- a/arch/x86/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_XEN_PAGE_COHERENT_H
-#define _ASM_X86_XEN_PAGE_COHERENT_H
-
-static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
-
-static inline void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
-
-#endif /* _ASM_X86_XEN_PAGE_COHERENT_H */
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a642e284f1e2..95911ff9c11c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -35,9 +35,6 @@
 #include <xen/xen-ops.h>
 #include <xen/hvc-console.h>
 
-#include <asm/dma-mapping.h>
-#include <asm/xen/page-coherent.h>
-
 #include <trace/events/swiotlb.h>
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..cce5cf6abf89 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -1189,7 +1189,6 @@ header-test-			+= video/vga.h
 header-test-			+= video/w100fb.h
 header-test-			+= xen/acpi.h
 header-test-			+= xen/arm/hypercall.h
-header-test-			+= xen/arm/page-coherent.h
 header-test-			+= xen/arm/page.h
 header-test-			+= xen/balloon.h
 header-test-			+= xen/events.h
diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
deleted file mode 100644
index 635492d41ebe..000000000000
--- a/include/xen/arm/page-coherent.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _XEN_ARM_PAGE_COHERENT_H
-#define _XEN_ARM_PAGE_COHERENT_H
-
-void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
-void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
-
-#endif /* _XEN_ARM_PAGE_COHERENT_H */
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 5e4b83f83dbc..a7c642872568 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -2,8 +2,14 @@
 #ifndef __LINUX_SWIOTLB_XEN_H
 #define __LINUX_SWIOTLB_XEN_H
 
+#include <linux/dma-mapping.h>
 #include <linux/swiotlb.h>
 
+void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
+void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
+
 extern int xen_swiotlb_init(int verbose, bool early);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
 
-- 
2.20.1

