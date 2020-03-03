Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478241783FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgCCU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 15:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgCCU2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:28:01 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9969A20CC7;
        Tue,  3 Mar 2020 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267280;
        bh=YV6CQtKhLrFI8QEQ4FLBJQUo+r9S+fVJg0CmYyWmunU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fadn+CEkQwJYQHUj4GibELnSV08ZpQFdVdJzZ9g1p3JBC0K7IEOMjasCZpZ5pmrf3
         STEu7OlLONE7G6p/ML20yh9o1mShzV0Bo6+5KC050Jnsy/NhixKNevPtdK+mN0Zx3Z
         6dBuB2DvD2Kn18DwkqaMaXc/67DiEB6nKpJXuzUo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Suman Anna <s-anna@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 3/4] iommu/omap: Fix -Woverflow warnings when compiling on 64-bit architectures
Date:   Tue,  3 Mar 2020 21:27:50 +0100
Message-Id: <20200303202751.5153-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303202751.5153-1-krzk@kernel.org>
References: <20200303202751.5153-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the OMAP IOMMU driver supports only ARMv7 (32-bit) platforms,
it can be compile tested for other architectures, including 64-bit ones.
In such case the warning appears:

       In file included from drivers/iommu/omap-iommu.c:33:0:
       drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
    >> drivers/iommu/omap-iopgtable.h:44:21: warning: large integer implicitly truncated to unsigned type [-Woverflow]
        #define IOPTE_MASK  (~(IOPTE_SIZE - 1))
                            ^
    >> drivers/iommu/omap-iommu.c:1641:41: note: in expansion of macro 'IOPTE_MASK'
           ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
                                                ^~~~~~~~~~

Fix this by using architecture-depending types in omap_iommu_translate():
1. Pointer should be cast to unsigned long,
2. Virtual addresses should be cast to dma_addr_t.

On 32-bit this will be the same as original code (using u32).  On 64-bit
it should produce meaningful result, although it does not really matter.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 drivers/iommu/omap-iopgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index 1a4adb59a859..51d74002cc30 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -63,7 +63,8 @@
  *
  * va to pa translation
  */
-static inline phys_addr_t omap_iommu_translate(u32 d, u32 va, u32 mask)
+static inline phys_addr_t omap_iommu_translate(unsigned long d, dma_addr_t va,
+					       dma_addr_t mask)
 {
 	return (d & mask) | (va & (~mask));
 }
-- 
2.17.1

