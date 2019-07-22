Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299FC6FE93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfGVLPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 07:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728154AbfGVLPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52D4FC057E29;
        Mon, 22 Jul 2019 11:15:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA13E5D704;
        Mon, 22 Jul 2019 11:15:10 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: Protect dma_addressing_limited against NULL dma_mask
Date:   Mon, 22 Jul 2019 13:14:49 +0200
Message-Id: <20190722111449.29258-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 22 Jul 2019 11:15:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases when the helper gets called when the dma_mask is NULL.

This is observed when running virtio-block-pci devices protected by
a virtual IOMMU. Guest crashes with NULL pointer dereference.

Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/linux/dma-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e11b115dd0e4..5e7f386fe0d2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
-		dma_get_required_mask(dev);
+	return dev->dma_mask ? min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
+		dma_get_required_mask(dev) : false;
 }
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-- 
2.20.1

