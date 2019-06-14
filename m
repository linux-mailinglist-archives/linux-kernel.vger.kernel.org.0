Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25F4613F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfFNOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 10:45:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfFNOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XBS/c6aAhCoK2T6+N2wWDRsaGJYTqp8SPA32e8G5Vls=; b=tQ3Dza/QcBJcS38+zf1dMFcwCR
        wOWrL7rj6nwYDGt7VTXJkayT9/vZ1B1x4y6D+70rRKXSK0Keg6en3t+OTABeFd2MpMr6pi86RsaVv
        piVg2obLpRIoHvWzGLid0ELT35b1jqNF8QOOvwr8qGwZL0fdgp7LNTCL5filwC7OjiebCX4sthC0R
        LoS2RmnWVPXEnO4xRcoY5OEvzqNgteFFeh0MPXGj/XsEnq99n4pB4DCMv1lJmzwZmadHpw25t0mwr
        l2JSMDIinJkBK1eMoahM70H9Du6SxZPPEN9FotSUwUszwxcjBfNcWhcuX+BBsRZNYIAsJs9aPJrRy
        4Dbh4RGg==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnRf-0005uj-AL; Fri, 14 Jun 2019 14:44:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] openrisc: remove the partial DMA_ATTR_NON_CONSISTENT support
Date:   Fri, 14 Jun 2019 16:44:27 +0200
Message-Id: <20190614144431.21760-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The openrisc DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
does not provide a cache_sync operation.  This means any user of it
will never be able to actually transfer cache ownership and thus cause
coherency bugs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index f79457cb3741..9f25fd0fbb5d 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -98,15 +98,13 @@ arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	va = (unsigned long)page;
 
-	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
-		/*
-		 * We need to iterate through the pages, clearing the dcache for
-		 * them and setting the cache-inhibit bit.
-		 */
-		if (walk_page_range(va, va + size, &walk)) {
-			free_pages_exact(page, size);
-			return NULL;
-		}
+	/*
+	 * We need to iterate through the pages, clearing the dcache for
+	 * them and setting the cache-inhibit bit.
+	 */
+	if (walk_page_range(va, va + size, &walk)) {
+		free_pages_exact(page, size);
+		return NULL;
 	}
 
 	return (void *)va;
@@ -122,10 +120,8 @@ arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		.mm = &init_mm
 	};
 
-	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
-		/* walk_page_range shouldn't be able to fail here */
-		WARN_ON(walk_page_range(va, va + size, &walk));
-	}
+	/* walk_page_range shouldn't be able to fail here */
+	WARN_ON(walk_page_range(va, va + size, &walk));
 
 	free_pages_exact(vaddr, size);
 }
-- 
2.20.1

