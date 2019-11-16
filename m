Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20607FEA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 04:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKPDgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 22:36:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbfKPDgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 22:36:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 459D3232D7737EC5CC9D;
        Sat, 16 Nov 2019 11:36:33 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 11:36:27 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <alexander.deucher@amd.com>, <evan.quan@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used
Date:   Sat, 16 Nov 2019 11:43:19 +0800
Message-ID: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..fad78bf 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
 static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU75_Discrete_DpmTable *table)
 {
-	int result = 0;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	table->GraphicsBootLevel = 0;
 	table->MemoryBootLevel = 0;
 
 	/* find boot level from dpm table */
-	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
-			data->vbios_boot_state.sclk_bootup_value,
-			(uint32_t *)&(table->GraphicsBootLevel));
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
+			    data->vbios_boot_state.sclk_bootup_value,
+			    (uint32_t *)&(table->GraphicsBootLevel));
 
-	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
-			data->vbios_boot_state.mclk_bootup_value,
-			(uint32_t *)&(table->MemoryBootLevel));
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
+			    data->vbios_boot_state.mclk_bootup_value,
+			    (uint32_t *)&(table->MemoryBootLevel));
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
-- 
2.7.4

