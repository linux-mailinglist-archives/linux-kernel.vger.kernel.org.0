Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBF2A4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEYOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 10:35:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfEYOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:35:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00D48BE49C145C661C87;
        Sat, 25 May 2019 22:35:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:34:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Tony.Cheng@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Remove set but not used variable 'pixel_width'
Date:   Sat, 25 May 2019 22:34:33 +0800
Message-ID: <20190525143433.20000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.c: In function dpp_get_optimal_number_of_taps:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.c:137:11: warning: variable pixel_width set but not used [-Wunused-but-set-variable]

It is never used and can be remove.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index 6f4b24756323..d963d361696e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -134,13 +134,6 @@ static bool dpp_get_optimal_number_of_taps(
 		struct scaler_data *scl_data,
 		const struct scaling_taps *in_taps)
 {
-	uint32_t pixel_width;
-
-	if (scl_data->viewport.width > scl_data->recout.width)
-		pixel_width = scl_data->recout.width;
-	else
-		pixel_width = scl_data->viewport.width;
-
 	/* Some ASICs does not support  FP16 scaling, so we reject modes require this*/
 	if (scl_data->format == PIXEL_FORMAT_FP16 &&
 		dpp->caps->dscl_data_proc_format == DSCL_DATA_PRCESSING_FIXED_FORMAT &&
-- 
2.17.1


