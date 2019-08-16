Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EAB8FB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfHPGyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 02:54:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b+a4pr26YNInd7/QhhzGzYpG1NEGvVch+LojSapMZZc=; b=q/BjrqiWxleujKZgKtvVwFD29i
        R1mYmGsd81RuGdIsBX2zKNbj6gTbsMekpGNZO1BfZY1yUTlE4y+R82pgKreWjAdZ3TPCN0qBPGpoz
        Tfmt3anDfnQQARogPDVC7yBNqwsk2KI2E6ryzuthV8Uriij1gwSy78oFMuRXMYNlF7GsE+Q5ukray
        IHZ7+1jsYG5AzIQHb2CC9qNjXfK14t4IHXUtVAF4KQueFuZChZjNoT86j3hyi5fntsJ9Nzoa7Xitb
        UNjeECi/IsqsIsdD7R4uqxzS5cwwXK50ol0ncpX7KdBddMgGniAH6y1yxQlNfkx7YU0T+dCfMDrMc
        qZKHsfBg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyW8I-0008HF-Su; Fri, 16 Aug 2019 06:54:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH 1/4] resource: add a not device managed request_free_mem_region variant
Date:   Fri, 16 Aug 2019 08:54:31 +0200
Message-Id: <20190816065434.2129-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816065434.2129-1-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add a simple macro that passes a NULL dev argument to
dev_request_free_mem_region, and call request_mem_region in the
function for that particular case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ioport.h |  2 ++
 kernel/resource.c      | 45 +++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5b6a7121c9f0..7bddddfc76d6 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
+struct resource *request_free_mem_region(struct resource *base,
+		unsigned long size, const char *name);
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 7ea4306503c5..74877e9d90ca 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1644,19 +1644,8 @@ void resource_list_free(struct list_head *head)
 EXPORT_SYMBOL(resource_list_free);
 
 #ifdef CONFIG_DEVICE_PRIVATE
-/**
- * devm_request_free_mem_region - find free region for device private memory
- *
- * @dev: device struct to bind the resource to
- * @size: size in bytes of the device memory to add
- * @base: resource tree to look in
- *
- * This function tries to find an empty range of physical address big enough to
- * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
- * memory, which in turn allocates struct pages.
- */
-struct resource *devm_request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size)
+static struct resource *__request_free_mem_region(struct device *dev,
+		struct resource *base, unsigned long size, const char *name)
 {
 	resource_size_t end, addr;
 	struct resource *res;
@@ -1670,7 +1659,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 				REGION_DISJOINT)
 			continue;
 
-		res = devm_request_mem_region(dev, addr, size, dev_name(dev));
+		if (dev)
+			res = devm_request_mem_region(dev, addr, size, name);
+		else
+			res = request_mem_region(addr, size, name);
 		if (!res)
 			return ERR_PTR(-ENOMEM);
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
@@ -1679,7 +1671,32 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 
 	return ERR_PTR(-ERANGE);
 }
+
+/**
+ * devm_request_free_mem_region - find free region for device private memory
+ *
+ * @dev: device struct to bind the resource to
+ * @size: size in bytes of the device memory to add
+ * @base: resource tree to look in
+ *
+ * This function tries to find an empty range of physical address big enough to
+ * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
+ * memory, which in turn allocates struct pages.
+ */
+struct resource *devm_request_free_mem_region(struct device *dev,
+		struct resource *base, unsigned long size)
+{
+	return __request_free_mem_region(dev, base, size, dev_name(dev));
+}
 EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
+
+struct resource *request_free_mem_region(struct resource *base,
+		unsigned long size, const char *name)
+{
+	return __request_free_mem_region(NULL, base, size, name);
+}
+EXPORT_SYMBOL_GPL(request_free_mem_region);
+
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 static int __init strict_iomem(char *str)
-- 
2.20.1

