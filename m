Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F04F86C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKLCMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 21:12:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbfKLCMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:12:02 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A28C9AFCD83B5867FBA;
        Tue, 12 Nov 2019 10:12:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 10:11:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>,
        <Anthony.Koo@amd.com>, <Zhan.Liu@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/amd/display: remove set but not used variable 'bpc'
Date:   Tue, 12 Nov 2019 10:10:50 +0800
Message-ID: <20191112021050.13128-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191109093538.23964-1-yuehaibing@huawei.com>
References: <20191109093538.23964-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
 variable bpc set but not used [-Wunused-but-set-variable]

It is not used since commit e49f69363adf ("drm/amd/display: use
proper formula to calculate bandwidth from timing"), this also
remove get_color_depth(), which is only used here.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: also remove unused get_color_depth()
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bdc8be3..1be4277 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2638,28 +2638,13 @@ static struct fixed31_32 get_pbn_per_slot(struct dc_stream_state *stream)
 	return dc_fixpt_div_int(mbytes_per_sec, 54);
 }
 
-static int get_color_depth(enum dc_color_depth color_depth)
-{
-	switch (color_depth) {
-	case COLOR_DEPTH_666: return 6;
-	case COLOR_DEPTH_888: return 8;
-	case COLOR_DEPTH_101010: return 10;
-	case COLOR_DEPTH_121212: return 12;
-	case COLOR_DEPTH_141414: return 14;
-	case COLOR_DEPTH_161616: return 16;
-	default: return 0;
-	}
-}
-
 static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t bpc;
 	uint64_t kbps;
 	struct fixed31_32 peak_kbps;
 	uint32_t numerator;
 	uint32_t denominator;
 
-	bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
 	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
 
 	/*
-- 
2.7.4


