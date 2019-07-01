Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06C71359B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 00:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfECWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 18:30:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:7005 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfECW3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:34 -0400
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
Subject: [PATCH v3 05/16] iommu/vt-d: Enlightened PASID allocation
Date:   Fri,  3 May 2019 15:32:06 -0700
Message-Id: <1556922737-76313-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
IOMMU driver should rely on the emulation software to allocate
and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
register set to support this. This includes a capability register,
a virtual command register and a virtual response register. Refer
to section 10.4.42, 10.4.43, 10.4.44 for more information.

This patch adds the enlightened PASID allocation/free interfaces
via the virtual command register.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 13 +++++++-
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2..95f8f0c 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -63,6 +63,82 @@ void *intel_pasid_lookup_id(int pasid)
 	return p;
 }
 
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
+{
+	u64 res;
+	u64 cap;
+	u8 status_code;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!ecap_vcs(iommu->ecap)) {
+		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
+			iommu->name);
+		return -ENODEV;
+	}
+
+	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
+	if (!(cap & DMA_VCS_PAS)) {
+		pr_warn("IOMMU: %s: Emulation software doesn't support PASID allocation\n",
+			iommu->name);
+		return -ENODEV;
+	}
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	status_code = VCMD_VRSP_SC(res);
+	switch (status_code) {
+	case VCMD_VRSP_SC_SUCCESS:
+		*pasid = VCMD_VRSP_RESULT(res);
+		break;
+	case VCMD_VRSP_SC_NO_PASID_AVAIL:
+		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
+		ret = -ENOMEM;
+		break;
+	default:
+		ret = -ENODEV;
+		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
+			iommu->name, status_code);
+	}
+
+	return ret;
+}
+
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
+{
+	u64 res;
+	u8 status_code;
+	unsigned long flags;
+
+	if (!ecap_vcs(iommu->ecap)) {
+		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
+			iommu->name);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	status_code = VCMD_VRSP_SC(res);
+	switch (status_code) {
+	case VCMD_VRSP_SC_SUCCESS:
+		break;
+	case VCMD_VRSP_SC_INVALID_PASID:
+		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
+		break;
+	default:
+		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
+			iommu->name, status_code);
+	}
+}
+
 /*
  * Per device pasid table management:
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 23537b3..4b26ab5 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -19,6 +19,16 @@
 #define PASID_PDE_SHIFT			6
 #define MAX_NR_PASID_BITS		20
 
+/* Virtual command interface for enlightened pasid management. */
+#define VCMD_CMD_ALLOC			0x1
+#define VCMD_CMD_FREE			0x2
+#define VCMD_VRSP_IP			0x1
+#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
+#define VCMD_VRSP_SC_SUCCESS		0
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
+#define VCMD_VRSP_SC_INVALID_PASID	1
+#define VCMD_VRSP_RESULT(e)		(((e) >> 8) & 0xfffff)
+
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
@@ -69,5 +79,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, int pasid);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
-
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6925a18..bff907b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -173,6 +173,7 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
@@ -289,6 +290,7 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
-- 
2.7.4

