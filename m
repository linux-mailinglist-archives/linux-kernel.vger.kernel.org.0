Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3291F8FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 13:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKLMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 07:51:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfKLMvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:51:21 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42DE32382CC2C805B117;
        Tue, 12 Nov 2019 20:51:19 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 20:51:09 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used warning
Date:   Tue, 12 Nov 2019 20:58:14 +0800
Message-ID: <1573563494-129617-1-git-send-email-chenwandun@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.c: In function fiji_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/fiji_smumgr.c:1605:6: warning: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 32ebb38..6df5af0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -1602,18 +1602,17 @@ static int fiji_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
 static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU73_Discrete_DpmTable *table)
 {
-	int result = 0;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	table->GraphicsBootLevel = 0;
 	table->MemoryBootLevel = 0;
 
 	/* find boot level from dpm table */
-	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
 			data->vbios_boot_state.sclk_bootup_value,
 			(uint32_t *)&(table->GraphicsBootLevel));
 
-	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
 			data->vbios_boot_state.mclk_bootup_value,
 			(uint32_t *)&(table->MemoryBootLevel));
 
-- 
2.7.4

