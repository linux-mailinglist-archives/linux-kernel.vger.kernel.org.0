Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6024B9023F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfHPNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:00:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfHPNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qdUo+R1PETYlMUD0i0ibfvvgSmVBaVigbP1YF9EqgXQ=; b=Z/9TBaBzEphkMy0u5IW3Mp2gIl
        WT8XK8s8t01nk5t2ByHHAKYRplxbXPvZ5Ds5XxHAMIbjjdrT7kRsSJbX5faxv+Vz8REsFtf9nq0NB
        WyghCeAN/dIJIxb3Y5CrmZ0p/b14ryeVjNdo9MsxDLX0DlEiKQrdWy7n3NL50LY33Vj+oyhrp7oXm
        2Xe9MaCjOECVJB1f0Gp+4+1/V+nj/KNV3CZrSlgSJJstohHJJbd5ZkSej9juTVKfE4ffIFnzfPOwg
        4wvRaSC9KA2M1k2wrOhbR8WL5rk6h3l/MgAAr2APWpbC8SVhDL09RyRUn2peGJ483E8/ufYaa0Yj2
        3mOpETKw==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybqX-0006Zz-2a; Fri, 16 Aug 2019 13:00:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] swiotlb-xen: use the same foreign page check everywhere
Date:   Fri, 16 Aug 2019 15:00:10 +0200
Message-Id: <20190816130013.31154-9-hch@lst.de>
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

xen_dma_map_page uses a different and more complicated check for
foreign pages than the other three cache maintainance helpers.
Switch it to the simpler pfn_vali method a well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/xen/page-coherent.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/xen/page-coherent.h b/include/xen/page-coherent.h
index 7c32944de051..0f4d468e7a89 100644
--- a/include/xen/page-coherent.h
+++ b/include/xen/page-coherent.h
@@ -43,14 +43,9 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs)
 {
-	unsigned long page_pfn = page_to_xen_pfn(page);
-	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
-	unsigned long compound_pages =
-		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
-	bool local = (page_pfn <= dev_pfn) &&
-		(dev_pfn - page_pfn < compound_pages);
+	unsigned long pfn = PFN_DOWN(dev_addr);
 
-	if (local)
+	if (pfn_valid(pfn))
 		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
 	else
 		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
-- 
2.20.1

