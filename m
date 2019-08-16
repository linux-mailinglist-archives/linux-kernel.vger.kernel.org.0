Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3790236
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHPNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:00:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfHPNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzVGQCPIzP80hj29yoKKmiRzbXskwbhBNL+qS7AZZRY=; b=mf7gDq063PtFs4Y2UUMW6zn16Z
        IpWo4iN85xzGULcHErn1+SNZUGQcbVSJz/8EWhnco/HGvOgLl9st+edt2gU7arYKR0RQLpwVkZHqv
        FB+Jz93Im1HBlYTwFfLpmGL1kcRXOH+tCyqRamRmxDS2A8AI6yTC3pvv80eSh5P+U6wtIHz9npXfl
        ww9Q9L+Oa3szn8PiiiTt/Gy5ndO6qZyb3U+i21v/ZksgqOLuIM4q4b1Kck6gdhfHq2tWbNQ5lCjiM
        v9NiWLjgTFEt0FJ67PJ5lmfbqwVGEt4W3SJZfELoY0iUlioztIjUW15b5gcwShqQaHcqHtgrg0Ms4
        014UhbFA==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybqM-0006Qu-UP; Fri, 16 Aug 2019 13:00:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] xen: remove the exports for xen_{create,destroy}_contiguous_region
Date:   Fri, 16 Aug 2019 15:00:07 +0200
Message-Id: <20190816130013.31154-6-hch@lst.de>
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

These routines are only used by swiotlb-xen, which cannot be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/xen/mm.c     | 2 --
 arch/x86/xen/mmu_pv.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 388a45002bad..a59980f1aa54 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -175,13 +175,11 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	*dma_handle = pstart;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xen_create_contiguous_region);
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
 	return;
 }
-EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
 int __init xen_mm_init(void)
 {
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 26e8b326966d..c8dbee62ec2a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2625,7 +2625,6 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	*dma_handle = virt_to_machine(vstart).maddr;
 	return success ? 0 : -ENOMEM;
 }
-EXPORT_SYMBOL_GPL(xen_create_contiguous_region);
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
@@ -2660,7 +2659,6 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 
 	spin_unlock_irqrestore(&xen_reservation_lock, flags);
 }
-EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
 static noinline void xen_flush_tlb_all(void)
 {
-- 
2.20.1

