Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6FF4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfD3Kyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 06:54:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfD3KxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7nhTx9drEQcJqOCbw3v9FtAi8Oly72Vd6sSVkvckvZs=; b=MI88V8kYc5uoUIXDv8hGUNcPe/
        YsMe5FEaLWWTMYtDKAV8nf8PaN6izfiJyC6kOfDQsp6cYSgtl0WsYuM9eKlbu/mxz66Zw3n4MfmTq
        Y8BWjxKogNQDAEjF4T/trNDTiYDG6QJlNQ/u9gJ7eLXmbyJ6hUeOQrwK5yu4tVuzlzusHYKBQm6s0
        PC/H+pI8mFN0cP6JlrY5i25Kxq5eWhZ1F6CMqYh+G91MVcFGHn2MZOeyJl42D92S/JrZMVpczGc9g
        gssdTbkFu1PNypDUxjalaBktXlXW1i2SFbx8t81u+vKnytDG3+MbdSw2K/tVDv7MYRQlJLmaXDFZv
        78aJHn3w==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQNf-0007Tp-2g; Tue, 30 Apr 2019 10:52:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] iommu/dma: Use for_each_sg in iommu_dma_alloc
Date:   Tue, 30 Apr 2019 06:51:54 -0400
Message-Id: <20190430105214.24628-6-hch@lst.de>
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

arch_dma_prep_coherent can handle physically contiguous ranges larger
than PAGE_SIZE just fine, which means we don't need a page-based
iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77d704c8f565..f915cb7c46e6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -577,15 +577,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		goto out_free_iova;
 
 	if (!(prot & IOMMU_CACHE)) {
-		struct sg_mapping_iter miter;
-		/*
-		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
-		 * sufficient here, so skip it by using the "wrong" direction.
-		 */
-		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
-			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
-		sg_miter_stop(&miter);
+		struct scatterlist *sg;
+		int i;
+
+		for_each_sg(sgt.sgl, sg, sgt.orig_nents, i)
+			arch_dma_prep_coherent(sg_page(sg), sg->length);
 	}
 
 	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
-- 
2.20.1

