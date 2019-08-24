Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4229BAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 03:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfHXBtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 21:49:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbfHXBtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:49:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72B379924FCC14EF7B24;
        Sat, 24 Aug 2019 09:49:20 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sat, 24 Aug 2019 09:49:16 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/dma: fix for dereferencing before null checking
Date:   Sat, 24 Aug 2019 09:47:12 +0800
Message-ID: <1566611232-165399-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cookie is dereferenced before null checking in the function
iommu_dma_init_domain.

This patch moves the dereferencing after the null checking.

Fixes: fdbe574eb693 ("iommu/dma: Allow MSI-only cookies")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/iommu/dma-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d991d40..cdf7814 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -303,13 +303,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn;
+	struct iova_domain *iovad;
 	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
 
+	iovad = &cookie->iovad;
+
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
-- 
2.8.1

