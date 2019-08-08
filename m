Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5935885F46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbfHHKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 06:10:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389901AbfHHKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yRYxxTnT0jAVorPkLUtPWJIe8pVj+mQODhml9KCp+bk=; b=bxWWx9FBXDhyN3GkIOCe9ilFT
        cakjc/vTNoc2ZDNL9roM8NMX4moNcjQqB+Ot4ntNyUoKk5E++1c5MhZs4RG3VI8eUWjCvxbQV7EWE
        VDgaWMjXzapOJkOuFY4TlotBt7b1LniCPxXSoZaaDHspDfsMIgR2ZJbiNx2mkvnA5L2zkrdoD4xC/
        W4vjqaeAbqBaz94FAfMfhaBbPTeMAUNV4YDrEkFHqVgCxQoMNokAD+Ll0ndLiF6tIMspz1ivJnkuY
        JKnSB8GOPWVKU7Su1C8mM56t2q4NunM/Qnk5uw7L/QP+Z7O3YRHme/iHfiQDdxYGQHmndDnoqrIvS
        V5WzbrQKQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvfNd-0002zp-3T; Thu, 08 Aug 2019 10:10:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tomi.valkeinen@ti.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
Date:   Thu,  8 Aug 2019 13:10:42 +0300
Message-Id: <20190808101042.18809-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The omapfb platform devices does not have a DMA mask set.  The
traditional arm DMA code ignores, but the generic dma-direct/swiotlb
has stricter checks and thus fails mappings without a DMA mask.
As we use swiotlb for arm with LPAE now, omap needs to catch up
and actually set a DMA mask.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 561c4812545b..2c8abf07e617 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -232,6 +232,8 @@ void omap_fbdev_init(struct drm_device *dev)
 	if (!priv->num_pipes)
 		return;
 
+	dma_coerce_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
+
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 	if (!fbdev)
 		goto fail;
-- 
2.20.1

