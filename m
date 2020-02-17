Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4B161BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgBQTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 14:39:10 -0500
Received: from 8bytes.org ([81.169.241.247]:54514 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgBQTjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:09 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DFC6C542; Mon, 17 Feb 2020 20:39:06 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into helper function
Date:   Mon, 17 Feb 2020 20:38:55 +0100
Message-Id: <20200217193858.26990-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move the code that does the deferred device attachment into a separate
helper function.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 80f2332a5466..42cdcce1602e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2529,16 +2529,20 @@ struct dmar_domain *find_domain(struct device *dev)
 	return NULL;
 }
 
-static struct dmar_domain *deferred_attach_domain(struct device *dev)
+static void do_deferred_attach(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev))) {
-		struct iommu_domain *domain;
+	struct iommu_domain *domain;
 
-		dev->archdata.iommu = NULL;
-		domain = iommu_get_domain_for_dev(dev);
-		if (domain)
-			intel_iommu_attach_device(domain, dev);
-	}
+	dev->archdata.iommu = NULL;
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		intel_iommu_attach_device(domain, dev);
+}
+
+static struct dmar_domain *deferred_attach_domain(struct device *dev)
+{
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	return find_domain(dev);
 }
-- 
2.17.1

