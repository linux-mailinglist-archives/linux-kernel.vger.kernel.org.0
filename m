Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483AE9CF64
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfHZMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 08:20:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbfHZMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZJgCE8VaT9ExMOoCkwFiJUHvSb4wx5RyTACIYTHpVAQ=; b=ccx+/pUC2Px9ZtFSoSgwf3fgQe
        MqQ62RGFxHrqG45mNd8ilMTmT4JrhEVAySuJy6LRSGtjnW3Hdh3a76KWYcGd7eF9mj/36vS3jh7cg
        IbF5puJUGBN0KCBAlfrGfxvFD5HCUO2eJn2A4KTo2IuQMUZh5TixAzSMkEe3GXaKRUPMmiwfDGZOX
        OWM7GWc2iB/J9WshSAIOdufyfr48m0oaA255syJMg7nBa+l6gQfX6MFGCYmqHU9+85QGgjglbtmPv
        AxOVXeiTzGEe+FjSFnGqXusM3izLelOWNSi8FgcAmgvNrDDOItvZPNMg+luCjfJjt2saMMOxH2Ndw
        9cS5iyJg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DyW-0002OV-UB; Mon, 26 Aug 2019 12:19:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 04/11] xen/arm: remove xen_dma_ops
Date:   Mon, 26 Aug 2019 14:19:37 +0200
Message-Id: <20190826121944.515-5-hch@lst.de>
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

arm and arm64 can just use xen_swiotlb_dma_ops directly like x86, no
need for a pointer indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm/mm/dma-mapping.c    | 3 ++-
 arch/arm/xen/mm.c            | 4 ----
 arch/arm64/mm/dma-mapping.c  | 3 ++-
 include/xen/arm/hypervisor.h | 2 --
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 738097396445..2661cad36359 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -35,6 +35,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
 #include <asm/dma-contiguous.h>
+#include <xen/swiotlb-xen.h>
 
 #include "dma.h"
 #include "mm.h"
@@ -2360,7 +2361,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 #ifdef CONFIG_XEN
 	if (xen_initial_domain())
-		dev->dma_ops = xen_dma_ops;
+		dev->dma_ops = &xen_swiotlb_dma_ops;
 #endif
 	dev->archdata.dma_ops_setup = true;
 }
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 14210ebdea1a..9b3a6c0ca681 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -163,16 +163,12 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
-const struct dma_map_ops *xen_dma_ops;
-EXPORT_SYMBOL(xen_dma_ops);
-
 int __init xen_mm_init(void)
 {
 	struct gnttab_cache_flush cflush;
 	if (!xen_initial_domain())
 		return 0;
 	xen_swiotlb_init(1, false);
-	xen_dma_ops = &xen_swiotlb_dma_ops;
 
 	cflush.op = 0;
 	cflush.a.dev_bus_addr = 0;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index bd2b039f43a6..4b244a037349 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -8,6 +8,7 @@
 #include <linux/cache.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-iommu.h>
+#include <xen/swiotlb-xen.h>
 
 #include <asm/cacheflush.h>
 
@@ -64,6 +65,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 #ifdef CONFIG_XEN
 	if (xen_initial_domain())
-		dev->dma_ops = xen_dma_ops;
+		dev->dma_ops = &xen_swiotlb_dma_ops;
 #endif
 }
diff --git a/include/xen/arm/hypervisor.h b/include/xen/arm/hypervisor.h
index 2982571f7cc1..43ef24dd030e 100644
--- a/include/xen/arm/hypervisor.h
+++ b/include/xen/arm/hypervisor.h
@@ -19,8 +19,6 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 	return PARAVIRT_LAZY_NONE;
 }
 
-extern const struct dma_map_ops *xen_dma_ops;
-
 #ifdef CONFIG_XEN
 void __init xen_early_init(void);
 #else
-- 
2.20.1

