Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE44FA2FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfH3G3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:29:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfH3G3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sn/QnlX0rzEihI8HOssDpQ+pS1nF5+oT1o59+Mon2VE=; b=olmX6PFWaRCNDeJRTc5ka9YH2y
        XXCmdUKALA1NTuT0dtoXbnlJ9dNkn8+by+C49GsXU2agUVxgZTgTL5dBH5BUGJo4qfQO4B8Zk9XUs
        TWMm4gqIDq9p9UJBw15uS9ptf7dFIVbdr+4Pvt5Snzx+WsH6r63jHfo7i9baTeQewLbKKmq6hJOnh
        tX5bIp8RCcwLgTfStdgPphKMtoW8aHnE2ontZr3OHksEtjKVniMgTBrCIhLbmxz6/3+MEuduEv7AY
        dhsPK6CrhXLDXjEv3lEJ3GndzUttSUc5u3IV8AsMTI8tfuwFy0HZXHxKm/RTkO3j5fgqgDGrfxJqs
        iKZMjMuQ==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3aPj-0002vk-8g; Fri, 30 Aug 2019 06:29:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm: remove wrappers for the generic dma remap helpers
Date:   Fri, 30 Aug 2019 08:29:24 +0200
Message-Id: <20190830062924.21714-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830062924.21714-1-hch@lst.de>
References: <20190830062924.21714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a few tiny wrappers around the generic dma remap code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d07e5c865557..8cb57f1664b2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -336,18 +336,6 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
 				 const void *caller, bool want_vaddr);
 
-static void *
-__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
-	const void *caller)
-{
-	return dma_common_contiguous_remap(page, size, prot, caller);
-}
-
-static void __dma_free_remap(void *cpu_addr, size_t size)
-{
-	dma_common_free_remap(cpu_addr, size);
-}
-
 #define DEFAULT_DMA_COHERENT_POOL_SIZE	SZ_256K
 static struct gen_pool *atomic_pool __ro_after_init;
 
@@ -503,7 +491,7 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 	if (!want_vaddr)
 		goto out;
 
-	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
+	ptr = dma_common_contiguous_remap(page, size, prot, caller);
 	if (!ptr) {
 		__dma_free_buffer(page, size);
 		return NULL;
@@ -570,7 +558,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 		goto out;
 
 	if (PageHighMem(page)) {
-		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
+		ptr = dma_common_contiguous_remap(page, size, prot, caller);
 		if (!ptr) {
 			dma_release_from_contiguous(dev, page, count);
 			return NULL;
@@ -590,7 +578,7 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 {
 	if (want_vaddr) {
 		if (PageHighMem(page))
-			__dma_free_remap(cpu_addr, size);
+			dma_common_free_remap(cpu_addr, size);
 		else
 			__dma_remap(page, size, PAGE_KERNEL);
 	}
@@ -682,7 +670,7 @@ static void *remap_allocator_alloc(struct arm_dma_alloc_args *args,
 static void remap_allocator_free(struct arm_dma_free_args *args)
 {
 	if (args->want_vaddr)
-		__dma_free_remap(args->cpu_addr, args->size);
+		dma_common_free_remap(args->cpu_addr, args->size);
 
 	__dma_free_buffer(args->page, args->size);
 }
@@ -1365,16 +1353,6 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 	return 0;
 }
 
-/*
- * Create a CPU mapping for a specified pages
- */
-static void *
-__iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
-		    const void *caller)
-{
-	return dma_common_pages_remap(pages, size, prot, caller);
-}
-
 /*
  * Create a mapping in device IO address space for specified pages
  */
@@ -1526,7 +1504,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return pages;
 
-	addr = __iommu_alloc_remap(pages, size, gfp, prot,
+	addr = dma_common_pages_remap(pages, size, prot,
 				   __builtin_return_address(0));
 	if (!addr)
 		goto err_mapping;
-- 
2.20.1

