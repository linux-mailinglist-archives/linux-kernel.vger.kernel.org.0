Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116B78F569
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 22:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfHOUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 16:09:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:43476 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733285AbfHOUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188596226"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 10/19] iommu/vt-d: Enlightened PASID allocation
Date:   Thu, 15 Aug 2019 13:13:16 -0700
Message-Id: <1565900005-62508-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-pasid.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 13 ++++++-
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 040a445..76bcbb2 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -63,6 +63,89 @@ void *intel_pasid_lookup_id(int pasid)
 	return p;
 }
 
+static int check_vcmd_pasid(struct intel_iommu *iommu)
+{
+	u64 cap;
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
+	return 0;
+}
+
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
+{
+	u64 res;
+	u8 status_code;
+	unsigned long flags;
+	int ret = 0;
+
+	ret = check_vcmd_pasid(iommu);
+	if (ret)
+		return ret;
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
+		pr_warn("IOMMU: %s: Unexpected error code %d\n",
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
+	if (check_vcmd_pasid(iommu))
+		return;
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
+		pr_warn("IOMMU: %s: Unexpected error code %d\n",
+			iommu->name, status_code);
+	}
+}
+
 /*
  * Per device pasid table management:
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index fc8cd8f..e413e88 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -23,6 +23,16 @@
 #define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
 #define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
 
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
@@ -95,5 +105,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, int pasid);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
-
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f2ae8a0..37fb0c9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -161,6 +161,7 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
@@ -277,6 +278,7 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
-- 
2.7.4

