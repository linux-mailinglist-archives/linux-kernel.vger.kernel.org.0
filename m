Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A499829112
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbfEXGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:37:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:3887 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388859AbfEXGhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:37:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 23:37:47 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 23:37:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Add missing new line for dma type
Date:   Fri, 24 May 2019 14:30:56 +0800
Message-Id: <20190524063056.12258-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that all types are printed in the same format.

Fixes: c52c72d3dee81 ("iommu: Add sysfs attribyte for domain type")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3fa025f849e9..f371574e9c68 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -341,7 +341,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 			type = "unmanaged\n";
 			break;
 		case IOMMU_DOMAIN_DMA:
-			type = "DMA";
+			type = "DMA\n";
 			break;
 		}
 	}
-- 
2.17.1

