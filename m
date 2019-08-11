Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E578908F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfHKINP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 04:13:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfHKIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wlIHq+QByXfQFn2NhPBNjI0aq3Vrr70dQs8BcS07ZzU=; b=kc3X0PTLwMO5fuhqlS6Qovruk8
        pDoyHkdZ+189ETCogs3IobPSptChmx20eLInajEaYa9SOM7Pu0nJdngc2DDaOBv0RtJyetKzZeBTk
        5u+SvBBaD19zrH72HD/iouIYz6pEmZoqRW1d+CernqP+Rvl1BCHCHKpAZmq41FiyvqG10jXSsjizQ
        lmAoD+M/3j/w6cUPONNpkZHits/zCfz91+B8ELezWMJqODmz+6Z867v/DGRNrXyNRy/ej2Qsv26ox
        MWJjal2GweQyLKvR3qdqWJm3DyKrLYCm/mXgb6XBkhRBKIc4VWBdo/FVTXaUYpePhl2cr5Nf9YJMS
        4VOyPYIg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwiyK-0005Dt-VH; Sun, 11 Aug 2019 08:13:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH 4/5] memremap: don't use a separate devm action for devmap_managed_enable_get
Date:   Sun, 11 Aug 2019 10:12:46 +0200
Message-Id: <20190811081247.22111-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811081247.22111-1-hch@lst.de>
References: <20190811081247.22111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just clean up for early failures and then piggy back on
devm_memremap_pages_release.  This helps with a pending not device
managed version of devm_memremap_pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memremap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 600a14cbe663..09a087ca30ff 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -21,13 +21,13 @@ DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
 EXPORT_SYMBOL(devmap_managed_key);
 static atomic_t devmap_managed_enable;
 
-static void devmap_managed_enable_put(void *data)
+static void devmap_managed_enable_put(void)
 {
 	if (atomic_dec_and_test(&devmap_managed_enable))
 		static_branch_disable(&devmap_managed_key);
 }
 
-static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
+static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
 	if (!pgmap->ops || !pgmap->ops->page_free) {
 		WARN(1, "Missing page_free method\n");
@@ -36,13 +36,16 @@ static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgm
 
 	if (atomic_inc_return(&devmap_managed_enable) == 1)
 		static_branch_enable(&devmap_managed_key);
-	return devm_add_action_or_reset(dev, devmap_managed_enable_put, NULL);
+	return 0;
 }
 #else
-static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
+static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
 	return -EINVAL;
 }
+static void devmap_managed_enable_put(void)
+{
+}
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
 static void pgmap_array_delete(struct resource *res)
@@ -123,6 +126,7 @@ static void devm_memremap_pages_release(void *data)
 	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
+	devmap_managed_enable_put();
 }
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
@@ -212,7 +216,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	}
 
 	if (need_devmap_managed) {
-		error = devmap_managed_enable_get(dev, pgmap);
+		error = devmap_managed_enable_get(pgmap);
 		if (error)
 			return ERR_PTR(error);
 	}
@@ -321,6 +325,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_array:
 	dev_pagemap_kill(pgmap);
 	dev_pagemap_cleanup(pgmap);
+	devmap_managed_enable_put();
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
-- 
2.20.1

