Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D360290240
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfHPNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:00:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfHPNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/coRcFOuhTVgeucGRP02jq6MPxmc29UfStBFaWddotw=; b=o2033zZnJGFQrl5WvJgIHegkA7
        3I8n/CVjA3frYwlzEaTN8N4/bi31dNBaR0mCktfGizSU4vwmKh2HFBD+pemx6yUB+tZ7w3Qc2cWFj
        R3zTFxhuZeE1gYcD7/6IKlwRULF78XqZuhVmrqG0IYhlE8LBMY/B5yfvltt7PFCBcGNaR2F5m5NVG
        6rT2CXC8bY7530Tl1XjQjWeQsWHpC7v31U5IAdxi61BUu3eS9lyvg9NdBLKO4t9iV5Tooqi2oiA7z
        6lUFp9/0XvzuPm5Whx5CCubIlxlB82q12yXI1P9woMpaTt6SB3NH2D8Jae7biN5e1Ku5MyxbYwA0g
        t5VwhH8g==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybqd-0006fj-7E; Fri, 16 Aug 2019 13:00:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] swiotlb-xen: merge xen_unmap_single into xen_swiotlb_unmap_page
Date:   Fri, 16 Aug 2019 15:00:12 +0200
Message-Id: <20190816130013.31154-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a no-op wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index c3c383033ae4..b6b9c4c1b397 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -414,9 +414,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			     size_t size, enum dma_data_direction dir,
-			     unsigned long attrs)
+static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
@@ -430,13 +429,6 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 }
 
-static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, enum dma_data_direction dir,
-			    unsigned long attrs)
-{
-	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
-}
-
 static void
 xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
@@ -477,7 +469,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
+		xen_swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
+				dir, attrs);
 
 }
 
-- 
2.20.1

