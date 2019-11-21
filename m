Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE770105BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKUVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 16:21:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:19234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfKUVV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:21:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="210224385"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2019 13:21:55 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 6/8] iommu/vt-d: Replace Intel specific PASID allocator with IOASID
Date:   Thu, 21 Nov 2019 13:26:26 -0800
Message-Id: <1574371588-65634-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of generic IOASID code to manage PASID allocation,
free, and lookup. Replace Intel specific code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 13 +++++++------
 drivers/iommu/intel-pasid.c | 36 ------------------------------------
 drivers/iommu/intel-svm.c   | 39 +++++++++++++++++++++++++--------------
 4 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index fd50ddffffbf..43ce450a40d3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -212,6 +212,7 @@ config INTEL_IOMMU_SVM
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
 	select MMU_NOTIFIER
+	select IOASID
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d598168e410d..a84f0caa33a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5238,7 +5238,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5256,10 +5256,11 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	if (domain->default_pasid <= 0) {
 		int pasid;
 
-		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
-					     pci_max_pasids(to_pci_dev(dev)),
-					     GFP_KERNEL);
-		if (pasid <= 0) {
+		/* No private data needed for the default pasid */
+		pasid = ioasid_alloc(NULL, PASID_MIN,
+				     pci_max_pasids(to_pci_dev(dev)) - 1,
+				     NULL);
+		if (pasid == INVALID_IOASID) {
 			pr_err("Can't allocate default pasid\n");
 			return -ENODEV;
 		}
@@ -5295,7 +5296,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	spin_unlock(&iommu->lock);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 732bfee228df..3cb569e76642 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -26,42 +26,6 @@
  */
 static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
-static DEFINE_IDR(pasid_idr);
-
-int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
-{
-	int ret, min, max;
-
-	min = max_t(int, start, PASID_MIN);
-	max = min_t(int, end, intel_pasid_max_id);
-
-	WARN_ON(in_interrupt());
-	idr_preload(gfp);
-	spin_lock(&pasid_lock);
-	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
-	spin_unlock(&pasid_lock);
-	idr_preload_end();
-
-	return ret;
-}
-
-void intel_pasid_free_id(int pasid)
-{
-	spin_lock(&pasid_lock);
-	idr_remove(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-}
-
-void *intel_pasid_lookup_id(int pasid)
-{
-	void *p;
-
-	spin_lock(&pasid_lock);
-	p = idr_find(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-
-	return p;
-}
 
 /*
  * Per device pasid table management:
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e90d0b914afe..71b85b892c56 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -17,6 +17,7 @@
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
+#include <linux/ioasid.h>
 #include <asm/page.h>
 
 #include "intel-pasid.h"
@@ -335,16 +336,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = intel_pasid_alloc_id(svm,
-					   !!cap_caching_mode(iommu->cap),
-					   pasid_max, GFP_KERNEL);
-		if (ret < 0) {
+		/* Do not use PASID 0, reserved for RID to PASID */
+		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
+					  pasid_max - 1, svm);
+		if (svm->pasid == INVALID_IOASID) {
 			kfree(svm);
 			kfree(sdev);
+			ret = -ENOSPC;
 			goto out;
 		}
-		svm->pasid = ret;
 		svm->notifier.ops = &intel_mmuops;
 		svm->mm = mm;
 		svm->flags = flags;
@@ -354,7 +354,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				intel_pasid_free_id(svm->pasid);
+				ioasid_free(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -370,7 +370,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			intel_pasid_free_id(svm->pasid);
+			ioasid_free(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -418,7 +418,15 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (!svm)
+		goto out;
+
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+
 	if (!svm)
 		goto out;
 
@@ -440,7 +448,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree_rcu(sdev, rcu);
 
 				if (list_empty(&svm->devs)) {
-					intel_pasid_free_id(svm->pasid);
+					ioasid_free(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -475,10 +483,14 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
+	svm = ioasid_find(NULL, pasid, NULL);
 	if (!svm)
 		goto out;
 
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
 	/* init_mm is used in this case */
 	if (!svm->mm)
 		ret = 1;
@@ -585,13 +597,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = intel_pasid_lookup_id(req->pasid);
+			svm = ioasid_find(NULL, req->pasid, NULL);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
 			rcu_read_unlock();
-
-			if (!svm) {
+			if (IS_ERR_OR_NULL(svm)) {
 				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
 				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
 				       ((unsigned long long *)req)[1]);
-- 
2.7.4

