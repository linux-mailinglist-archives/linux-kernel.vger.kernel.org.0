Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7B1358D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfECW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 18:29:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:7005 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfECW3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 15:29:33 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 11/16] iommu/vt-d: Avoid duplicated code for PASID setup
Date:   Fri,  3 May 2019 15:32:12 -0700
Message-Id: <1556922737-76313-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After each setup for PASID entry, related translation caches must be flushed.
We can combine duplicated code into one function which is less error prone.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 2ce6ac2..dde05b5 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -520,6 +520,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
+static inline void pasid_flush_caches(struct intel_iommu *iommu,
+				struct pasid_entry *pte,
+				int pasid, u16 did)
+{
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	if (cap_caching_mode(iommu->cap)) {
+		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iotlb_invalidation_with_pasid(iommu, did, pasid);
+	} else
+		iommu_flush_write_buffer(iommu);
+
+}
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -565,16 +580,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, 1);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
@@ -638,16 +644,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
@@ -681,16 +678,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
-- 
2.7.4

