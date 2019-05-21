Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0A24914
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEUHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:37:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:4506 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUHhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:37:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 00:37:13 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 00:37:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Kevin Tian <kevin.tian@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Set the right field for Page Walk Snoop
Date:   Tue, 21 May 2019 15:30:16 +0800
Message-Id: <20190521073016.27525-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521073016.27525-1-baolu.lu@linux.intel.com>
References: <20190521073016.27525-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the page walk snoop to the right bit, otherwise the domain
id field will be overlapped.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Fixes: 6f7db75e1c469 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 2fefeafda437..fe51d8af457f 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -389,7 +389,7 @@ static inline void pasid_set_present(struct pasid_entry *pe)
  */
 static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 {
-	pasid_set_bits(&pe->val[1], 1 << 23, value);
+	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
 /*
-- 
2.17.1

