Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66581185AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLJK7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:59:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfLJK7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:59:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 76933FF6CC4C6D65F05D;
        Tue, 10 Dec 2019 18:59:49 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Dec 2019 18:59:42 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <oded.gabbay@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <rppt@linux.ibm.com>,
        <ttayar@habana.ai>, <oshpigelman@habana.ai>, <dbenzoor@habana.ai>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] habanalabs: remove variable 'val' set but not used
Date:   Tue, 10 Dec 2019 19:06:56 +0800
Message-ID: <1575976016-110900-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/habanalabs/goya/goya.c: In function goya_pldm_init_cpu:
drivers/misc/habanalabs/goya/goya.c:2195:6: warning: variable val set but not used [-Wunused-but-set-variable]
drivers/misc/habanalabs/goya/goya.c: In function goya_hw_init:
drivers/misc/habanalabs/goya/goya.c:2505:6: warning: variable val set but not used [-Wunused-but-set-variable]

Fixes: 9494a8dd8d22 ("habanalabs: add h/w queues module")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/misc/habanalabs/goya/goya.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c8d16aa..7344e8a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2192,7 +2192,7 @@ static int goya_push_linux_to_device(struct hl_device *hdev)
 
 static int goya_pldm_init_cpu(struct hl_device *hdev)
 {
-	u32 val, unit_rst_val;
+	u32 unit_rst_val;
 	int rc;
 
 	/* Must initialize SRAM scrambler before pushing u-boot to SRAM */
@@ -2200,14 +2200,14 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
 
 	/* Put ARM cores into reset */
 	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
-	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+	RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
 
 	/* Reset the CA53 MACRO */
 	unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
 	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
-	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
 	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
-	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
 
 	rc = goya_push_uboot_to_device(hdev);
 	if (rc)
@@ -2228,7 +2228,7 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
 	/* Release ARM core 0 from reset */
 	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
 					CPU_RESET_CORE0_DEASSERT);
-	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+	RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
 
 	return 0;
 }
@@ -2502,13 +2502,12 @@ int goya_mmu_init(struct hl_device *hdev)
 static int goya_hw_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 val;
 	int rc;
 
 	dev_info(hdev->dev, "Starting initialization of H/W\n");
 
 	/* Perform read from the device to make sure device is up */
-	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
 	/*
 	 * Let's mark in the H/W that we have reached this point. We check
@@ -2560,7 +2559,7 @@ static int goya_hw_init(struct hl_device *hdev)
 		goto disable_queues;
 
 	/* Perform read from the device to flush all MSI-X configuration */
-	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
 	return 0;
 
-- 
2.7.4

