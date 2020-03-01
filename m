Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B55174FB1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCAUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 15:48:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:58737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgCAUsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:48:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2020 12:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,505,1574150400"; 
   d="scan'208";a="233094895"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2020 12:48:39 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v3 5/5] platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic for platforms that support sub-states
Date:   Sun,  1 Mar 2020 12:44:26 -0800
Message-Id: <5e28f488a6cc8b7c1e08b536868844b586a1eaf1.1583093898.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583093898.git.gayatri.kammela@intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1583093898.git.gayatri.kammela@intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
number of status/live status registers which is hardcoded and cannot
be re-used for future platforms that support sub-states. To maintain
readability, make pmc_core_lpm_display() generic, so that it can re-used
for future platforms.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 04ac058b9871..cf3aaace21d5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/uaccess.h>
 
@@ -640,15 +641,30 @@ static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
 	}
 }
 
+static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
+{
+	int idx, arr_size = 0;
+
+	for (idx = 0; maps[idx]; idx++)
+		arr_size++;
+
+	return arr_size;
+}
+
 static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 				 struct seq_file *s, u32 offset,
 				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
-	u32 lpm_regs[ARRAY_SIZE(tgl_lpm_maps)-1];
-	int index, idx, len = 32, bit_mask;
+	int arr_size = pmc_core_lpm_get_arr_size(maps);
+	int index, idx, bit_mask, len = 32;
+	u32 *lpm_regs;
+
+	lpm_regs = kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
+	if(!lpm_regs)
+		goto err;
 
-	for (index = 0; tgl_lpm_maps[index]; index++) {
+	for (index = 0; maps[index]; index++) {
 		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
 		offset += 4;
 	}
@@ -672,6 +688,9 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 					   lpm_regs[idx] & bit_mask ? 1 : 0);
 		}
 	}
+
+err:
+	kfree(lpm_regs);
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-- 
2.17.1

