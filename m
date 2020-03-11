Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBD181D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgCKQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:07:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgCKQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=65ZSUL0dKbJAKyYRgWo0UNHaxeezpoOi3//F5OsJs7c=; b=UbTco4Xe3oMNx9xr0T5vn+uY88
        x/iyP5VlO01hiwneGgA0fNHl46oBY5s5eADKJSkTOmQMTtX6dLw4Z53zeNbxRFohTiiEMwiNyU0G/
        kJ8J6Xndp2mmejZF8Br1cTlT8456Hfpl+iTQuvCalLFF6lUivG6DEGdcdxyQYGGXemnfCTgnZWFMV
        Pk3aPv9bVVxUKJ+fvSpzJIMSzhjqu+kVqEHiNxzzr4qv5Vvp1ogCUnOvEerqVXmU+gIJwadhTG1h3
        mCMbAmY7CJ8eoEiiRDOC76bchnN9+xqqtYHcTosy0YgffOBSTwWyQLJXi3yrlL4/A2DLK3M/Qo8ti
        sj7aKUcw==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jC3t5-0007VI-CA; Wed, 11 Mar 2020 16:07:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     aros@gmx.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH] device core: fix dma_mask handling in platform_device_register_full
Date:   Wed, 11 Mar 2020 17:07:10 +0100
Message-Id: <20200311160710.376090-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since the generic platform device code started allocating DMA masks
itself the code to allocate and leak a private DMA mask in
platform_device_register_full has been superflous.  More so the fact that
it unconditionally frees the DMA mask allocation in the failure path
can lead to slab corruption if the function fails later on for a device
where it didn't allocate the mask.  Just remove the offending code.

Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for platform device")
Reported-by: Artem S. Tashkinov <aros@gmx.com>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
---
 drivers/base/platform.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..47d3e6187a1c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -662,19 +662,6 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			goto err;
-
-		kmemleak_ignore(pdev->dev.dma_mask);
-
 		*pdev->dev.dma_mask = pdevinfo->dma_mask;
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
@@ -700,7 +687,6 @@ struct platform_device *platform_device_register_full(
 	if (ret) {
 err:
 		ACPI_COMPANION_SET(&pdev->dev, NULL);
-		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
-- 
2.24.1

