Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2EE86674
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404115AbfHHQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:00:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404023AbfHHQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6uQHLvwXHj0Q2UKb8R7HLwCPZBGgiQ/jWuWt81/oxHs=; b=IFZmzOUSkpao5gD1L9NaSU5lJ+
        tmtIUhDdaUpOxxRw69SgBH2dLmOZYumTbOCTJoz0b1lev3uDxeNt37CZI06CXv5mkBCjvg8hz0FZj
        GAOaerKFvqtOjrUAP6wJxcHH7IYvrezyhD+vvySiCmPYZ0QUKMwK91xeJDi/70LeLFz02E5uhNrWJ
        0DK/OBC/HmCHw/4NgRq8IxLRPpjcp+Wr4+TJvI7GycFmKb+XvbY+TxUgfjFffv9rXX87s2Degd1ch
        7iVIr0GX+KSQSMhoe/GvIY1sK/Yi6oe3T8oXRdCn4Fly/5TtEg9J7q0VuI8QnuL3J9GS9OSDHmc1j
        CkO32ksA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkqH-0006ib-Nf; Thu, 08 Aug 2019 16:00:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dma-mapping: add a dma_can_mmap helper
Date:   Thu,  8 Aug 2019 19:00:01 +0300
Message-Id: <20190808160005.10325-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check if DMA allocations for a specific device can be
mapped to userspace using dma_mmap_*.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..17271857be5d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -462,6 +462,7 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
+bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
@@ -552,6 +553,10 @@ static inline int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 {
 	return -ENXIO;
 }
+static inline bool dma_can_mmap(struct device *dev)
+{
+	return false;
+}
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 0;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 67b900ad0836..64d1de59e133 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -220,6 +220,29 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 
+/**
+ * dma_can_mmap - check if a given device supports dma_mmap_*
+ * @dev: device to check
+ *
+ * Returns %true if @dev supports dma_mmap_coherent() and dma_mmap_attrs() to
+ * map DMA allocations to userspace.
+ */
+bool dma_can_mmap(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (IS_ENABLED(CONFIG_ARCH_NO_COHERENT_DMA_MMAP))
+		return false;
+
+	if (dma_is_direct(ops)) {
+		return dev_is_dma_coherent(dev) ||
+			IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN);
+	}
+
+	return ops->mmap != NULL;
+}
+EXPORT_SYMBOL_GPL(dma_can_mmap);
+
 /**
  * dma_mmap_attrs - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.20.1

