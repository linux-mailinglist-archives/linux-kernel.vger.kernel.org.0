Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618B13A62C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfFINln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 09:41:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:31607 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbfFINlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:41:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 06:41:19 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2019 06:41:18 -0700
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org,
        Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH v4 18/22] iommu/vt-d: Add nested translation helper function
Date:   Sun,  9 Jun 2019 06:44:18 -0700
Message-Id: <1560087862-57608-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
With PASID granular translation type set to 0x11b, translation
result from the first level(FL) also subject to a second level(SL)
page table translation. This mode is used for SVA virtualization,
where FL performs guest virtual to guest physical translation and
SL performs guest physical to host physical translation.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 11 ++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 1ff2ecc..50ec344 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -684,3 +684,96 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation
+ * which is used for vSVA. The first level page tables are used for
+ * GVA-GPA translation in the guest, second level page tables are used
+ * for GPA to HPA translation.
+ *
+ * @iommu:      Iommu which the device belong to
+ * @dev:        Device to be set up for translation
+ * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @flags:      Additional info such as supervisor PASID
+ * @domain:     Domain info for setting up second level page tables
+ * @addr_width: Address width of the first level (guest)
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *gpgd,
+			int pasid, int flags,
+			struct dmar_domain *domain,
+			int addr_width)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err("IOMMU: %s: No nested translation support\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	pasid_clear_entry(pte);
+
+	/* Sanity checking performed by caller to make sure address
+	 * width matching in two dimensions:
+	 * 1. CPU vs. IOMMU
+	 * 2. Guest vs. Host.
+	 */
+	switch (addr_width) {
+	case 57:
+		pasid_set_flpm(pte, 1);
+		break;
+	case 48:
+		pasid_set_flpm(pte, 0);
+		break;
+	default:
+		dev_err(dev, "Invalid paging mode %d\n", addr_width);
+		return -EINVAL;
+	}
+
+	/* Setup the first level page table pointer in GPA */
+	pasid_set_flptr(pte, (u64)gpgd);
+	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_sre(pte);
+	}
+
+	/* Setup the second level based on the given domain */
+	pgd = domain->pgd;
+
+	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd)) {
+			dev_err(dev, "Invalid domain page table\n");
+			return -EINVAL;
+		}
+	}
+	pgd_val = virt_to_phys(pgd);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_fault_enable(pte);
+
+	did = domain->iommu_did[iommu->seq_id];
+	pasid_set_domain_id(pte, did);
+
+	pasid_set_address_width(pte, agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+	pasid_flush_caches(iommu, pte, pasid, did);
+
+	return 0;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 4b26ab5..2234fd5 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -42,6 +42,7 @@
  * to vmalloc or even module mappings.
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
+#define PASID_FLAG_NESTED		BIT(1)
 
 struct pasid_dir_entry {
 	u64 val;
@@ -51,6 +52,11 @@ struct pasid_entry {
 	u64 val[8];
 };
 
+#define PASID_ENTRY_PGTT_FL_ONLY	(1)
+#define PASID_ENTRY_PGTT_SL_ONLY	(2)
+#define PASID_ENTRY_PGTT_NESTED		(3)
+#define PASID_ENTRY_PGTT_PT		(4)
+
 /* The representative of a PASID table */
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
@@ -77,6 +83,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *pgd,
+			int pasid, int flags,
+			struct dmar_domain *domain,
+			int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
-- 
2.7.4

