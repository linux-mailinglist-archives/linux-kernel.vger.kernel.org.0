Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D262217380D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1NQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:16:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:16:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j7fUs-0000UF-L0; Fri, 28 Feb 2020 13:16:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: fix indentation issue on a hunk of code
Date:   Fri, 28 Feb 2020 13:16:06 +0000
Message-Id: <20200228131606.65041-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are multiple statements that are indented incorrectly. Add
in the missing tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 5d081c42e81b..2c6db379afae 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -3265,33 +3265,33 @@ bool bw_calcs(struct dc_context *ctx,
 				bw_fixed_to_int(bw_mul(data->
 					stutter_exit_watermark[9], bw_int_to_fixed(1000)));
 
-		calcs_output->stutter_entry_wm_ns[0].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[4], bw_int_to_fixed(1000)));
-		calcs_output->stutter_entry_wm_ns[1].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[5], bw_int_to_fixed(1000)));
-		calcs_output->stutter_entry_wm_ns[2].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[6], bw_int_to_fixed(1000)));
-		if (ctx->dc->caps.max_slave_planes) {
-			calcs_output->stutter_entry_wm_ns[3].b_mark =
+			calcs_output->stutter_entry_wm_ns[0].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[0], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[4].b_mark =
+					stutter_entry_watermark[4], bw_int_to_fixed(1000)));
+			calcs_output->stutter_entry_wm_ns[1].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[1], bw_int_to_fixed(1000)));
-		} else {
-			calcs_output->stutter_entry_wm_ns[3].b_mark =
+					stutter_entry_watermark[5], bw_int_to_fixed(1000)));
+			calcs_output->stutter_entry_wm_ns[2].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[7], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[4].b_mark =
+					stutter_entry_watermark[6], bw_int_to_fixed(1000)));
+			if (ctx->dc->caps.max_slave_planes) {
+				calcs_output->stutter_entry_wm_ns[3].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[0], bw_int_to_fixed(1000)));
+				calcs_output->stutter_entry_wm_ns[4].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[1], bw_int_to_fixed(1000)));
+			} else {
+				calcs_output->stutter_entry_wm_ns[3].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[7], bw_int_to_fixed(1000)));
+				calcs_output->stutter_entry_wm_ns[4].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[8], bw_int_to_fixed(1000)));
+			}
+			calcs_output->stutter_entry_wm_ns[5].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[8], bw_int_to_fixed(1000)));
-		}
-		calcs_output->stutter_entry_wm_ns[5].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[9], bw_int_to_fixed(1000)));
+					stutter_entry_watermark[9], bw_int_to_fixed(1000)));
 
 			calcs_output->urgent_wm_ns[0].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-- 
2.25.0

