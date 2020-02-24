Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0907D16B508
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgBXXVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:21:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:27195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgBXXVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:21:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 15:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="255749683"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 15:21:18 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA APIs
Date:   Mon, 24 Feb 2020 15:26:37 -0800
Message-Id: <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an initial step to replace Intel SVM code with the
following IOMMU SVA ops:
intel_svm_bind_mm() => iommu_sva_bind_device()
intel_svm_unbind_mm() => iommu_sva_unbind_device()
intel_svm_is_pasid_valid() => iommu_sva_get_pasid()

The features below will continue to work but are not included in this patch
in that they are handled mostly within the IOMMU subsystem.
- IO page fault
- mmu notifier

Consolidation of the above will come after merging generic IOMMU sva
code[1]. There should not be any changes needed for SVA users such as
accelerator device drivers during this time.

[1] http://jpbrucker.net/sva/

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |   3 ++
 drivers/iommu/intel-svm.c   | 123 ++++++++++++++++++++++++--------------------
 include/linux/intel-iommu.h |   7 +++
 include/linux/intel-svm.h   |  85 ------------------------------
 4 files changed, 78 insertions(+), 140 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5eca6e10d2a4..ccfa5adfd06d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6475,6 +6475,9 @@ const struct iommu_ops intel_iommu_ops = {
 	.cache_invalidate	= intel_iommu_sva_invalidate,
 	.sva_bind_gpasid	= intel_svm_bind_gpasid,
 	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
+	.sva_bind		= intel_svm_bind,
+	.sva_unbind		= intel_svm_unbind,
+	.sva_get_pasid		= intel_svm_get_pasid,
 #endif
 };
 
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 1d7a95372f8c..35d949513728 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -516,13 +516,14 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 	return ret;
 }
 
-int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
+/* Caller must hold pasid_mutex, mm reference */
+static int intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
+		      struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
-	struct mm_struct *mm = NULL;
 	int pasid_max;
 	int ret;
 
@@ -539,16 +540,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	} else
 		pasid_max = 1 << 20;
 
+	/* Bind supervisor PASID shuld have mm = NULL */
 	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap))
+		if (!ecap_srs(iommu->ecap) || mm) {
+			pr_err("Supervisor PASID with user provided mm.\n");
 			return -EINVAL;
-	} else if (pasid) {
-		mm = get_task_mm(current);
-		BUG_ON(!mm);
+		}
 	}
 
