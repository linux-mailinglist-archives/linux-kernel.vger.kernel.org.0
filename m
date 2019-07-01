Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A03F49A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfD3KxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 06:53:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfD3KxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dotHK77xs9sVhoNDHL3fwKLARcXVB6TAnxDN+zxeaow=; b=Dawea36fqlk3xDnXPb6nYAayKP
        22NnQ9l9UWhUaNU81Mp3jmBqF3Nrs7y42nZ4DXfniZKmM6tDkJ4owdzwogY3KlfJeQTBIrVkj7z4Z
        OBNWAde9641MtR7fb9pvZ4bKc6VySCYVPwppmftFih5pbWMdak5jT1tUa2omEQjcTRqqrDwJ3snpP
        IStEUwYhmhC8iQDgAlS8f+q88tn3fq0bAWIL1czZFOnQAxHQCrSA8eeinurlUtkP0mY7vjKqAO5Nw
        0jUK0dhigdrbFWlkbFn10vcavK9rlp8dyZVQYqNng/UwrDwgDAzixKj9LevwmcAS3GiByJlcblBBo
        QGMA53xA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQNp-0007ka-Kk; Tue, 30 Apr 2019 10:53:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] iommu/dma: Remove __iommu_dma_free
Date:   Tue, 30 Apr 2019 06:52:01 -0400
Message-Id: <20190430105214.24628-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only have a single caller of this function left, so open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 969a11c667fa..25def31ade4d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -534,24 +534,6 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
 	return area->pages;
 }
 
-/**
- * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
- * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
- * @size: Size of buffer in bytes
- * @handle: DMA address of buffer
- *
- * Frees both the pages associated with the buffer, and the array
- * describing them
- */
-static void __iommu_dma_free(struct device *dev, struct page **pages,
-		size_t size, dma_addr_t *handle)
-{
-	__iommu_dma_unmap(dev, *handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_MAPPING_ERROR;
-}
-
 /**
  * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
@@ -1034,7 +1016,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 		if (!pages)
 			return;
-		__iommu_dma_free(dev, pages, iosize, &handle);
+		__iommu_dma_unmap(dev, handle, iosize);
+		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
 		__iommu_dma_unmap(dev, handle, iosize);
-- 
2.20.1

