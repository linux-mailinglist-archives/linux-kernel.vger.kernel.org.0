Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB71C162EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBRSmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:42:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgBRSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VQL9b0KCtYJf/wKA75fcrO7i0ZsCI/zdnz7C6Mgld9E=; b=dt3nhAKHFUYD4fQquR+byh0g+C
        LkOyIGy4cFbzqTwpGBti5+Pz050ibdUOBGlRrSyBVmNn4QD1kAGNyn78acwP29WxEfNdlelKTEXd5
        JhCWIZtnImkRmyS/+N10xgd1XLpHLP1qGTfyE6w+hQ4lptNNzvtDdRdFkpW/gvIE8qPw21y6bNHup
        HBdJCl7PXjDHgC1TnlnU+iVsGIBQ5sAOVyOnFjoibMECVFEiafa1BpEoEMPCCGhdMOPWlrXrQqIF9
        axGjpvGq704pw29Lp+edRAFFcbqCqI8RFLsTT/PTtt9bbXCrIPXSTH4sCngq36zvIeqN+lWXzoTz0
        uENcsp8w==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j47oh-0002xO-K7; Tue, 18 Feb 2020 18:41:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM/dma-mapping: take the bus limit into account in __dma_alloc
Date:   Tue, 18 Feb 2020 10:41:02 -0800
Message-Id: <20200218184103.35932-3-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218184103.35932-1-hch@lst.de>
References: <20200218184103.35932-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA coherent allocator needs to take bus limits into account for
picking the zone that the memory is allocated from.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 72ddc3d0f5eb..87aba505554a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -658,7 +658,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
 			 unsigned long attrs, const void *caller)
 {
-	u64 mask = dev->coherent_dma_mask;
+	u64 mask = min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 	struct page *page = NULL;
 	void *addr;
 	bool allowblock, cma;
-- 
2.24.1

