Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149168D4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfHNNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:38:48 -0400
Received: from 8bytes.org ([81.169.241.247]:49378 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbfHNNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:38:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E92C34FE; Wed, 14 Aug 2019 15:38:43 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 08/10] iommu: Set default domain type at runtime
Date:   Wed, 14 Aug 2019 15:38:39 +0200
Message-Id: <20190814133841.7095-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814133841.7095-1-joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Set the default domain-type at runtime, not at compile-time.
This keeps default domain type setting in one place when we
have to change it at runtime.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 233bc22b487e..96cc7cc8ab21 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -26,11 +26,8 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
-#else
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
-#endif
+
+static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = true;
 static u32 iommu_cmd_line __read_mostly;
 
@@ -76,7 +73,7 @@ static void iommu_set_cmd_line_dma_api(void)
 	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
 }
 
-static bool __maybe_unused iommu_cmd_line_dma_api(void)
+static bool iommu_cmd_line_dma_api(void)
 {
 	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
 }
@@ -115,8 +112,18 @@ static const char *iommu_domain_type_str(unsigned int t)
 
 static int __init iommu_subsys_init(void)
 {
-	pr_info("Default domain type: %s\n",
-		iommu_domain_type_str(iommu_def_domain_type));
+	bool cmd_line = iommu_cmd_line_dma_api();
+
+	if (!cmd_line) {
+		if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
+			iommu_set_default_passthrough();
+		else
+			iommu_set_default_translated();
+	}
+
+	pr_info("Default domain type: %s %s\n",
+		iommu_domain_type_str(iommu_def_domain_type),
+		cmd_line ? "(set via kernel command line)" : "");
 
 	return 0;
 }
-- 
2.17.1

