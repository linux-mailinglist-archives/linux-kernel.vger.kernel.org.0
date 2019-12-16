Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC93121A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfLPUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 15:12:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:10619 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfLPULe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:11:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 11:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="209411632"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2019 11:19:22 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 01/10] iommu/vt-d: Move domain helper to header
Date:   Mon, 16 Dec 2019 11:24:03 -0800
Message-Id: <1576524252-79116-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move domain helper to header to be used by SVA code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 6 ------
 include/linux/intel-iommu.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fdb688983fec..cc89791d807c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -428,12 +428,6 @@ static void init_translation_status(struct intel_iommu *iommu)
 		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
 }
 
-/* Convert generic 'struct iommu_domain to private struct dmar_domain */
-static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct dmar_domain, domain);
-}
-
 static int __init intel_iommu_setup(char *str)
 {
 	if (!str)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index aaece25c055f..74b79e2e6a73 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -589,6 +589,12 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+/* Convert generic struct iommu_domain to private struct dmar_domain */
+static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct dmar_domain, domain);
+}
+
 /*
  * 0: readable
  * 1: writable
-- 
2.7.4

