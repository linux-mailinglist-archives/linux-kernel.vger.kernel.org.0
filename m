Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F381915CF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfHRJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:12:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ybl6KWkI9r5RiELOPQNVwBgBcMfR1YS4dX2AUNxc4u0=; b=AzgRNbcmu8a6MZwuoiTuScTGjo
        re7HmmJo0FyV4s7q+yx3NU78IRkpJbcuzl4lC3iaUMeyGKOHEX+eP9aunnP04z8WMn+zmL9R0Ts/D
        vFHqGdCf6pKfcUkjEzAbb17peu97HD76/EQk1BjGuuOM3vtJy3Nqe8bp6YsdZKICTAvyzDvXzm+TQ
        HtFyvU61DDFMNBtepPkuICsVgx5PCp/XZe7qXXhajE1vWCw8gJgsF5leIDeMlGD1OHK3aJ8C2Rus4
        QbE+O6EgCfpHWOHUgDOqwYxXz+y1RD5Z3FN6DU37ZCy0IRkz8f3rFieIoHQVr5+nG6I8eRQgPVEKp
        ATdz2K2w==;
Received: from 213-225-6-198.nat.highway.a1.net ([213.225.6.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hzHEp-00018U-8I; Sun, 18 Aug 2019 09:12:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
Date:   Sun, 18 Aug 2019 11:05:55 +0200
Message-Id: <20190818090557.17853-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818090557.17853-1-hch@lst.de>
References: <20190818090557.17853-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev field in struct dev_pagemap is only used to print dev_name in
two places, which are at best nice to have.  Just remove the field
and thus the name in those two messages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/memremap.h | 1 -
 kernel/memremap.c        | 6 +-----
 mm/page_alloc.c          | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..8f0013e18e14 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -109,7 +109,6 @@ struct dev_pagemap {
 	struct percpu_ref *ref;
 	struct percpu_ref internal_ref;
 	struct completion done;
-	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
 	u64 pci_p2pdma_bus_offset;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 6ee03a816d67..600a14cbe663 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -96,7 +96,6 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 static void devm_memremap_pages_release(void *data)
 {
 	struct dev_pagemap *pgmap = data;
-	struct device *dev = pgmap->dev;
 	struct resource *res = &pgmap->res;
 	unsigned long pfn;
 	int nid;
@@ -123,8 +122,7 @@ static void devm_memremap_pages_release(void *data)
 
 	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
-	dev_WARN_ONCE(dev, pgmap->altmap.alloc,
-		      "%s: failed to free all reserved pages\n", __func__);
+	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 }
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
@@ -245,8 +243,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_array;
 	}
 
-	pgmap->dev = dev;
-
 	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(res->start),
 				PHYS_PFN(res->end), pgmap, GFP_KERNEL));
 	if (error)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..b39baa2b1faf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5982,7 +5982,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		}
 	}
 
-	pr_info("%s initialised, %lu pages in %ums\n", dev_name(pgmap->dev),
+	pr_info("%s initialised %lu pages in %ums\n", __func__,
 		size, jiffies_to_msecs(jiffies - start));
 }
 
-- 
2.20.1

