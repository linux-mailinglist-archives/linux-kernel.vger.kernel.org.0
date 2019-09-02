Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0299A5777
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfIBNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:13:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfIBNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WUT2tiM88hPNkRtYXbHex8vC4m/OZCxIoGmn21PiEzg=; b=B6461RqGBtBH0KvXzaW8gyE1di
        GNR0A4uyyj8ExfMELYP3VZkyAGwY6+begEERVgg7lTlpC0MJuiW7f8kqUm2GgK6gMnmLcNPDcrkmh
        z3MxWlMA7p8dH+gac4nQqy46dF0HtEaYLr57yX90WRs51OeH5NH825iZp70lz03vDITtknrHmGZyT
        zPmNPVQwbUonkMu/pkmu2tKa/HiQScOjFywXrII680+PS8FHxVj+Z91/w8g71hstuq/AQJfgaklzv
        men9DAHq4czBJLy8Q1O/YWZSAlbjfdVDjU1o111d7b1N4Ynuaao5JCOn1pDg1pEPV3h+GPKO0Qya5
        jj8KCK9A==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4m8l-0000VK-Cr; Mon, 02 Sep 2019 13:13:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] swiotlb-xen: merge xen_unmap_single into xen_swiotlb_unmap_page
Date:   Mon,  2 Sep 2019 15:03:38 +0200
Message-Id: <20190902130339.23163-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902130339.23163-1-hch@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a no-op wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 95911ff9c11c..384304a77020 100644
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

