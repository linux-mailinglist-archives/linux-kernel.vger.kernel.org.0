Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA82872
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfHFAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 20:15:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:52044 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHFAPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="373246771"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2019 17:15:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Fix possible use-after-free of private domain
Date:   Tue,  6 Aug 2019 08:14:09 +0800
Message-Id: <20190806001409.3293-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806001409.3293-1-baolu.lu@linux.intel.com>
References: <20190806001409.3293-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple devices might share a private domain. One real example
is a pci bridge and all devices behind it. When remove a private
domain, make sure that it has been detached from all devices to
avoid use-after-free case.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 37259b7f95a7..12d094d08c0a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4791,7 +4791,8 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 	/* free the private domain */
 	if (domain->flags & DOMAIN_FLAG_LOSE_CHILDREN &&
-	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY))
+	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
+	    list_empty(&domain->devices))
 		domain_exit(info->domain);
 
 	free_devinfo_mem(info);
-- 
2.17.1

