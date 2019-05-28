Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12AF2CEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfE1SaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 14:30:06 -0400
Received: from smtp.aristanetworks.com ([54.193.82.35]:38984 "EHLO
        uscaw2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbfE1SaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:30:03 -0400
Received: from uscaw2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 723F221459D6;
        Tue, 28 May 2019 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1559068203;
        bh=OG5iz7Y2otWoE83PZVl2kJS3N6qNz01B8T1Adm2jXHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=be/t+vffeui5H702naDf64viw7wYSRkAX3enYHSh0h3DCUNHfUoYP0Rjgh2s4QY4t
         I6Q96NmEyXjDFQZb2sHxP1IOAMuSYNU/PycHnluMgO728gPcP1FzjHhQ1yFci4GHav
         LxJC6BkStaU++vFGNuoASIrqCx0PMXUnSnC7PIS+hc1ZVxIavjrR/v0ZSQtCtiUxX8
         4DTwduKeQeit5mUZyRD88mESQEnCRMtp6SKAtx8/gyxPV0k6ImFNu/VPrkzO6mYuP1
         HDBMaEixxPP1zDuC697hkXkKxvQFTSW5rSo87mJroVursmhyKQhIVnb9NX4d77TTlV
         aF8DVcsZWst/g==
Received: from chmeee (unknown [10.95.80.198])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 69A8F3134185;
        Tue, 28 May 2019 11:30:03 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hVgrK-0000xV-UI; Tue, 28 May 2019 11:30:02 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 3/3] iommu/amd: only free resources once on init error
Date:   Tue, 28 May 2019 11:29:58 -0700
Message-Id: <20190528182958.3623-4-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528182958.3623-1-kevmitch@arista.com>
References: <20190528182958.3623-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When amd_iommu=off was specified on the command line, free_X_resources
functions were called immediately after early_amd_iommu_init. They were
then called again when amd_iommu_init also failed (as expected).

Instead, call them only once: at the end of state_next() whenever
there's an error. These functions should be safe to call any time and
any number of times. However, since state_next is never called again in
an error state, the cleanup will only ever be run once.

This also ensures that cleanup code is run as soon as possible after an
error is detected rather than waiting for amd_iommu_init() to be called.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5f3df5ae6ba8..24fc060fe596 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2638,8 +2638,6 @@ static int __init state_next(void)
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
 			pr_info("AMD IOMMU disabled on kernel command-line\n");
-			free_dma_resources();
-			free_iommu_resources();
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		}
@@ -2680,6 +2678,19 @@ static int __init state_next(void)
 		BUG();
 	}
 
+	if (ret) {
+		free_dma_resources();
+		if (!irq_remapping_enabled) {
+			disable_iommus();
+			free_iommu_resources();
+		} else {
+			struct amd_iommu *iommu;
+
+			uninit_device_table_dma();
+			for_each_iommu(iommu)
+				iommu_flush_all_caches(iommu);
+		}
+	}
 	return ret;
 }
 
@@ -2753,18 +2764,6 @@ static int __init amd_iommu_init(void)
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
-	if (ret) {
-		free_dma_resources();
-		if (!irq_remapping_enabled) {
-			disable_iommus();
-			free_iommu_resources();
-		} else {
-			uninit_device_table_dma();
-			for_each_iommu(iommu)
-				iommu_flush_all_caches(iommu);
-		}
-	}
-
 #ifdef CONFIG_GART_IOMMU
 	if (ret && list_empty(&amd_iommu_list)) {
 		/*
-- 
2.20.1

