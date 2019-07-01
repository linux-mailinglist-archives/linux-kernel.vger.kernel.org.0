Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4D41981
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 02:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407990AbfFLAgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 20:36:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:50299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407573AbfFLAgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:36:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 17:36:15 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2019 17:36:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/7] iommu/vt-d: Allow DMA domain attaching to rmrr locked device
Date:   Wed, 12 Jun 2019 08:28:48 +0800
Message-Id: <20190612002851.17103-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't allow a device to be assigned to user level when it is locked
by any RMRR's. Hence, intel_iommu_attach_device() will return error if
a domain of type IOMMU_DOMAIN_UNMANAGED is about to attach to a device
locked by rmrr. But this doesn't apply to a domain of type other than
IOMMU_DOMAIN_UNMANAGED. This adds a check to fix this.

Fixes: fa954e6831789 ("iommu/vt-d: Delegate the dma domain to upper layer")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reported-and-tested-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5251533a18a4..19c4c387a3f6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5139,7 +5139,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (device_is_rmrr_locked(dev)) {
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
+	    device_is_rmrr_locked(dev)) {
 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
 		return -EPERM;
 	}
-- 
2.17.1

