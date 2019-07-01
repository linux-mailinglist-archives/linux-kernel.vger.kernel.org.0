Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1618062
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEHTT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 15:19:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:27842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfEHTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:19:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 12:19:58 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2019 12:19:57 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix bind svm with multiple devices
Date:   Wed,  8 May 2019 12:22:46 -0700
Message-Id: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multiple devices try to bind to the same mm/PASID, we need to
set up first level PASID entries for all the devices. The current
code does not consider this case which results in failed DMA for
devices after the first bind.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Mike Campin <mike.campin@intel.com>
---
 drivers/iommu/intel-svm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..f3d59d1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -357,6 +357,21 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 
 		list_add_tail(&svm->list, &global_svm_list);
+	} else {
+		/*
+		 * Binding a new device with existing PASID, need to setup
+		 * the PASID entry.
+		 */
+		spin_lock(&iommu->lock);
+		ret = intel_pasid_setup_first_level(iommu, dev,
+						mm ? mm->pgd : init_mm.pgd,
+						svm->pasid, FLPT_DEFAULT_DID,
+						mm ? 0 : PASID_FLAG_SUPERVISOR_MODE);
+		spin_unlock(&iommu->lock);
+		if (ret) {
+			kfree(sdev);
+			goto out;
+		}
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 
-- 
2.7.4

