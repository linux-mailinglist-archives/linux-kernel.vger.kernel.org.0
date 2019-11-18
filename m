Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40E7FFFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 08:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 02:56:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfKRH4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:56:41 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 53A43BAD1F679704F9BA;
        Mon, 18 Nov 2019 15:56:39 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 15:56:31 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when error occur
Date:   Mon, 18 Nov 2019 16:03:34 +0800
Message-ID: <1574064214-109525-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return errno code to caller when error occur, and meanwhile
remove gcc '-Wunused-but-set-variable' warning.

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..50896e9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1371,11 +1371,16 @@ static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
 			data->vbios_boot_state.sclk_bootup_value,
 			(uint32_t *)&(table->GraphicsBootLevel));
+	if (result)
+		return result;
 
 	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
 			data->vbios_boot_state.mclk_bootup_value,
 			(uint32_t *)&(table->MemoryBootLevel));
 
+	if (result)
+		return result;
+
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
 	table->BootVddci = data->vbios_boot_state.vddci_bootup_value *
-- 
2.7.4

