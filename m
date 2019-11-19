Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EC102B07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKSRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:52:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:14025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfKSRwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:52:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 09:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="209488288"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2019 09:51:58 -0800
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
Subject: [PATCH v3 7/8] iommu/vt-d: Avoid sending invalid page response
Date:   Tue, 19 Nov 2019 09:56:31 -0800
Message-Id: <1574186193-30457-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page responses should only be sent when last page in group (LPIG) or
private data is present in the page request. This patch avoids sending
invalid descriptors.

Fixes: 5d308fc1ecf53 ("iommu/vt-d: Add 256-bit invalidation descriptor
support")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 71b85b892c56..4eecc24412dc 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -686,11 +686,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			if (req->priv_data_present)
 				memcpy(&resp.qw2, req->priv_data,
 				       sizeof(req->priv_data));
+			resp.qw2 = 0;
+			resp.qw3 = 0;
+			qi_submit_sync(&resp, iommu);
 		}
-		resp.qw2 = 0;
-		resp.qw3 = 0;
-		qi_submit_sync(&resp, iommu);
-
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-- 
2.7.4

