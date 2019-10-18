Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612AEDC08B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633036AbfJRJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 05:07:46 -0400
Received: from 8bytes.org ([81.169.241.247]:47974 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfJRJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:07:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CB025300; Fri, 18 Oct 2019 11:07:43 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Qian Cai <cai@lca.pw>, Dan Carpenter <dan.carpenter@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Pass gfp flags to iommu_map_page() in amd_iommu_map()
Date:   Fri, 18 Oct 2019 11:07:36 +0200
Message-Id: <20191018090736.18819-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A recent commit added a gfp parameter to amd_iommu_map() to make it
callable from atomic context, but forgot to pass it down to
iommu_map_page() and left GFP_KERNEL there. This caused
sleep-while-atomic warnings and needs to be fixed.

Reported-by: Qian Cai <cai@lca.pw>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0d2479546b77..fb54df5c2e11 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2561,7 +2561,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
+	ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
 
 	domain_flush_np_cache(domain, iova, page_size);
 
-- 
2.16.4