-	mutex_lock(&pasid_mutex);
-	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
 		struct intel_svm *t;
 
 		list_for_each_entry(t, &global_svm_list, list) {
@@ -586,9 +586,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	sdev->dev = dev;
 
 	ret = intel_iommu_enable_pasid(iommu, dev);
-	if (ret || !pasid) {
-		/* If they don't actually want to assign a PASID, this is
-		 * just an enabling check/preparation. */
+	if (ret) {
 		kfree(sdev);
 		goto out;
 	}
@@ -688,18 +686,17 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
-
- success:
-	*pasid = svm->pasid;
+success:
+	sdev->pasid = svm->pasid;
+	sdev->sva.dev = dev;
+	if (sd)
+		*sd = sdev;
 	ret = 0;
  out:
-	mutex_unlock(&pasid_mutex);
-	if (mm)
-		mmput(mm);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
 
+/* Caller must hold pasid_mutex */
 int intel_svm_unbind_mm(struct device *dev, int pasid)
 {
 	struct intel_svm_dev *sdev;
@@ -707,7 +704,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	struct intel_svm *svm;
 	int ret = -EINVAL;
 
-	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
 	if (!iommu)
 		goto out;
@@ -753,45 +749,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 		break;
 	}
  out:
-	mutex_unlock(&pasid_mutex);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
-
-int intel_svm_is_pasid_valid(struct device *dev, int pasid)
-{
-	struct intel_iommu *iommu;
-	struct intel_svm *svm;
-	int ret = -EINVAL;
-
-	mutex_lock(&pasid_mutex);
-	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu)
-		goto out;
-
-	svm = ioasid_find(NULL, pasid, NULL);
-	if (!svm)
-		goto out;
-
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
-		goto out;
-	}
-	/* init_mm is used in this case */
-	if (!svm->mm)
-		ret = 1;
-	else if (atomic_read(&svm->mm->mm_users) > 0)
-		ret = 1;
-	else
-		ret = 0;
-
- out:
-	mutex_unlock(&pasid_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(intel_svm_is_pasid_valid);
 
 /* Page request queue descriptor */
 struct page_req_dsc {
@@ -984,3 +944,56 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 	return IRQ_RETVAL(handled);
 }
+
+#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
+struct iommu_sva *
+intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	struct iommu_sva *sva = ERR_PTR(-EINVAL);
+	struct intel_svm_dev *sdev = NULL;
+	int flags = 0;
+	int ret;
+
+	/*
+	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
+	 * It will require shared SVM data structures, i.e. combine io_mm
+	 * and intel_svm etc.
+	 */
+	if (drvdata)
+		flags = *(int *)drvdata;
+	mutex_lock(&pasid_mutex);
+	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
+	if (ret)
+		sva = ERR_PTR(ret);
+	else if (sdev)
+		sva = &sdev->sva;
+	else
+		WARN(!sdev, "SVM bind succeeded with no sdev!\n");
+
+	mutex_unlock(&pasid_mutex);
+
+	return sva;
+}
+
+void intel_svm_unbind(struct iommu_sva *sva)
+{
+	struct intel_svm_dev *sdev;
+
+	mutex_lock(&pasid_mutex);
+	sdev = to_intel_svm_dev(sva);
+	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+int intel_svm_get_pasid(struct iommu_sva *sva)
+{
+	struct intel_svm_dev *sdev;
+	int pasid;
+
+	mutex_lock(&pasid_mutex);
+	sdev = to_intel_svm_dev(sva);
+	pasid = sdev->pasid;
+	mutex_unlock(&pasid_mutex);
+
+	return pasid;
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 37cfd35b7ccf..044493a11dce 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -702,6 +702,11 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
 		struct device *dev, struct iommu_gpasid_bind_data *data);
 extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
+extern struct iommu_sva *
+intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata);
+extern void intel_svm_unbind(struct iommu_sva *handle);
+extern int intel_svm_get_pasid(struct iommu_sva *handle);
+
 struct svm_dev_ops;
 
 struct intel_svm_dev {
@@ -709,6 +714,8 @@ struct intel_svm_dev {
 	struct rcu_head rcu;
 	struct device *dev;
 	struct svm_dev_ops *ops;
+	struct iommu_sva sva;
+	int pasid;
 	int users;
 	u16 did;
 	u16 dev_iotlb:1;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index a2c189ad0b01..fb7e786d8877 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -62,89 +62,4 @@ struct svm_dev_ops {
  */
 #define SVM_FLAG_GUEST_PASID	(1<<3)
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-
-/**
- * intel_svm_bind_mm() - Bind the current process to a PASID
- * @dev:	Device to be granted access
- * @pasid:	Address for allocated PASID
- * @flags:	Flags. Later for requesting supervisor mode, etc.
- * @ops:	Callbacks to device driver
- *
- * This function attempts to enable PASID support for the given device.
- * If the @pasid argument is non-%NULL, a PASID is allocated for access
- * to the MM of the current process.
- *
- * By using a %NULL value for the @pasid argument, this function can
- * be used to simply validate that PASID support is available for the
- * given device — i.e. that it is behind an IOMMU which has the
- * requisite support, and is enabled.
- *
- * Page faults are handled transparently by the IOMMU code, and there
- * should be no need for the device driver to be involved. If a page
- * fault cannot be handled (i.e. is an invalid address rather than
- * just needs paging in), then the page request will be completed by
- * the core IOMMU code with appropriate status, and the device itself
- * can then report the resulting fault to its driver via whatever
- * mechanism is appropriate.
- *
- * Multiple calls from the same process may result in the same PASID
- * being re-used. A reference count is kept.
- */
-extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
-			     struct svm_dev_ops *ops);
-
-/**
- * intel_svm_unbind_mm() - Unbind a specified PASID
- * @dev:	Device for which PASID was allocated
- * @pasid:	PASID value to be unbound
- *
- * This function allows a PASID to be retired when the device no
- * longer requires access to the address space of a given process.
- *
- * If the use count for the PASID in question reaches zero, the
- * PASID is revoked and may no longer be used by hardware.
- *
- * Device drivers are required to ensure that no access (including
- * page requests) is currently outstanding for the PASID in question,
- * before calling this function.
- */
-extern int intel_svm_unbind_mm(struct device *dev, int pasid);
-
-/**
- * intel_svm_is_pasid_valid() - check if pasid is valid
- * @dev:	Device for which PASID was allocated
- * @pasid:	PASID value to be checked
- *
- * This function checks if the specified pasid is still valid. A
- * valid pasid means the backing mm is still having a valid user.
- * For kernel callers init_mm is always valid. for other mm, if mm->mm_users
- * is non-zero, it is valid.
- *
- * returns -EINVAL if invalid pasid, 0 if pasid ref count is invalid
- * 1 if pasid is valid.
- */
-extern int intel_svm_is_pasid_valid(struct device *dev, int pasid);
-
-#else /* CONFIG_INTEL_IOMMU_SVM */
-
-static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
-				    int flags, struct svm_dev_ops *ops)
-{
-	return -ENOSYS;
-}
-
-static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
-{
-	BUG();
-}
-
-static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_INTEL_IOMMU_SVM */
-
-#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
-
 #endif /* __INTEL_SVM_H__ */
-- 
2.7.4

