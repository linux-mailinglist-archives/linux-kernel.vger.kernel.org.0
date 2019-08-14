Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3544D8CD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfHNH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 03:59:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfHNH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hfS6RsR5kjsKcGJBFHaOUQyC3/8MsUUHBDSv8Fc2tAY=; b=aHIuwPxrfJ6VgYAFHUe3HF6WvO
        VvC9ZXTXF3YbQgV/nw+aupbSt5/kftWSDJM6y9+Gy9q5iVowI+1f+Eh/0BUa6tRo/mbtIIfhAEw8a
        VG4obijb46aDWR2joJqDlbTtr0HQq+PQmF4b+d1dN52OBLVSGbu9XUDGYucPSNwxnnPsaFuTnYPTo
        EMwQ2U0+5E0XGwApoLUggf8SbKELOmiOF4yRHfgZrpRzKarTgj3W9F5xjqRk4XNOqFe8odjp3SGqY
        eM3+mob4z2HiWLHg+DUzyoZ9FCC5tSvGXwjMpYxgR8s1MokjeKZPzPda7qldT45SDaykrMgF1+6sM
        ytpTgR6g==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoC5-0007zb-Cc; Wed, 14 Aug 2019 07:59:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] nouveau: factor out device memory address calculation
Date:   Wed, 14 Aug 2019 09:59:21 +0200
Message-Id: <20190814075928.23766-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
References: <20190814075928.23766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the repeated device memory address calculation into
a helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 42 +++++++++++---------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index e696157f771e..d469bc334438 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -102,6 +102,14 @@ struct nouveau_migrate {
 	unsigned long dma_nr;
 };
 
+static unsigned long nouveau_dmem_page_addr(struct page *page)
+{
+	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
+	unsigned long idx = page_to_pfn(page) - chunk->pfn_first;
+
+	return (idx << PAGE_SHIFT) + chunk->bo->bo.offset;
+}
+
 static void nouveau_dmem_page_free(struct page *page)
 {
 	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
@@ -169,9 +177,7 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 	/* Copy things over */
 	copy = drm->dmem->migrate.copy_func;
 	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct nouveau_dmem_chunk *chunk;
 		struct page *spage, *dpage;
-		u64 src_addr, dst_addr;
 
 		dpage = migrate_pfn_to_page(dst_pfns[i]);
 		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
@@ -194,14 +200,10 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 			continue;
 		}
 
-		dst_addr = fault->dma[fault->npages++];
-
-		chunk = spage->zone_device_data;
-		src_addr = page_to_pfn(spage) - chunk->pfn_first;
-		src_addr = (src_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
-
-		ret = copy(drm, 1, NOUVEAU_APER_HOST, dst_addr,
-				   NOUVEAU_APER_VRAM, src_addr);
+		ret = copy(drm, 1, NOUVEAU_APER_HOST,
+				fault->dma[fault->npages++],
+				NOUVEAU_APER_VRAM,
+				nouveau_dmem_page_addr(spage));
 		if (ret) {
 			dst_pfns[i] = MIGRATE_PFN_ERROR;
 			__free_page(dpage);
@@ -687,18 +689,12 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
 	/* Copy things over */
 	copy = drm->dmem->migrate.copy_func;
 	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct nouveau_dmem_chunk *chunk;
 		struct page *spage, *dpage;
-		u64 src_addr, dst_addr;
 
 		dpage = migrate_pfn_to_page(dst_pfns[i]);
 		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
 			continue;
 
-		chunk = dpage->zone_device_data;
-		dst_addr = page_to_pfn(dpage) - chunk->pfn_first;
-		dst_addr = (dst_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
-
 		spage = migrate_pfn_to_page(src_pfns[i]);
 		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
 			nouveau_dmem_page_free_locked(drm, dpage);
@@ -716,10 +712,10 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
 			continue;
 		}
 
-		src_addr = migrate->dma[migrate->dma_nr++];
-
-		ret = copy(drm, 1, NOUVEAU_APER_VRAM, dst_addr,
-				   NOUVEAU_APER_HOST, src_addr);
+		ret = copy(drm, 1, NOUVEAU_APER_VRAM,
+				nouveau_dmem_page_addr(dpage),
+				NOUVEAU_APER_HOST,
+				migrate->dma[migrate->dma_nr++]);
 		if (ret) {
 			nouveau_dmem_page_free_locked(drm, dpage);
 			dst_pfns[i] = 0;
@@ -846,7 +842,6 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
 
 	npages = (range->end - range->start) >> PAGE_SHIFT;
 	for (i = 0; i < npages; ++i) {
-		struct nouveau_dmem_chunk *chunk;
 		struct page *page;
 		uint64_t addr;
 
@@ -864,10 +859,7 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
 			continue;
 		}
 
-		chunk = page->zone_device_data;
-		addr = page_to_pfn(page) - chunk->pfn_first;
-		addr = (addr + chunk->bo->bo.mem.start) << PAGE_SHIFT;
-
+		addr = nouveau_dmem_page_addr(page);
 		range->pfns[i] &= ((1UL << range->pfn_shift) - 1);
 		range->pfns[i] |= (addr >> PAGE_SHIFT) << range->pfn_shift;
 	}
-- 
2.20.1

