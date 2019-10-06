Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A335CD17E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfJFK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 06:57:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfJFK55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:57:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 926D158369EC033520F0;
        Sun,  6 Oct 2019 18:57:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:57:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Anthony.Koo@amd.com>,
        <aric.cyr@amd.com>, <Harmanprit.Tatla@amd.com>,
        <bayan.zabihiyan@amd.com>, <ahmad.othman@amd.com>,
        <Reza.Amini@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'core_freesync'
Date:   Sun, 6 Oct 2019 18:57:35 +0800
Message-ID: <20191006105735.60708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

rivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:
 In function mod_freesync_get_settings:
drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:984:24:
 warning: variable core_freesync set but not used [-Wunused-but-set-variable]

It is not used since commit 98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 9ce56a8..237dda7 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -981,13 +981,9 @@ void mod_freesync_get_settings(struct mod_freesync *mod_freesync,
 		unsigned int *inserted_frames,
 		unsigned int *inserted_duration_in_us)
 {
-	struct core_freesync *core_freesync = NULL;
-
 	if (mod_freesync == NULL)
 		return;
 
-	core_freesync = MOD_FREESYNC_TO_CORE(mod_freesync);
-
 	if (vrr->supported) {
 		*v_total_min = vrr->adjust.v_total_min;
 		*v_total_max = vrr->adjust.v_total_max;
-- 
2.7.4


