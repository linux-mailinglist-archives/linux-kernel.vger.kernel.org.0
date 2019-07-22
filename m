Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD7702BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfGVOzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 10:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfGVOzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADBC5308FE9A;
        Mon, 22 Jul 2019 14:55:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFB060A9F;
        Mon, 22 Jul 2019 14:55:18 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited against NULL dma_mask
Date:   Mon, 22 Jul 2019 16:55:08 +0200
Message-Id: <20190722145509.1284-2-eric.auger@redhat.com>
In-Reply-To: <20190722145509.1284-1-eric.auger@redhat.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 22 Jul 2019 14:55:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_addressing_limited() should not be called on a device with
a NULL dma_mask. If this occurs let's WARN_ON_ONCE and immediately
return. Existing call sites are updated separately.

Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- add a WARN_ON_ONCE()
- reword the commit message
---
 include/linux/dma-mapping.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e11b115dd0e4..ef0cf9537abc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -689,8 +689,9 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
-		dma_get_required_mask(dev);
+	return WARN_ON_ONCE(!dev->dma_mask) ? false :
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
+			dma_get_required_mask(dev);
 }
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-- 
2.20.1

